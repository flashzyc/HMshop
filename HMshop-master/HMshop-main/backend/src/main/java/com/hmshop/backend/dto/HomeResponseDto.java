package com.hmshop.backend.dto;

import com.hmshop.backend.entity.Banner;
import com.hmshop.backend.entity.Brand;
import com.hmshop.backend.entity.Channel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class HomeResponseDto {
    private List<Banner> banner;
    private List<Channel> channel;
    private List<CouponHomeDto> couponList;
    private List<SimpleGoodsDto> newGoodsList;
    private List<GroupBuyDto> grouponList;
    private List<Brand> brandList;
    private List<SimpleGoodsDto> hotGoodsList;
    private List<TopicListDto> topicList;
}
