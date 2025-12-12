package com.hmshop.backend.repository;

import com.hmshop.backend.entity.Goods;
import com.hmshop.backend.entity.GoodsAttribute;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface GoodsAttributeRepository extends JpaRepository<GoodsAttribute, Long> {
    List<GoodsAttribute> findByGoodsAndDeletedFalse(Goods goods);
}
