package com.flo.alwaysbom.community.review.controller;

import com.flo.alwaysbom.community.review.dto.ReviewDto;
import com.flo.alwaysbom.community.review.service.ReviewService;
import com.flo.alwaysbom.community.review.vo.ReviewLikeVo;
import com.flo.alwaysbom.member.vo.MemberVO;
import com.flo.alwaysbom.order.vo.OrdersVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class MyPageReviewController {
    private final ReviewService service;

//    @GetMapping("/community/com_mypage_review")
//    public String goReview(@SessionAttribute(required = false) MemberVO member, Model model){
//        List<OrdersVo> orderList = service.reviewPossible(member.getId());
//        System.out.println(orderList);
//        model.addAttribute("orderList", orderList);
//        return "community/com_mypage_review";
//    }

}
