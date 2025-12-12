package com.hmshop.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderCheckoutDto {
    private Long grouponRulesId;
    private double actualPrice;
    private double orderTotalPrice;
    private Long cartId;
    private Long userCouponId;
    private Long couponId;
    private double goodsTotalPrice;
    private Long addressId;
    private double grouponPrice;
    private CheckedAddressDto checkedAddress;
    private double couponPrice;
    private int availableCouponLength;
    private double freightPrice;
    private List<CheckedGoodsItemDto> checkedGoodsList;
}
