package com.flo.alwaysbom.order.vo;

import lombok.*;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class DeliveryInfoVo {
    private Integer idx;
    private String memberId;
    private String receiverName;
    private String receiverPhone;
    private String receiverZipcode;
    private String receiverAddrBase;
    private String receiverAddrDetail;
    private String receiverAddrExtra;
}
