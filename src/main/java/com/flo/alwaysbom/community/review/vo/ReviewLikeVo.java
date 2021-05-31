package com.flo.alwaysbom.community.review.vo;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ReviewLikeVo {
    private Integer idx;
    private Integer reviewIdx;
    private String memberId;
}
