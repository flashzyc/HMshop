package com.hmshop.backend.repository;

import com.hmshop.backend.entity.Goods;
import com.hmshop.backend.entity.GoodsProduct;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface GoodsProductRepository extends JpaRepository<GoodsProduct, Long> {
    List<GoodsProduct> findByGoodsAndDeletedFalse(Goods goods);

    Optional<GoodsProduct> findByIdAndDeletedFalse(Long id);
}
