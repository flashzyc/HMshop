package com.hmshop.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CheckedAddressDto {
    private Long id;
    private String name;
    private Long userId;
    private String province;
    private String city;
    private String county;
    private String addressDetail;
    private String areaCode;
    private String postalCode;
    private String tel;
    private Boolean isDefault;
    private String addTime;
    private String updateTime;
    private Boolean deleted;
}
