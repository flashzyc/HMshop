package com.hmshop.backend.repository;

import com.hmshop.backend.entity.Channel;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ChannelRepository extends JpaRepository<Channel, Long> {
    List<Channel> findAllByOrderByIdAsc();
}
