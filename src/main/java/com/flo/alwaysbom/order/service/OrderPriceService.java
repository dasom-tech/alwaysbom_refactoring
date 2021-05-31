package com.flo.alwaysbom.order.service;

import com.flo.alwaysbom.member.vo.MemberVO;
import com.flo.alwaysbom.order.vo.OitemVo;
import com.flo.alwaysbom.order.vo.OrderPriceDto;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderPriceService {

    public OrderPriceDto getOrderPrice(List<OitemVo> olist, MemberVO mvo) {

        // 전체 금액
        int totalPrice = 0;
        for (OitemVo oitemVo : olist) {
            totalPrice += oitemVo.getPrice();
        }

        // discountGradePrice 계산
        int discountGradePrice = 0;
        if (!mvo.getGrade().equals("데이지")) {
            discountGradePrice = (int) (totalPrice * 0.02);
        }

        // delivery fee
        int deliveryFee = 3000;
        String deliveryString = "+3,000 원";
        if (totalPrice >= 30000) {
            deliveryFee = 0;
            deliveryString = "무료배송";
        }

        // final Price
        int finalPrice = totalPrice - discountGradePrice + deliveryFee;

        return new OrderPriceDto(totalPrice, discountGradePrice, deliveryFee, finalPrice);
    }
}
