package com.flo.alwaysbom.fclass.service;

import com.flo.alwaysbom.fclass.dao.ScheduleDao;
import com.flo.alwaysbom.fclass.vo.ScheduleVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ScheduleService {
    private final ScheduleDao scheduleDao;

    public ScheduleVo addSchedule(ScheduleVo vo) {
        return scheduleDao.addSchedule(vo);
    }

    public List<ScheduleVo> searchSchedule(ScheduleVo vo) {
        return scheduleDao.searchSchedule(vo);
    }

    public boolean deleteSchedule(List<Integer> idx) {
        if (idx == null || idx.size() == 0) {
            throw new IllegalArgumentException("idx 배열이 비어있습니다");
        }
        return scheduleDao.deleteSchedule(idx);
    }

    public ScheduleVo updateSchedule(ScheduleVo vo) {
        return scheduleDao.updateSchedule(vo);
    }

    public ScheduleVo findByIdx(Integer scheduleIdx) {
        return scheduleDao.findByIdx(scheduleIdx);
    }
}
