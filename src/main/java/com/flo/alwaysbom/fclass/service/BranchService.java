package com.flo.alwaysbom.fclass.service;

import com.flo.alwaysbom.fclass.dao.BranchDao;
import com.flo.alwaysbom.fclass.vo.BranchVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class BranchService {
    private final BranchDao dao;

    public BranchVo addBranch(BranchVo vo){
        return dao.addBranch(vo);
    }
    public int updateBranch(BranchVo vo){
        return dao.updateBranch(vo);
    }
    public int deleteBranch(int idx){
        return dao.deleteBranch(idx);
    }
    public BranchVo findByIdx(int idx){
        return dao.findByIdx(idx);
    }
    public List<BranchVo> findAll(){
        return dao.findAll();
    }

    public List<BranchVo> findBranchByClassIdx(Integer classIdx) {
        return dao.findBranchByClassIdx(classIdx);
    }

}
