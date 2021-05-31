package com.flo.alwaysbom.fclass.vo;

import lombok.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class FclassVo {
    private Integer idx;
    private String category;
    private String name;
    private String subheader;
    private Integer price;
    private Integer discountRate;
    private String image1;
    private String image2;
    private String image3;
    private String content;
    private Integer count;

    private List<BranchVo> branchList;


    public Integer getFinalPrice(){
        return (int)(price * (1 - discountRate / 100.0));
    }

    public static void main(String[] args) {
//        FclassVo vo = new FclassVo();
//        String[] branchNames = new String[vo.getBranchList().size()];
//
//        for (int i = 0; i < branchList.size(); i++) {
//            branchNames[i] = branchList.get(i).getName();
//        }

        String[] branchNames = {"1호점", "3호점", "월계점", "광화문점", "2호점"};
        System.out.println(Arrays.toString(branchNames));
        Arrays.sort(branchNames);
        System.out.println(Arrays.toString(branchNames));
    }

    public String[] getBranchName() {
        String[] branchNames = new String[branchList.size()];

        for (int i = 0; i < branchList.size(); i++) {
            branchNames[i] = branchList.get(i).getName();
        }
        Arrays.sort(branchNames);
        return branchNames;
    }
}
