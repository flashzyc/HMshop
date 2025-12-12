package com.hmshop.backend.repository;

import com.hmshop.backend.entity.Collect;
import com.hmshop.backend.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CollectRepository extends JpaRepository<Collect, Long> {
    List<Collect> findByUser(User user);
}
