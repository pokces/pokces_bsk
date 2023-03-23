package com.bsk.dao.impl;

import com.bsk.dao.OrderDetailDao;
import com.bsk.po.OrderDetail;
import com.bsk.util.DataSourceUtil;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

public class OrderDetailImpl implements OrderDetailDao {
    private JdbcTemplate jdbcTemplate = new JdbcTemplate(DataSourceUtil.getDataSource());
    @Override
    public void addOrderDetail(OrderDetail orderDetail) {
        String orderDetailsql="INSERT into t_order_details(product_name,product_num,product_money,order_id) VALUES(?,?,?,?)";
        Object[] orderDetailObject={orderDetail.getProductName(),orderDetail.getProductNum(),orderDetail.getProductMoney(),orderDetail.getOrderId()};
        jdbcTemplate.update(orderDetailsql,orderDetailObject);
    }

    @Override
    public List<OrderDetail> getOrderDetailByOrderID(Integer id) {
        String sql="SELECT * FROM t_order_details WHERE order_id=?";
        Object[] o={id};
        return jdbcTemplate.query(sql, o, new BeanPropertyRowMapper<>(OrderDetail.class));
    }

    @Override
    public void delOrder(Integer id) {
        String sql=" DELETE FROM t_order_details WHERE order_id=?";
        Object[] o={id};
        jdbcTemplate.update(sql,o);
    }
}
