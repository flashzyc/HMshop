package com.hmshop.backend.repository;

import com.hmshop.backend.entity.Goods;
import com.hmshop.backend.entity.GoodsSpecification;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface GoodsSpecificationRepository extends JpaRepository<GoodsSpecification, Long> {
    List<GoodsSpecification> findByGoodsAndDeletedFalse(Goods goods);
}
