package com.hmshop.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SimpleGoodsDto {
    private Long id;
    private String name;
    private String brief;
    private String picUrl;
    private Boolean isNew;
    private Boolean isHot;
    private Double counterPrice;
    private Double retailPrice;
}
