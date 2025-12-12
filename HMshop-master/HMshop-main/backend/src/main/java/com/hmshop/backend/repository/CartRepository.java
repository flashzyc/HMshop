package com.hmshop.backend.repository;

import com.hmshop.backend.entity.Cart;
import com.hmshop.backend.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

public interface CartRepository extends JpaRepository<Cart, Long> {
    List<Cart> findByUserAndDeletedFalse(User user);

    List<Cart> findByUserAndProductIdIn(User user, Collection<Long> productIds);

    Optional<Cart> findByIdAndUser(Long id, User user);
}
