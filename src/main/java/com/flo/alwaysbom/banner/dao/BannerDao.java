package com.flo.alwaysbom.banner.dao;

import com.flo.alwaysbom.banner.vo.BannerVo;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class BannerDao {

    private final SqlSessionTemplate sqlSessionTemplate;

    public BannerVo addBanner(BannerVo vo) {
        sqlSessionTemplate.insert("BANNER.addBanner", vo);
        return vo;
    }

    public BannerVo findByCategory(String category) {
        BannerVo vo = sqlSessionTemplate.selectOne("BANNER.findByCategory", category);
        return vo;
    }

    public String updateBanner(BannerVo vo) {
        sqlSessionTemplate.update("BANNER.updateBanner", vo);
        return vo.getCategory();
    }

    public String deleteFlower(String category) {
        sqlSessionTemplate.delete("BANNER.deleteBanner", category);
        return category;
    }


}
