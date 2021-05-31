package com.flo.alwaysbom.subs.dao;

import com.flo.alwaysbom.community.review.dto.ReviewDto;
import com.flo.alwaysbom.order.vo.OitemVo;
import com.flo.alwaysbom.subs.vo.SubsVo;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Repository
@RequiredArgsConstructor
public class SubsDao {

    private final SqlSessionTemplate sqlSessionTemplate;

    public SubsVo addSubs(SubsVo svo) {
        sqlSessionTemplate.insert("SUBS.addSubs",svo);
        return svo;
    }

    public List<SubsVo> findAll() {
        return sqlSessionTemplate.selectList("SUBS.findAll");
    }

    public Optional<SubsVo> findByIdx(Integer idx) {
        return Optional.ofNullable(sqlSessionTemplate.selectOne("SUBS.findByIdx",idx));
    }
    public Integer updateSubs(SubsVo svo) {
        sqlSessionTemplate.update("SUBS.updateSubs",svo);
        return svo.getIdx();
    }
    public void deleteSubs(Integer idx) {
        sqlSessionTemplate.delete("SUBS.deleteSubs",idx);
    }

    public Integer findByName(String name) {
        return sqlSessionTemplate.selectOne("SUBS.findByName", name);
    }

    public List<ReviewDto> findReviewByIdx(Integer idx) {
        return sqlSessionTemplate.selectList("SUBS.findReviewByIdx", idx);
    }

    public List<ReviewDto> findBestReview() {
        return sqlSessionTemplate.selectList("SUBS.findBestReview");
    }

    public List<OitemVo> findAvailableOitemToReview(Map<String, String> map) {
        return sqlSessionTemplate.selectList("SUBS.findAvailableOitemToReview", map);
    }
}
