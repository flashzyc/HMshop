package com.hmshop.backend.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "orders")
@Data
@NoArgsConstructor
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    private String orderSn;
    /**
     * 101 待付款 201 已付款待发货 301 已发货 401 确认收货
     */
    private Integer orderStatus;
    private Double actualPrice;
    private Double goodsPrice;
    private Double freightPrice;
    private Double couponPrice;
    private String message;

    private String consignee;
    private String mobile;
    private String address;
    private Integer aftersaleStatus;

    private LocalDateTime addTime;
    private LocalDateTime updateTime;
    private LocalDateTime payTime;
    private LocalDateTime shipTime;
    private LocalDateTime confirmTime;
    private Boolean deleted;
}
