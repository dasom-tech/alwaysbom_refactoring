package com.flo.alwaysbom.flower.controller;

import com.flo.alwaysbom.banner.service.BannerService;
import com.flo.alwaysbom.banner.vo.BannerVo;
import com.flo.alwaysbom.community.review.dto.ReviewDto;
import com.flo.alwaysbom.community.review.service.ReviewService;
import com.flo.alwaysbom.flower.service.FlowerService;
import com.flo.alwaysbom.flower.vo.FlowerVo;
import com.flo.alwaysbom.item.service.ItemService;
import com.flo.alwaysbom.item.vo.ItemReviewForm;
import com.flo.alwaysbom.member.vo.MemberVO;
import com.flo.alwaysbom.order.vo.OitemVo;
import com.flo.alwaysbom.product.service.ProductService;
import com.flo.alwaysbom.product.vo.ProductVo;
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
public class FlowerController {

    private final BannerService bannerService;
    private final FlowerService flowerService;
    private final ProductService productService;
    private final FileHandler fileHandler;
    private final ItemService itemService;
    private final ReviewService reviewService;

    @GetMapping("/flower/test")
    public String goTest(){
        return "flower/imgThumbTest";
    }

    @GetMapping("/flower")
    public String getList(Model model) {
        BannerVo banner = bannerService.findByCategory("flower");
        List<FlowerVo> list = flowerService.findAll();
        model.addAttribute("bannerVo", banner);
        model.addAttribute("list", list);
        return "flower/flowerList";
    }

    @GetMapping("/flower/{idx}")
    public String getOne(@PathVariable("idx") Integer idx, Model model, @SessionAttribute(required = false) MemberVO member) {
        FlowerVo flower = flowerService.findByIdx(idx)
                .orElseThrow(() -> new IllegalStateException("해당 상품 인덱스가 존재하지 않습니다"));
        // 추가옵션상품 불러오기
        List<ProductVo> productList = productService.findAll();
        // 꽃다발 카테고리 베스트 리뷰 불러오기
        List<ReviewDto> bestReviewList = flowerService.findBestReview();
        // 이 상품의 리뷰 불러오기
        List<ReviewDto> thisReviewList = flowerService.findReviewByIdx(idx);
        // 리뷰 쓸 수 있는지 체크
        int cnt = 0;
        List<OitemVo> oitemList = null;
        if (member != null) {
            Map<String, String> map = new HashMap<>();
            map.put("flowerIdx", idx + "");
            map.put("memberId", member.getId());
            oitemList = flowerService.findAvailableOitemToReview(map);
        }
        model.addAttribute("flowerVo", flower);
        model.addAttribute("productList", productList);
        model.addAttribute("bestReviewList", bestReviewList);
        model.addAttribute("thisReviewList", thisReviewList);
        model.addAttribute("oitemList", oitemList);

        return "flower/flowerDetail";
    }

    @PostMapping(value = "/flower/{idx}/reviews", produces = {"application/json;charset=utf-8"})
    @ResponseBody
    public ReviewDto addReview(@ModelAttribute ItemReviewForm newReview, @PathVariable Integer idx,
                               @SessionAttribute MemberVO member) throws IOException {

        ReviewDto reviewDto;
        try {
            newReview.setMemberId(member.getId());
            newReview.setCategory("꽃다발");
            newReview.setImage(fileHandler.uploadFile(newReview.getImageFile(), null, "/flower/reviews"));
            reviewDto = itemService.addReview(newReview);
            return reviewDto;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


}
