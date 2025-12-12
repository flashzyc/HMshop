package com.hmshop.backend.controller;

import com.hmshop.backend.common.ApiResponse;
import com.hmshop.backend.dto.IndividualViewDto;
import com.hmshop.backend.entity.User;
import com.hmshop.backend.service.OrderService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/wx/user")
@RequiredArgsConstructor
public class UserController extends BaseController {

    private final OrderService orderService;

    @GetMapping("/index")
    public ApiResponse<IndividualViewDto> index(HttpServletRequest request) {
        User user = getCurrentUser(request);
        if (user == null) {
            return needLogin();
        }
        IndividualViewDto dto = new IndividualViewDto(orderService.count(user));
        return ApiResponse.ok(dto);
    }
}
