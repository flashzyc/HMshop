package com.hmshop.backend.service;

import com.hmshop.backend.dto.CouponListViewDto;
import com.hmshop.backend.dto.CouponUserDto;
import com.hmshop.backend.entity.CouponUser;
import com.hmshop.backend.entity.User;
import com.hmshop.backend.repository.CouponUserRepository;
import com.hmshop.backend.util.DateUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CouponService {
    private final CouponUserRepository couponUserRepository;

    public CouponListViewDto listUserCoupons(User user, Integer status) {
        List<CouponUser> coupons;
        if (status == null) {
            coupons = couponUserRepository.findByUser(user);
        } else {
            coupons = couponUserRepository.findByUserAndStatus(user, status);
        }

        List<CouponUserDto> dtoList = coupons.stream().map(cu -> {
            boolean available = cu.getStatus() != null && cu.getStatus() == 0 &&
                    (cu.getEndTime() == null || cu.getEndTime().isAfter(LocalDateTime.now()));
            return new CouponUserDto(
                    cu.getId(),
                    cu.getCoupon().getId(),
                    cu.getCoupon().getName(),
                    cu.getCoupon().getDesc(),
                    cu.getCoupon().getTag(),
                    cu.getCoupon().getMin(),
                    cu.getCoupon().getDiscount(),
                    DateUtil.format(cu.getStartTime()),
                    DateUtil.format(cu.getEndTime()),
                    available
            );
        }).toList();
        return new CouponListViewDto(dtoList);
    }
}
