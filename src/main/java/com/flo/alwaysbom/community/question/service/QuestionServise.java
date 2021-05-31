package com.flo.alwaysbom.community.question.service;

import com.flo.alwaysbom.community.question.dao.QuestionDao;
import com.flo.alwaysbom.community.question.vo.QuestionVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class QuestionServise {
    private final QuestionDao dao;

    public void addQuestion(QuestionVo vo) {
        dao.addQuestion(vo);
    }

    public List<QuestionVo> noAnswer() {
        return dao.noAnswer();
    }

    public List<QuestionVo> answer() {
        return dao.answer();
    }

    public void updateAnswer(QuestionVo vo) {
        dao.updateAnswer(vo);
    }

    public void deleteAnswer(Integer idx) {
        dao.deleteAnswer(idx);
    }

    public Integer mailCheckIdx(Integer idx) {
        return dao.mailCheckIdx(idx);
    }
}
