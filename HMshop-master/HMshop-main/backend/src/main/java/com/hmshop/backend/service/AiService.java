package com.hmshop.backend.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.hmshop.backend.entity.Goods;
import com.hmshop.backend.repository.GoodsRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class AiService {

    private final GoodsRepository goodsRepository;
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Value("${deepseek.api.key:YOUR_DEEPSEEK_API_KEY}")
    private String apiKey;

    @Value("${deepseek.api.url:https://api.deepseek.com/chat/completions}")
    private String apiUrl;

    /**
     * 智能对话推荐
     * @param userMessage 用户输入的消息
     * @return AI回复和推荐商品
     */
    public com.hmshop.backend.dto.AiChatResponse chat(String userMessage) {
        // 1. 获取候选商品 (为了演示，这里获取前100个商品作为上下文)
        // 实际生产中应该使用向量数据库检索相关商品
        List<Goods> candidates = goodsRepository.findAll().stream().limit(100).collect(Collectors.toList());

        // 2. 构建Prompt
        String prompt = buildChatPrompt(userMessage, candidates);

        // 3. 调用DeepSeek API
        return callDeepSeekChatApi(prompt, candidates);
    }

    /**
     * 智能推荐商品 (旧接口保留)
     */
    public List<Goods> recommendGoods(Long userId) {
        return chat("请推荐一些热门和新品").getRecommendations();
    }

    private String buildChatPrompt(String userMessage, List<Goods> candidates) {
        StringBuilder sb = new StringBuilder();
        sb.append("你是一个专业的购物助手。用户正在咨询：\"").append(userMessage).append("\"。");
        sb.append("\n请根据用户的需求，从以下商品列表中挑选合适的商品进行推荐。");
        sb.append("\n请返回一个JSON对象，包含两个字段：");
        sb.append("\n1. 'reply': 字符串，给用户的回复，包含推荐理由，语气亲切自然。");
        sb.append("\n2. 'recommendedIds': 数字数组，推荐商品的ID列表。");
        sb.append("\n注意：只返回JSON字符串，不要包含Markdown标记或其他文字。");
        sb.append("\n\n可选商品列表：\n");
        for (Goods g : candidates) {
            sb.append(String.format("- ID:%d, 名称:%s, 价格:%.2f, 简介:%s\n", g.getId(), g.getName(), g.getRetailPrice(), g.getBrief()));
        }
        return sb.toString();
    }

    private com.hmshop.backend.dto.AiChatResponse callDeepSeekChatApi(String prompt, List<Goods> candidates) {
        com.hmshop.backend.dto.AiChatResponse response = new com.hmshop.backend.dto.AiChatResponse();
        response.setRecommendations(new ArrayList<>());
        response.setReply("抱歉，AI服务暂时不可用。");

        try {
            if ("YOUR_DEEPSEEK_API_KEY".equals(apiKey)) {
                log.warn("DeepSeek API Key not set.");
                return response;
            }

            ObjectNode message = objectMapper.createObjectNode();
            message.put("role", "user");
            message.put("content", prompt);

            ArrayNode messages = objectMapper.createArrayNode();
            messages.add(message);

            ObjectNode requestBody = objectMapper.createObjectNode();
            requestBody.put("model", "deepseek-chat");
            requestBody.set("messages", messages);
            requestBody.put("temperature", 0.7);
            // 强制JSON模式 (如果模型支持)
            ObjectNode responseFormat = objectMapper.createObjectNode();
            responseFormat.put("type", "json_object");
            requestBody.set("response_format", responseFormat);

            String jsonBody = objectMapper.writeValueAsString(requestBody);

            HttpClient client = HttpClient.newHttpClient();
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(apiUrl))
                    .header("Content-Type", "application/json")
                    .header("Authorization", "Bearer " + apiKey)
                    .POST(HttpRequest.BodyPublishers.ofString(jsonBody))
                    .build();

            HttpResponse<String> httpResponse = client.send(request, HttpResponse.BodyHandlers.ofString());

            if (httpResponse.statusCode() == 200) {
                JsonNode root = objectMapper.readTree(httpResponse.body());
                String content = root.path("choices").get(0).path("message").path("content").asText();
                
                // 清理可能存在的Markdown代码块标记
                content = content.replace("```json", "").replace("```", "").trim();
                
                try {
                    JsonNode resultNode = objectMapper.readTree(content);
                    String reply = resultNode.path("reply").asText();
                    JsonNode idsNode = resultNode.path("recommendedIds");
                    
                    List<Long> ids = new ArrayList<>();
                    if (idsNode.isArray()) {
                        for (JsonNode node : idsNode) {
                            ids.add(node.asLong());
                        }
                    }

                    List<Goods> recommendedGoods = candidates.stream()
                            .filter(g -> ids.contains(g.getId()))
                            .collect(Collectors.toList());

                    response.setReply(reply);
                    response.setRecommendations(recommendedGoods);
                } catch (Exception e) {
                    log.error("Failed to parse AI response JSON", e);
                    response.setReply("AI返回格式异常，请稍后再试。");
                }
            } else {
                log.error("DeepSeek API Error: " + httpResponse.statusCode() + " " + httpResponse.body());
                response.setReply("AI服务响应错误。");
            }
        } catch (Exception e) {
            log.error("Failed to call DeepSeek API", e);
            response.setReply("网络连接异常。");
        }
        return response;
    }

    // Remove old methods to avoid confusion or keep them private if needed
    // For this refactoring, I will remove the old implementation details but keep the structure clean.
}


