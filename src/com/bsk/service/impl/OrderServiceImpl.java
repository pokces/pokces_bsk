package com.bsk.service.impl;

import com.bsk.dao.OrderDao;
import com.bsk.dao.OrderDetailDao;
import com.bsk.dao.UserDao;
import com.bsk.dao.impl.OrderDaoImpl;
import com.bsk.dao.impl.OrderDetailImpl;
import com.bsk.dao.impl.UserDaoImpl;
import com.bsk.dto.OrderDto;
import com.bsk.po.Order;
import com.bsk.po.OrderDetail;
import com.bsk.po.User;
import com.bsk.service.OrderService;

import java.util.ArrayList;
import java.util.List;

public class OrderServiceImpl implements OrderService {
    OrderDao orderDao=new OrderDaoImpl();
    OrderDetailDao orderDetailDao=new OrderDetailImpl();
    UserDao userDao=new UserDaoImpl();
    @Override
    public void orderSubmit(Order order, ArrayList<OrderDetail> orderDetails) {
        int i = orderDao.addOrder(order);
        for (OrderDetail orderDetail : orderDetails) {
            orderDetail.setOrderId(i);
            orderDetailDao.addOrderDetail(orderDetail);
        }
    }
    public List<OrderDto> getAllOrderDto(String addTimeStart,String addTimeEnd,Integer type,Integer orderId){
        ArrayList<OrderDto> allOrder = (ArrayList<OrderDto>) orderDao.getAllOrder(addTimeStart,addTimeEnd,type,orderId);
        for (OrderDto orderDto : allOrder) {
            orderDto.setOrderDetail((ArrayList<OrderDetail>) orderDetailDao.getOrderDetailByOrderID(orderDto.getOrderId()));
            User user = new User();
            user.setUserId(orderDto.getUserId());
            orderDto.setUserName(userDao.getUser(user,0,0).get(0).getUserName());
        }
        return allOrder;
    }

    @Override
    public void changeType(Integer id, Integer type) {
        orderDao.setOrder(id,type);
    }

    @Override
    public void delOrder(Integer id) {
        orderDao.delOrder(id);
        orderDetailDao.delOrder(id);
    }
}
