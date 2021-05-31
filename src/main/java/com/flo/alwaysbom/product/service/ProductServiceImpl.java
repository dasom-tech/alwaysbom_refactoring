package com.flo.alwaysbom.product.service;

import com.flo.alwaysbom.community.review.dao.ReviewDao;
import com.flo.alwaysbom.community.review.dto.ReviewDto;
import com.flo.alwaysbom.fclass.vo.FclassReviewForm;
import com.flo.alwaysbom.item.vo.ItemReviewForm;
import com.flo.alwaysbom.order.vo.OitemVo;
import com.flo.alwaysbom.product.dao.ProductDao;
import com.flo.alwaysbom.product.vo.ProductVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {

    private final ProductDao dao;
    private final ReviewDao reviewDao;

    @Override
    public ProductVo addProduct(ProductVo vo) {
        return dao.addProduct(vo);
    }

    @Override
    public List<ProductVo> findAll() {
        return dao.findAll();
    }

    @Override
    public List<ProductVo> findByCategory(String category) {
        return dao.findByCategory(category);
    }

    @Override
    public Optional<ProductVo> findByIdx(Integer idx) {
        return dao.findByIdx(idx);
    }

    @Override
    public List<ReviewDto> findBestReview() {
        return dao.findBestReview();
    }

    @Override
    public List<ReviewDto> findReviewByIdx(Integer idx) {
        return dao.findReviewByIdx(idx);
    }

    @Override
    public Integer updateProduct(ProductVo vo) {
        return dao.updateProduct(vo);
    }

    @Override
    public void deleteProduct(Integer idx) {
        dao.deleteProduct(idx);
    }

    @Override
    public List<OitemVo> findAvailableOitemToReview(Map<String, String> map) {
        return dao.findAvailableOitemToReview(map);
    }

    @Override
    public ReviewDto addReview(ItemReviewForm newReview) {
        return null;

    }

}
