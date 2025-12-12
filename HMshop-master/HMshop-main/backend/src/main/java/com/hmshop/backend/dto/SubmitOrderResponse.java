package com.hmshop.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SubmitOrderResponse {
    private Long orderId;
    private Long grouponLinkId;
    private boolean payed;
}
