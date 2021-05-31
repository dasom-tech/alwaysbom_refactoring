package com.flo.alwaysbom.flower.dao;

import com.flo.alwaysbom.community.review.dto.ReviewDto;
import com.flo.alwaysbom.flower.vo.FlowerVo;
import com.flo.alwaysbom.order.vo.OitemVo;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Repository
@RequiredArgsConstructor
public class FlowerDao {

    private final SqlSessionTemplate sqlSessionTemplate;

    public FlowerVo addFlower(FlowerVo vo) {
        sqlSessionTemplate.insert("FLOWER.addFlower", vo);
        return vo;
    }

    public List<FlowerVo> findAll() {
        return sqlSessionTemplate.selectList("FLOWER.findAll");
    }

    public Optional<FlowerVo> findByIdx(Integer idx) {
        return Optional.ofNullable(sqlSessionTemplate.selectOne("FLOWER.findByIdx", idx));
    }

    public List<FlowerVo> findRecent4() {
        return sqlSessionTemplate.selectList("FLOWER.findRecent4");
    }

    public List<ReviewDto> findBestReview() {
        return sqlSessionTemplate.selectList("FLOWER.findBestReview");
    }

    public List<ReviewDto> findReviewByIdx(Integer idx) {
        return sqlSessionTemplate.selectList("FLOWER.findReviewByIdx", idx);
    }

    public Integer updateFlower(FlowerVo vo) {
        sqlSessionTemplate.update("FLOWER.updateFlower", vo);
        return vo.getIdx();
    }

    public void deleteFlower(Integer idx) {
        sqlSessionTemplate.update("FLOWER.deleteFlower", idx);
    }

    public List<OitemVo> findAvailableOitemToReview(Map<String, String> map) {
        return sqlSessionTemplate.selectList("FLOWER.findAvailableOitemToReview", map);
    }

    public Integer findByName(String name) {
        FlowerVo vo = sqlSessionTemplate.selectOne("FLOWER.findByName", name);
        Integer idx = vo.getIdx();
        return idx;
    }
}
