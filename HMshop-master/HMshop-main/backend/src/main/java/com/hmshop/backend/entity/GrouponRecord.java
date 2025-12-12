package com.hmshop.backend.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "groupon_record")
@Data
@NoArgsConstructor
public class GrouponRecord {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long orderId;
    private Long rulesId;
    private Long userId;
    private Integer status;
    private LocalDateTime addTime;
}
