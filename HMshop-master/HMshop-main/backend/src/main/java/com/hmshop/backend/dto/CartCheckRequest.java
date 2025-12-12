package com.hmshop.backend.dto;

import lombok.Data;

import java.util.List;

@Data
public class CartCheckRequest {
    private List<Long> productIds;
    private Integer isChecked;
}
