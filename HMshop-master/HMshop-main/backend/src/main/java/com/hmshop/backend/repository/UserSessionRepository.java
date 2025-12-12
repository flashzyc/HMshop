package com.hmshop.backend.repository;

import com.hmshop.backend.entity.User;
import com.hmshop.backend.entity.UserSession;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.Optional;

public interface UserSessionRepository extends JpaRepository<UserSession, Long> {
    Optional<UserSession> findByToken(String token);

    void deleteByUser(User user);

    void deleteByExpireAtBefore(LocalDateTime time);
}
