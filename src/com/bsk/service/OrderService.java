package com.bsk.service;

import com.bsk.dto.OrderDto;
import com.bsk.po.Order;
import com.bsk.po.OrderDetail;

import java.util.ArrayList;
import java.util.List;

public interface OrderService {
    void orderSubmit(Order order, ArrayList<OrderDetail> orderDetails);
    List<OrderDto> getAllOrderDto(String addTimeStart,String addTimeEnd,Integer type,Integer orderId);
    void changeType(Integer id,Integer type);
    void delOrder(Integer id);
}
