package com.flo.alwaysbom.fclass.vo;

import com.flo.alwaysbom.community.review.dto.ReviewDto;
import lombok.*;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class FclassReviewForm extends ReviewDto {
    private MultipartFile imageFile;
    private Integer oclassIdx;
}
