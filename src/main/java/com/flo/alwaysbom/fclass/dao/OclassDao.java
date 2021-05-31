package com.flo.alwaysbom.fclass.dao;

import com.flo.alwaysbom.community.review.dto.ReviewDto;
import com.flo.alwaysbom.fclass.vo.*;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
@RequiredArgsConstructor
public class OclassDao {
    private final SqlSessionTemplate sqlSessionTemplate;

    public OclassVo addOclass(OclassVo vo) {
        sqlSessionTemplate.insert("oclass.addOclass", vo);
        vo = findByIdx(vo.getIdx());
        return vo;
    }

    public List<OclassVo> findBySearchOption(OclassSearchOptionDto searchOption) {
        System.out.println("searchOption = " + searchOption);
        return sqlSessionTemplate.selectList("oclass.findBySearchOption", searchOption);
    }

    public List<String> findAllBranch() {
        return sqlSessionTemplate.selectList("oclass.findAllBranch");
    }

    public void updateOrderStatus(OclassVo oclassVo) {
        sqlSessionTemplate.update("oclass.updateOrderStatus", oclassVo);
    }

    public OclassVo findByIdx(Integer idx) {
        return sqlSessionTemplate.selectOne("oclass.findByIdx", idx);
    }

    public boolean deleteOrder(Integer idx) {
        return sqlSessionTemplate.delete("oclass.deleteOrder", idx) > 0;
    }

    public void updateClassImg(String newImg, int idx) {
        OclassVo build = OclassVo.builder().fclassIdx(idx).fclassImage(newImg).build();
        sqlSessionTemplate.update("oclass.updateClassImg", build);
    }

    public List<OclassVo> findReviewable(OclassVo oclassVo) {
        return sqlSessionTemplate.selectList("oclass.findReviewable", oclassVo);
    }

    public ReviewDto addReview(FclassReviewForm newReview) {
        sqlSessionTemplate.insert("oclass.addReview", newReview);
        return newReview;
    }

    public void updateReviewCheck(FclassReviewForm newReview) {
        sqlSessionTemplate.update("oclass.updateReviewCheck", newReview);
    }

    public void updatePoint(String memberId, int point) {
        HashMap<String, Object> paramMap = new HashMap<>();
        paramMap.put("memberId", memberId);
        paramMap.put("point", point);
        sqlSessionTemplate.update("oclass.updatePoint", paramMap);
    }
}
