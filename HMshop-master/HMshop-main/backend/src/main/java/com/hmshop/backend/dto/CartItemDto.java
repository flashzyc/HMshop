package com.hmshop.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartItemDto {
    private Long id;
    private Long userId;
    private Long goodsId;
    private String goodsSn;
    private String goodsName;
    private Long productId;
    private Double price;
    private Integer number;
    private String[] specifications;
    private Boolean checked;
    private String picUrl;
    private String addTime;
    private String updateTime;
    private Boolean deleted;
}
