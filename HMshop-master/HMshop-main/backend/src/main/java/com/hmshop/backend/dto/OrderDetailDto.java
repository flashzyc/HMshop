package com.hmshop.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderDetailDto {
    private String orderStatusText;
    private Integer aftersaleStatus;
    private Boolean isGroupin;
    private String orderSn;
    private Double actualPrice;
    private List<OrderGoodsDto> goodsList;
    private Long id;
    private OrderHandleOptionDto handleOption;
}
