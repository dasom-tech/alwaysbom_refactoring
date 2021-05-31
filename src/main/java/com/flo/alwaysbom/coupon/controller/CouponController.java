package com.flo.alwaysbom.coupon.controller;

import com.flo.alwaysbom.coupon.service.CouponService;
import com.flo.alwaysbom.coupon.vo.CouponVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class CouponController {

    private final CouponService couponService;

    @GetMapping("/admin/coupon")
    public String goCoupon(Model model) {
        List<CouponVo> list = couponService.findBySearchOption(null);
        model.addAttribute("couponList", list);
        return "coupon/list";
    }

    @GetMapping("/api/coupons")
    @ResponseBody
    public List<CouponVo> getCoupons(CouponVo option) {
        return couponService.findBySearchOption(option);
    }

    @PostMapping("/api/coupons")
    @ResponseBody
    public CouponVo addCoupon(@RequestBody CouponVo couponVo) {
        return couponService.addCoupon(couponVo);
    }

    @RequestMapping(value = "/api/coupons/{idx}", method = RequestMethod.PUT)
    @ResponseBody
    public CouponVo updateCoupon(@RequestBody CouponVo couponVo, @PathVariable Integer idx) {
        return couponService.updateCoupon(couponVo);
    }

    @RequestMapping(value = "/api/coupons/{idx}", method = RequestMethod.DELETE)
    @ResponseBody
    public boolean deleteCoupon(@PathVariable Integer idx) {
        return couponService.deleteCoupon(idx);
    }
}
