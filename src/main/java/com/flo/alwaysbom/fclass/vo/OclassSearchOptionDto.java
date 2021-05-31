package com.flo.alwaysbom.fclass.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class OclassSearchOptionDto {
    private String memberId;
    private String status;
    private String className;
    private String branchName;
}
