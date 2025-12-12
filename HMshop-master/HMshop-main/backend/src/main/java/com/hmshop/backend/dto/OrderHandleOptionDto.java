package com.hmshop.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderHandleOptionDto {
    private boolean cancel;
    private boolean delete;
    private boolean pay;
    private boolean comment;
    private boolean confirm;
    private boolean refund;
    private boolean rebuy;
    private boolean aftersale;
}
