package com.flo.alwaysbom.coupon.vo;

import lombok.*;

import java.sql.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@EqualsAndHashCode
public class CouponVo {

    private Integer idx;
    private String name;
    private String memberId;
    private Integer status;
    private Integer point;
    private Date cdate;
}
