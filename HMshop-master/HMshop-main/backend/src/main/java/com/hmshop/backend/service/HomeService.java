package com.hmshop.backend.service;

import com.hmshop.backend.dto.*;
import com.hmshop.backend.entity.Banner;
import com.hmshop.backend.entity.Brand;
import com.hmshop.backend.entity.Goods;
import com.hmshop.backend.entity.GrouponRules;
import com.hmshop.backend.repository.*;
import com.hmshop.backend.util.DateUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class HomeService {

    private final BannerRepository bannerRepository;
    private final ChannelRepository channelRepository;
    private final CouponRepository couponRepository;
    private final GoodsService goodsService;
    private final GrouponRulesRepository grouponRulesRepository;
    private final GoodsRepository goodsRepository;
    private final BrandRepository brandRepository;
    private final TopicRepository topicRepository;

    public HomeResponseDto buildHome() {
        List<Banner> banners = bannerRepository.findByDeletedFalseAndEnabledTrueOrderByPositionAsc();
        List<com.hmshop.backend.entity.Channel> channels = channelRepository.findAllByOrderByIdAsc();
        List<CouponHomeDto> couponList = couponRepository.findAll().stream()
                .filter(c -> c.getEnabled() == null || c.getEnabled())
                .limit(3)
                .map(c -> new CouponHomeDto(c.getId(), c.getName(), c.getDesc(), c.getTag(),
                        c.getDiscount(), c.getMin(), c.getDays()))
                .toList();

        List<SimpleGoodsDto> newGoods = goodsService.listNewGoods(10);
        List<SimpleGoodsDto> hotGoods = goodsService.listHotGoods(10);
        List<GroupBuyDto> groupBuys = grouponRulesRepository.findAll().stream()
                .limit(6)
                .map(this::toGroupBuyDto)
                .filter(Optional::isPresent)
                .map(Optional::get)
                .toList();
        List<Brand> brandList = brandRepository.findAll(PageRequest.of(0, 6)).getContent();
        List<TopicListDto> topics = topicRepository.findAll(PageRequest.of(0, 6)).map(t ->
                new TopicListDto(t.getId(), t.getTitle(), t.getSubtitle(), t.getPrice(), t.getReadCount(), t.getPicUrl())
        ).getContent();

        return new HomeResponseDto(banners, channels, couponList, newGoods, groupBuys, brandList, hotGoods, topics);
    }

    private Optional<GroupBuyDto> toGroupBuyDto(GrouponRules rules) {
        Optional<Goods> goodsOpt = goodsRepository.findById(rules.getGoodsId());
        if (goodsOpt.isEmpty()) {
            return Optional.empty();
        }
        Goods goods = goodsOpt.get();
        double grouponPrice = Math.max(goods.getRetailPrice() - rules.getDiscount(), 0);
        return Optional.of(new GroupBuyDto(
                rules.getId(),
                goods.getId(),
                goods.getName(),
                goods.getBrief(),
                goods.getPicUrl(),
                goods.getCounterPrice(),
                goods.getRetailPrice(),
                grouponPrice,
                rules.getDiscount(),
                rules.getDiscountMember(),
                DateUtil.format(rules.getExpireTime())
        ));
    }
}
