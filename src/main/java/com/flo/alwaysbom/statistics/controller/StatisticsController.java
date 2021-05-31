package com.flo.alwaysbom.statistics.controller;

import com.flo.alwaysbom.statistics.service.StatisticsService;
import com.flo.alwaysbom.statistics.vo.StatisticsVo;
import com.flo.alwaysbom.statistics.vo.SubsByMonthVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class StatisticsController {

    private final StatisticsService statisticsService;

    @GetMapping("/admin/statistics/subs")
    public String goStatisticsSubs() {
        return "statistics/subs";
    }

    @GetMapping("/admin/statistics/sales")
    public String goStatisticsSales() {
        return "statistics/sales";
    }

    @GetMapping("/statistics/api/subsByMonth")
    @ResponseBody
    public List<SubsByMonthVo> getSubsByMonth() {
        System.out.println("StatisticsController.getSubsByMonth");
        return statisticsService.findSubsByMonth();
    }

    @GetMapping("/statistics/api/subsBySize")
    @ResponseBody
    public List<SubsByMonthVo> getSubsBySize() {
        System.out.println("StatisticsController.getSubsBySize");
        return statisticsService.findSubsBySize();
    }

    @GetMapping("/statistics/api/sales")
    @ResponseBody
    public List<StatisticsVo> findStatisticsTable(String type) {
        if("thisMonth".equals(type)) {
            return statisticsService.findStatisticsThisMonth();
        } else {
            return statisticsService.findStatisticsTable();
        }
    }
}
