package com.flo.alwaysbom.community.event.service;

import com.flo.alwaysbom.community.event.dao.EcommentDao;
import com.flo.alwaysbom.community.event.vo.EcommentVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class EcommentService {
    private final EcommentDao ecommentDao;


    public List<EcommentVo> ecoList(Integer idx) {
        return ecommentDao.ecoList(idx);
    }

    public void addEcomment(EcommentVo vo) {
        ecommentDao.addEcomment(vo);
    }

    public EcommentVo findByIdx(EcommentVo vo) {
        return ecommentDao.findByIdx(vo);
    }


    public void ecommentUpdate(EcommentVo vo) {
        ecommentDao.ecommentUpdate(vo);
    }

    public void ecommentDelete(Integer idx) {
        ecommentDao.ecommentDelete(idx);
    }

    public void ecommentReport(Integer idx){
        ecommentDao.ecommentReport(idx);
    }

}
