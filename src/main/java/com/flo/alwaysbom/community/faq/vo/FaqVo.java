package com.flo.alwaysbom.community.faq.vo;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class FaqVo {
    private Integer idx;
    private String category;
    private String question;
    private String answer;
}
