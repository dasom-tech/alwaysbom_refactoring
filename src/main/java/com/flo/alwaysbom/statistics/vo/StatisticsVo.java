package com.flo.alwaysbom.statistics.vo;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class StatisticsVo {
    private String period;
    private Integer salesCount;
    private Integer subsAmount;
    private Integer flowerAmount;
    private Integer productAmount;
    private Integer classAmount;
    private Integer totalAmount;
}
