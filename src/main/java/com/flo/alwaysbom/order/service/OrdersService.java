package com.flo.alwaysbom.order.service;

import com.flo.alwaysbom.member.vo.MemberVO;
import com.flo.alwaysbom.order.vo.*;

import java.util.List;

public interface OrdersService {

    OrdersVo insertOrder(OrdersVo vo, List<OitemVo> olist);

    DeliveryInfoVo findAddress(MemberVO vo);

    int getPoint(MemberVO mvo);

    //주문 완료시 저장
    OrdersVo saveDelivery(OrdersVo ordersVo);

    //주문내역 조회 (회원 아이디로 조회)
    List<OrdersVo> findByMember(MemberVO vo);

   // 아이디, 배송지 정보로 찾기
    List<OrdersVo> findBySearchOption(OrdersSearchOptionDto status);

    OrdersStatusCount findStatusCount();

    boolean updateStatus(OrdersVo orders);

    void updatePoint(MemberVO member);

    List<OrdersVo> findBySubs(MemberVO member);

    List<OrdersVo> findByFlower(MemberVO member);
}
