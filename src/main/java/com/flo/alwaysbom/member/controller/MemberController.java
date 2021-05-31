package com.flo.alwaysbom.member.controller;

import com.flo.alwaysbom.community.question.vo.QuestionVo;
import com.flo.alwaysbom.coupon.service.CouponService;
import com.flo.alwaysbom.coupon.vo.CouponVo;
import com.flo.alwaysbom.member.service.MemberService;
import com.flo.alwaysbom.member.vo.MemberVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequiredArgsConstructor
@SessionAttributes(value = {"member", "coupons", "couponCount"})
public class MemberController {

    private final MemberService memberService;
    private final CouponService couponService;

    //회원가입하기 누르면 가입 옵션 나오는 페이지
    @GetMapping("/goMemberJoin")
    public String goMemberJoin() {
        return "member/join";
    }

    //회원가입(get)
    @GetMapping("/member_join")
    public String member_join(String kakao_id, String kakao_name, String kakao_gender, Model model) {
        model.addAttribute("kakao_id", kakao_id);
        model.addAttribute("kakao_name", kakao_name);
        model.addAttribute("kakao_gender", kakao_gender);
        return "member/member_join";
    }

    //회원가입 화면 요청(post)
    @PostMapping("/member_join")
    public String member_join(MemberVO memberVO, String joinPassword) {
        //System.out.println("memberVO = " + memberVO);
        if ("tosmfqha1!".equals(joinPassword)) {
            memberService.insertMember(memberVO);
        }
        return "member/login";
    }

    //로그인(get)
    @GetMapping("/login")
    public String memberLogin() {
        return "member/login";
    }

    //아이디 중복 확인
    @GetMapping("/idCheck")
    public @ResponseBody int idCheck(@RequestParam("id")String id) {
        int cnt=memberService.idCheck(id);
        return cnt;
    }

    //로그인(post)
    @PostMapping("/login")
    @ResponseBody
    public boolean loginProc(@RequestParam String id, @RequestParam String pw, Model model, RedirectAttributes rttr) throws Exception {
        //System.out.println("아이디 : " + id + ", 패스워드 : " + pw);

        MemberVO member = new MemberVO();
        member.setId(id);
        member.setPw(pw);
        member = memberService.login(member);

        List<CouponVo> coupons = couponService.findBySearchOption(CouponVo.builder().memberId(id).build());

        int count = 0;
        for (CouponVo coupon : coupons) {
            if (coupon.getStatus() == 0) {
                count++;
            }
        }
        model.addAttribute("coupons", coupons);
        model.addAttribute("couponCount", count);
        //System.out.println("coupons = " + coupons);
        model.addAttribute("member", member);

        return member != null;
    }

    //로그아웃
    @RequestMapping("/logout")
    public String logout(SessionStatus sessionStatus) {
        sessionStatus.setComplete();
        return "redirect:/";
    }

    //아이디 찾기 form
    @RequestMapping(value = "/find_id")
    public String find_id() throws Exception {
        return "member/find_id";
    }

    //아이디 찾기
    @RequestMapping(value = "/found_id", method = RequestMethod.POST)
    public String found_id(HttpServletResponse response, @RequestParam("phone") String phone, Model model) throws Exception{
        model.addAttribute("id", memberService.found_id(response, phone));
        return "/member/found_id";
    }
    // 비밀번호 찾기 form
    @RequestMapping(value = "/find_pw")
    public String find_pw() throws Exception{
        return "/member/find_pw";
    }

    // 비밀번호 찾기
    @RequestMapping(value = "/found_pw", method = RequestMethod.POST)
    public String found_pw(@ModelAttribute MemberVO memberVO, HttpServletResponse response) throws Exception{
        memberService.find_pw(response, memberVO);
        return "/member/found_pw";
    }

    //마이페이지 메인
    @GetMapping("/myPage")
    public String myPage() {
        return "member/myPage";
    }

    //1:1문의
    @GetMapping("/myPage_faq_main")
    public String myPage_faq_main(@SessionAttribute(required = false) MemberVO member, Model model) {
        //회원 로그인 정보 받아오기
        if (member == null) {
            return "member/login";
        }
        System.out.println(member.getId() + "memberid");
        List<QuestionVo> qlist = memberService.myQuestion(member.getId());

        model.addAttribute("quList", qlist);
        System.out.println("qList test = " + qlist);
        return "member/myPage_faq_main";
    }

    //카카오 회원가입
    @GetMapping("/kakao_join")
    public String kakao_join() {
        return "member/kakao_join";
    }

    //회원 등급
    @GetMapping("/member_grade")
    public String member_grade() {
        return "member/member_grade";
    }

    //회원 정보 수정(get)
    @GetMapping("/member_update")
    public String member_update() {
        return "member/member_update";
    }

    //회원정보수정(post)
    @RequestMapping(value="/member_update", method = RequestMethod.POST)
    public String member_update(MemberVO memberVO, HttpSession session) throws Exception{
        memberService.updateMember(memberVO);
        session.invalidate();
        return "redirect:/";
    }

    //상품 후기
    @GetMapping("/mypage_review")
    public String mypage_review() {
        return "member/mypage_review";
    }

    //포인트
    @GetMapping("/member_point")
    public String member_point() {
        return "member/member_point";
    }

    //회원 탈퇴(get)
    @GetMapping("/member_delete")
    public String member_delete() {
        return "member/member_delete";
    }

    //회원 탈퇴(post)
    @RequestMapping(value="/member_delete", method = RequestMethod.POST)
    public String member_delete(MemberVO memberVO, Model model, HttpSession session) throws Exception{
        memberService.deleteMember(memberVO, session);
        model.addAttribute("member", null);
        return "redirect:/";
    }

    //쿠폰 사용
    @PostMapping("/api/useCoupon")
    @ResponseBody
    public CouponVo useCoupon(@RequestBody Integer idx, Model model, @SessionAttribute MemberVO member){
        // 넘겨받은 couponVo 의 idx 를 사용해서 쿠폰 vo 찾기
        CouponVo couponVo = couponService.findByIdx(idx);
        couponVo.setStatus(1);

        // coupon 사용 후 회원의 포인트 증가
        memberService.raisePoint(couponVo);
        // coupon 디비에도 업데이트를 해야되니까 쿠폰 status 업데이트
        couponService.updateCouponStatus(couponVo);

        List<CouponVo> coupons = couponService.findBySearchOption(
                CouponVo.builder()
                        .memberId(couponVo.getMemberId())
                        .build());

        //미사용 쿠폰만 count
        int count = 0;
        for (CouponVo coupon:coupons) {
            if (coupon.getStatus() == 0) {
                count++;
            }
        }
        //System.out.println(count);
        model.addAttribute("coupons", coupons);
        model.addAttribute("couponCount", count);

        member.setPoint(member.getPoint() + couponVo.getPoint());
        model.addAttribute("member", member);

        return couponVo;
    }
    //회원 목록
    @GetMapping("/admin/b_memList")
    public String b_memList(Model model) {
        List<MemberVO> list = memberService.b_memList();
        model.addAttribute("list", list);
        System.out.println(list);
        return "member/b_memList";
    }


}













