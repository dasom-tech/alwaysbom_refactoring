package com.flo.alwaysbom.choice.dao;

import com.flo.alwaysbom.cart.vo.CartVo;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class ChoiceDao {

    private final SqlSessionTemplate sqlSessionTemplate;

    public void addChoices(CartVo cartVo) {
        sqlSessionTemplate.update("choice.addChoice", cartVo);
    }
}
