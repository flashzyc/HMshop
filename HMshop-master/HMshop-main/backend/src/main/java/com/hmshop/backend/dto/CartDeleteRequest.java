package com.hmshop.backend.dto;

import lombok.Data;

import java.util.List;

@Data
public class CartDeleteRequest {
    private List<Long> productIds;
}
