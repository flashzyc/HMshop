package com.hmshop.backend.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "goods_product")
@Data
@NoArgsConstructor
public class GoodsProduct {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "goods_id")
    private Goods goods;

    /**
     * Comma separated specification values
     */
    private String specifications;
    private Double price;
    private Integer number;
    private String url;
    private LocalDateTime addTime;
    private LocalDateTime updateTime;
    private Boolean deleted;
}
