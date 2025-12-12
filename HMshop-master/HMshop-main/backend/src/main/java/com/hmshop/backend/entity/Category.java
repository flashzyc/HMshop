package com.hmshop.backend.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "category")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Data
@NoArgsConstructor
public class Category {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String keywords;
    @Column(name = "description")
    private String desc;
    private Long pid;
    private String iconUrl;
    private String picUrl;
    private String level;
    private Integer sortOrder;
    private LocalDateTime addTime;
    private LocalDateTime updateTime;
    private Boolean deleted;
}
