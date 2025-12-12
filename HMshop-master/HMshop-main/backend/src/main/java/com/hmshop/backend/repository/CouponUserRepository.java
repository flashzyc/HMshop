package com.hmshop.backend.repository;

import com.hmshop.backend.entity.CouponUser;
import com.hmshop.backend.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CouponUserRepository extends JpaRepository<CouponUser, Long> {
    List<CouponUser> findByUserAndStatus(User user, Integer status);

    List<CouponUser> findByUser(User user);
}
