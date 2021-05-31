package com.flo.alwaysbom.community.question.controller;

import com.flo.alwaysbom.community.question.service.QuestionServise;
import com.flo.alwaysbom.community.question.vo.QuestionVo;
import com.flo.alwaysbom.member.vo.MemberVO;
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

@Controller
@RequiredArgsConstructor
public class MyquestionController {
    private final FileHandler fileHandler;
    private final QuestionServise servise;
    // 여기부터는 로그인 회원 정보 받기
    @GetMapping("/question/create")
    public String question(@SessionAttribute(required = false) MemberVO member, Model model){
        if (member == null) {
            // 없을 때 임시
            return "member/login";
        }
        model.addAttribute("memberId", member.getId());
        return "community/myquestion";
    }

    @PostMapping("/admin/question/api/writeQuest")
    @ResponseBody
    public Boolean addQuestion(@SessionAttribute(required = false) MemberVO member, QuestionVo vo, MultipartFile file) throws IOException {
        if(vo.getEmailSend() == null){
            vo.setEmailSend(0);
        }

        vo.setImage(fileHandler.uploadFile(file, null, "community/question"));
//        if(vo.getEmailSend() == null || vo.getEmailSend().equals("null")){
//            vo.setEmailSend(0);
//        }
        vo.setMemberId(member.getId());
        servise.addQuestion(vo);
        System.out.println(vo);
        return true;
    }

}
