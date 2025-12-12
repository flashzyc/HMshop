package com.hmshop.backend.service;

import com.hmshop.backend.dto.*;
import com.hmshop.backend.entity.*;
import com.hmshop.backend.repository.*;
import com.hmshop.backend.util.DateUtil;
import jakarta.persistence.criteria.Predicate;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class GoodsService {

    private final GoodsRepository goodsRepository;
    private final GoodsAttributeRepository attributeRepository;
    private final GoodsSpecificationRepository specificationRepository;
    private final GoodsProductRepository productRepository;
    private final CategoryRepository categoryRepository;
    private final BrandRepository brandRepository;

    public GoodsDetailDto getGoodsDetail(Long id) {
        Goods goods = goodsRepository.findById(id).orElseThrow();
        List<GoodsAttribute> attributes = attributeRepository.findByGoodsAndDeletedFalse(goods);
        List<GoodsSpecification> specs = specificationRepository.findByGoodsAndDeletedFalse(goods);
        List<GoodsProduct> products = productRepository.findByGoodsAndDeletedFalse(goods);

        GoodsInfoDto infoDto = toGoodsInfoDto(goods);
        List<SpecificationDto> specList = groupSpecifications(specs);
        List<ProductDto> productDtos = products.stream().map(this::toProductDto).toList();

        return new GoodsDetailDto(infoDto, attributes, specList, productDtos);
    }

    public GoodsListResponseDto listGoods(int page, int limit, Boolean isNew, Boolean isHot, Long categoryId,
                                          Long brandId, String keyword) {
        Pageable pageable = PageRequest.of(Math.max(page - 1, 0), limit);

        Page<Goods> goodsPage = goodsRepository.findAll((root, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();
            predicates.add(cb.isFalse(root.get("deleted")));
            if (isNew != null) {
                predicates.add(cb.equal(root.get("isNew"), isNew));
            }
            if (isHot != null) {
                predicates.add(cb.equal(root.get("isHot"), isHot));
            }
            if (categoryId != null && categoryId > 0) {
                predicates.add(cb.equal(root.get("category").get("id"), categoryId));
            }
            if (brandId != null && brandId > 0) {
                predicates.add(cb.equal(root.get("brand").get("id"), brandId));
            }
            if (StringUtils.hasText(keyword)) {
                String like = "%" + keyword + "%";
                // 搜索范围：名称、货号、关键字、简介、详情
                predicates.add(cb.or(
                        cb.like(root.get("name"), like),
                        cb.like(root.get("goodsSn"), like),
                        cb.like(root.get("keywords"), like),
                        cb.like(root.get("brief"), like),
                        cb.like(root.get("detail"), like)
                ));
            }
            query.distinct(true);
            return cb.and(predicates.toArray(new Predicate[0]));
        }, pageable);

        List<SimpleGoodsDto> list = goodsPage.getContent().stream().map(this::toSimpleGoods).toList();
        List<Category> filterCategories = categoryRepository.findByPidAndDeletedFalseOrderBySortOrderAsc(0L);

        return new GoodsListResponseDto(
                goodsPage.getTotalElements(),
                goodsPage.getTotalPages(),
                limit,
                page,
                list,
                filterCategories
        );
    }

    public List<SimpleGoodsDto> listNewGoods(int limit) {
        return listGoods(1, limit, true, null, null, null, null).getList();
    }

    public List<SimpleGoodsDto> listHotGoods(int limit) {
        return listGoods(1, limit, null, true, null, null, null).getList();
    }

    public List<SimpleGoodsDto> listByBrand(Long brandId, int limit) {
        GoodsListResponseDto dto = listGoods(1, limit, null, null, null, brandId, null);
        return dto.getList();
    }

    public List<SimpleGoodsDto> listByCategory(Long categoryId, int limit) {
        GoodsListResponseDto dto = listGoods(1, limit, null, null, categoryId, null, null);
        return dto.getList();
    }

    public SimpleGoodsDto toSimpleGoods(Goods g) {
        return new SimpleGoodsDto(
                g.getId(),
                g.getName(),
                g.getBrief(),
                g.getPicUrl(),
                g.getIsNew(),
                g.getIsHot(),
                g.getCounterPrice(),
                g.getRetailPrice()
        );
    }

    private GoodsInfoDto toGoodsInfoDto(Goods goods) {
        List<String> gallery = new ArrayList<>();
        if (StringUtils.hasText(goods.getGallery())) {
            gallery = Arrays.stream(goods.getGallery().split(","))
                    .map(String::trim)
                    .filter(StringUtils::hasText)
                    .toList();
        }
        Long categoryId = goods.getCategory() != null ? goods.getCategory().getId() : null;
        Long brandId = goods.getBrand() != null ? goods.getBrand().getId() : null;
        return new GoodsInfoDto(
                goods.getId(),
                goods.getGoodsSn(),
                goods.getName(),
                categoryId,
                brandId,
                gallery,
                goods.getKeywords(),
                goods.getBrief(),
                goods.getIsOnSale(),
                goods.getSortOrder(),
                goods.getPicUrl(),
                goods.getShareUrl(),
                goods.getIsNew(),
                goods.getIsHot(),
                goods.getUnit(),
                goods.getCounterPrice(),
                goods.getRetailPrice(),
                DateUtil.format(goods.getAddTime()),
                DateUtil.format(goods.getUpdateTime()),
                goods.getDeleted(),
                goods.getDetail()
        );
    }

    private SpecificationValueDto toSpecValueDto(GoodsSpecification spec) {
        return new SpecificationValueDto(
                spec.getId(),
                spec.getGoods().getId(),
                spec.getSpecification(),
                spec.getValue(),
                spec.getPicUrl(),
                DateUtil.format(spec.getAddTime()),
                DateUtil.format(spec.getUpdateTime()),
                spec.getDeleted()
        );
    }

    private ProductDto toProductDto(GoodsProduct p) {
        String[] specs = new String[0];
        if (StringUtils.hasText(p.getSpecifications())) {
            specs = Arrays.stream(p.getSpecifications().split(","))
                    .map(String::trim)
                    .filter(StringUtils::hasText)
                    .toArray(String[]::new);
        }
        return new ProductDto(
                p.getId(),
                p.getGoods().getId(),
                specs,
                p.getPrice(),
                p.getNumber(),
                p.getUrl(),
                DateUtil.format(p.getAddTime()),
                DateUtil.format(p.getUpdateTime()),
                p.getDeleted()
        );
    }

    private List<SpecificationDto> groupSpecifications(List<GoodsSpecification> specs) {
        Map<String, List<SpecificationValueDto>> grouped = new LinkedHashMap<>();
        for (GoodsSpecification spec : specs) {
            grouped.computeIfAbsent(spec.getSpecification(), k -> new ArrayList<>())
                    .add(toSpecValueDto(spec));
        }
        return grouped.entrySet().stream()
                .map(e -> new SpecificationDto(e.getKey(), e.getValue()))
                .collect(Collectors.toList());
    }
}
