package com.flo.alwaysbom.flower.service;

import com.flo.alwaysbom.community.review.dto.ReviewDto;
import com.flo.alwaysbom.flower.dao.FlowerDao;
import com.flo.alwaysbom.flower.vo.FlowerVo;
import com.flo.alwaysbom.order.vo.OitemVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class FlowerServiceImpl implements FlowerService {

    private final FlowerDao dao;

    @Override
    public FlowerVo addFlower(FlowerVo vo) {
        return dao.addFlower(vo);
    }

    @Override
    public List<FlowerVo> findAll() {
        return dao.findAll();
    }

    @Override
    public Optional<FlowerVo> findByIdx(Integer idx) {
        return dao.findByIdx(idx);
    }

    @Override
    public List<FlowerVo> findRecent4() {
        return dao.findRecent4();
    }

    @Override
    public List<ReviewDto> findBestReview() {
        return dao.findBestReview();
    }

    @Override
    public List<ReviewDto> findReviewByIdx(Integer idx) {
        return dao.findReviewByIdx(idx);
    }

    @Override
    public Integer updateFlower(FlowerVo vo) {
        return dao.updateFlower(vo);
    }

    @Override
    public void deleteFlower(Integer idx) {
        dao.deleteFlower(idx);
    }

    @Override
    public List<OitemVo> findAvailableOitemToReview(Map<String, String> map) {
        return dao.findAvailableOitemToReview(map);
    }
}
