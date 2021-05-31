package com.flo.alwaysbom.fclass.service;

import com.flo.alwaysbom.community.review.dto.ReviewDto;
import com.flo.alwaysbom.fclass.dao.FclassDao;
import com.flo.alwaysbom.fclass.vo.FclassReviewDto;
import com.flo.alwaysbom.fclass.vo.FclassVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class FclassService {

    private final FclassDao dao;

    public void addClass(FclassVo vo, Integer[] branches) {
        dao.addClass(vo);
        if (branches != null && branches.length > 0) {
            dao.addFcb(vo, branches);
        }
    }

    public void updateFclass(FclassVo vo, Integer[] branches) {
        dao.updateFclass(vo);
        if (branches != null && branches.length > 0) {
            dao.addFcb(vo, branches);
        }
    }

    public FclassVo deleteFclass(int idx) {
        FclassVo fclassVo = dao.findByIdx(idx);
        dao.deleteFclass(idx);
        return fclassVo;
    }

    public FclassVo findByIdx(int idx) {
        return dao.findByIdx(idx);
    }

    public List<FclassVo> findAll(){
        List<FclassVo> list = dao.findAll();
        return list;
    }

    public List<FclassVo> findClassByCategory(String category) {
        return dao.findClassByCategory(category);
    }

    public FclassReviewDto findReviewsByOption(Integer idx, Integer startIndex, Integer endIndex) {
        Integer count = dao.findReviewsCount(idx);
        List<ReviewDto> reviews = dao.findReviewsByOption(idx, startIndex, endIndex);
        return new FclassReviewDto(count, reviews);
    }
}
