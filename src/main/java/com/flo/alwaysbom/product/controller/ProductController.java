package com.flo.alwaysbom.product.controller;

import com.flo.alwaysbom.banner.service.BannerService;
import com.flo.alwaysbom.banner.vo.BannerVo;
import com.flo.alwaysbom.community.review.dto.ReviewDto;
import com.flo.alwaysbom.community.review.service.ReviewService;
import com.flo.alwaysbom.fclass.vo.FclassReviewForm;
import com.flo.alwaysbom.item.service.ItemService;
import com.flo.alwaysbom.item.vo.ItemReviewForm;
import com.flo.alwaysbom.member.vo.MemberVO;
import com.flo.alwaysbom.order.vo.OitemVo;
import com.flo.alwaysbom.product.service.ProductService;
import com.flo.alwaysbom.product.vo.ProductVo;
import com.flo.alwaysbom.util.CloudFileHandler;
import com.flo.alwaysbom.util.FileHandler;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.lang.reflect.Member;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class ProductController {

    private final BannerService bannerService;
    private final ItemService itemService;
    private final ProductService productService;
    private final FileHandler fileHandler;

    @GetMapping("/product")
    public String getList(Model model) {
        BackProductController.getProductList(model, productService.findAll(), productService.findByCategory("vase"),
                productService.findByCategory("goods"));
        BannerVo banner = bannerService.findByCategory("product");
        model.addAttribute("bannerVo", banner);
        return "/product/productList";
    }

    @GetMapping("/product/{idx}")
    public String getOne(@PathVariable("idx") Integer idx, Model model, @SessionAttribute(required = false) MemberVO member) {
        ProductVo product = productService.findByIdx(idx)
                .orElseThrow(() -> new IllegalStateException("해당 상품 인덱스가 존재하지 않습니다"));
        // 소품샵 카테고리 베스트 리뷰 불러오기
        List<ReviewDto> bestReviewList = productService.findBestReview();
        // 이 상품의 리뷰 불러오기
        List<ReviewDto> thisReviewList = productService.findReviewByIdx(idx);
        // 리뷰 쓸 수 있는지 체크
        int cnt = 0;
        List<OitemVo> oitemList = null;
        if (member != null) {
            Map<String, String> map = new HashMap<>();
            map.put("productIdx", idx + "");
            map.put("memberId", member.getId());
            oitemList = productService.findAvailableOitemToReview(map);
        }
        model.addAttribute("idx", idx);
        model.addAttribute("productVo", product);
        model.addAttribute("bestReviewList", bestReviewList);
        model.addAttribute("thisReviewList", thisReviewList);
        model.addAttribute("oitemList", oitemList);

        return "product/productDetail";
    }

    @PostMapping("/product/{idx}/get")
    @ResponseBody
    public ProductVo findProductByIdx(@PathVariable("idx") Integer idx) {
        return productService.findByIdx(idx)
                .orElseThrow(() -> new IllegalStateException("해당 상품 인덱스가 존재하지 않습니다"));
    }

//    @PostMapping("product/api/chkAvailability")
//    @ResponseBody
//    public Boolean isPossibleToWrite(@RequestBody Integer idx, @SessionAttribute MemberVO member) {
//        Map<String, String> map = new HashMap<>();
//        map.put("idx", idx + "");
//        map.put("memberId", member.getId());
//        List<OitemVo> list = productService.findAvailableOitemToReview(map);
//        return list.size() > 0;
//    }

    @PostMapping(value = "/product/{idx}/reviews", produces = {"application/json;charset=utf-8"})
    @ResponseBody
    public ReviewDto addReview(@ModelAttribute ItemReviewForm newReview, @PathVariable Integer idx,
                               @SessionAttribute MemberVO member) throws IOException {

        ReviewDto reviewDto;
        try {
            newReview.setMemberId(member.getId());
            newReview.setCategory("소품샵");
            newReview.setImage(fileHandler.uploadFile(newReview.getImageFile(), null, "/product/reviews"));
            reviewDto = itemService.addReview(newReview);
            return reviewDto;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
