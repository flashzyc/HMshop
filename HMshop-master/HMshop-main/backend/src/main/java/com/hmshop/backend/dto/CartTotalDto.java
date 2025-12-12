package com.hmshop.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartTotalDto {
    private int goodsCount;
    private int checkedGoodsCount;
    private double goodsAmount;
    private double checkedGoodsAmount;
}
