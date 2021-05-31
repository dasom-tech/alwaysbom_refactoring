package com.flo.alwaysbom.community.faq.service;

import com.flo.alwaysbom.community.faq.dao.FaqDao;
import com.flo.alwaysbom.community.faq.vo.FaqVo;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class FaqService {
    private final FaqDao faqDao;


    public List<String> faqCategory() {
        return faqDao.faqCategoryStrings();
    }

    public List<FaqVo> faqlist(FaqVo vo) {
        return faqDao.faqList(vo);
    }

    public void faqDelete(Integer idx) {
        faqDao.faqDelete(idx);
    }

    public void faqFaqDelete(FaqVo vo) {
        faqDao.daqUpdate(vo);
    }

    public void faqInsert(FaqVo vo) {
        faqDao.faqInsert(vo);
    }

    public FaqVo faqSelectOne(Integer idx) {
        return faqDao.faqSelectOne(idx);
    }

    public void faqUpdate(FaqVo vo) {
        faqDao.faqUpdate(vo);
    }
}
