package com.bsk.dto;

import com.bsk.po.Order;
import com.bsk.po.OrderDetail;

import java.util.ArrayList;

public class OrderDto extends Order {
    private ArrayList<OrderDetail> orderDetail;
    private String userName;

    public OrderDto() {
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public ArrayList<OrderDetail> getOrderDetail() {
        return orderDetail;
    }
    public void setOrderDetail(ArrayList<OrderDetail> orderDetail) {
        this.orderDetail = orderDetail;
    }
}
