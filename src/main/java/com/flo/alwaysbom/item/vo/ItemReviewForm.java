package com.flo.alwaysbom.item.vo;

import com.flo.alwaysbom.community.review.dto.ReviewDto;
import lombok.*;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ItemReviewForm extends ReviewDto {
    private MultipartFile imageFile;
    private Integer oitemIdx;
}
