package com.hmshop.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SpecificationValueDto {
    private Long id;
    private Long goodsId;
    private String specification;
    private String value;
    private String picUrl;
    private String addTime;
    private String updateTime;
    private Boolean deleted;
}
