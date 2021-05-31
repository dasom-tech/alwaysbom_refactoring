package com.flo.alwaysbom.community.event.vo;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class EventVo {
    private Integer idx;
    private String thumb;
    private String name;
    private String image1;
    private String image2;
    private String content;
    private String startDate;
    private String endDate;
}
