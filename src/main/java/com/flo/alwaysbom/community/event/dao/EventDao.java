package com.flo.alwaysbom.community.event.dao;

import com.flo.alwaysbom.community.event.vo.EventVo;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
@RequiredArgsConstructor
public class EventDao {
    private final SqlSessionTemplate sqlSessionTemplate;

    public void addEvent(EventVo vo) {
        sqlSessionTemplate.insert("event.addevent", vo);
    }

    public List<EventVo> eventList() {
        List<EventVo> list = sqlSessionTemplate.selectList("event.eventList");
        for (EventVo vo : list) {
            vo.setStartDate(vo.getStartDate().substring(0,10));
            vo.setEndDate(vo.getEndDate().substring(0,10));
        }
        return list;
    }

    public EventVo eventDetail(Integer idx) {
        EventVo vo = sqlSessionTemplate.selectOne("event.eventDetail", idx);
        return dateCut(vo);

    }

    public void eventDelete(Integer idx) {
        sqlSessionTemplate.delete("event.eventDelete", idx);
    }

    private EventVo dateCut(EventVo vo){
        vo.setStartDate(vo.getStartDate().substring(0,10));
        vo.setEndDate(vo.getEndDate().substring(0,10));
        return vo;
    }


    public void eventUpdate(EventVo vo) {
        sqlSessionTemplate.update("event.eventUpdate", vo);
    }

    public List<EventVo> eventOldList() {
        return sqlSessionTemplate.selectList("event.oldeventList");
    }

}
