package com.hmshop.backend.service;

import com.hmshop.backend.common.ApiResponse;
import com.hmshop.backend.dto.*;
import com.hmshop.backend.entity.*;
import com.hmshop.backend.repository.*;
import com.hmshop.backend.util.DateUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CartService {

    private final CartRepository cartRepository;
    private final GoodsRepository goodsRepository;
    private final GoodsProductRepository productRepository;
    private final CouponUserRepository couponUserRepository;
    private final AddressRepository addressRepository;

    public CartViewDto getCart(User user) {
        List<Cart> cartList = cartRepository.findByUserAndDeletedFalse(user);
        return toCartView(cartList, user.getId());
    }

    public ApiResponse<CartViewDto> setChecked(User user, List<Long> productIds, boolean checked) {
        if (!CollectionUtils.isEmpty(productIds)) {
            List<Cart> list = cartRepository.findByUserAndProductIdIn(user, productIds);
            list.forEach(c -> c.setChecked(checked));
            cartRepository.saveAll(list);
        }
        return ApiResponse.ok(toCartView(cartRepository.findByUserAndDeletedFalse(user), user.getId()));
    }

    public ApiResponse<CartViewDto> deleteProducts(User user, List<Long> productIds) {
        List<Cart> list = cartRepository.findByUserAndProductIdIn(user, productIds);
        list.forEach(c -> c.setDeleted(true));
        cartRepository.saveAll(list);
        return ApiResponse.ok(toCartView(cartRepository.findByUserAndDeletedFalse(user), user.getId()));
    }

    public ApiResponse<Void> updateNumber(User user, Long cartId, int number) {
        Optional<Cart> cartOpt = cartRepository.findByIdAndUser(cartId, user);
        if (cartOpt.isEmpty()) {
            return ApiResponse.fail(402, "购物车不存在");
        }
        Cart cart = cartOpt.get();
        cart.setNumber(number);
        cart.setUpdateTime(LocalDateTime.now());
        cartRepository.save(cart);
        return ApiResponse.ok(null);
    }

    public ApiResponse<Integer> addToCart(User user, CartAddRequest req, boolean fastAdd) {
        Goods goods = goodsRepository.findById(req.getGoodsId()).orElse(null);
        GoodsProduct product = productRepository.findByIdAndDeletedFalse(req.getProductId()).orElse(null);
        if (goods == null || product == null) {
            return ApiResponse.fail(402, "商品不存在");
        }
        Cart cart;
        if (!fastAdd) {
            cart = cartRepository.findByUserAndProductIdIn(user, List.of(product.getId()))
                    .stream().findFirst().orElse(new Cart());
        } else {
            cart = new Cart();
            cart.setFastAdd(true);
        }
        if (cart.getId() == null) {
            cart.setUser(user);
            cart.setGoodsId(goods.getId());
            cart.setGoodsSn(goods.getGoodsSn());
            cart.setGoodsName(goods.getName());
            cart.setProductId(product.getId());
            cart.setPrice(product.getPrice());
            cart.setNumber(req.getNumber());
            cart.setSpecifications(product.getSpecifications());
            cart.setChecked(true);
            cart.setPicUrl(product.getUrl());
            cart.setAddTime(LocalDateTime.now());
            cart.setUpdateTime(LocalDateTime.now());
            cart.setDeleted(false);
        } else {
            cart.setNumber(cart.getNumber() + req.getNumber());
            cart.setUpdateTime(LocalDateTime.now());
        }
        cartRepository.save(cart);
        int count = cartRepository.findByUserAndDeletedFalse(user).stream()
                .mapToInt(Cart::getNumber).sum();
        return ApiResponse.ok("加入购物车成功", count);
    }

    public ApiResponse<Long> fastAdd(User user, CartAddRequest req) {
        ApiResponse<Integer> res = addToCart(user, req, true);
        if (res.getErrno() != 0) {
            return ApiResponse.fail(res.getErrno(), res.getErrmsg());
        }
        Cart latest = cartRepository.findByUserAndDeletedFalse(user).stream()
                .filter(c -> Boolean.TRUE.equals(c.getFastAdd()))
                .max(Comparator.comparing(Cart::getAddTime))
                .orElse(null);
        return latest == null ? ApiResponse.fail(402, "添加失败") : ApiResponse.ok(latest.getId());
    }

    public ApiResponse<OrderCheckoutDto> checkout(User user, Long cartId, Long addressId, Long couponId,
                                                  Long userCouponId, Long grouponRulesId) {
        List<Cart> cartItems;
        if (cartId != null && cartId != 0) {
            cartItems = cartRepository.findByIdAndUser(cartId, user)
                    .map(List::of)
                    .orElse(List.of());
        } else {
            cartItems = cartRepository.findByUserAndDeletedFalse(user).stream()
                    .filter(c -> Boolean.TRUE.equals(c.getChecked()))
                    .toList();
        }
        Address address = resolveAddress(user, addressId);
        int availableCoupon = (int) couponUserRepository.findByUserAndStatus(user, 0).stream()
                .filter(cu -> cu.getEndTime() == null || cu.getEndTime().isAfter(LocalDateTime.now()))
                .count();

        double goodsTotal = cartItems.stream().mapToDouble(c -> c.getPrice() * c.getNumber()).sum();
        double freightPrice = goodsTotal > 99 ? 0 : 8;
        double couponPrice = 0;
        if (couponId != null && couponId > 0) {
            couponPrice = Math.min(goodsTotal, 5);
        }
        double orderTotal = goodsTotal + freightPrice - couponPrice;
        double actualPrice = orderTotal;

        List<CheckedGoodsItemDto> goodsDtos = cartItems.stream()
                .map(c -> new CheckedGoodsItemDto(
                        c.getId(), user.getId(), c.getGoodsId(), c.getGoodsSn(), c.getGoodsName(),
                        c.getProductId(), c.getPrice(), c.getNumber(),
                        splitSpecs(c.getSpecifications()), c.getChecked(), c.getPicUrl(),
                        DateUtil.format(c.getAddTime()), DateUtil.format(c.getUpdateTime()), c.getDeleted()
                )).toList();

        CheckedAddressDto checkedAddress = buildCheckedAddress(user, address);

        OrderCheckoutDto dto = new OrderCheckoutDto(
                grouponRulesId == null ? 0L : grouponRulesId,
                actualPrice,
                orderTotal,
                cartId == null ? 0L : cartId,
                userCouponId == null ? 0L : userCouponId,
                couponId == null ? 0L : couponId,
                goodsTotal,
                address == null ? null : address.getId(),
                0,
                checkedAddress,
                couponPrice,
                availableCoupon,
                freightPrice,
                goodsDtos
        );
        return ApiResponse.ok(dto);
    }

    private CheckedAddressDto buildCheckedAddress(User user, Address address) {
        if (address != null) {
            return new CheckedAddressDto(
                    address.getId(), address.getName(), user.getId(),
                    address.getProvince(), address.getCity(), address.getCounty(),
                    address.getAddressDetail(), address.getAreaCode(), address.getPostalCode(),
                    address.getTel(), address.getIsDefault(), DateUtil.format(address.getAddTime()),
                    DateUtil.format(address.getUpdateTime()), address.getDeleted()
            );
        }
        return new CheckedAddressDto(0L, "", user.getId(), "", "", "",
                "", "", "", "", false, null, null, false);
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

    private CartViewDto toCartView(List<Cart> cartList, Long userId) {
        List<CartItemDto> items = cartList.stream().map(c -> new CartItemDto(
                c.getId(),
                userId,
                c.getGoodsId(),
                c.getGoodsSn(),
                c.getGoodsName(),
                c.getProductId(),
                c.getPrice(),
                c.getNumber(),
                splitSpecs(c.getSpecifications()),
                c.getChecked(),
                c.getPicUrl(),
                DateUtil.format(c.getAddTime()),
                DateUtil.format(c.getUpdateTime()),
                c.getDeleted()
        )).collect(Collectors.toList());

        int goodsCount = cartList.stream().mapToInt(Cart::getNumber).sum();
        int checkedCount = cartList.stream()
                .filter(c -> Boolean.TRUE.equals(c.getChecked()))
                .mapToInt(Cart::getNumber).sum();
        double goodsAmount = cartList.stream().mapToDouble(c -> c.getPrice() * c.getNumber()).sum();
        double checkedAmount = cartList.stream()
                .filter(c -> Boolean.TRUE.equals(c.getChecked()))
                .mapToDouble(c -> c.getPrice() * c.getNumber()).sum();

        CartTotalDto totalDto = new CartTotalDto(goodsCount, checkedCount, goodsAmount, checkedAmount);
        return new CartViewDto(items, totalDto);
    }

    private Address resolveAddress(User user, Long addressId) {
        if (addressId != null && addressId > 0) {
            return addressRepository.findByIdAndUser(addressId, user).orElse(null);
        }
        return addressRepository.findByUserAndIsDefaultTrueAndDeletedFalse(user)
                .orElseGet(() -> addressRepository.findByUserAndDeletedFalseOrderByAddTimeDesc(user)
                        .stream().findFirst().orElse(null));
    }
}

