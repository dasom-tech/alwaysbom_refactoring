package com.flo.alwaysbom.community.question.dao;

import com.flo.alwaysbom.community.question.vo.QuestionVo;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class QuestionDao {
    private final SqlSessionTemplate sessionTemplate;
    public void addQuestion(QuestionVo vo) {
        sessionTemplate.insert("question.addque", vo);
    }

    public List<QuestionVo> noAnswer() {
        List<QuestionVo> list = sessionTemplate.selectList("question.noAnswer");
        list = dateCut(list);
        return list;
    }
    public List<QuestionVo> answer() {
        List<QuestionVo> list = sessionTemplate.selectList("question.answer");
        list = dateCut(list);
        return list;
    }

    public void updateAnswer(QuestionVo vo) {
        sessionTemplate.update("question.updateAnswer", vo);
    }

    public void deleteAnswer(Integer idx) {
        sessionTemplate.delete("question.deleteAnswer", idx);
    }

    public Integer mailCheckIdx(Integer idx) {
        return sessionTemplate.selectOne("question.mailCheck", idx);
    }

    private List<QuestionVo> dateCut(List<QuestionVo> list) {
        for (QuestionVo vo : list) {
            vo.setQuestionDate(vo.getQuestionDate().substring(0,10));
            if(vo.getAnswerDate() != null){
                vo.setAnswerDate(vo.getAnswerDate().substring(0,10));
            }
        }
        return list;
    }


}
