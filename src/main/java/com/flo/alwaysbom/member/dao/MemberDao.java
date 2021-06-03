package com.flo.alwaysbom.member.dao;

import com.flo.alwaysbom.community.question.vo.QuestionVo;
import com.flo.alwaysbom.coupon.vo.CouponVo;
import com.flo.alwaysbom.member.vo.MemberVo;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class MemberDao {

    private final SqlSessionTemplate sessionTemplate;

    //회원 가입
    public void insertMember(MemberVo memberVo) {
        sessionTemplate.insert("member.insertMember",memberVo);
    }
    // 로그인 검사
    public MemberVo login(String id) throws Exception{
        return sessionTemplate.selectOne("member.login", id);
    }

    //로그인
    public MemberVo login(MemberVo memberVo) throws Exception {
        return sessionTemplate.selectOne("member.Login", memberVo);
    }

    //로그아웃
    public void logout(HttpSession session){
    }

    // 아이디 중복 확인
    public int idCheck(String id) {
        int cnt=sessionTemplate.selectOne("member.idCheck", id);
        return cnt;
    }

    //회원 정보 수정
    public void updateMember(MemberVo memberVo) throws Exception {
        sessionTemplate.update("member.updateMember", memberVo);
    }

    //회원 탈퇴
    public void deleteMember(MemberVo memberVo, HttpSession session) throws Exception {
        sessionTemplate.update("member.deleteMember", memberVo);
        session.invalidate();
    }

    //아이디 찾기
    public String found_id(String phone)throws Exception {
        return sessionTemplate.selectOne("member.found_id", phone);
    }

    // 비밀번호 변경
    @Transactional
    public int update_pw(MemberVo memberVo) throws Exception{
        return sessionTemplate.update("member.update_pw", memberVo);
    }

    //쿠폰 사용 후 포인트 증가
    public void raisePoint(CouponVo couponVO) {
        sessionTemplate.update("member.raisePoint", couponVO);
    }

    //1:1문의 리스트
    public List<QuestionVo> myQuestion(String id) {
        return sessionTemplate.selectList("member.myQuestion", id);
    }
    
    //회원 목록
    public List<MemberVo> b_memList() {
        return sessionTemplate.selectList("member.b_memList");
    }


}












