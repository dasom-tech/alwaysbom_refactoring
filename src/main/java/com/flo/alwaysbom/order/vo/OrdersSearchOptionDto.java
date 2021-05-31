package com.flo.alwaysbom.order.vo;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class OrdersSearchOptionDto {
    private String memberId;
    private String status;
}
