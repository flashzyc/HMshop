package com.hmshop.backend.repository;

import com.hmshop.backend.entity.Banner;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BannerRepository extends JpaRepository<Banner, Long> {
    List<Banner> findByDeletedFalseAndEnabledTrueOrderByPositionAsc();
}
