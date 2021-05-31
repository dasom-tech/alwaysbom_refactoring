package com.flo.alwaysbom.community.event.controller;


import com.flo.alwaysbom.community.event.service.EcommentService;
import com.flo.alwaysbom.community.event.service.EventService;
import com.flo.alwaysbom.community.event.vo.EcommentVo;
import com.flo.alwaysbom.community.event.vo.EventVo;
import com.flo.alwaysbom.util.CloudFileHandler;
import com.flo.alwaysbom.util.FileHandler;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class EventController {
    private final FileHandler fileHandler;
    private final EventService servise;
    private final EcommentService ecommentService;

    @GetMapping("/community/event/eventlist")
    public String eventlist(Model model){
        List<EventVo> list = servise.eventList();
        model.addAttribute("eventList", list);
        return "community/eventList";
    }

    @GetMapping("/community/event/{idx}")
    public String eventDetail(@PathVariable("idx") Integer idx, Model model){
        EventVo vo = servise.eventDetail(idx);
        model.addAttribute("eventVo", vo);

        List<EcommentVo> list = ecommentService.ecoList(vo.getIdx());
        model.addAttribute("ecoList", list);
        return "community/eventDetail";
    }

    @PostMapping("/community/eco/addEcomment")
    public String addEcomment(EcommentVo vo){
        ecommentService.addEcomment(vo);
        return "redirect:/community/event/" + vo.getEventIdx();
    }

    @PostMapping("/api/community/eco/ecommentList")
    @ResponseBody
    public List<EcommentVo> ecommentList(Integer idx){
        List<EcommentVo> list = ecommentService.ecoList(idx);
        return list;
    }

    @PostMapping("/api/community/eco/ecommentUpdate")
    @ResponseBody
    public EcommentVo ecommentUpdate(EcommentVo vo) {
        EcommentVo evo = ecommentService.findByIdx(vo);
        return evo;
    }

    @PostMapping("/api/community/eco/ecommentUpdateSend")
    @ResponseBody
    public Boolean ecommentUpdateSend(EcommentVo vo) {

        ecommentService.ecommentUpdate(vo);
        return true;
    }

    @PostMapping("/api/community/eco/ecommentDeleteSend")
    @ResponseBody
    public Boolean ecommentDeleteSend(EcommentVo vo) {
        ecommentService.ecommentDelete(vo.getIdx());
        return true;
    }

    @PostMapping("/api/community/eco/ecommentReport")
    @ResponseBody
    public Boolean ecommentReport(Integer idx){
        ecommentService.ecommentReport(idx);
        return true;
    }


}
