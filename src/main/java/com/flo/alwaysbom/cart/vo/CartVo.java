package com.flo.alwaysbom.cart.vo;

import com.flo.alwaysbom.choice.vo.ChoiceVo;
import com.flo.alwaysbom.flower.vo.FlowerVo;
import com.flo.alwaysbom.order.vo.OsubsVo;
import com.flo.alwaysbom.product.vo.ProductVo;
import com.flo.alwaysbom.subs.vo.SubsVo;
import lombok.*;
import org.apache.ibatis.jdbc.Null;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class CartVo {
    private Integer idx;
    private String memberId;
    private String category;
    private Integer subsIdx;
    private Integer flowerIdx;
    private Integer productIdx;
    private int quantity;
    private Integer subsMonth;
    private Date subsStartDate;
    private int letter;
    private Date requestDate;

    // 관련 데이터
    private SubsVo subsVo;
    private FlowerVo flowerVo;
    private ProductVo productVo;
    private List<ChoiceVo> choices;


    //비즈니스 로직
    public String getName() {
        String name = "";
        try {
            if ("정기구독".equals(category)) {
                name = subsVo.getName();
            } else if ("꽃다발".equals(category)) {
                name = flowerVo.getName();
            } else if ("소품샵".equals(category)) {
                name = productVo.getName();
            }
        } catch (NullPointerException e) {
            System.out.println("Item Each Price : 상품 카테고리에 해당하는 vo가 존재하지 않습니다");
        }
        return name;
    }

    public String getImage() {
        String image = "";
        try {
            if ("정기구독".equals(category)) {
                image = subsVo.getImage1();
            } else if ("꽃다발".equals(category)) {
                image = flowerVo.getImage1();
            } else if ("소품샵".equals(category)) {
                image = productVo.getImage1();
            }
        } catch (NullPointerException e) {
            System.out.println("Item Each Price : 상품 카테고리에 해당하는 vo가 존재하지 않습니다");
        }
        return image;
    }

    public List<OsubsVo> getOsubsList() {
        List<OsubsVo> list = new ArrayList<>();
        try {
            if ("정기구독".equals(category)) {
                if (subsMonth != null) {
                    for (int i = 0; i < (subsMonth * 2); i++) {
                        list.add(OsubsVo.builder()
                                .month(subsMonth)
                                .deliveryDate(new Date(subsStartDate.getTime() + 1000L * 60 * 60 * 24 * 14 * i))
                                .deliveryStatus("배송전")
                                .build());
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public String getOptions() {
        StringBuilder builder = new StringBuilder();
        for (ChoiceVo choice : choices) {
            builder.append(choice.getProductVo().getName())
                    .append(" : ")
                    .append(choice.getQuantity())
                    .append("개, ");
        }
        if (builder.length() > 0) {
            builder.substring(0, builder.length() - 2);
        }
        return builder.toString();
    }

    public int getItemOriginalPrice() {
        int eachPrice = 0;
        try {
            if ("정기구독".equals(category)) {
                eachPrice = subsVo.getPrice();
            } else if ("꽃다발".equals(category)) {
                eachPrice = flowerVo.getPrice();
            } else if ("소품샵".equals(category)) {
                eachPrice = productVo.getPrice();
            }
        } catch (NullPointerException e) {
            System.out.println("Item Each Price : 상품 카테고리에 해당하는 vo가 존재하지 않습니다");
        }
        return eachPrice;
    }

    public int getItemFinalPrice() {
        int eachPrice = 0;
        try {
            if ("정기구독".equals(category)) {
                eachPrice = subsVo.getFinalPrice();
            } else if ("꽃다발".equals(category)) {
                eachPrice = flowerVo.getFinalPrice();
            } else if ("소품샵".equals(category)) {
                eachPrice = productVo.getFinalPrice();
            }
        } catch (NullPointerException e) {
            System.out.println("Item Final Price : 상품 카테고리에 해당하는 vo가 존재하지 않습니다");
        }

        return eachPrice;
    }

    public int getTotalPrice() {
        int eachPrice = getItemFinalPrice();

        int totalPrice = eachPrice * quantity;

        try {
            if (choices != null) {
                totalPrice += choices
                        .stream()
                        .mapToInt(choice -> choice.getProductVo().getFinalPrice() * choice.getQuantity())
                        .sum();
            }
        } catch (NullPointerException e) {
            System.out.println("choice 해당 상품 vo가 존재하지 않습니다");
        }

        if (letter > 0) {
            totalPrice += 2500;
        }
        return totalPrice;
    }

    public String getFsize() {
        String fsize = "";
        try {
            if ("정기구독".equals(category)) {
                fsize = subsVo.getFsize();
            } else if ("꽃다발".equals(category)) {
                fsize = flowerVo.getFsize();
            } else if ("소품샵".equals(category)) {
                fsize = productVo.getFsize();
            }
        } catch (NullPointerException e) {
            System.out.println("Item Final Price : 상품 카테고리에 해당하는 vo가 존재하지 않습니다");
        }
        return fsize;
    }

    public Integer getItemIdx() {
        int itemIdx = 0;
        try {
            if ("정기구독".equals(category)) {
                itemIdx = subsVo.getIdx();
            } else if ("꽃다발".equals(category)) {
                itemIdx = flowerVo.getIdx();
            } else if ("소품샵".equals(category)) {
                itemIdx = productVo.getIdx();
            }
        } catch (NullPointerException e) {
            System.out.println("Item Final Price : 상품 카테고리에 해당하는 vo가 존재하지 않습니다");
        }
        return itemIdx;
    }
}
