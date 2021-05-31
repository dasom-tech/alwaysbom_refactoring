package com.flo.alwaysbom.subs.controller;

import com.flo.alwaysbom.subs.service.SubsService;
import com.flo.alwaysbom.subs.vo.SubsVo;
import com.flo.alwaysbom.util.CloudFileHandler;
import com.flo.alwaysbom.util.FileHandler;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class BackSubsController {

    private final SubsService subsService;
    private final FileHandler fileHandler;

    //백오피스 정기구독 이동
    @GetMapping("/admin/subs")
    public String goIndex() {
        return "subs/b_subsManager";
    }

    //백오피스 정기구독 상품등록 이동
    @GetMapping("/admin/subsAddForm")
    public String goAddForm() {
        return "subs/b_addForm";
    }

    //정기구독 등록 ! (파일 업로드) -> 담영언니한테 물어보기!
    @PostMapping("/admin/addSubs")
    public String addSubs(SubsVo svo, List<MultipartFile> file) throws IOException {
        svo.setImage1(fileHandler.uploadFile(file.get(0),null,"subs"));
        svo.setImage2(fileHandler.uploadFile(file.get(1),null,"subs"));
        svo.setImage3(fileHandler.uploadFile(file.get(2),null,"subs"));
        System.out.println("svo = " + svo);
        subsService.addSubs(svo);
        return "redirect:/admin/subsList";
    }

    //상품 수정 페이지로 이동
    @GetMapping("/admin/subsUpdateForm/{idx}")
    public String goUpdateForm(@PathVariable Integer idx, Model model) {
        SubsVo subs = subsService.findByIdx(idx)
                .orElseThrow(() -> new IllegalStateException("해당 상품 인덱스가 존재하지 않습니다."));
        model.addAttribute("subsVo",subs);
        return "subs/b_addForm";
    }

    //상품 수정 완료 버튼 클릭시
    @PostMapping("/admin/updateSubs")
    public String updateSubs(SubsVo svo, List<MultipartFile> file) throws IOException {
        svo.setImage1(fileHandler.uploadFile(file.get(0), svo.getImage1(),"subs"));
        svo.setImage2(fileHandler.uploadFile(file.get(1), svo.getImage2(),"subs"));
        svo.setImage3(fileHandler.uploadFile(file.get(2), svo.getImage3(),"subs"));
        Integer idx = subsService.updateSubs(svo);
        return "redirect:/admin/subsList";
    }

    //정기구독 상품 리스트 조회
    @GetMapping("/admin/subsList")
    public String findAll(Model model) {
        System.out.println("findAll()실행");
        List<SubsVo> list = subsService.findAll();
        model.addAttribute("subsList",list);
        return "subs/b_subsList";
    }
    //상품 인덱스로 상세페이지 조회
    @GetMapping("/admin/subs/{idx}")
    public String findByIdx(@PathVariable Integer idx, Model model) {
        SubsVo subs = subsService.findByIdx(idx).orElseThrow(() -> new IllegalStateException("해당 상품 인덱스가 존재하지 않습니다."));
        model.addAttribute("subsVo",subs);
        return "subs/b_subsDetail";
    }

    //해당 상품 삭제
    @GetMapping("/admin/deleteSubs")
    public String deleteSubs(Integer idx) {
        System.out.println("deleteSubs()실행");
        subsService.deleteSubs(idx);
        return "redirect:/admin/subsList";
    }
}
