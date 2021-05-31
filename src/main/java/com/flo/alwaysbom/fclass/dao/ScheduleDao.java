package com.flo.alwaysbom.fclass.dao;

import com.flo.alwaysbom.fclass.vo.ScheduleVo;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class ScheduleDao {
    private final SqlSessionTemplate sqlSessionTemplate;

    public ScheduleVo addSchedule(ScheduleVo vo) {
        sqlSessionTemplate.insert("schedule.addSchedule", vo);
        return vo;
    }

    public List<ScheduleVo> searchSchedule(ScheduleVo vo) {
        return sqlSessionTemplate.selectList("schedule.searchSchedule", vo);
    }

    public boolean deleteSchedule(List<Integer> idx) {
        return sqlSessionTemplate.delete("schedule.deleteSchedule", idx) > 0;
    }

    public ScheduleVo updateSchedule(ScheduleVo vo) {
        sqlSessionTemplate.update("schedule.updateSchedule", vo);
        return vo;
    }

    public ScheduleVo findByIdx(Integer scheduleIdx) {
        return sqlSessionTemplate.selectOne("schedule.findByIdx", scheduleIdx);
    }

    public void updateRegCount(ScheduleVo svo) {
        sqlSessionTemplate.update("schedule.updateRegCount", svo);
    }
}
