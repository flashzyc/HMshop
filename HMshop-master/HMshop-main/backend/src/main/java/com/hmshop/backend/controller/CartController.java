package com.hmshop.backend.controller;

import com.hmshop.backend.common.ApiResponse;
import com.hmshop.backend.dto.*;
import com.hmshop.backend.entity.User;
import com.hmshop.backend.service.CartService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/wx/cart")
@RequiredArgsConstructor
public class CartController extends BaseController {

    private final CartService cartService;

    @GetMapping("/index")
    public ApiResponse<CartViewDto> index(HttpServletRequest request) {
        User user = getCurrentUser(request);
        if (user == null) {
            return needLogin();
        }
        return ApiResponse.ok(cartService.getCart(user));
    }

    @PostMapping("/checked")
    public ApiResponse<CartViewDto> checked(HttpServletRequest request, @RequestBody CartCheckRequest req) {
        User user = getCurrentUser(request);
        if (user == null) {
            return needLogin();
        }
        boolean checked = req.getIsChecked() != null && req.getIsChecked() == 1;
        return cartService.setChecked(user, req.getProductIds(), checked);
    }

    @PostMapping("/delete")
    public ApiResponse<CartViewDto> delete(HttpServletRequest request, @RequestBody CartDeleteRequest req) {
        User user = getCurrentUser(request);
        if (user == null) {
            return needLogin();
        }
        return cartService.deleteProducts(user, req.getProductIds());
    }

    @PostMapping("/update")
    public ApiResponse<Void> update(HttpServletRequest request, @RequestBody CartUpdateRequest req) {
        User user = getCurrentUser(request);
        if (user == null) {
            return needLogin();
        }
        return cartService.updateNumber(user, req.getId(), req.getNumber());
    }

    @PostMapping("/add")
    public ApiResponse<Integer> add(HttpServletRequest request, @RequestBody CartAddRequest req) {
        User user = getCurrentUser(request);
        if (user == null) {
            return needLogin();
        }
        return cartService.addToCart(user, req, false);
    }

    @PostMapping("/fastadd")
    public ApiResponse<Long> fastAdd(HttpServletRequest request, @RequestBody CartAddRequest req) {
        User user = getCurrentUser(request);
        if (user == null) {
            return needLogin();
        }
        return cartService.fastAdd(user, req);
    }

    @GetMapping("/checkout")
    public ApiResponse<OrderCheckoutDto> checkout(HttpServletRequest request,
                                                  @RequestParam(defaultValue = "0") Long cartId,
                                                  @RequestParam(defaultValue = "0") Long addressId,
                                                  @RequestParam(defaultValue = "0") Long couponId,
                                                  @RequestParam(defaultValue = "0") Long userCouponId,
                                                  @RequestParam(defaultValue = "0") Long grouponRulesId) {
        User user = getCurrentUser(request);
        if (user == null) {
            return needLogin();
        }
        return cartService.checkout(user, cartId, addressId, couponId, userCouponId, grouponRulesId);
    }
}
