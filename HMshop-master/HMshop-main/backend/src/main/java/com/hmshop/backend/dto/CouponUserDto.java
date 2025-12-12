package com.hmshop.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CouponUserDto {
    private Long id;
    private Long cid;
    private String name;
    private String desc;
    private String tag;
    private Double min;
    private Double discount;
    private String startTime;
    private String endTime;
    private Boolean available;
}
