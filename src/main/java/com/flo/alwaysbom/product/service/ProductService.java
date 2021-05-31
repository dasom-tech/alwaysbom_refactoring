package com.flo.alwaysbom.product.service;

import com.flo.alwaysbom.community.review.dto.ReviewDto;
import com.flo.alwaysbom.item.vo.ItemReviewForm;
import com.flo.alwaysbom.order.vo.OitemVo;
import com.flo.alwaysbom.product.vo.ProductVo;

import java.util.List;
import java.util.Map;
import java.util.Optional;

public interface ProductService {

    ProductVo addProduct(ProductVo vo);

    List<ProductVo> findAll();

    List<ProductVo> findByCategory(String category);

    Optional<ProductVo> findByIdx(Integer idx);

    List<ReviewDto> findBestReview();

    List<ReviewDto> findReviewByIdx(Integer idx);

    Integer updateProduct(ProductVo vo);

    void deleteProduct(Integer idx);

    List<OitemVo> findAvailableOitemToReview(Map<String, String> map);

    ReviewDto addReview(ItemReviewForm newReview);
}
