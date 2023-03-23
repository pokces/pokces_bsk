package com.bsk.service;

import com.bsk.dto.CartDto;
import com.bsk.po.Cart;

import java.util.List;

public interface CartService {
    List<CartDto> getCart(Cart cart);
    void addCart(Cart cart);
    void changeNum(Cart cart,Integer num);
    void delAll(Integer id);
    void delCart(Integer id);
}
