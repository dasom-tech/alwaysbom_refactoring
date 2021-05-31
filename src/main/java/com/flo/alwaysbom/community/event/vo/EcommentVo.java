package com.flo.alwaysbom.community.event.vo;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class EcommentVo {
    private Integer idx;
    private String memberId;
    private String image;
    private String content;
    private String regDate;
    private Integer report;
    private Integer eventIdx;
}
