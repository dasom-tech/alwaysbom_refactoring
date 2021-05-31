package com.flo.alwaysbom.order.vo;

import lombok.*;

import java.util.List;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OrdersVo {
    private Integer idx;
    private String memberId;
    private String odate;
    private String receiverName;
    private String receiverPhone;
    private String receiverZipcode;
    private String receiverAddrBase;
    private String receiverAddrDetail;
    private String receiverAddrExtra;
    private String senderName;
    private String payType;
    private Integer payTotal;
    private Integer payDelivery;
    private String payDate;
    private Integer discountGrade;
    private Integer discountPoint;
    private String status;

    //비즈니스 로직 관련 데이터..
    private boolean saveAddress;
    private List<OitemVo> olist;

    //무통장입금
    private String mootongName;



    //카드결제
    
}
