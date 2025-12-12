package com.hmshop.backend.controller;

import com.hmshop.backend.common.ApiResponse;
import com.hmshop.backend.dto.*;
import com.hmshop.backend.entity.User;
import com.hmshop.backend.service.OrderService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/wx/order")
@RequiredArgsConstructor
public class OrderController extends BaseController {

    private final OrderService orderService;

    @PostMapping("/submit")
    public ApiResponse<SubmitOrderResponse> submit(HttpServletRequest request, @RequestBody SubmitOrderRequest req) {
        User user = getCurrentUser(request);
        if (user == null) {
            return needLogin();
        }
        return orderService.submitOrder(user, req);
    }

    @GetMapping("/detail")
    public ApiResponse<PayViewDto> detail(HttpServletRequest request, @RequestParam Long orderId) {
        User user = getCurrentUser(request);
        if (user == null) {
            return needLogin();
        }
        return orderService.getOrderInfo(user, orderId);
    }

    @PostMapping("/h5pay")
    public ApiResponse<?> pay(HttpServletRequest request, @RequestBody IdRequest req) {
        User user = getCurrentUser(request);
        if (user == null) {
            return needLogin();
        }
        return orderService.pay(user, req.getOrderId());
    }

    @GetMapping("/list")
    public ApiResponse<OrderListViewDto> list(HttpServletRequest request,
                                              @RequestParam(defaultValue = "0") int showType,
                                              @RequestParam(defaultValue = "1") int page,
                                              @RequestParam(defaultValue = "10") int limit) {
        User user = getCurrentUser(request);
        if (user == null) {
            return needLogin();
        }
        return orderService.list(user, showType, page, limit);
    }

    @PostMapping("/delete")
    public ApiResponse<?> delete(HttpServletRequest request, @RequestBody IdRequest req) {
        User user = getCurrentUser(request);
        if (user == null) {
            return needLogin();
        }
        return orderService.delete(user, req.getOrderId());
    }
}
