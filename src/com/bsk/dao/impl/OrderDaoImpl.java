package com.bsk.dao.impl;

import com.bsk.dao.OrderDao;
import com.bsk.dto.OrderDto;
import com.bsk.po.Order;
import com.bsk.util.DataSourceUtil;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;


import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class OrderDaoImpl implements OrderDao {
    private JdbcTemplate jdbcTemplate = new JdbcTemplate(DataSourceUtil.getDataSource());
    @Override
    public int addOrder(Order order) {
        String orderSql="INSERT into t_order(user_id,address_details,update_time,order_type) VALUES(?,?,?,?)";
        String orderIDSql="SELECT MAX(order_id) FROM t_order";
        Connection connection = null;
        int id=0;
        Object[] orderObject={order.getUserId(),order.getAddressDetails()};
        try {
            connection= DataSourceUtil.getDataSource().getConnection();
            PreparedStatement pre1 = connection.prepareStatement(orderSql);
            PreparedStatement pre2 = connection.prepareStatement(orderIDSql);
            pre1.setInt(1,order.getUserId());
            pre1.setString(2,order.getAddressDetails());
            pre1.setString(3, LocalDateTime.now().toString());
            pre1.setInt(4,0);

            connection.setAutoCommit(false);
            pre1.executeUpdate();
            ResultSet resultSet = pre2.executeQuery();
            connection.setAutoCommit(true);
            while (resultSet.next()){
                id=resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("事务失败！开始回滚");
            try {
                connection.rollback();
                System.out.println("事务失败！回滚完毕");
            } catch (SQLException ex) {
                System.out.println("回滚失败");
            }
        }
        return id;
    }

    @Override
    public List<OrderDto> getAllOrder(String addTimeStart,String addTimeEnd,Integer type,Integer orderId) {
        String sql="SELECT * FROM t_order where ";
        ArrayList<Object> arr=new ArrayList<>();
        if(addTimeStart!=null){
            sql+="add_time>= ? and ";
            arr.add(addTimeStart);
        }
        if(addTimeEnd!=null){
            sql+="add_time<= ? and ";
            arr.add(addTimeEnd);
        }
        if(type!=null){
            sql+="order_type=? and ";
            arr.add(type);
        }
        if(orderId!=null){
            sql+="order_id=? and ";
            arr.add(orderId);
        }
        sql=sql.substring(0,sql.length()-4);
        return jdbcTemplate.query(sql,arr.toArray(),new BeanPropertyRowMapper<>(OrderDto.class));
    }

    @Override
    public void setOrder(Integer id,Integer type) {
        String sql="UPDATE t_order SET order_type=? where order_id=?";
        Object[] o={type,id};
        jdbcTemplate.update(sql,o);
    }

    @Override
    public void delOrder(Integer id) {
        String sql=" DELETE FROM t_order WHERE order_id=?";
        Object[] o={id};
        jdbcTemplate.update(sql,o);
    }
}
