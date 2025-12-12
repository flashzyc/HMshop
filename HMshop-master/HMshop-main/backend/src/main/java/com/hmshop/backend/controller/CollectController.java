package com.hmshop.backend.controller;

import com.hmshop.backend.common.ApiResponse;
import com.hmshop.backend.entity.Collect;
import com.hmshop.backend.entity.User;
import com.hmshop.backend.repository.CollectRepository;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/wx/collect")
@RequiredArgsConstructor
public class CollectController extends BaseController {

    private final CollectRepository collectRepository;

    @GetMapping("/list")
    public ApiResponse<Map<String, Object>> list(HttpServletRequest request,
                                                 @RequestParam(defaultValue = "0") int type,
                                                 @RequestParam(defaultValue = "1") int page,
                                                 @RequestParam(defaultValue = "10") int limit) {
        User user = getCurrentUser(request);
        if (user == null) {
            return needLogin();
        }
        List<Collect> list = collectRepository.findByUser(user);
        List<String> names = list.stream()
                .map(c -> "收藏-" + c.getValueId())
                .collect(Collectors.toList());
        Map<String, Object> data = new HashMap<>();
        data.put("list", names);
        return ApiResponse.ok(data);
    }
}
