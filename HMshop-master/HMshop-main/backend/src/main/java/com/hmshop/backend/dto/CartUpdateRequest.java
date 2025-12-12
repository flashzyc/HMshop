package com.hmshop.backend.dto;

import lombok.Data;

@Data
public class CartUpdateRequest {
    private Integer number;
    private Long goodsId;
    private Long id;
    private Long productId;
}
