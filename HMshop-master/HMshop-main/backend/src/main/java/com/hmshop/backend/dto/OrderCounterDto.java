package com.hmshop.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderCounterDto {
    private int unrecv;
    private int uncomment;
    private int unpaid;
    private int unship;
}
