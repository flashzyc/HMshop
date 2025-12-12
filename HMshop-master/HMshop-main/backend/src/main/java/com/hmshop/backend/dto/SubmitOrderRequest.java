package com.hmshop.backend.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class SubmitOrderRequest {
    @NotNull
    private String addressId;
    @NotNull
    private String cartId;
    @NotNull
    private String couponId;
    @NotNull
    private String userCouponId;
    private Long grouponLinkId;
    private Long grouponRulesId;
    private String message;
}
