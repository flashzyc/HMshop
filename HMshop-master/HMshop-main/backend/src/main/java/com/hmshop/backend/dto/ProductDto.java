package com.hmshop.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductDto {
    private Long id;
    private Long goodsId;
    private String[] specifications;
    private Double price;
    private Integer number;
    private String url;
    private String addTime;
    private String updateTime;
    private Boolean deleted;
}
