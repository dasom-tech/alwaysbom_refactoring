package com.flo.alwaysbom.order.controller;

import com.flo.alwaysbom.member.vo.MemberVO;
import com.flo.alwaysbom.order.dao.OrdersDao;
import com.flo.alwaysbom.order.service.OrdersService;
import com.flo.alwaysbom.order.vo.OrdersSearchOptionDto;
import com.flo.alwaysbom.order.vo.OrdersStatusCount;
import com.flo.alwaysbom.order.vo.OrdersVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class BackOrderController {

    private final OrdersService ordersService;
    private final OrdersDao ordersDao;

    @GetMapping("/admin/order")
    public String backOrder() {
        return "b_orderList";
    }

    //주문정보 + 주문한 상품내역 조회 (관리자용)
    @GetMapping("/admin/orders")
    public String findOrder(@SessionAttribute(required = false) MemberVO member, Model model) {
        if (member == null) {
            member = MemberVO.builder().id("yuna1880").build();
        }

        OrdersSearchOptionDto searchOption = OrdersSearchOptionDto.builder()
                //.memberId(member.getId()) // admin 일땐 이게 없어야 함.
                .status("입금대기")
                .build();

        List<OrdersVo> ordersList = ordersService.findBySearchOption(searchOption);
        //주문에 대한 총 개수 구하기
        OrdersStatusCount statusCount = ordersService.findStatusCount();

        model.addAttribute("statusCount", statusCount);
        model.addAttribute("searchOption", searchOption);
        model.addAttribute("ordersList",ordersList);
        return "/order/b_orderList";
    }

    //해당 status에 대한 주문정보 찾기 (만들어둔 DTO이용)
    @GetMapping("/admin/api/orders")
    public String findOrdersByStatus(OrdersSearchOptionDto searchOption, Model model) {
        //라디오 버튼에서 선택한 ststus 값으로 주문 찾기
        List<OrdersVo> orders = ordersService.findBySearchOption(searchOption);
        model.addAttribute("searchOption", searchOption);
        model.addAttribute("ordersList", orders);
        return "/order/b_orderListContent";
    }

    //해당 인덱스의 상태값 update
    @RequestMapping("/admin/api/orders/{idx}/status")
    @ResponseBody
    public boolean updateStatus(@RequestBody String status, @PathVariable Integer idx) {
        OrdersVo orders = OrdersVo.builder()
                .idx(idx)
                .status(status)
                .build();

        return ordersService.updateStatus(orders);
    }

}
