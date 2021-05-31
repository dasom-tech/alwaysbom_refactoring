package com.flo.alwaysbom.order.service;


import com.flo.alwaysbom.cart.dao.CartDao;
import com.flo.alwaysbom.member.vo.MemberVO;
import com.flo.alwaysbom.order.dao.OrdersDao;
import com.flo.alwaysbom.order.vo.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class OrdersServiceImpl implements OrdersService {

    private final OrdersDao orderDao;
    private final CartDao cartDao;

    //주문완료시 저장
    @Override
    public OrdersVo insertOrder(OrdersVo ordersVo, List<OitemVo> olist) {
        orderDao.insertOrder(ordersVo);

        // 방법 1
        List<OitemVo> list = new ArrayList<>();
        for (OitemVo oitemVo : olist) {
            oitemVo.setOrdersIdx(ordersVo.getIdx());
            orderDao.insertOitem(oitemVo);
            cartDao.removeByIdx(oitemVo.getCartIdx());
            list.add(oitemVo);
        }

        /* 방법 2
        List<OitemVo> list = olist.stream()
                .peek(oitemVo -> {
                    oitemVo.setOrdersIdx(ordersVo.getIdx());
                    orderDao.insertOitem(oitemVo);
                })
                .collect(Collectors.toList());
         */

        ordersVo.setOlist(list);

        //남은 일

        return ordersVo;
    }

    // 배송지 불러오기
    @Override
    public DeliveryInfoVo findAddress(MemberVO vo) {
        return orderDao.findAddress(vo);
    }

    @Override
    public int getPoint(MemberVO mvo) {
        return orderDao.getPoint(mvo);
    }


    @Override
    public OrdersVo saveDelivery(OrdersVo ordersVo) {
        orderDao.saveDelivery(ordersVo);
        return ordersVo;
    }

    @Override
    public List<OrdersVo> findByMember(MemberVO vo) {

        //여기서는 ordersList들만 뽑아줌
        List<OrdersVo> ordersList = orderDao.findByMember(vo);
/*
        // 찾은 orderList안의 oitemList를 orderIdx가 동일한 것만 찾아오기(내가 한 것)
        for(OrdersVo order : ordersList) {
            // ordersVo의 olist를 (orderDao에서 찾은 idx값의 값으로 set 해줌) (그래서 orderIdx만 필요!!)
            order.setOlist(orderDao.findByOrderIdx(order.getIdx()));
        }
        System.out.println("orderList =" + ordersList);
 */
        return ordersList;
    }

    @Override
    public List<OrdersVo> findBySearchOption(OrdersSearchOptionDto searchOption) {
        return orderDao.findBySearchOption(searchOption);
    }

    @Override
    public OrdersStatusCount findStatusCount() {
        return orderDao.findStatusCount();
    }

    @Override
    public boolean updateStatus(OrdersVo orders) {
        return orderDao.updateStatus(orders);
    }

    @Override
    public void updatePoint(MemberVO member) {
        orderDao.updatePoint(member);
    }

    @Override
    public List<OrdersVo> findBySubs(MemberVO member) {
        return orderDao.findBySubs(member);
    }

    @Override
    public List<OrdersVo> findByFlower(MemberVO member) {
        return orderDao.findByFlower(member);
    }

}
