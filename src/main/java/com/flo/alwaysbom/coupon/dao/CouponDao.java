package com.flo.alwaysbom.coupon.dao;

import com.flo.alwaysbom.coupon.vo.CouponVo;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class CouponDao {

    private final SqlSessionTemplate sessionTemplate;

    public void addCoupon(CouponVo couponVo) {
        sessionTemplate.insert("coupon.addCoupon", couponVo);
    }

    public List<CouponVo> findBySearchOption(CouponVo option) {
        return sessionTemplate.selectList("coupon.findBySearchOption", option);
    }

    public CouponVo findByIdx(Integer idx) {
        return sessionTemplate.selectOne("coupon.findByIdx", idx);
    }

    public void updateCoupon(CouponVo couponVo) {
        sessionTemplate.update("coupon.updateCoupon", couponVo);
    }

    public void updateCouponStatus(CouponVo couponVo) {
        sessionTemplate.update("coupon.updateCouponStatus", couponVo);
    }

    public boolean deleteCoupon(Integer idx) {
        return sessionTemplate.delete("coupon.deleteByIdx", idx) > 0;
    }
}
