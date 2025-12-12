package com.hmshop.backend.controller;

import com.hmshop.backend.common.ApiResponse;
import com.hmshop.backend.dto.CouponListViewDto;
import com.hmshop.backend.entity.User;
import com.hmshop.backend.service.CouponService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/wx/coupon")
@RequiredArgsConstructor
public class CouponController extends BaseController {

    private final CouponService couponService;

    @GetMapping("/mylist")
    public ApiResponse<CouponListViewDto> mylist(HttpServletRequest request,
                                                 @RequestParam(defaultValue = "0") Integer status,
                                                 @RequestParam(defaultValue = "1") int page,
                                                 @RequestParam(defaultValue = "10") int limit) {
        User user = getCurrentUser(request);
        if (user == null) {
            return needLogin();
        }
        return ApiResponse.ok(couponService.listUserCoupons(user, status));
    }
}
