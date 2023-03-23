package com.bsk.dao.impl;

import com.bsk.dao.CartDao;
import com.bsk.dto.CartDto;
import com.bsk.po.Cart;
import com.bsk.util.DataSourceUtil;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.Arrays;
import java.util.List;

public class CartDaoImpl implements CartDao {
    private JdbcTemplate jdbcTemplate = new JdbcTemplate(DataSourceUtil.getDataSource());
    @Override
    public List<CartDto> getCarts(Cart cart) {
        String sql="select c.cart_id,c.product_id,c.product_num,c.user_id,p.product_name,p.product_price,p.product_pic from t_cart c JOIN t_product p on c.product_id = p.product_id WHERE c.user_id=?";
        try {
            return  jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(CartDto.class), cart.getUserId());
        }catch (Exception e){
            return null;
        }
    }

    @Override
    public Cart getCart(Cart cart) {
        String sql = "select * from t_cart where product_id=? and user_id = ?";
        try {
            return jdbcTemplate.queryForObject(sql,new BeanPropertyRowMapper<>(Cart.class),cart.getProductId(),cart.getUserId());
        }catch (Exception e){
            return null;
        }
    }

    @Override
    public void setCart(Cart cart) {
        String sql = "update t_cart set product_num = product_num + ? where product_id=? and user_id = ?";
        jdbcTemplate.update(sql,cart.getProductNum(),cart.getProductId(),cart.getUserId());
    }

    @Override
    public void delCart(Cart cart) {
        String sql="DELETE FROM t_cart WHERE user_id=?";
        jdbcTemplate.update(sql,cart.getUserId());
    }

    @Override
    public void addCart(Cart cart) {
        String sql="insert into t_cart(product_id,product_num,user_id) values(?,?,?)";
        Object[] o={cart.getProductId(),cart.getProductNum(),cart.getUserId()};
        jdbcTemplate.update(sql,o);
    }

    @Override
    public Cart getCartById(Cart cart) {
        String sql = "select * from t_cart where cart_id=?";
        try {
            return jdbcTemplate.queryForObject(sql,new BeanPropertyRowMapper<>(Cart.class),cart.getCartId());
        }catch (Exception e){
            return null;
        }
    }

    @Override
    public void setCartNum(Cart cart) {
        String sql = "update t_cart set product_num =  ? where product_id=? and user_id = ?";
        jdbcTemplate.update(sql,cart.getProductNum(),cart.getProductId(),cart.getUserId());
    }

    @Override
    public void delCartById(Cart cart) {
        String sql="DELETE FROM t_cart WHERE cart_id=?";
        jdbcTemplate.update(sql,cart.getCartId());
    }
}
