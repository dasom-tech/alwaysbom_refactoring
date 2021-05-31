package com.flo.alwaysbom.fclass.vo;

import com.flo.alwaysbom.community.review.dto.ReviewDto;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.List;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class FclassReviewDto {
    private int count;
    private List<ReviewDto> reviews;

    // 비즈니스 로직
    public boolean getIsFinish() {
        // 리뷰 사이즈가 0이라면?
        if (reviews.size() == 0) {
            return true;
        }

        ReviewDto reviewDto = reviews.get(reviews.size() - 1);

        return reviewDto.getRn() == count;
    }
}
