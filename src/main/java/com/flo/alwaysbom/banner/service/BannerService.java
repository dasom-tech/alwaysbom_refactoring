package com.flo.alwaysbom.banner.service;

import com.flo.alwaysbom.banner.vo.BannerVo;


public interface BannerService {

    BannerVo addBanner(BannerVo bannerVo);

    BannerVo findByCategory(String category);

    String updateBanner(BannerVo vo);

    String deleteFlower(String category);
}
