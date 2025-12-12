package com.hmshop.backend.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "cart")
@Data
@NoArgsConstructor
public class Cart {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    private Long goodsId;
    private String goodsSn;
    private String goodsName;
    private Long productId;
    private Double price;
    private Integer number;
    private String specifications;
    private Boolean checked;
    private String picUrl;
    private LocalDateTime addTime;
    private LocalDateTime updateTime;
    private Boolean deleted;
    private Boolean fastAdd;
}
