package com.flo.alwaysbom.fclass.vo;

import lombok.*;

import java.sql.Date;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Builder
public class ScheduleVo {
    private int idx;
    private int branchIdx;
    private int fclassIdx;
    private Date sdate;
    private Integer smonth;
    private Integer sday;
    private String startTime;
    private String endTime;
    private int totalCount;
    private int regCount;

    public Integer getSmonth() {
        if (sdate != null) {
            return sdate.toLocalDate().getMonth().getValue();
        } else {
            return null;
        }
    }

    public Integer getSday() {
        if (sdate != null) {
            return sdate.toLocalDate().getDayOfMonth();
        } else {
            return null;
        }
    }
}
