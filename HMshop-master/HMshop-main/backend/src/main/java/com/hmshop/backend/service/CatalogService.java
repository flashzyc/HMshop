package com.hmshop.backend.service;

import com.hmshop.backend.dto.CatalogResponseDto;
import com.hmshop.backend.entity.Category;
import com.hmshop.backend.repository.CategoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CatalogService {

    private final CategoryRepository categoryRepository;

    public CatalogResponseDto index() {
        List<Category> roots = categoryRepository.findByPidAndDeletedFalseOrderBySortOrderAsc(0L);
        Category current = roots.isEmpty() ? null : roots.get(0);
        List<Category> sub = current == null ? List.of() :
                categoryRepository.findByPidAndDeletedFalseOrderBySortOrderAsc(current.getId());
        return new CatalogResponseDto(roots, current, sub);
    }

    public CatalogResponseDto current(Long id) {
        Category current = categoryRepository.findByIdAndDeletedFalse(id).orElse(null);
        List<Category> roots = categoryRepository.findByPidAndDeletedFalseOrderBySortOrderAsc(0L);
        List<Category> sub = current == null ? List.of() :
                categoryRepository.findByPidAndDeletedFalseOrderBySortOrderAsc(current.getId());
        return new CatalogResponseDto(roots, current, sub);
    }

    public Category getCategory(Long id) {
        return categoryRepository.findByIdAndDeletedFalse(id).orElse(null);
    }

    public List<Category> findSiblings(Category category) {
        if (category == null) {
            return List.of();
        }
        return categoryRepository.findByPidAndDeletedFalseOrderBySortOrderAsc(category.getPid());
    }
}
