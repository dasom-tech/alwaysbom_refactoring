package com.flo.alwaysbom.order.vo;

import lombok.*;

import java.sql.Date;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OsubsVo {
    private Integer idx;
    private Integer oitemIdx;
    private Integer month;
    private Date deliveryDate;
    private String deliveryStatus;
}
