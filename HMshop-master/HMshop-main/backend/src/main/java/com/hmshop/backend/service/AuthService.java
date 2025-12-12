package com.hmshop.backend.service;

import com.hmshop.backend.common.ApiResponse;
import com.hmshop.backend.dto.LoginResponse;
import com.hmshop.backend.dto.UserInfoDto;
import com.hmshop.backend.entity.User;
import com.hmshop.backend.entity.UserSession;
import com.hmshop.backend.repository.UserRepository;
import com.hmshop.backend.repository.UserSessionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserRepository userRepository;
    private final UserSessionRepository sessionRepository;
    private final PasswordEncoder passwordEncoder;

    public Optional<User> getUserByToken(String token) {
        if (!StringUtils.hasText(token)) {
            return Optional.empty();
        }
        sessionRepository.deleteByExpireAtBefore(LocalDateTime.now());
        return sessionRepository.findByToken(token)
                .filter(session -> session.getExpireAt() == null || session.getExpireAt().isAfter(LocalDateTime.now()))
                .map(UserSession::getUser);
    }

    public ApiResponse<LoginResponse> login(String username, String rawPassword) {
        Optional<User> userOpt = userRepository.findByUsername(username);
        if (userOpt.isEmpty()) {
            return ApiResponse.fail(402, "账号或密码错误");
        }
        User user = userOpt.get();
        boolean passwordOk = passwordEncoder.matches(rawPassword, user.getPassword()) ||
                rawPassword.equals(user.getPassword());
        if (!passwordOk) {
            return ApiResponse.fail(402, "账号或密码错误");
        }

        sessionRepository.deleteByUser(user);
        UserSession session = new UserSession();
        session.setUser(user);
        session.setToken(UUID.randomUUID().toString().replace("-", ""));
        session.setAddTime(LocalDateTime.now());
        session.setExpireAt(LocalDateTime.now().plusDays(3));
        sessionRepository.save(session);

        LoginResponse resp = new LoginResponse(new UserInfoDto(user.getNickname(), user.getAvatar()), session.getToken());
        return ApiResponse.ok(resp);
    }

    public void logout(User user) {
        sessionRepository.deleteByUser(user);
    }
}
