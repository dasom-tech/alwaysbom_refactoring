package com.flo.alwaysbom.choice.vo;

import com.flo.alwaysbom.product.vo.ProductVo;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ChoiceVo {
    private Integer idx;
    private Integer productIdx;
    private Integer cartIdx;
    private Integer quantity;

    // 핵심 비즈니스 로직
    private ProductVo productVo;
}
