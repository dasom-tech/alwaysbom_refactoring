package com.flo.alwaysbom.subs.service;

import com.flo.alwaysbom.community.review.dto.ReviewDto;
import com.flo.alwaysbom.order.vo.OitemVo;
import com.flo.alwaysbom.subs.dao.SubsDao;
import com.flo.alwaysbom.subs.vo.SubsVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class SubsServiceImpl implements SubsService{

    private final SubsDao dao;

    @Override
    public SubsVo addSubs(SubsVo svo) {
       return dao.addSubs(svo);
    }

    @Override
    public List<SubsVo> findAll() {
        return dao.findAll();
    }

    @Override
    public Optional<SubsVo> findByIdx(Integer idx) {
        return dao.findByIdx(idx);
    }
    @Override
    public Integer updateSubs(SubsVo svo) {
        return dao.updateSubs(svo);
    }
    @Override
    public void deleteSubs(Integer idx) {
        dao.deleteSubs(idx);
    }

    @Override
    public List<ReviewDto> findReviewByIdx(Integer idx) {
        return dao.findReviewByIdx(idx);
    }

    @Override
    public List<ReviewDto> findBestReview() {
        return dao.findBestReview();
    }

    @Override
    public List<OitemVo> findAvailableOitemToReview(Map<String, String> map) {
        return dao.findAvailableOitemToReview(map);
    }
}
