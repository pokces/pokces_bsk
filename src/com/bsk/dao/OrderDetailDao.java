package com.bsk.dao;

import com.bsk.po.OrderDetail;

import java.util.List;

public interface OrderDetailDao {
    void addOrderDetail(OrderDetail orderDetail);
    List<OrderDetail> getOrderDetailByOrderID(Integer id);
    void delOrder(Integer id);
}
