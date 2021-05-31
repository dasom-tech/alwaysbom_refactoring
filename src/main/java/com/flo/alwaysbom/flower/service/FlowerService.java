package com.flo.alwaysbom.flower.service;

import com.flo.alwaysbom.community.review.dto.ReviewDto;
import com.flo.alwaysbom.flower.vo.FlowerVo;
import com.flo.alwaysbom.order.vo.OitemVo;

import java.util.List;
import java.util.Map;
import java.util.Optional;

public interface FlowerService {

    FlowerVo addFlower(FlowerVo vo);

    List<FlowerVo> findAll();

    Optional<FlowerVo> findByIdx(Integer idx);

    List<FlowerVo> findRecent4();

    List<ReviewDto> findBestReview();

    List<ReviewDto> findReviewByIdx(Integer idx);

    Integer updateFlower(FlowerVo vo);

    void deleteFlower(Integer idx);

    List<OitemVo> findAvailableOitemToReview(Map<String, String> map);
}
