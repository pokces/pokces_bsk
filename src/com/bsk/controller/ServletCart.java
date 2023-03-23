package com.bsk.controller;

import com.bsk.dto.CartDto;
import com.bsk.po.Address;
import com.bsk.po.Cart;
import com.bsk.po.User;
import com.bsk.service.impl.CartServiceImpl;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.Base64;
import java.util.List;
import java.util.Map;

@WebServlet("/ServletCart")
public class ServletCart extends ServletBase {
    CartServiceImpl cartService= new CartServiceImpl();
    public void addCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cart cart = fullElement(request);
        cartService.addCart(cart);
        response.getWriter().write("Y");
    }
    public void getCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cart cart = new Cart();
        User loginuser = (User) request.getSession().getAttribute("loginuser");
        cart.setUserId(loginuser.getUserId());
        List<CartDto> carts = cartService.getCart(cart);
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.writeValue(response.getWriter(),carts);
    }
    public void changeNum(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cart cart = fullElement(request);
        int num = Integer.parseInt(request.getParameter("num"));
        cartService.changeNum(cart,num);
    }
    public void removeAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loginuser = (User) request.getSession().getAttribute("loginuser");
        cartService.delAll(loginuser.getUserId());
    }
    public void delcart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        int cartid = Integer.parseInt(request.getParameter("cartId"));

        cartService.delCart(cartid);
    }
    private Cart fullElement(HttpServletRequest request) {
        Map<String, String[]> parameterMap = request.getParameterMap();
        Cart cart = new Cart();
        try {
            BeanUtils.populate(cart, parameterMap);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
        return cart;
    }
}
