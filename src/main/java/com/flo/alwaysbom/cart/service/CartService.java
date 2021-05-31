package com.flo.alwaysbom.cart.service;

import com.flo.alwaysbom.cart.vo.CartVo;

import java.util.List;
import java.util.Optional;

public interface CartService {

    List<CartVo> findByIdxArray(Integer[] idx);

    Integer addCart(CartVo cartVo);

    List<CartVo> findCartsByMember(String memberId);

    Optional<CartVo> findById(Integer idx);

    CartVo updateQuantity(CartVo cartItem);

    boolean removeByIdx(Integer idx);

    List<CartVo> removeByIdxes(List<Integer> idxes);
}
