package com.flo.alwaysbom.member.vo;

import lombok.*;

import java.sql.Date;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MemberVO{

    private String id;
    private String pw;
    private String name;
    private Date birth;
    private String gender;
    private String phone;
    private int point;
    private String grade;

}
