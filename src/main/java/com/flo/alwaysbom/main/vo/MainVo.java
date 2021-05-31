package com.flo.alwaysbom.main.vo;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class MainVo {
    private Integer fclassIdxBig;
    private Integer fclassIdxSmall;
    private List<MainImage> images;


}
