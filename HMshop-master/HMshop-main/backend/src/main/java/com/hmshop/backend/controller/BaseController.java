package com.hmshop.backend.controller;

import com.hmshop.backend.common.ApiResponse;
import com.hmshop.backend.entity.User;
import jakarta.servlet.http.HttpServletRequest;

public abstract class BaseController {

    protected User getCurrentUser(HttpServletRequest request) {
        Object user = request.getAttribute("currentUser");
        if (user instanceof User) {
            return (User) user;
        }
        return null;
    }

    protected <T> ApiResponse<T> needLogin() {
        return ApiResponse.fail(501, "请登录");
    }
}
