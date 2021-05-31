package com.flo.alwaysbom.community.review.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ReviewDto {
      private Integer rn;
      private Integer idx;
      private String category;
      private Integer subsIdx;
      private Integer flowerIdx;
      private Integer fclassIdx;
      private Integer productIdx;
      private String name;
      private String memberId;
      private String image;
      private String content;
      private String regDate;
      private double star;
      private Integer likeCount;
      private boolean hasReview;

}
