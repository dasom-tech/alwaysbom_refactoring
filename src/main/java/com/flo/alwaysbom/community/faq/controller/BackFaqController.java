package com.flo.alwaysbom.community.faq.controller;

import com.flo.alwaysbom.community.faq.service.FaqService;
import com.flo.alwaysbom.community.faq.vo.FaqVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class BackFaqController {
    private final FaqService service;

    @GetMapping("/adnin/community/goFaq")
    public String goFaq(FaqVo vo, Model model) {
        List<String> cateList = service.faqCategory();
        model.addAttribute("category", cateList);
        return "community/b_faq";
    }

    @PostMapping("/admin/community/api/gogoFaq")
    @ResponseBody
    public List<FaqVo> gogoFaq(FaqVo vo){
        System.out.println(vo.getCategory());
        List<FaqVo> faqlist = service.faqlist(vo);
        return faqlist;
    }

    @PostMapping("/admin/faq/api/Delete")
    @ResponseBody
    public boolean adminDelete(FaqVo vo){
        service.faqDelete(vo.getIdx());
        return true;
    }

    @PostMapping("/admin/faq/Update")
    public String adminFaqUpdate(Integer idx, FaqVo vo){
        return "redirect:/admin/faq/write?idx=" + idx;
    }

    @PostMapping("/admin/faq/api/insert")
    @ResponseBody
    public boolean adminFaqInsert(FaqVo vo){
        service.faqInsert(vo);
        return true;
    }

    @PostMapping("/admin/faq/api/update")
    @ResponseBody
    public boolean adminFaqUpdate(FaqVo vo){
        service.faqUpdate(vo);
        return true;
    }

    @GetMapping("/admin/faq/write")
    public String adminFaqWrite(Model model, Integer idx, FaqVo vo){
        List<String> cateList = service.faqCategory();
        if(idx != null) {
            vo = service.faqSelectOne(idx);
        }
        model.addAttribute("category", cateList);
        model.addAttribute("vo", vo);
        return "community/b_faqWrite";
    }
}