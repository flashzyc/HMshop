package com.hmshop.backend.service;

import com.hmshop.backend.common.ApiResponse;
import com.hmshop.backend.dto.*;
import com.hmshop.backend.entity.Address;
import com.hmshop.backend.entity.Cart;
import com.hmshop.backend.entity.Order;
import com.hmshop.backend.entity.OrderItem;
import com.hmshop.backend.entity.User;
import com.hmshop.backend.repository.AddressRepository;
import com.hmshop.backend.repository.CartRepository;
import com.hmshop.backend.repository.OrderItemRepository;
import com.hmshop.backend.repository.OrderRepository;
import com.hmshop.backend.util.DateUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderRepository orderRepository;
    private final OrderItemRepository orderItemRepository;
    private final CartRepository cartRepository;
    private final AddressRepository addressRepository;

    public ApiResponse<SubmitOrderResponse> submitOrder(User user, SubmitOrderRequest req) {
        List<Cart> cartItems;
        if (!"0".equals(req.getCartId())) {
            Long cartId = Long.parseLong(req.getCartId());
            cartItems = cartRepository.findByIdAndUser(cartId, user)
                    .map(List::of).orElse(List.of());
        } else {
            cartItems = cartRepository.findByUserAndDeletedFalse(user).stream()
                    .filter(c -> Boolean.TRUE.equals(c.getChecked()))
                    .toList();
        }
        if (cartItems.isEmpty()) {
            return ApiResponse.fail(402, "购物车为空");
        }

        double goodsPrice = cartItems.stream().mapToDouble(c -> c.getPrice() * c.getNumber()).sum();
        double freightPrice = goodsPrice > 99 ? 0 : 8;
        double couponPrice = 0;
        double actualPrice = goodsPrice + freightPrice - couponPrice;

        Address address = resolveAddress(user, req.getAddressId());
        String fullAddress = address == null ? "" : String.join("",
                Optional.ofNullable(address.getProvince()).orElse(""),
                Optional.ofNullable(address.getCity()).orElse(""),
                Optional.ofNullable(address.getCounty()).orElse(""),
                Optional.ofNullable(address.getAddressDetail()).orElse(""));

        Order order = new Order();
        order.setUser(user);
        order.setOrderSn(buildOrderSn());
        order.setOrderStatus(101);
        order.setGoodsPrice(goodsPrice);
        order.setFreightPrice(freightPrice);
        order.setCouponPrice(couponPrice);
        order.setActualPrice(actualPrice);
        order.setMessage(req.getMessage());
        if (address != null) {
            order.setConsignee(address.getName());
            order.setMobile(address.getTel());
            order.setAddress(fullAddress);
        }
        order.setAddTime(LocalDateTime.now());
        order.setUpdateTime(LocalDateTime.now());
        order.setAftersaleStatus(0);
        order.setDeleted(false);
        // address snapshot is omitted for brevity
        orderRepository.save(order);

        List<OrderItem> items = cartItems.stream().map(c -> {
            OrderItem oi = new OrderItem();
            oi.setOrder(order);
            oi.setGoodsId(c.getGoodsId());
            oi.setGoodsName(c.getGoodsName());
            oi.setGoodsSn(c.getGoodsSn());
            oi.setProductId(c.getProductId());
            oi.setNumber(c.getNumber());
            oi.setPrice(c.getPrice());
            oi.setSpecifications(c.getSpecifications());
            oi.setPicUrl(c.getPicUrl());
            return oi;
        }).toList();
        orderItemRepository.saveAll(items);

        cartItems.forEach(c -> c.setDeleted(true));
        cartRepository.saveAll(cartItems);

        SubmitOrderResponse resp = new SubmitOrderResponse(order.getId(), order.getId(), false);
        return ApiResponse.ok(resp);
    }

    public ApiResponse<PayViewDto> getOrderInfo(User user, Long orderId) {
        Optional<Order> orderOpt = orderRepository.findByIdAndUserAndDeletedFalse(orderId, user);
        if (orderOpt.isEmpty()) {
            return ApiResponse.fail(402, "订单不存在");
        }
        Order order = orderOpt.get();
        PayViewDto dto = new PayViewDto(toPayInfo(order));
        return ApiResponse.ok(dto);
    }

    public ApiResponse<PayViewDto> pay(User user, Long orderId) {
        Optional<Order> orderOpt = orderRepository.findByIdAndUserAndDeletedFalse(orderId, user);
        if (orderOpt.isEmpty()) {
            return ApiResponse.fail(402, "订单不存在");
        }
        Order order = orderOpt.get();
        order.setOrderStatus(201);
        order.setPayTime(LocalDateTime.now());
        order.setUpdateTime(LocalDateTime.now());
        orderRepository.save(order);
        return getOrderInfo(user, orderId);
    }

    public ApiResponse<OrderListViewDto> list(User user, int showType, int page, int limit) {
        List<Integer> statuses = switch (showType) {
            case 1 -> List.of(101);
            case 2 -> List.of(201);
            case 3 -> List.of(301);
            case 4 -> List.of(401);
            default -> List.of(101, 201, 301, 401);
        };
        List<Order> orders = orderRepository.findByUserAndOrderStatusInAndDeletedFalseOrderByAddTimeDesc(user, statuses);
        List<OrderDetailDto> detailList = orders.stream()
                .skip((long) (Math.max(page, 1) - 1) * limit)
                .limit(limit)
                .map(this::toOrderDetail)
                .toList();
        return ApiResponse.ok(new OrderListViewDto(detailList));
    }

    public ApiResponse<Void> delete(User user, Long orderId) {
        Optional<Order> orderOpt = orderRepository.findByIdAndUserAndDeletedFalse(orderId, user);
        if (orderOpt.isPresent()) {
            Order order = orderOpt.get();
            order.setDeleted(true);
            orderRepository.save(order);
            return ApiResponse.ok(null);
        }
        return ApiResponse.fail(402, "订单不存在");
    }

    public OrderCounterDto count(User user) {
        List<Order> orders = orderRepository.findByUserAndDeletedFalseOrderByAddTimeDesc(user);
        int unpaid = (int) orders.stream().filter(o -> o.getOrderStatus() == 101).count();
        int unship = (int) orders.stream().filter(o -> o.getOrderStatus() == 201).count();
        int unrecv = (int) orders.stream().filter(o -> o.getOrderStatus() == 301).count();
        int uncomment = (int) orders.stream().filter(o -> o.getOrderStatus() == 401).count();
        return new OrderCounterDto(unrecv, uncomment, unpaid, unship);
    }

    private String buildOrderSn() {
        return "HM" + System.currentTimeMillis();
    }

    private OrderDetailDto toOrderDetail(Order order) {
        List<OrderItem> items = orderItemRepository.findByOrder(order);
        List<OrderGoodsDto> goodsDtos = items.stream().map(oi -> new OrderGoodsDto(
                oi.getNumber(),
                oi.getPicUrl(),
                oi.getPrice(),
                oi.getId(),
                oi.getGoodsName(),
                splitSpecs(oi.getSpecifications())
        )).collect(Collectors.toList());

        return new OrderDetailDto(
                statusText(order.getOrderStatus()),
                order.getAftersaleStatus(),
                false,
                order.getOrderSn(),
                order.getActualPrice(),
                goodsDtos,
                order.getId(),
                handleOption(order)
        );
    }

    private PayOrderInfoDto toPayInfo(Order order) {
        OrderHandleOptionDto handle = handleOption(order);
        return new PayOrderInfoDto(
                order.getConsignee(),
                order.getAddress(),
                DateUtil.format(order.getAddTime()),
                order.getOrderSn(),
                order.getActualPrice(),
                order.getMobile(),
                order.getMessage(),
                statusText(order.getOrderStatus()),
                order.getAftersaleStatus(),
                order.getGoodsPrice(),
                order.getCouponPrice(),
                order.getId(),
                order.getFreightPrice(),
                handle
        );
    }

    private OrderHandleOptionDto handleOption(Order order) {
        boolean cancel = order.getOrderStatus() == 101;
        boolean delete = order.getOrderStatus() == 401 || Boolean.TRUE.equals(order.getDeleted());
        boolean pay = order.getOrderStatus() == 101;
        boolean confirm = order.getOrderStatus() == 301;
        boolean refund = order.getOrderStatus() == 201;
        boolean rebuy = order.getOrderStatus() == 401;
        boolean comment = order.getOrderStatus() == 401;
        boolean aftersale = order.getOrderStatus() >= 201 && order.getOrderStatus() < 401;
        return new OrderHandleOptionDto(cancel, delete, pay, comment, confirm, refund, rebuy, aftersale);
    }

    private String statusText(Integer status) {
        if (status == null) {
            return "";
        }
        return switch (status) {
            case 101 -> "未付款";
            case 201 -> "已付款";
            case 301 -> "已发货";
            case 401 -> "已完成";
            default -> "未知";
        };
    }

    private String[] splitSpecs(String specs) {
        if (specs == null) {
            return new String[0];
        }
        return Arrays.stream(specs.split(","))
                .map(String::trim)
                .filter(s -> !s.isEmpty())
                .toArray(String[]::new);
    }

    private Address resolveAddress(User user, String addressIdRaw) {
        try {
            long addressId = Long.parseLong(addressIdRaw);
            if (addressId > 0) {
                return addressRepository.findById(addressId).orElse(null);
            }
        } catch (NumberFormatException ignored) {
        }
        return addressRepository.findByUserAndIsDefaultTrueAndDeletedFalse(user)
                .orElseGet(() -> addressRepository.findByUserAndDeletedFalseOrderByAddTimeDesc(user)
                        .stream().findFirst().orElse(null));
    }
}
