package com.flo.alwaysbom.product.vo;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ProductVo {
    private Integer idx;
    private String category;
    private String name;
    private String subheader;
    private Integer price;
    private int discountRate;
    private String image1;
    private String image2;
    private String image3;
    private String content;
    private String delStatus;
    private String soldoutStatus;
    private String fsize;

    /** 핵심 비즈니스 로직 */

    // 무료배송 여부 메세지 출력
    public String getFreeDeliveryMessage() {
        if (getFinalPrice() >= 30000) {
            return "무료배송";
        } else {
            return "";
        }
    }

    // 최종 금액 출력
    public Integer getFinalPrice() {
        return (int)(price * (1 - discountRate / 100.0));
    }

    // 편지 추가 가격
    public int getLetterPrice() {
        return 2500;
    }
}
