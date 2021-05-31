package com.flo.alwaysbom.order.vo;

import lombok.*;

@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class OrderPriceDto {
    private int totalPrice;
    private int discountGradePrice;
    private int deliveryFee;
    private int finalPrice;

    public String getDeliveryString() {
        if (deliveryFee == 0) {
            return "무료배송";
        } else {
            return "+3,000 원";
        }
    }
}
