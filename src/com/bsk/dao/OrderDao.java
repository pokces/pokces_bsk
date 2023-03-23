package com.bsk.dao;

import com.bsk.dto.OrderDto;
import com.bsk.po.Order;

import java.util.List;

public interface OrderDao {
    int addOrder(Order order);
    List<OrderDto> getAllOrder(String addTimeStart,String addTimeEnd,Integer type,Integer orderId);
    void setOrder(Integer id,Integer type);
    void delOrder(Integer id);
}
