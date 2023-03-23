package com.bsk.dao;

import com.bsk.dto.CartDto;
import com.bsk.po.Cart;

import java.util.List;

public interface CartDao {
    List<CartDto> getCarts(Cart cart);
    Cart getCart(Cart cart);
    void setCart(Cart cart);
    void delCart(Cart cart);
    void addCart(Cart cart);
    Cart getCartById(Cart cart);
    void setCartNum(Cart cart);
    void delCartById(Cart cart);
}
