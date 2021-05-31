package com.flo.alwaysbom.order.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.type.CollectionType;
import com.flo.alwaysbom.order.service.OrderPriceService;
import com.flo.alwaysbom.order.vo.*;
import com.flo.alwaysbom.member.vo.MemberVO;
import com.flo.alwaysbom.order.service.OrdersService;
import com.flo.alwaysbom.util.MailSend;
import lombok.RequiredArgsConstructor;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Controller
@RequiredArgsConstructor
@SessionAttributes(value = {"ordersVo","oitemList","member"})
public class OrdersController {

    private final OrderPriceService orderPriceService;
    private final OrdersService ordersService;
    private final MailSend mail;

    //주문 시작!
    @PostMapping("/order/letter")

    public String startOrder(@SessionAttribute("member") MemberVO member, String data, Model model) throws JsonProcessingException {
        System.out.println(">>startOrder() 주문시작!");

        ObjectMapper mapper = new ObjectMapper();
//        List<OitemVo> list = mapper.readValue(data, new TypeReference<List<OitemVo>>() {});
        CollectionType collectionType = mapper.getTypeFactory().constructCollectionType(ArrayList.class, OitemVo.class);
        List<OitemVo> list = mapper.readValue(data, collectionType);
        list.forEach(System.out::println);

        System.out.println("oitemList : " + list);
        model.addAttribute("oitemList", list);
        model.addAttribute("member", member);

        return "order/letter";
    }

    //편지 (letter_contents값 가지고)-> 배송지입력
    @PostMapping("/oitem/checkOut")
    public String checkOut(@SessionAttribute("oitemList") List<OitemVo> olist, Model model, String data) throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        CollectionType collectionType = mapper.getTypeFactory().constructCollectionType(ArrayList.class, Letter.class);
        List<Letter> list = mapper.readValue(data, collectionType);
        System.out.println("oitemList : " + olist);

        //편지 내용들 출력해보고, 각 인덱스에 맞는 편지내용 저장!
        for (Letter letter : list) {
            System.out.println("편지 : " + letter.getContent());
            olist.get(letter.getIdx()).setLetterContent(letter.getContent());
        }

