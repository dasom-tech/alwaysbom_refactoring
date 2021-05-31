package com.flo.alwaysbom.community.event.dao;

import com.flo.alwaysbom.community.event.vo.EcommentVo;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class EcommentDao {
    private final SqlSessionTemplate sqlSessionTemplate;

    public List<EcommentVo> ecoList(Integer idx) {
        return sqlSessionTemplate.selectList("ecomment.ecoList", idx);
    }

    public void addEcomment(EcommentVo vo) {
        sqlSessionTemplate.insert("ecomment.addEcomment", vo);
    }

    public EcommentVo findByIdx(EcommentVo vo) {
        return sqlSessionTemplate.selectOne("ecomment.findByIdx", vo);
    }


    public void ecommentUpdate(EcommentVo vo) {
        sqlSessionTemplate.update("ecomment.ecommentUpdate", vo);
    }

    public void ecommentDelete(Integer idx) {
        sqlSessionTemplate.delete("ecomment.ecommentDelete", idx);
    }

    public void ecommentReport(Integer idx) {
        sqlSessionTemplate.delete("ecomment.ecommentReport", idx);
    }
}