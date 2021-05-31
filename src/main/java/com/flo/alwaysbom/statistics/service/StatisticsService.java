package com.flo.alwaysbom.statistics.service;

import com.flo.alwaysbom.statistics.dao.StatisticsDao;
import com.flo.alwaysbom.statistics.vo.StatisticsVo;
import com.flo.alwaysbom.statistics.vo.SubsByMonthVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class StatisticsService {

    private final StatisticsDao statisticsDao;

    public List<SubsByMonthVo> findSubsByMonth() {
        return statisticsDao.findSubsByMonth();
    }

    public List<SubsByMonthVo> findSubsBySize() {
        return statisticsDao.findSubsBySize();
    }

    public List<StatisticsVo> findStatisticsTable() {
        return statisticsDao.findStatisticsTable();
    }

    public List<StatisticsVo> findStatisticsThisMonth() {
        return statisticsDao.findStatisticsThisMonth();
    }
}
