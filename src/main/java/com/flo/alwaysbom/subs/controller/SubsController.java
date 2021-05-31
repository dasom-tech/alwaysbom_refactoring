package com.flo.alwaysbom.subs.controller;

import com.flo.alwaysbom.banner.service.BannerService;
import com.flo.alwaysbom.banner.vo.BannerVo;
import com.flo.alwaysbom.community.review.dto.ReviewDto;
import com.flo.alwaysbom.item.service.ItemService;
import com.flo.alwaysbom.item.vo.ItemReviewForm;
import com.flo.alwaysbom.member.vo.MemberVO;
import com.flo.alwaysbom.order.vo.OitemVo;
import com.flo.alwaysbom.product.service.ProductServiceImpl;
import com.flo.alwaysbom.product.vo.ProductVo;
import com.flo.alwaysbom.subs.service.SubsService;
import com.flo.alwaysbom.subs.vo.SubsVo;
import com.flo.alwaysbom.util.FileHandler;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class SubsController {

    private final BannerService bannerService;
    private final SubsService subsService;
    private final ProductServiceImpl productService;
    private final FileHandler fileHandler;
    private final ItemService itemService;

    @GetMapping("/subs")
    public String goIndex(Model model) {
        BannerVo banner = bannerService.findByCategory("subs");
        List<SubsVo> list = subsService.findAll();
        model.addAttribute("subsList", list);
        model.addAttribute("bannerVo", banner);
        return "subs/subsMain";
    }

    @GetMapping("/subs/{idx}")
    public String getOne(@PathVariable("idx") Integer idx, Model model, @SessionAttribute(required = false) MemberVO member) {
        SubsVo subs = subsService.findByIdx(idx)
                .orElseThrow( () -> new IllegalStateException("해당 상품 인덱스가 존재하지 않습니다"));
        // 추가 옵션 상품 불러오기
        List<ProductVo> productList = productService.findAll();
        // 소품샵 카테고리 베스트 리뷰 불러오기
        List<ReviewDto> bestReviewList = subsService.findBestReview();
        // 이 상품의 리뷰 불러오기
        List<ReviewDto> thisReviewList = subsService.findReviewByIdx(idx);
        // 리뷰 쓸 수 있는지 체크
        List<OitemVo> oitemList = null;
        if (member != null) {
            Map<String, String> map = new HashMap<>();
            map.put("subsIdx", idx + "");
            map.put("memberId", member.getId());
            oitemList = subsService.findAvailableOitemToReview(map);
        }
        model.addAttribute("subsVo",subs);
        model.addAttribute("productList", productList);
        model.addAttribute("bestReviewList", bestReviewList);
        model.addAttribute("thisReviewList", thisReviewList);
        model.addAttribute("oitemList", oitemList);

        return "subs/subsDetail";
    }

    @PostMapping(value = "/subs/{idx}/reviews", produces = {"application/json;charset=utf-8"})
    @ResponseBody
    public ReviewDto addReview(@ModelAttribute ItemReviewForm newReview, @PathVariable Integer idx,
                               @SessionAttribute MemberVO member) throws IOException {

        ReviewDto reviewDto;
        try {
            newReview.setMemberId(member.getId());
            newReview.setCategory("정기구독");
            newReview.setImage(fileHandler.uploadFile(newReview.getImageFile(), null, "/subs/reviews"));
            reviewDto = itemService.addReview(newReview);
            return reviewDto;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
