package com.flo.alwaysbom.fclass.dao;

import com.flo.alwaysbom.community.review.dto.ReviewDto;
import com.flo.alwaysbom.fclass.vo.FclassVo;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
@RequiredArgsConstructor
public class FclassDao {

    private final SqlSessionTemplate sqlSessionTemplate;

    public FclassVo addClass(FclassVo vo) {
        sqlSessionTemplate.insert("fclass.addClass", vo);
        return vo;
    }

    public int updateFclass(FclassVo vo) {
        sqlSessionTemplate.update("fclass.updateFclass", vo);

        // FCB 테이블에서 현재 fclass에 해당하는 행을 다 지운다
        // delete from fcb where fclass_idx = #{idx} <- fclass vo에 있는 idx
        sqlSessionTemplate.delete("fclass.deleteClassBranch", vo.getIdx());

        return vo.getIdx();
    }

    public void addFcb(FclassVo vo, Integer[] branches) {
        for (Integer branch : branches) {
            Map<String, Object> map = new HashMap<>();
            map.put("fclassIdx", vo.getIdx());
            map.put("branchIdx", branch);
            sqlSessionTemplate.insert("fclass.addFcb", map);
        }
    }

    public int deleteFclass(int idx) {
        sqlSessionTemplate.delete("fclass.deleteFclass", idx);
        return idx;
    }

    public FclassVo findByIdx(int idx) {
        return sqlSessionTemplate.selectOne("fclass.findByIdx", idx);
    }

    public List<FclassVo> findAll(){
        return sqlSessionTemplate.selectList("fclass.findAll");
    }

    public List<FclassVo> findClassByCategory(String category) {
        List<FclassVo> fclassVos = sqlSessionTemplate.selectList("fclass.findClassByCategory", category);
        return fclassVos;
    }

    public Integer findReviewsCount(Integer idx) {
        return sqlSessionTemplate.selectOne("fclass.findReviewsCount", idx);
    }

    public List<ReviewDto> findReviewsByOption(Integer idx, Integer startIndex, Integer endIndex) {
        Map<String, Integer> map = new HashMap<>();
        map.put("idx", idx);
        map.put("startIndex", startIndex);
        map.put("endIndex", endIndex);

        return sqlSessionTemplate.selectList("fclass.findReviewsByOption", map);
    }
}
