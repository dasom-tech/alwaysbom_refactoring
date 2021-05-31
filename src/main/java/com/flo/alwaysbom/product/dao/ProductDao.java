package com.flo.alwaysbom.product.dao;

import com.flo.alwaysbom.community.review.dto.ReviewDto;
import com.flo.alwaysbom.fclass.vo.FclassReviewForm;
import com.flo.alwaysbom.order.vo.OitemVo;
import com.flo.alwaysbom.product.vo.ProductVo;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Repository
@RequiredArgsConstructor
public class ProductDao {

    private final SqlSessionTemplate sqlSessionTemplate;

    public ProductVo addProduct(ProductVo vo) {
        sqlSessionTemplate.insert("PRODUCT.addProduct", vo);
        return vo;
    }

    public List<ProductVo> findAll() {
        return sqlSessionTemplate.selectList("PRODUCT.findAll");
    }

    public List<ProductVo> findByCategory(String category) {
        return sqlSessionTemplate.selectList("PRODUCT.findByCategory", category);
    }

    public Optional<ProductVo> findByIdx(Integer idx) {
        return Optional.ofNullable(sqlSessionTemplate.selectOne("PRODUCT.findByIdx", idx));
    }

    public List<ReviewDto> findBestReview() {
        return sqlSessionTemplate.selectList("PRODUCT.findBestReview");
    }

    public List<ReviewDto> findReviewByIdx(Integer idx) {
        return sqlSessionTemplate.selectList("PRODUCT.findReviewByIdx", idx);
    }

    public Integer updateProduct(ProductVo vo) {
        sqlSessionTemplate.update("PRODUCT.updateProduct", vo);
        return vo.getIdx();
    }

    public Integer deleteProduct(Integer idx) {
        return sqlSessionTemplate.update("PRODUCT.deleteProduct", idx);
    }

    public Integer findByName(String name) {
        return sqlSessionTemplate.selectOne("PRODUCT.findByName", name);
    }

    public List<OitemVo> findAvailableOitemToReview(Map<String, String> map) {
        return sqlSessionTemplate.selectList("PRODUCT.findAvailableOitemToReview", map);
    }

}
