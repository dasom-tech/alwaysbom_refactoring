package com.flo.alwaysbom.choice.service;

import com.flo.alwaysbom.cart.vo.CartVo;
import com.flo.alwaysbom.choice.dao.ChoiceDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ChoiceServiceImpl implements ChoiceService {

    private final ChoiceDao choiceDao;

    @Override
    public void addChoices(CartVo cartVo) {
        choiceDao.addChoices(cartVo);
    }
}
