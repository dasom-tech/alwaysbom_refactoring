package com.flo.alwaysbom.cart.controller;

import com.flo.alwaysbom.cart.service.CartService;
import com.flo.alwaysbom.cart.vo.CartVo;
import com.flo.alwaysbom.order.vo.OitemVo;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequiredArgsConstructor
public class CartApi {

    private final CartService cartService;

    @GetMapping("/api/cart/list")
    public List<CartVo> findByIdxArray(Integer[] idx) {
        return cartService.findByIdxArray(idx);
    }

    @GetMapping("/api/cart/convertOitemList")
    public List<OitemVo> getOitemList(Integer[] idx) {
        List<CartVo> cartList = cartService.findByIdxArray(idx);
        return cartList.stream().map(cartVo -> OitemVo.builder()
                .hasLetter(cartVo.getLetter() > 0)
                .name(cartVo.getName())
                .price(cartVo.getTotalPrice())
                .options(cartVo.getOptions())
                .image(cartVo.getImage())
                .requestDate(cartVo.getRequestDate())
                .category(cartVo.getCategory())
                .quantity(cartVo.getQuantity())
                .reviewCheck(0)
                .osubsList(cartVo.getOsubsList())
                .cartIdx(cartVo.getIdx())
                .fsize(cartVo.getFsize())
                .itemIdx(cartVo.getItemIdx())
                .build()).collect(Collectors.toList());
    }

    @PostMapping(value = "/api/carts")
    public CartVo addCart(@RequestBody CartVo cartVo) {
        cartService.addCart(cartVo);
        return cartService.findById(cartVo.getIdx()).orElse(null);
    }

    @RequestMapping(value = "/api/carts", method = RequestMethod.DELETE)
    public List<CartVo> deleteCarts(@RequestBody List<Integer> idxes) {
        System.out.println("idxes = " + idxes);
        return cartService.removeByIdxes(idxes);
    }

    @PostMapping("/api/cart/updateQuantity")
    public CartVo updateQuantity(@RequestBody CartVo cartItem) {
        return cartService.updateQuantity(cartItem);
    }

    @PostMapping("/api/cart/removeByIdx")
    public boolean removeByIdx(@RequestBody Integer idx) {
        return cartService.removeByIdx(idx);
    }
}