        //편지 내용 저장 후 oitemList
        System.out.println("oitemList : " + olist);
        return "order/checkout";
    }

    //배송지입력 후 -> 결제전 확인 페이지
    @PostMapping("/order/payment")
    public String goPayment(@SessionAttribute("oitemList") List<OitemVo> olist , OrdersVo ordersVo,@SessionAttribute("member") MemberVO member, Model model) {

        //세션값 가져오기
        System.out.println("orderVo = " + ordersVo); //orderList
        System.out.println("OitemList = " + olist); //oitemList

        model.addAttribute("member", member);
        model.addAttribute("oitemList", olist);
        model.addAttribute("orderPrice", orderPriceService.getOrderPrice(olist, member));

        ordersVo.setMemberId(member.getId());
        model.addAttribute("ordersVo", ordersVo); //orderVo 세션
        System.out.println("ordersVo : " + ordersVo);
        return "order/payment";
    }

    //배송지 찾기
    @PostMapping("/order/findAddress")
    @ResponseBody
    public DeliveryInfoVo findAddress(@SessionAttribute("member") MemberVO member) {
        System.out.println("findAddress()");
        System.out.println("member : " + member);
        DeliveryInfoVo dvo = ordersService.findAddress(member);
        System.out.println("찾은 주소 : " + dvo);
        return dvo;
    }

    //주문 전 확인창 (결제 정보 입력) -> 주문 완료
    @PostMapping("/order/complete")
    public String completeOrder (@SessionAttribute("oitemList") List<OitemVo> olist, @SessionAttribute("member") MemberVO member, OrdersVo ordersVo, Model model) {

        System.out.println("OrdersController.completeOrder");
        System.out.println("oitemList : " + olist);
        System.out.println("orderVo : " + ordersVo);

        //주문상태 변경 (신용카드 -> 결제완료 / 무통장입금 -> 입금대기)
        if (ordersVo.getPayType().equals("무통장입금")) {
            ordersVo.setStatus("입금대기");
        } else {
            ordersVo.setStatus("결제완료");
        }

        //주문상품, 주문자 정보 모두 가지고 DB insert
        ordersService.insertOrder(ordersVo, olist);

        //배송지 저장 눌렀을때 ? -> 저장해주기
        if (ordersVo.isSaveAddress()) {
            ordersService.saveDelivery(ordersVo);
        }
        //mail.sendMail("xzllxz456@naver.com");

        System.out.println("최종 ordersVo: " + ordersVo);

        //주문 후 회원 포인트 업데이트
        if (ordersVo.getDiscountPoint() != 0) {
            Integer updatedPoint = (member.getPoint() - ordersVo.getDiscountPoint());
            member.setPoint(updatedPoint);
            ordersService.updatePoint(member);
        }

        model.addAttribute("member", member);
        model.addAttribute("oitemList", olist);
        model.addAttribute("ordersVo",ordersVo);
        return "/order/order_ok";
    }




    //주문정보 + 주문한 상품내역 조회 (회원용)
    @GetMapping("/orders")
    public String findByMember(@SessionAttribute(required = false) MemberVO member, Model model) {
        if (member == null) {
            member = MemberVO.builder().id("yuna1880").build();
        }

        OrdersSearchOptionDto searchOption = OrdersSearchOptionDto.builder()
                .memberId(member.getId()) // admin 일땐 이게 없어야 함.
                //.status("입금대기") //회원으로 조회는 상태값 필요없다.
                .build();

        List<OrdersVo> ordersList = ordersService.findBySearchOption(searchOption);

        model.addAttribute("searchOption", searchOption);
        model.addAttribute("ordersList",ordersList);
        return "/order/orderList";
    }

    // (정기구독)으로 조회
    @GetMapping("/orders/subsList")
    public String findBySubs (@SessionAttribute(required = false) MemberVO member, Model model) {
        if (member == null) {
            member = MemberVO.builder().id("yuna1880").build();
        }
        List<OrdersVo> ordersList = ordersService.findBySubs(member);
        ordersList.forEach(ordersVo -> {
            ordersVo.setOlist(ordersVo.getOlist().stream().filter(oitemVo -> {
                String category = oitemVo.getCategory();
                return category.equals("정기구독");
            }).collect(Collectors.toList()));
        });

        model.addAttribute("ordersList", ordersList);
        return "/order/subsList";
    }

    // (꽃다발, 소품샵) 으로 조회
    @GetMapping("/orders/flowerList")
    public String findByFlower (@SessionAttribute(required = false) MemberVO member, Model model) {
        if (member == null) {
            member = MemberVO.builder().id("yuna1880").build();
        }
        List<OrdersVo> ordersList = ordersService.findByFlower(member);
        ordersList.forEach(ordersVo -> {
            ordersVo.setOlist(ordersVo.getOlist().stream().filter(oitemVo -> {
                String category = oitemVo.getCategory();
                return category.equals("꽃다발") || category.equals("소품샵");
            }).collect(Collectors.toList()));
        });


        model.addAttribute("ordersList", ordersList);
        return "/order/orderList";
    }

    // status (주문상태 = 배송완료) 로 조회하기 (동호)
    @GetMapping("/orders/status")
    public String findByStatus(@SessionAttribute(required = false) MemberVO member, Model model) {

        if (member == null) {
            member = MemberVO.builder().id("yuna1880").build();
        }

        OrdersSearchOptionDto searchOption = OrdersSearchOptionDto.builder()
                .memberId(member.getId()) // 현재 로그인된 회원 아이디
                .status("배송완료") // 배송완료 상태값
                .build();

        List<OrdersVo> ordersList = ordersService.findBySearchOption(searchOption);

        System.out.println("orderList : " + ordersList);
        model.addAttribute("searchOption", searchOption);
        model.addAttribute("ordersList",ordersList);
        return "/order/orderStatus";
    }


}
