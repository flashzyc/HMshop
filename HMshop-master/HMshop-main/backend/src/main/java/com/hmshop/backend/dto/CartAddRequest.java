package com.hmshop.backend.dto;

import lombok.Data;

@Data
public class CartAddRequest {
    private Long goodsId;
    private Integer number;
    private Long productId;
}
