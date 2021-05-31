package com.flo.alwaysbom.flower.controller;

import com.flo.alwaysbom.flower.service.FlowerService;
import com.flo.alwaysbom.flower.vo.FlowerVo;
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
public class BackFlowerController {

    private final FlowerService flowerService;
    private final FileHandler fileHandler;

    /* 꽃다발 관리 인덱스로 이동 */
    @GetMapping("/admin/flower")
    public String goIndex() {
        return "flower/b_flowerManager";
    }

    /* 상품 등록페이지로 이동 */
    @GetMapping("/admin/flowerAddForm")
    public String goInsertForm() {
        return "flower/b_addForm";
    }

    /* '등록하기' 버튼 눌렀을 때 처리 */
    @PostMapping("/admin/addFlower")
    public String addFlower(FlowerVo vo, List<MultipartFile> file) throws IOException {
        vo.setImage1(fileHandler.uploadFile(file.get(0), null, "flower"));
        vo.setImage2(fileHandler.uploadFile(file.get(1), null, "flower"));
        vo.setImage3(fileHandler.uploadFile(file.get(2), null, "flower"));
        vo = flowerService.addFlower(vo);
        return "redirect:/admin/flowerList";
    }

    /* 상품 수정페이지로 이동 */
    @GetMapping("/admin/flowerUpdateForm/{idx}")
    public String goUpdateForm(@PathVariable Integer idx, Model model) {
        FlowerVo flower = flowerService.findByIdx(idx)
                .orElseThrow(() -> new IllegalStateException("해당 상품 인덱스가 존재하지 않습니다"));
        model.addAttribute("flowerVo", flower);
        return "flower/b_addForm";
    }

    /* '수정완료' 버튼 눌렀을 때 처리 */
    @PostMapping("/admin/updateFlower")
    public String updateFlower(FlowerVo vo, List<MultipartFile> file) throws IOException {
        vo.setImage1(fileHandler.uploadFile(file.get(0), vo.getImage1(), "flower"));
        vo.setImage2(fileHandler.uploadFile(file.get(1), vo.getImage2(), "flower"));
        vo.setImage3(fileHandler.uploadFile(file.get(2), vo.getImage3(), "flower"));
        Integer idx = flowerService.updateFlower(vo);
        return "redirect:/admin/flowerList";
    }

    /* 꽃다발 상품 리스트 조회 */
    @GetMapping("/admin/flowerList")
    public String findAll(Model model) {
        List<FlowerVo> list = flowerService.findAll();
        model.addAttribute("list", list);
        return "flower/b_flowerList";
    }

    /* 상품 삭제 */
    @GetMapping("/admin/deleteFlower")
    public String deleteFlower(Integer idx) {
        flowerService.deleteFlower(idx);
        return "redirect:/admin/flowerList";
    }


}
