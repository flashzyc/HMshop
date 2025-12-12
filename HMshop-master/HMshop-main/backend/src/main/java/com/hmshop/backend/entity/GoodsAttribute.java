package com.hmshop.backend.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "goods_attribute")
@Data
@NoArgsConstructor
public class GoodsAttribute {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "goods_id")
    private Goods goods;

    private String attribute;
    @Column(name = "attr_value")
    private String value;
    private LocalDateTime addTime;
    private LocalDateTime updateTime;
    private Boolean deleted;
}
