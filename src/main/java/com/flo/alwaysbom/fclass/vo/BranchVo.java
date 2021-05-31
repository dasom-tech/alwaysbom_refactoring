package com.flo.alwaysbom.fclass.vo;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@EqualsAndHashCode
public class BranchVo {
    private Integer idx;
    private String name;
    private String color;
    private String addr;
    private String mapImage;
}
