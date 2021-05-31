package com.flo.alwaysbom.community.faq.dao;

import com.flo.alwaysbom.community.faq.vo.FaqVo;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class FaqDao {
    private final SqlSessionTemplate sqlSessionTemplate;

    public List<String> faqCategoryStrings() {
        return sqlSessionTemplate.selectList("faq.faqCategoryStrings");
    }

    public List<FaqVo> faqList(FaqVo vo) {
        return sqlSessionTemplate.selectList("faq.faqlist", vo);
    }

    public void faqDelete(Integer idx) {
        sqlSessionTemplate.delete("faq.faqDelete", idx);
    }

    public void daqUpdate(FaqVo vo) {
        sqlSessionTemplate.update("faq.faqUpdate", vo);
    }

    public void faqInsert(FaqVo vo) {
        sqlSessionTemplate.insert("faq.faqInsert", vo);
    }

    public FaqVo faqSelectOne(Integer idx) {
        return sqlSessionTemplate.selectOne("faq.faqOne", idx);
    }

    public void faqUpdate(FaqVo vo) {
        sqlSessionTemplate.update("faq.faqUpdate", vo);
    }
}


/*
    Map<> abc = op~~~data

    BooleanBuilder boolean = new BooleanBuilder();

    // 프론트 검색값 가져오기
    Optional<String> faqType = ~~~~~("jsp 쓴id)


    // DB 구분값 == 검색
    String value = ~~trim.uppercase
    if(!Strings.isNullable(faqType.get()){
        boolean()
    }

    // 로직
 */