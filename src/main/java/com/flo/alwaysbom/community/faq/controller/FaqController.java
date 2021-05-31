package com.flo.alwaysbom.community.faq.controller;

import com.flo.alwaysbom.community.faq.service.FaqService;
import com.flo.alwaysbom.community.faq.vo.FaqVo;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class FaqController {
    private final FaqService service;

    @GetMapping("/community/goFaq")
    public String goFaq(FaqVo vo, Model model) {
        List<String> cateList = service.faqCategory();
        model.addAttribute("category", cateList);
        return "community/faq";
    }

    @PostMapping("/community/api/gogoFaq")
    @ResponseBody
    public List<FaqVo> gogoFaq(FaqVo vo){
        System.out.println(vo.getCategory());
        List<FaqVo> faqlist = service.faqlist(vo);
        return faqlist;
    }
}