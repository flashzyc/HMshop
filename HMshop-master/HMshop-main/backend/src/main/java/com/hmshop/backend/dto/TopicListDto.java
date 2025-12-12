package com.hmshop.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TopicListDto {
    private Long id;
    private String title;
    private String subtitle;
    private Double price;
    private String readCount;
    private String picUrl;
}
