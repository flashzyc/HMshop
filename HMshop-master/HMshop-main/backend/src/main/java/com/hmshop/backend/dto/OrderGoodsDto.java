package com.hmshop.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderGoodsDto {
    private Integer number;
    private String picUrl;
    private Double price;
    private Long id;
    private String goodsName;
    private String[] specifications;
}
