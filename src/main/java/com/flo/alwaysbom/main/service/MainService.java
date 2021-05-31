package com.flo.alwaysbom.main.service;

import com.flo.alwaysbom.main.dao.MainDao;
import com.flo.alwaysbom.main.vo.MainImage;
import com.flo.alwaysbom.main.vo.MainVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class MainService {

    private final MainDao mainDao;


    public MainVo getConfig() {
        MainVo config = mainDao.getConfig();
        config.setImages(mainDao.getImages());
        return config;
    }

    public void updateConfig(MainVo mainVo) {
        mainDao.updateConfig(mainVo);
        for (MainImage image : mainVo.getImages()) {
            mainDao.updateImages(image);
        }
    }
}
