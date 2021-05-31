package com.flo.alwaysbom.community.event.controller;


import com.flo.alwaysbom.community.event.service.EventService;
import com.flo.alwaysbom.community.event.vo.EventVo;
import com.flo.alwaysbom.util.CloudFileHandler;
import com.flo.alwaysbom.util.FileHandler;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class BackEventController {
    private final EventService servise;
    private final FileHandler fileHandler;


    @GetMapping("/admin/community/eventList")
    public String eventList(Model model){

        List<EventVo> list = servise.eventList();
        model.addAttribute("eventList", list);
        return "/community/b_EventList";
    }

    @GetMapping("/admin/community/eventOldList")
    public String eventOldList(Model model){
        List<EventVo> list = servise.eventOldList();
        model.addAttribute("eventList", list);
        return "/community/b_EventList";
    }


    @GetMapping("/admin/community/addEventList")
    public String addEventList(EventVo vo, List<MultipartFile> file) throws IOException {
        return "/community/b_addEventClass";
    }

    @PostMapping("/admin/community/addEvent")
    public String addEventContent(EventVo vo, List<MultipartFile> file) throws IOException {
        System.out.println(vo);
        vo.setThumb(fileHandler.uploadFile(file.get(0), null, "event"));
        vo.setImage1(fileHandler.uploadFile(file.get(1), null, "event"));
        vo.setImage2(fileHandler.uploadFile(file.get(2), null, "event"));
        servise.addEvent(vo);
        return "redirect:/admin/community/eventList";
    }

    @PostMapping("/admin/community/eventDelete")
    public String eventDelete(Integer idx){
        EventVo vo = servise.eventDelete(idx);
//        fileHandler.deleteFile(vo.getThumb());
//        fileHandler.deleteFile(vo.getImage1());
//        fileHandler.deleteFile(vo.getImage2());
        return "redirect:/admin/community/eventList";
    }

    @PostMapping("/admin/community/UpdateEvent")
    public String eventUpdate(EventVo vo, List<MultipartFile> file) throws IOException {
        System.out.println(vo);
        vo.setThumb(fileHandler.uploadFile(file.get(0), vo.getThumb(), "event"));
        vo.setImage1(fileHandler.uploadFile(file.get(1), vo.getImage1(), "event"));
        vo.setImage2(fileHandler.uploadFile(file.get(2), vo.getImage2(), "event"));
        servise.eventUpdate(vo);
        return "redirect:/admin/community/eventList";

    }

    @GetMapping("/admin/event/detail")
    public String eventDetail(Integer idx, Model model) {
        EventVo vo = servise.eventDetail(idx);
        model.addAttribute("eventVo", vo);

        return "/community/b_EventClassDetail";
    }



}
