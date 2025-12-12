package com.hmshop.backend.config;

import com.hmshop.backend.entity.User;
import com.hmshop.backend.service.AuthService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.Optional;

@Component
@RequiredArgsConstructor
public class AuthFilter extends OncePerRequestFilter {

    private final AuthService authService;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        String token = request.getHeader("x-litemall-token");
        if (!org.springframework.util.StringUtils.hasText(token)) {
            token = request.getHeader("X-Litemall-Token");
        }

        if (org.springframework.util.StringUtils.hasText(token)) {
            Optional<User> userOpt = authService.getUserByToken(token);
            userOpt.ifPresent(user -> request.setAttribute("currentUser", user));
        }

        filterChain.doFilter(request, response);
    }
}
