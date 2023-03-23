package com.bsk.controller;

import com.bsk.dao.AddressDao;
import com.bsk.dao.impl.AddressDaoImpl;

import com.bsk.dto.CartDto;
import com.bsk.dto.OrderDto;
import com.bsk.po.*;
import com.bsk.service.CartService;
import com.bsk.service.OrderService;
import com.bsk.service.impl.CartServiceImpl;
import com.bsk.service.impl.OrderServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ServletOrder")
public class ServletOrder extends ServletBase {
    AddressDao addressDao=new AddressDaoImpl();
    CartService cartService=new CartServiceImpl();
    OrderService orderService=new OrderServiceImpl();
    public void jumpOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Address add = new Address();
        User loginuser = (User) request.getSession().getAttribute("loginuser");
        add.setUserId(loginuser.getUserId());
        List<Address> address = addressDao.getAddress(add);
        Cart cart = new Cart();
        cart.setUserId(loginuser.getUserId());
        List<CartDto> allcart = cartService.getCart(cart);
        int countprice=0;
        for (CartDto cartDto : allcart) {
            countprice+=cartDto.getProductPrice()*cartDto.getProductNum();
        }
        request.setAttribute("countPrice",countprice);
        request.setAttribute("userAddress",address);
        request.getRequestDispatcher("order_submit.jsp").forward(request,response);
    }
    public void submitOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String address = request.getParameter("address");
        User loginuser = (User) request.getSession().getAttribute("loginuser");
        Order order = new Order();
        order.setAddressDetails(address);
        order.setUserId(loginuser.getUserId());
        ArrayList<OrderDetail> orderDetails=new ArrayList<>();
        Cart cart = new Cart();
        cart.setUserId(loginuser.getUserId());
        List<CartDto> allcart = cartService.getCart(cart);
        for (CartDto cartDto : allcart) {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setProductName(cartDto.getProductName());
            orderDetail.setProductMoney(cartDto.getProductPrice()*cartDto.getProductNum());
            orderDetail.setProductNum(cartDto.getProductNum());
            orderDetails.add(orderDetail);
        }
        orderService.orderSubmit(order,orderDetails);
        cartService.delAll(loginuser.getUserId());
    }
    public void jumpOrderManage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        ArrayList<Object> arr=new ArrayList<>();
        String startTime= request.getParameter("startTime")!=null&&!"".equals(request.getParameter("startTime"))?request.getParameter("startTime"):null;
        String endTime=request.getParameter("endtime")!=null&&!"".equals(request.getParameter("endtime"))?request.getParameter("endtime"):null;
        Integer type=request.getParameter("type")!=null&&!"".equals(request.getParameter("type"))?Integer.parseInt(request.getParameter("type")):null;
        Integer orderId=request.getParameter("orderid")!=null&&!"".equals(request.getParameter("orderid"))?Integer.parseInt(request.getParameter("orderid")):null;
        List<OrderDto> allOrderDto = orderService.getAllOrderDto(startTime,endTime,type,orderId);
        request.setAttribute("allOrderDto",allOrderDto);
        request.getRequestDispatcher("order.jsp").forward(request,response);
    }
    public void changeType(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        Integer orderId= request.getParameter("orderId")!=null&&!"".equals(request.getParameter("orderId"))?Integer.parseInt(request.getParameter("orderId")):null;
        Integer type= request.getParameter("type")!=null&&!"".equals(request.getParameter("type"))?Integer.parseInt(request.getParameter("type")):null;
        orderService.changeType(orderId,type);
    }
    public void delOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        int orderid = Integer.parseInt(request.getParameter("orderid"));
        orderService.delOrder(orderid);
    }
}
