package com.flo.alwaysbom.cart.service;

import com.flo.alwaysbom.cart.dao.CartDao;
import com.flo.alwaysbom.cart.vo.CartVo;
import com.flo.alwaysbom.choice.service.ChoiceService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class CartServiceImpl implements CartService {

    private final ChoiceService choiceService;
    private final CartDao cartDao;

    @Override
    public List<CartVo> findByIdxArray(Integer[] idx) {
        return cartDao.findByIdxArray(idx);
    }

    @Override
    public Integer addCart(CartVo cartVo) {
        cartDao.addCart(cartVo);
        if (cartVo.getChoices() != null && cartVo.getChoices().size() > 0) {
            choiceService.addChoices(cartVo);
        }
        return cartVo.getIdx();
    }

    @Override
    public List<CartVo> findCartsByMember(String memberId) {
        return cartDao.findCartsByMember(memberId);
    }

    @Override
    public Optional<CartVo> findById(Integer idx) {
        return cartDao.findByIdx(idx);
    }

    @Override
    public CartVo updateQuantity(CartVo cartItem) {
        if (cartDao.updateQuantity(cartItem)) {
            return cartDao.findByIdx(cartItem.getIdx())
                    .orElseThrow(() -> new IllegalStateException("Cart 조회에 실패했습니다. idx를 확인해주세요"));
        } else {
            throw new IllegalStateException("Cart 수량 업데이트에 실패했습니다.");
        }
    }

    @Override
    public boolean removeByIdx(Integer idx) {
        return cartDao.removeByIdx(idx);
    }

    @Override
    public List<CartVo> removeByIdxes(List<Integer> idxes) {
        List<CartVo> targetList = cartDao.findByIdxArray(idxes.toArray(new Integer[0]));
        int i = cartDao.removeByIdxes(idxes);
        System.out.println(i + "건의 행이 삭제되었습니다");
        return targetList;
    }
}
