package com.flo.alwaysbom.coupon.service;

import com.flo.alwaysbom.coupon.dao.CouponDao;
import com.flo.alwaysbom.coupon.vo.CouponVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CouponService {

    private final CouponDao couponDao;

    public CouponVo addCoupon(CouponVo couponVo) {
        couponDao.addCoupon(couponVo);
        return couponDao.findByIdx(couponVo.getIdx());
    }

    public List<CouponVo> findBySearchOption(CouponVo option) {
        return couponDao.findBySearchOption(option);
    }

    public CouponVo findByIdx(Integer idx) {
        return couponDao.findByIdx(idx);
    }

    public CouponVo updateCoupon(CouponVo couponVo) {
        couponDao.updateCoupon(couponVo);
        return couponDao.findByIdx(couponVo.getIdx());
    }

    public boolean deleteCoupon(Integer idx) {
        return couponDao.deleteCoupon(idx);
    }

    public CouponVo updateCouponStatus(CouponVo couponVo) {
        couponDao.updateCouponStatus(couponVo);
        return couponDao.findByIdx(couponVo.getIdx());
    }
}
