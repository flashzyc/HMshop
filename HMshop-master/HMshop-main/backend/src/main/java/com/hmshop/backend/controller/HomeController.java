package com.hmshop.backend.controller;

import com.hmshop.backend.common.ApiResponse;
import com.hmshop.backend.dto.GroupBuyDto;
import com.hmshop.backend.dto.HomeResponseDto;
import com.hmshop.backend.dto.TopicListDto;
import com.hmshop.backend.repository.TopicRepository;
import com.hmshop.backend.service.HomeService;
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
@RequestMapping("/wx")
@RequiredArgsConstructor
public class HomeController extends BaseController {

    private final HomeService homeService;
    private final TopicRepository topicRepository;

    @GetMapping("/home/index")
    public ApiResponse<HomeResponseDto> home() {
        return ApiResponse.ok(homeService.buildHome());
    }

    @GetMapping("/groupon/list")
    public ApiResponse<Map<String, Object>> groupBuy(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int limit) {
        List<GroupBuyDto> list = homeService.buildHome().getGrouponList();
        int from = Math.max((page - 1) * limit, 0);
        int to = Math.min(from + limit, list.size());
        List<GroupBuyDto> pageList = from >= to ? List.of() : list.subList(from, to);
        Map<String, Object> data = new HashMap<>();
        data.put("list", pageList);
        return ApiResponse.ok(data);
    }

    @GetMapping("/topic/detail")
    public ApiResponse<Map<String, Object>> topicDetail(@RequestParam Long id) {
        return topicRepository.findById(id)
                .map(topic -> {
                    Map<String, Object> data = new HashMap<>();
                    data.put("topic", topic);
                    return ApiResponse.ok(data);
                })
                .orElse(ApiResponse.fail(402, "专题不存在"));
    }

    @GetMapping("/topic/list")
    public ApiResponse<Map<String, Object>> topicList(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int limit) {
        List<TopicListDto> list = topicRepository.findAll(PageRequest.of(Math.max(page - 1, 0), limit))
                .map(t -> new TopicListDto(t.getId(), t.getTitle(), t.getSubtitle(), t.getPrice(), t.getReadCount(), t.getPicUrl()))
                .getContent();
        Map<String, Object> data = new HashMap<>();
        data.put("list", list);
        return ApiResponse.ok(data);
    }
}
