package com.hmshop.backend.repository;

import com.hmshop.backend.entity.Brand;
import com.hmshop.backend.entity.Category;
import com.hmshop.backend.entity.Goods;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface GoodsRepository extends JpaRepository<Goods, Long>, JpaSpecificationExecutor<Goods> {
    List<Goods> findByBrandAndDeletedFalse(Brand brand);

    List<Goods> findByCategoryAndDeletedFalse(Category category);

    List<Goods> findByIsHotTrueAndDeletedFalse();

    List<Goods> findByIsNewTrueAndDeletedFalse();
}
