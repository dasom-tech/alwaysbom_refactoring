package com.flo.alwaysbom.order.dao;

import com.flo.alwaysbom.member.vo.MemberVO;
import com.flo.alwaysbom.order.vo.*;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class OrdersDao {

    private final SqlSessionTemplate sqlSessionTemplate;

    //결제완료시 ordersVo 저장 !(insert)
    public int insertOrder(OrdersVo vo) {
        System.out.println(">> OrderDao() insertOrder()실행");
        return sqlSessionTemplate.insert("orders-mapper.insertOrder",vo);
    }
    //결제완료시 OitemVo 저장 !
    public int insertOitem(OitemVo oitemVo) {
        System.out.println(">> OrderDao() insertOitems()실행");
        return sqlSessionTemplate.insert("orders-mapper.insertOitem",oitemVo);
    }

    //배송지 저장
    public int saveDelivery(OrdersVo ordersVo) {
        return sqlSessionTemplate.insert("orders-mapper.saveDelivery",ordersVo);
    }

    //저장된 배송지 찾기
    public DeliveryInfoVo findAddress(MemberVO vo) {
        System.out.println(">> OrderDao() findAddress()실행");
        System.out.println("받은 membervo : " + vo);
        return sqlSessionTemplate.selectOne("orders-mapper.findDelivery",vo);
    }

    //포인트찾기 (더미)
    public int getPoint(MemberVO mvo) {
        return sqlSessionTemplate.selectOne("orders-mapper.getPoint",mvo);
    }

    public List<OrdersVo> findByMember(MemberVO vo) {
        return sqlSessionTemplate.selectList("orders-mapper.findByMember",vo);
    }

    public List<OitemVo> findByOrderIdx(Integer idx) {
        return sqlSessionTemplate.selectList("orders-mapper.findByOrderIdx",idx);
    }

    public List<OrdersVo> findBySearchOption(OrdersSearchOptionDto searchOption) {
        return sqlSessionTemplate.selectList("orders-mapper.findBySearchOption", searchOption);
    }

    public OrdersStatusCount findStatusCount() {
        return sqlSessionTemplate.selectOne("orders-mapper.findStatusCount");
    }

    public boolean updateStatus(OrdersVo orders) {
        return sqlSessionTemplate.update("orders-mapper.updateStatus", orders) > 0;
    }

    public void updatePoint(MemberVO member) {
        sqlSessionTemplate.update("orders-mapper.updatePoint", member);
    }

    //정기구독 주문리스트 조회
    public List<OrdersVo> findBySubs(MemberVO member) {
        return sqlSessionTemplate.selectList("orders-mapper.findBySubs", member);
    }
    //소품샵, 꽃다발 주문조회
    public List<OrdersVo> findByFlower(MemberVO member) {
        return sqlSessionTemplate.selectList("orders-mapper.findByFlower", member);
    }
}
