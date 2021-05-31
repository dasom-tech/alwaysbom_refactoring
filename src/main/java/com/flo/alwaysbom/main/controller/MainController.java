package com.flo.alwaysbom.main.controller;

import com.flo.alwaysbom.fclass.service.FclassService;
import com.flo.alwaysbom.fclass.vo.FclassVo;
import com.flo.alwaysbom.flower.service.FlowerService;
import com.flo.alwaysbom.flower.vo.FlowerVo;
import com.flo.alwaysbom.main.service.MainService;
import com.flo.alwaysbom.main.vo.MainVo;
import com.flo.alwaysbom.subs.service.SubsService;
import com.flo.alwaysbom.subs.vo.SubsVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class MainController {

    private final FclassService fclassService;
    private final FlowerService flowerService;
    private final MainService mainService;
    private final SubsService subsService;

    @GetMapping("/")
    public String main(Model model) {
        MainVo mainVo = mainService.getConfig();
        System.out.println("mainVo = " + mainVo);
        List<SubsVo> subsList = subsService.findAll();
        List<FlowerVo> flowerList = flowerService.findRecent4();
        FclassVo fclassBig = fclassService.findByIdx(mainVo.getFclassIdxBig());
        FclassVo fclassSmall = fclassService.findByIdx(mainVo.getFclassIdxSmall());

        model.addAttribute("mainVo", mainVo);
        model.addAttribute("subsList", subsList);
        model.addAttribute("flowerList", flowerList);
        model.addAttribute("fclassBig", fclassBig);
        model.addAttribute("fclassSmall", fclassSmall);

        return "main/index";
    }


}
