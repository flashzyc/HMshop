package com.hmshop.backend.dto;

import com.hmshop.backend.entity.GoodsAttribute;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GoodsDetailDto {
    private GoodsInfoDto info;
    private List<GoodsAttribute> attribute;
    private List<SpecificationDto> specificationList;
    private List<ProductDto> productList;
}
