package com.flo.alwaysbom.main.dao;

import com.flo.alwaysbom.main.vo.MainImage;
import com.flo.alwaysbom.main.vo.MainVo;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class MainDao {

    private final SqlSessionTemplate sessionTemplate;


    public MainVo getConfig() {
        return sessionTemplate.selectOne("main.getConfig");
    }

    public List<MainImage> getImages() {
        return sessionTemplate.selectList("main.getImages");
    }

    public void updateConfig(MainVo mainVo) {
        sessionTemplate.update("main.updateConfig", mainVo);
    }

    public void updateImages(MainImage image) {
        sessionTemplate.update("main.updateImages", image);
    }
}
