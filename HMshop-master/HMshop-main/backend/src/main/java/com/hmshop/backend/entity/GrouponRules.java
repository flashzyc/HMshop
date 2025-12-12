package com.hmshop.backend.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "groupon_rules")
@Data
@NoArgsConstructor
public class GrouponRules {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long goodsId;
    private Double discount;
    private Integer discountMember;
    private LocalDateTime expireTime;
    private Boolean enabled;
}
