package com.hmshop.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GroupBuyDto {
    private Long id;
    private Long goodsId;
    private String name;
    private String brief;
    private String picUrl;
    private Double counterPrice;
    private Double retailPrice;
    private Double grouponPrice;
    private Double grouponDiscount;
    private Integer grouponMember;
    private String expireTime;
}
