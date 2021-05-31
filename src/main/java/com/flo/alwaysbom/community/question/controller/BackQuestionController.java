package com.flo.alwaysbom.community.question.controller;

import com.flo.alwaysbom.community.question.service.QuestionServise;
import com.flo.alwaysbom.community.question.vo.QuestionVo;
import com.flo.alwaysbom.member.vo.MemberVO;
import com.flo.alwaysbom.util.MailSend;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class BackQuestionController {
    private final QuestionServise servise;
    private final MailSend mail;

//    MailSend mail = new MailSend();
    // 여기부터는 로그인 회원 정보 받기
    @GetMapping("/admin/community/question")
    public String question(Model model, String answer){
        List<QuestionVo> list = null;
        if(answer != null && answer.equals("answer")){
            list = servise.answer();
            model.addAttribute("questlist",list);
            return "community/b_question";
        }
        list = servise.noAnswer();
        model.addAttribute("questlist",list);
        return "community/b_question";
    }

//    @PostMapping("/admin/question/api/writeQuest")
//    @ResponseBody
//    public Boolean addQuestion(QuestionVo vo, MultipartFile file) throws IOException {
//        vo.setImage(fileHandler.uploadFile(file, null, "community/question"));
////        if(vo.getEmailSend() == null || vo.getEmailSend().equals("null")){
////            vo.setEmailSend(0);
////        }
//        servise.addQuestion(vo);
//        System.out.println(vo);
//        return true;
//    }

    // 1:1문의 관리자 답변
    @PostMapping("/admin/question/api/addAnswer")
    @ResponseBody
    public boolean addAnswer(@SessionAttribute(required = false) MemberVO member, QuestionVo vo){


        servise.updateAnswer(vo);
        Integer mailCheck = servise.mailCheckIdx(vo.getIdx());
        System.out.println(mailCheck);
        if(mailCheck == 1){
            mail.sendMail(member.getId(), "<h3>안녕하세요</h3>\n <h4>안녕하세요 새늘봄입니다 :) \n 문의하신 내용에 답변을 하였습니다.</h4>\n <h4>꽃같은 하루 되시길 바랍니다.</h4> \n",
                    "안녕하세요 새늘봄입니다 :) 문의하신 내용에 답변을 하였습니다.");
        }
        return true;
    }

    // 1:1문의 관리자 삭제
    @GetMapping("/admin/question/api/deleteAnswer")
    public String deleteAnswer(Integer idx){
        servise.deleteAnswer(idx);
        return "redirect:/admin/community/question";
    }
}
