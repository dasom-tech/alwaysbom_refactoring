package com.flo.alwaysbom.statistics.dao;

import com.flo.alwaysbom.statistics.vo.StatisticsVo;
import com.flo.alwaysbom.statistics.vo.SubsByMonthVo;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class StatisticsDao {

    private final SqlSessionTemplate sessionTemplate;

    public List<SubsByMonthVo> findSubsByMonth() {
        return sessionTemplate.selectList("statistics.findSubsByMonth");
    }

    public List<SubsByMonthVo> findSubsBySize() {
        return sessionTemplate.selectList("statistics.findSubsBySize");
    }

    public List<StatisticsVo> findStatisticsTable() {
        return sessionTemplate.selectList("statistics.findStatisticsTable");
    }

    public List<StatisticsVo> findStatisticsThisMonth() {
        return sessionTemplate.selectList("statistics.findStatisticsThisMonth");
    }
}
