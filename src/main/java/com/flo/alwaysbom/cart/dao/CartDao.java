package com.flo.alwaysbom.cart.dao;

import com.flo.alwaysbom.cart.vo.CartVo;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@Repository
@RequiredArgsConstructor
public class CartDao {

    private final SqlSessionTemplate sqlSessionTemplate;

    public List<CartVo> findByIdxArray(Integer[] idx) {
        return sqlSessionTemplate.selectList("cart.findByIdxArray", idx);
    }

    public Integer addCart(CartVo cartVo) {
        sqlSessionTemplate.insert("cart.insertCart", cartVo);
        return cartVo.getIdx();
    }

    public List<CartVo> findCartsByMember(String memberId) {
        return sqlSessionTemplate.selectList("cart.findCartsByMember", memberId);
    }

    public Optional<CartVo> findByIdx(Integer idx) {
        return Optional.ofNullable(sqlSessionTemplate.selectOne("cart.findByIdx", idx));
    }

    public boolean updateQuantity(CartVo cartItem) {
        return sqlSessionTemplate.update("cart.updateQuantity", cartItem) > 0;
    }

    public boolean removeByIdx(Integer idx) {
        return sqlSessionTemplate.delete("cart.removeByIdx", idx) > 0;
    }

    public int removeByIdxes(List<Integer> idxes) {
        return sqlSessionTemplate.delete("cart.removeByIdxes", idxes);
    }
}
