package com.hmshop.backend.controller;

import com.hmshop.backend.common.ApiResponse;
import com.hmshop.backend.dto.AiChatRequest;
import com.hmshop.backend.dto.AiChatResponse;
import com.hmshop.backend.entity.Goods;
import com.hmshop.backend.entity.User;
import com.hmshop.backend.service.AiService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/wx/ai")
@RequiredArgsConstructor
public class AiController extends BaseController {

    private final AiService aiService;

    /**
     * 获取AI智能推荐商品 (旧接口)
     * @param request 请求对象，用于获取当前登录用户
     * @return 推荐商品列表
     */
    @GetMapping("/recommend")
    public ApiResponse<List<Goods>> recommend(HttpServletRequest request) {
        User currentUser = getCurrentUser(request);
        Long userId = (currentUser != null) ? currentUser.getId() : null;
        
        List<Goods> recommendations = aiService.recommendGoods(userId);
        return ApiResponse.ok(recommendations);
    }

    /**
     * AI 智能对话
     * @param chatRequest 用户消息
     * @return AI回复和推荐
     */
    @PostMapping("/chat")
    public ApiResponse<AiChatResponse> chat(@RequestBody AiChatRequest chatRequest) {
        return ApiResponse.ok(aiService.chat(chatRequest.getMessage()));
    }
}
