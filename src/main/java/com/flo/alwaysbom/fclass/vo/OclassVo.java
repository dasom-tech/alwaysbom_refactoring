package com.flo.alwaysbom.fclass.vo;

import lombok.*;

import java.sql.Date;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Builder
public class OclassVo {
    private Integer idx;
    private String memberId; //
    private Integer regCount; //
    private String payType; //
    private String payTotal; //
    private Date payDate;   // -> 결제타입에 따라 다르게 적용 (서비스)
    private Integer discountGrade;  //
    private Integer discountPoint;  //
    private String fclassName;    ////////////////////
    private String branchName;  //
    private String branchAddr;  //
    private String fclassImage; //
    private Date scheduleDate;  //
    private String scheduleStartTime;   //
    private String scheduleEndTime; //
    private Integer fclassCount;    ////////////////////
    private String status; // -> 결제타입에 따라 다르게 적용 (서비스)
    private int reviewCheck;    //mapper에 넣을때 아예 value에 포함하지 말것 (default 0)
    private Integer discountTotalPrice;
    private Integer fclassIdx;
    private Integer scheduleIdx;
    private Date orderDate;
    private Integer reviewIdx;
}
