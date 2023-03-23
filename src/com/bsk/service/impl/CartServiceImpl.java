package com.bsk.service.impl;

import com.bsk.dao.CartDao;
import com.bsk.dao.impl.CartDaoImpl;
import com.bsk.dto.CartDto;
import com.bsk.po.Cart;
import com.bsk.service.CartService;

import java.util.List;

public class CartServiceImpl implements CartService {
   CartDao cartDao=new CartDaoImpl();

    @Override
    public List<CartDto> getCart(Cart cart) {
        return cartDao.getCarts(cart);
    }

    @Override
    public void addCart(Cart cart) {
        Cart c = cartDao.getCart(cart);
        if(c==null){
            cartDao.addCart(cart);
        }else{
            cartDao.setCart(cart);
        }
    }

    @Override
    public void changeNum(Cart cart,Integer num) {
        Cart cartById = cartDao.getCartById(cart);
        cartById.setProductNum(cartById.getProductNum()+num);

        cartDao.setCartNum(cartById);
    }

    @Override
    public void delAll(Integer id) {
        Cart cart = new Cart();
        cart.setUserId(id);
        cartDao.delCart(cart);
    }

    @Override
    public void delCart(Integer id) {
            Cart cart = new Cart();
            cart.setCartId(id);
            cartDao.delCartById(cart);
    }
}
