package com.flo.alwaysbom.banner.service;

import com.flo.alwaysbom.banner.dao.BannerDao;
import com.flo.alwaysbom.banner.vo.BannerVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


@Service
@RequiredArgsConstructor
public class BannerServiceImpl implements BannerService {

    private final BannerDao dao;

    @Override
    public BannerVo addBanner(BannerVo vo) {
        return dao.addBanner(vo);
    }

    @Override
    public BannerVo findByCategory(String category) {
        return dao.findByCategory(category);
    }

    @Override
    public String updateBanner(BannerVo vo) {
        return dao.updateBanner(vo);
    }

    @Override
    public String deleteFlower(String category) {
        return dao.deleteFlower(category);
    }
}
