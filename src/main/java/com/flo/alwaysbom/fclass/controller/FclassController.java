package com.flo.alwaysbom.fclass.controller;

import com.flo.alwaysbom.community.review.dto.ReviewDto;
import com.flo.alwaysbom.community.review.service.ReviewService;
import com.flo.alwaysbom.community.review.vo.ReviewLikeVo;
import com.flo.alwaysbom.fclass.service.BranchService;
import com.flo.alwaysbom.fclass.service.FclassService;
import com.flo.alwaysbom.fclass.service.OclassService;
import com.flo.alwaysbom.fclass.service.ScheduleService;
import com.flo.alwaysbom.fclass.vo.*;
import com.flo.alwaysbom.member.vo.MemberVO;
import com.flo.alwaysbom.util.FileHandler;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class FclassController {

    private final FclassService fclassService;
    private final BranchService branchService;
    private final ScheduleService scheduleService;
    private final FileHandler fileHandler;
    private final OclassService oclassService;
    private final ReviewService reviewService;

    @GetMapping("/fclass/testPage")
    public String testPage() {
        return "fclass/testPage";
    }


    @GetMapping("/fclass/orders")
    public String goMyClassList(@SessionAttribute(required = false) MemberVO member, Model model) {
/*
        OclassSearchOptionDto searchOption = new OclassSearchOptionDto();
        //searchOption.setMemberId(member != null ? member.getId() : "minho1030@naver.com");

        List<OclassVo> orders = oclassService.findBySearchOption(searchOption);
        model.addAttribute("orders", orders);
*/
        return "fclass/myClassList";
    }

    @GetMapping("/api/fclass/orders")
    public String getOrders(@SessionAttribute(required = false) MemberVO member, Model model, OclassSearchOptionDto searchOption) {
        searchOption.setMemberId(member != null ? member.getId() : "minho1030@naver.com");
        List<OclassVo> orders = oclassService.findBySearchOption(searchOption);
        model.addAttribute("orders", orders);
        return "fclass/myClassListContent";
    }



    @GetMapping("/fclass/classList")
    public String goList(Model model) {
        List<FclassVo> classList = fclassService.findAll();
        List<BranchVo> branchList = branchService.findAll();
        model.addAttribute("classList", classList);
        model.addAttribute("branchList", branchList);
        return "fclass/classList";
    }

    @GetMapping("/fclass/classList/{idx}")
    public String classDetail(@PathVariable("idx") Integer idx,
                              @SessionAttribute(required = false) MemberVO member, Model model) {
        FclassVo fclassVo = fclassService.findByIdx(idx);
        List<BranchVo> branchList = fclassVo.getBranchList();
        //전체리뷰 값 가져오기
//        List<ReviewDto> thisReview = reviewService.thisReview("클래스", "allList", idx);
        FclassReviewDto reviewDto = fclassService.findReviewsByOption(idx, 1, 5);

                //베스트리뷰 값 가져오기
        List<ReviewDto> bestReview = reviewService.allReview("클래스", "best", idx);

        List<OclassVo> oclassList;
        if (member != null) {
            oclassList = oclassService.findReviewable(OclassVo.builder()
                    .memberId(member.getId())
                    .fclassIdx(idx)
                    .build());
        } else {
            oclassList = new ArrayList<>();
        }

        model.addAttribute("fclassVo", fclassVo);
        model.addAttribute("branchList", branchList);
        //리뷰 불러오기
        model.addAttribute("reviewDto", reviewDto);
        model.addAttribute("bestReview", bestReview);
        //리뷰작성 자격있는 클래스리스트
        model.addAttribute("reviewableList", oclassList);
        //allReviewCount = 해당 클래스의 전체리뷰 갯수
        int allReviewCount = reviewService.oldCateListCnt("클래스");
        model.addAttribute("allReviewCount", allReviewCount);
        //게시글 좋아요 갯수
        List<ReviewLikeVo> likeList = reviewService.likeList();
        model.addAttribute("likeList", likeList);



        return "fclass/flowerClassDetail";
    }

    @GetMapping("/fclass/payment")
    public String goPayment(@SessionAttribute(required = false) MemberVO member, Integer scheduleIdx, Integer regCount, Model model) {
        // member는 아마도.. 세션에서 꺼내올거야
        // 지금은 임시로 객체를 여기서 생성한다
 /*       MemberVO memberVO = new MemberVO();
        memberVO.setId("dlagksk64@naver.com");
        memberVO.setPoint(2000);
        memberVO.setGrade("자스민");
        memberVO.setName("임하나");*/
        //////////////////////////////////////////

        ScheduleVo scheduleVo = scheduleService.findByIdx(scheduleIdx);
        BranchVo branchVo = branchService.findByIdx(scheduleVo.getBranchIdx());
        FclassVo fclassVo = fclassService.findByIdx(scheduleVo.getFclassIdx());

        model.addAttribute("scheduleVo", scheduleVo);
        model.addAttribute("branchVo", branchVo);
        model.addAttribute("fclassVo", fclassVo);
        model.addAttribute("regCount", regCount);
        model.addAttribute("memberVo", member);

        return "/fclass/payment";
    }

    @PostMapping ("/fclass/completePayment")
    public String completePayment(@SessionAttribute(required = false) MemberVO member, Integer scheduleIdx, OclassVo ovo, Model model) {
        // @RequestParam("pay-type") String payType, Integer payTotal, String payDate, Integer discountGrade, Integer discountPoint, Model model
        ScheduleVo svo = scheduleService.findByIdx(scheduleIdx);
        FclassVo fvo = fclassService.findByIdx(svo.getFclassIdx());
        BranchVo bvo = branchService.findByIdx(svo.getBranchIdx());

        ovo.setFclassName(fvo.getName());
        ovo.setBranchName(bvo.getName());
        ovo.setBranchAddr(bvo.getAddr());
        ovo.setFclassImage(fvo.getImage1());
        ovo.setScheduleDate(svo.getSdate());
        ovo.setScheduleStartTime(svo.getStartTime());
        ovo.setScheduleEndTime(svo.getEndTime());
        ovo.setFclassCount(fvo.getCount());
        if (ovo.getPayType().equals("무통장입금")) {
            ovo.setStatus("입금대기");
        } else {
            ovo.setStatus("결제완료");
        }
        ovo.setFclassIdx(fvo.getIdx());
        ovo.setScheduleIdx(svo.getIdx());

        if(svo.getTotalCount() < svo.getRegCount() + ovo.getRegCount() ) {
            throw new IllegalStateException("등록 인원수가 큽니다");
        }
/*        if (!ovo.getPayType().equals("무통장입금")) {
            svo.setRegCount(svo.getRegCount() + ovo.getRegCount());
        }*/

        oclassService.addOclass(ovo, svo);
        scheduleService.updateSchedule(svo);

        model.addAttribute("order", ovo);

        /*MemberVO member = new MemberVO();
        member.setName("임하나");*/
        model.addAttribute("member", member);

        return "/fclass/completePayment";
    }

    @GetMapping("/api/fclass/schedules/{idx}")
    @ResponseBody
    public ScheduleVo getSchedule(@PathVariable Integer idx) {
        return scheduleService.findByIdx(idx);
    }

    @GetMapping("/fclass/api/branches/{idx}")
    @ResponseBody
    public BranchVo findBranches(@PathVariable Integer idx) {
        return branchService.findByIdx(idx);
    }

    @GetMapping("/fclass/api/classList/{idx}/reviews")
    @ResponseBody
    public FclassReviewDto getReviewsByOption(@PathVariable Integer idx, Integer startIndex, Integer endIndex) {
        return fclassService.findReviewsByOption(idx, startIndex, endIndex);
    }

    @PostMapping(value = "/fclass/api/classList/{idx}/reviews", produces = {"application/json;charset=utf-8"})
    @ResponseBody
    public ReviewDto addReview(@ModelAttribute FclassReviewForm newReview, @PathVariable Integer idx,
                               @SessionAttribute MemberVO member) throws IOException {

        ReviewDto reviewDto = null;
        try {
            newReview.setMemberId(member.getId());
            newReview.setFclassIdx(idx);
            newReview.setImage(fileHandler.uploadFile(newReview.getImageFile(), null, "/fclass/reviews"));

            reviewDto = oclassService.addReview(newReview);
            return reviewDto;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @PostMapping("/fclass/api/searchSchedule")
    @ResponseBody
    public List<ScheduleVo> searchSchedule(@RequestBody ScheduleVo vo) {
        return scheduleService.searchSchedule(vo);
    }
}
