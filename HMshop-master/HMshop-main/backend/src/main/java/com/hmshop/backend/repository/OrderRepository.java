package com.hmshop.backend.repository;

import com.hmshop.backend.entity.Order;
import com.hmshop.backend.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByUserAndOrderStatusInAndDeletedFalseOrderByAddTimeDesc(User user, Collection<Integer> statuses);

    List<Order> findByUserAndDeletedFalseOrderByAddTimeDesc(User user);

    Optional<Order> findByIdAndUserAndDeletedFalse(Long id, User user);
}
