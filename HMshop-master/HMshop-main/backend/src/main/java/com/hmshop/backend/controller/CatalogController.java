package com.hmshop.backend.controller;

import com.hmshop.backend.common.ApiResponse;
import com.hmshop.backend.dto.CatalogResponseDto;
import com.hmshop.backend.service.CatalogService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/wx/catalog")
@RequiredArgsConstructor
public class CatalogController extends BaseController {

    private final CatalogService catalogService;

    @GetMapping("/index")
    public ApiResponse<CatalogResponseDto> index() {
        return ApiResponse.ok(catalogService.index());
    }

    @GetMapping("/current")
    public ApiResponse<CatalogResponseDto> current(@RequestParam Long id) {
        return ApiResponse.ok(catalogService.current(id));
    }
}
