package com.flo.alwaysbom.item.dao;

import com.flo.alwaysbom.community.review.dto.ReviewDto;
import com.flo.alwaysbom.item.vo.ItemReviewForm;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class ItemDao {

    private final SqlSessionTemplate sqlSessionTemplate;

    public ReviewDto addReview(ItemReviewForm newReview) {
        sqlSessionTemplate.insert("ITEM.addReview", newReview);
        return newReview;
    }

    public void updateReviewCheck(ItemReviewForm newReview) {
        sqlSessionTemplate.update("ITEM.updateReviewCheck", newReview);
    }
}
