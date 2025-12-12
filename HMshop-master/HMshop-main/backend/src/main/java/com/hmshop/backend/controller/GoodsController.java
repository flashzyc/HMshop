package com.hmshop.backend.controller;

import com.hmshop.backend.common.ApiResponse;
import com.hmshop.backend.dto.GoodsDetailDto;
import com.hmshop.backend.dto.GoodsListResponseDto;
import com.hmshop.backend.entity.Category;
import com.hmshop.backend.service.CatalogService;
import com.hmshop.backend.service.GoodsService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/wx/goods")
@RequiredArgsConstructor
public class GoodsController extends BaseController {

    private final GoodsService goodsService;
    private final CatalogService catalogService;

    @GetMapping("/list")
    public ApiResponse<GoodsListResponseDto> list(@RequestParam(defaultValue = "1") int page,
                                                  @RequestParam(defaultValue = "10") int limit,
                                                  @RequestParam(required = false) Boolean isNew,
                                                  @RequestParam(required = false) Boolean isHot,
                                                  @RequestParam(required = false) Long categoryId,
                                                  @RequestParam(required = false) Long brandId,
                                                  @RequestParam(required = false) String keyword) {
        return ApiResponse.ok(goodsService.listGoods(page, limit, isNew, isHot, categoryId, brandId, keyword));
    }

    @GetMapping("/detail")
    public ApiResponse<GoodsDetailDto> detail(@RequestParam Long id) {
        return ApiResponse.ok(goodsService.getGoodsDetail(id));
    }

    @GetMapping("/category")
    public ApiResponse<Map<String, Object>> category(@RequestParam Long id) {
        Category current = catalogService.getCategory(id);
        Map<String, Object> data = new HashMap<>();
        data.put("brotherCategory", catalogService.findSiblings(current));
        data.put("currentCategory", current);
        return ApiResponse.ok(data);
    }
}
