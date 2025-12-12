package com.hmshop.backend.dto;

import com.hmshop.backend.entity.Category;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CatalogResponseDto {
    private List<Category> categoryList;
    private Category currentCategory;
    private List<Category> currentSubCategory;
}
