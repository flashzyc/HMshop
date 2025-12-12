package com.hmshop.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GoodsInfoDto {
    private Long id;
    private String goodsSn;
    private String name;
    private Long categoryId;
    private Long brandId;
    private List<String> gallery;
    private String keywords;
    private String brief;
    private Boolean isOnSale;
    private Integer sortOrder;
    private String picUrl;
    private String shareUrl;
    private Boolean isNew;
    private Boolean isHot;
    private String unit;
    private Double counterPrice;
    private Double retailPrice;
    private String addTime;
    private String updateTime;
    private Boolean deleted;
    private String detail;
}
