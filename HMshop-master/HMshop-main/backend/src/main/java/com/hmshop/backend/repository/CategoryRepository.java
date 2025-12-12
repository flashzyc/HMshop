package com.hmshop.backend.repository;

import com.hmshop.backend.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface CategoryRepository extends JpaRepository<Category, Long> {
    List<Category> findByPidAndDeletedFalseOrderBySortOrderAsc(Long pid);

    Optional<Category> findByIdAndDeletedFalse(Long id);
}
