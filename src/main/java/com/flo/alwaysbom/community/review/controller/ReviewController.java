package com.flo.alwaysbom.community.review.controller;

import com.flo.alwaysbom.community.review.dto.ReviewDto;
import com.flo.alwaysbom.community.review.service.ReviewService;
import com.flo.alwaysbom.community.review.vo.ReviewLikeVo;
import com.flo.alwaysbom.fclass.vo.OclassVo;
import com.flo.alwaysbom.member.vo.MemberVO;
import com.flo.alwaysbom.order.vo.OrdersVo;
import com.flo.alwaysbom.util.CloudFileHandler;
import com.flo.alwaysbom.util.FileHandler;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class ReviewController {
    private final ReviewService service;
    private final FileHandler fileHandler;

    @GetMapping("/community/goReview")
    public String goReview(@SessionAttribute(required = false) MemberVO member, Model model){
        if (member == null) {
            // 없을 때 임시
            member = new MemberVO();
            member.setId("ee@test.com");
        }

        List<ReviewDto> bestRList = service.allBestReview(member.getId());
        model.addAttribute("bestRList", bestRList);
        int oldListCnt = service.oldListCnt();
        model.addAttribute("oldListCnt", oldListCnt);
        List<ReviewLikeVo> likeList = service.likeList();
        model.addAttribute("likeList", likeList);
        return "community/review";
    }

    @PostMapping("/community/api/category/goAllReview")
    @ResponseBody
    public List<ReviewDto> goAllReview(@SessionAttribute(required = false) MemberVO member, Model model, String category, String startIndex, String endIndex){
        if (member == null) {
            // 없을 때 임시
            member = new MemberVO();
            member.setId("ee@test.com");
        }

        Map<String, String> searchParam = new HashMap<>();
        searchParam.put("startIndex",startIndex);
        searchParam.put("endIndex",endIndex);
        if(category.equals("")){
            category = null;
        }
        searchParam.put("category", category);

        List<ReviewDto> list = service.allCateReview(searchParam, member.getId());
        System.out.println(list);
//        ObjectMapper mapper = new ObjectMapper();
//        String jsonStr = mapper.writeValueAsString(list);
//        System.out.println(jsonStr);
        return list;

    }

    @PostMapping("/question/searchReview")
    @ResponseBody
    public List<ReviewDto> searchReview(@SessionAttribute(required = false) MemberVO member, String opt, String search, Model model){
        if (member == null) {
            // 없을 때 임시
            member = new MemberVO();
            member.setId("ee@test.com");
        }

        List<ReviewDto> list = service.searchReview(opt, search, member.getId());
        System.out.println(list);
        List<ReviewLikeVo> likeList = service.likeList();
        model.addAttribute("likeList", likeList);
        return list;
    }

    @PostMapping("/community/api/category/goBestReview")
    @ResponseBody
    public List<ReviewDto> goAllReview(@SessionAttribute(required = false) MemberVO member, Model model, String tab, String category){
        if (member == null) {
            // 없을 때 임시
            member = new MemberVO();
            member.setId("ee@test.com");
        }
        System.out.println(category + " 카테 " + tab + "탭탭");
        List<ReviewDto> bestRList;
        if(category != null || !(category.equals(""))){
            model.addAttribute("category", category);
        }
        bestRList = service.cateBestReview(category, member.getId());
        model.addAttribute("bestRList", bestRList);
        List<ReviewLikeVo> likeList = service.likeList();
        model.addAttribute("likeList", likeList);
        return bestRList;
    }

    @GetMapping("/community/category/goReview")
    public String goReview(@SessionAttribute(required = false) MemberVO member, Model model, String category, Integer page){
        if (member == null) {
            // 없을 때 임시
            member = new MemberVO();
            member.setId("ee@test.com");
        }
        if (category == null){
            category = "";
        }
        if(category != null || !(category.equals(""))){
            model.addAttribute("category", category);
        }
        List<ReviewDto> bestRList = service.cateBestReview(category, member.getId());
        model.addAttribute("bestRList", bestRList);
        int oldListCnt = service.oldCateListCnt(category);
        model.addAttribute("oldListCnt", oldListCnt);
        List<ReviewLikeVo> likeList = service.likeList();
        model.addAttribute("likeList", likeList);
        return "community/review";
    }

    @GetMapping("/community/category/writeReview")
    public String goWrite(){
        return null;
    }

    @GetMapping("/community/category/deleteReview")
    public String deleteReview(@SessionAttribute(required = false) MemberVO member, Integer idx){
        service.deleteReview(idx, member);
        return "redirect:/community/goReview";
    }

    @GetMapping("/community/api/category/golike")
    public List<ReviewLikeVo> like(){

        return service.likeList();
    }

    @GetMapping("/admin/question/likeCheck")
    @ResponseBody
    public Boolean likeCheck(String memberId, Integer reviewIdx){
        service.likeCheck(memberId, reviewIdx);
        return true;
    }

    @GetMapping("/community/com_mypage_review")
    public String myPageReview(@SessionAttribute(required = false) MemberVO member, Model model){
        List<OrdersVo> orderList = service.reviewPossible(member.getId());
        System.out.println(orderList);
        model.addAttribute("orderList", orderList);
        return "community/com_mypage_review";
    }

    @GetMapping("/community/event/reviewWrite")
    public String revieWrite(String category, String name, Integer idx, Model model, Integer reviewIdx){
        System.out.println("reviewIdx =" + reviewIdx);
        ReviewDto dto = service.revieWrite(category, name);
        model.addAttribute("reviewDto", dto);
        model.addAttribute("oidx", idx);
        model.addAttribute("reviewIdx", reviewIdx);
        return "community/rv_Writer";
    }

    @PostMapping("/admin/community/addReview")
    public String addReview(@SessionAttribute(required = false) MemberVO member, ReviewDto vo, MultipartFile file, Integer comment, Integer oidx) throws IOException {
        System.out.println(vo + "  " + file + "  " + comment);
        vo.setImage(fileHandler.uploadFile(file, vo.getImage(), "review"));
        vo.setStar(comment);
        vo.setMemberId(member.getId());
        System.out.println(oidx);
        service.addReview(vo, oidx);
        return "redirect:/community/com_mypage_review";
    }

    @GetMapping("/community/api/myPageReviewe")
    @ResponseBody
    public List<OrdersVo> myPageReviewe(@SessionAttribute(required = false) MemberVO member, Model model){
    List<OrdersVo> orderList = service.reviewPossible(member.getId());
        System.out.println(orderList);
        model.addAttribute("orderList", orderList);
        return orderList;
    }

    @GetMapping("/community/event/updateWrite")
    public String updateWrite(String category, String name, Integer idx, Model model, Integer reviewIdx){
        System.out.println(reviewIdx);
        ReviewDto dto = service.findByIdx(reviewIdx);
        model.addAttribute("reviewDto", dto);
        return "community/rvUpdater";
    }

    @PostMapping("/admin/community/updateReview")
    public String updateReview(@SessionAttribute(required = false) MemberVO member, ReviewDto vo, MultipartFile file, Integer comment, Integer idx) throws IOException {
        vo.setImage(fileHandler.uploadFile(file, vo.getImage(), "review"));
        vo.setStar(comment);
        vo.setMemberId(member.getId());
        System.out.println(vo.getIdx());
        service.updateReview(vo, idx);
        return "redirect:/community/com_mypage_review";
    }

    @PostMapping("/community/event/updateWrite")
    public ReviewDto updateApiWrite(String category, String name, Integer idx, Model model, Integer reviewIdx) {
        ReviewDto dto = service.findByIdx(reviewIdx);
        model.addAttribute("reviewDto", dto);
        return dto;
    }

    @GetMapping("/community/api/myPageReviewFclass")
    @ResponseBody
    public List<OclassVo> reviewOclass(@SessionAttribute(required = false) MemberVO member, Integer check){
        List<OclassVo> OclassList = service.reviewOclass(member.getId(), check);
        System.out.println(OclassList);
        return OclassList;
    }

    @GetMapping("/community/classWriter")
    public String classWriter(String category, Integer fidx, Integer idx,Model model){
        System.out.println(category + "  " + fidx);
        ReviewDto dto = new ReviewDto();
        dto.setCategory(category);
        dto.setFclassIdx(fidx);
        model.addAttribute("reviewDto", dto);
        model.addAttribute("oidx", idx);
        model.addAttribute("reviewIdx", idx);
        return "community/rv_Writer";
    }

    @GetMapping("/community/event/updateFclassWrite")
    public String updateFclassWrite(String category, Integer idx, Model model, Integer reviewIdx){
        System.out.println(reviewIdx);
        ReviewDto dto = service.findByIdx(reviewIdx);
        model.addAttribute("reviewDto", dto);
        return "community/rvUpdater";
    }
}
