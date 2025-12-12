package com.hmshop.backend.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "topic")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Data
@NoArgsConstructor
public class Topic {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String title;
    private String subtitle;
    private Double price;
    private String readCount;
    private String picUrl;
    private Integer sortOrder;
    @Column(columnDefinition = "TEXT")
    private String goods; // serialized goods list
    private LocalDateTime addTime;
    private LocalDateTime updateTime;
    private Boolean deleted;
    @Column(columnDefinition = "TEXT")
    private String content;
}
