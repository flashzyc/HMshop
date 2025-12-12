package com.hmshop.backend.repository;

import com.hmshop.backend.entity.Address;
import com.hmshop.backend.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface AddressRepository extends JpaRepository<Address, Long> {
    List<Address> findByUserAndDeletedFalseOrderByAddTimeDesc(User user);

    Optional<Address> findByUserAndIsDefaultTrueAndDeletedFalse(User user);

    Optional<Address> findByIdAndUser(Long id, User user);
}
