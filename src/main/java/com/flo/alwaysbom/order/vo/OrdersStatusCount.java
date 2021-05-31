package com.flo.alwaysbom.order.vo;

import lombok.*;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class OrdersStatusCount {
    private Integer wait;
    private Integer cancel;
    private Integer cancelComplete;
    private Integer orderComplete;
    private Integer delivery;
    private Integer deliveryComplete;

}
