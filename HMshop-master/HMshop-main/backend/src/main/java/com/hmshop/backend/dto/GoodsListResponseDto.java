package com.hmshop.backend.dto;

import com.hmshop.backend.entity.Category;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GoodsListResponseDto {
    private long total;
    private long pages;
    private int limit;
    private int page;
    private List<SimpleGoodsDto> list;
    private List<Category> filterCategoryList;
}
