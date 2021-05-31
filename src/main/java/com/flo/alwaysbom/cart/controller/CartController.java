package com.flo.alwaysbom.cart.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.flo.alwaysbom.cart.service.CartService;
import com.flo.alwaysbom.cart.vo.CartVo;
import com.flo.alwaysbom.member.vo.MemberVO;
import com.flo.alwaysbom.order.vo.Letter;
import lombok.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class CartController {

    private final CartService cartService;

    @GetMapping("/cart/list")
    public String getCart(@SessionAttribute(required = false) MemberVO member, Model model) {
        if (member == null) {
            member = MemberVO.builder().id("test").build();
        }

        List<CartVo> list = cartService.findCartsByMember(member.getId());

        int totalSum = list.stream().mapToInt(CartVo::getTotalPrice).sum();

        model.addAttribute("list", list);
        model.addAttribute("totalSum", totalSum);
        return "cart/list";
    }

    //@RequestBody : 들어오는 json 문자열을 java객체로 변환.
    //@ResponseBody : 리턴되는 자바 객체를 json문자열로 변환.
    @GetMapping("/cart/{idx}")
    @ResponseBody
    public CartVo findCartByIdx(@PathVariable("idx") Integer idx) {
        return cartService.findById(idx)
                .orElseThrow(() -> new IllegalStateException("해당 Id가 존재하지 않습니다"));
    }

}
