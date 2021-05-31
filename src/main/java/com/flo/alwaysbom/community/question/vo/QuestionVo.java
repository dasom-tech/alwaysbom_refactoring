package com.flo.alwaysbom.community.question.vo;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class QuestionVo {
    private Integer idx;
    private String name;
    private String content;
    private String image;
    private String memberId;
    private Integer emailSend;
    private String answer;
    private String questionDate;
    private String answerDate;
    private String answerTitle;
}
