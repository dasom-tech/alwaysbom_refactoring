package com.flo.alwaysbom.order.service;

import com.flo.alwaysbom.member.vo.MemberVo;
import com.flo.alwaysbom.order.vo.*;

import java.util.List;

public interface OrdersService {

    OrdersVo insertOrder(OrdersVo vo, List<OitemVo> olist);

    DeliveryInfoVo findAddress(MemberVo vo);

    int getPoint(MemberVo mvo);

    //주문 완료시 저장
    OrdersVo saveDelivery(OrdersVo ordersVo);

    //주문내역 조회 (회원 아이디로 조회)
    List<OrdersVo> findByMember(MemberVo vo);

   // 아이디, 배송지 정보로 찾기
    List<OrdersVo> findBySearchOption(OrdersSearchOptionDto status);

    OrdersStatusCount findStatusCount();

    boolean updateStatus(OrdersVo orders);

    void updatePoint(MemberVo member);

    List<OrdersVo> findBySubs(MemberVo member);

    List<OrdersVo> findByFlower(MemberVo member);
}
