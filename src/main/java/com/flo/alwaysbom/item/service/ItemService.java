package com.flo.alwaysbom.item.service;

import com.flo.alwaysbom.community.review.dao.ReviewDao;
import com.flo.alwaysbom.community.review.dto.ReviewDto;
import com.flo.alwaysbom.item.dao.ItemDao;
import com.flo.alwaysbom.item.vo.ItemReviewForm;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ItemService {

    private final ItemDao dao;
    private final ReviewDao reviewDao;

    public ReviewDto addReview(ItemReviewForm newReview) {
        dao.addReview(newReview);
        dao.updateReviewCheck(newReview);
        return reviewDao.findByIdx(newReview.getIdx());
    }
}
