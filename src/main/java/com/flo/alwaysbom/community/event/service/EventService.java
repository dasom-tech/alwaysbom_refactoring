package com.flo.alwaysbom.community.event.service;


import com.flo.alwaysbom.community.event.dao.EventDao;
import com.flo.alwaysbom.community.event.vo.EventVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class EventService {
    private final EventDao eventDao;


    public void addEvent(EventVo vo) {
        eventDao.addEvent(vo);
    }

    public List<EventVo> eventList() {
        return eventDao.eventList();
    }

    public EventVo eventDetail(Integer idx) {
        return eventDao.eventDetail(idx);
    }

    public EventVo eventDelete(Integer idx) {
        EventVo vo = eventDao.eventDetail(idx);
        eventDao.eventDelete(idx);
        return vo;
    }

    public void eventUpdate(EventVo vo) {
        eventDao.eventUpdate(vo);
    }

    public List<EventVo> eventOldList() {
        return eventDao.eventOldList();
    }
}
