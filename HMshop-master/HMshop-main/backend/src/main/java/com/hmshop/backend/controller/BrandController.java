package com.hmshop.backend.controller;

import com.hmshop.backend.common.ApiResponse;
import com.hmshop.backend.entity.Brand;
import com.hmshop.backend.repository.BrandRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/wx/brand")
@RequiredArgsConstructor
public class BrandController extends BaseController {

    private final BrandRepository brandRepository;

    @GetMapping("/list")
    public ApiResponse<Map<String, Object>> list(@RequestParam(defaultValue = "1") int page,
                                                 @RequestParam(defaultValue = "10") int limit) {
        List<Brand> brands = brandRepository.findAll(PageRequest.of(Math.max(page - 1, 0), limit)).getContent();
        Map<String, Object> data = new HashMap<>();
        data.put("list", brands);
        return ApiResponse.ok(data);
    }

    @GetMapping("/detail")
    public ApiResponse<Brand> detail(@RequestParam Long id) {
        return brandRepository.findById(id)
                .map(ApiResponse::ok)
                .orElse(ApiResponse.fail(402, "品牌不存在"));
    }
}
