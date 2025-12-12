package com.hmshop.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CouponHomeDto {
    private Long id;
    private String name;
    private String desc;
    private String tag;
    private Double discount;
    private Double min;
    private Integer days;
}
