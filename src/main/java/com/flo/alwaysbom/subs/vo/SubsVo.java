package com.flo.alwaysbom.subs.vo;

import lombok.*;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class SubsVo {
    private Integer idx;
    private String name;
    private String subheader;
    private String summary;
    private Integer price;
    private String image1;
    private String image2;
    private String image3;
    private String content;
    private String fsize;

    /* 핵심 비즈니스 로직 */
    // 최종 금액 출력
    public int getDiscountRate() {
        return 0;
    }

    public Integer getFinalPrice(){
        return (int)(price * (1 - 0 / 100.0));
    }

    // 편지 추가 가격
    public int getLetterPrice() {
        return 2500;
    }
}
