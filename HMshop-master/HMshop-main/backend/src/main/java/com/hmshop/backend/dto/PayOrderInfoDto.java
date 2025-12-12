package com.hmshop.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PayOrderInfoDto {
    private String consignee;
    private String address;
    private String addTime;
    private String orderSn;
    private Double actualPrice;
    private String mobile;
    private String message;
    private String orderStatusText;
    private Integer aftersaleStatus;
    private Double goodsPrice;
    private Double couponPrice;
    private Long id;
    private Double freightPrice;
    private OrderHandleOptionDto handleOption;
}
