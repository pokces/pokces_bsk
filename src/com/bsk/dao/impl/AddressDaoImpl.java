package com.bsk.dao.impl;

import com.bsk.dao.AddressDao;
import com.bsk.po.Address;
import com.bsk.po.User;
import com.bsk.util.DataSourceUtil;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.ArrayList;
import java.util.List;

public class AddressDaoImpl implements AddressDao {
    private JdbcTemplate jdbcTemplate = new JdbcTemplate(DataSourceUtil.getDataSource());

    @Override
    public List<Address> getAddress(Address address) {
        String sql = "select * from t_address where ";
        ArrayList<Object> arr = new ArrayList<>();
        if (address.getAddressId() != null) {
            sql += "address_id=? and ";
            arr.add(address.getAddressId());
        }else{
            sql+="address_id is not null and ";
        }
        if (address.getAddressProvince() != null) {
            sql += "address_province=? and ";
            arr.add(address.getAddressProvince());
        }
        if (address.getAddressCity() != null) {
            sql += "address_city=? and ";
            arr.add(address.getAddressCity());
        }
        if (address.getAddressDistrict() != null) {
            sql += "address_district=? and ";
            arr.add(address.getAddressDistrict());
        }
        if (address.getAddressDescribe() != null) {
            sql += "address_describe=? and ";
            arr.add(address.getAddressDescribe());
        }
        if (address.getUserId() != null) {
            sql += "user_id=? and ";
            arr.add(address.getUserId());
        }
        sql=sql.substring(0,sql.length()-5);
        List<Address> userList=new ArrayList<>();
        try {
                userList = jdbcTemplate.query(sql, arr.toArray(), new BeanPropertyRowMapper<>(Address.class));
        } catch (Exception e) {
        }
        return userList;
    }
    @Override
    public void setAddress(Address address) {
        String sql="UPDATE t_address SET";
        ArrayList<Object> o=new ArrayList<>();
        if(address.getAddressProvince()!=null){
            sql+=" address_province=?,";
            o.add(address.getAddressProvince());
        }
        if(address.getAddressCity()!=null){
            sql+=" address_city=?,";
            o.add(address.getAddressCity());
        }
        if(address.getAddressDistrict()!=null){
            sql+=" address_district=?,";
            o.add(address.getAddressDistrict());
        }
        if(address.getAddressDescribe()!=null){
            sql+=" address_describe=?,";
            o.add(address.getAddressDescribe());
        }
        if(address.getUserId()!=null){
            sql+=" user_id=?,";
            o.add(address.getUserId());
        }
        sql=sql.substring(0,sql.length()-1);
        sql+=" where address_id=? ";
        o.add(address.getAddressId());
        jdbcTemplate.update(sql,o.toArray());
    }
    public void delAddress(Integer id){
        String sql="DELETE FROM t_address WHERE address_id=?";
        Object[] o={id};
        jdbcTemplate.update(sql,o);
    }

    @Override
    public void addAddress(Address address) {
        String sql = "INSERT into t_address(address_province,address_city,address_district,address_describe,user_id) VALUES(?,?,?,?,?)";
        Object[] o = {address.getAddressProvince(),address.getAddressCity(),address.getAddressDistrict(),address.getAddressDescribe(),address.getUserId()};
        jdbcTemplate.update(sql, o);
    }

    @Override
    public void setAddressForUser(Address address) {
        String sql="UPDATE t_address SET";
        ArrayList<Object> o=new ArrayList<>();
        if(address.getAddressProvince()!=null){
            sql+=" address_province=?,";
            o.add(address.getAddressProvince());
        }
        if(address.getAddressCity()!=null){
            sql+=" address_city=?,";
            o.add(address.getAddressCity());
        }
        if(address.getAddressDistrict()!=null){
            sql+=" address_district=?,";
            o.add(address.getAddressDistrict());
        }
        if(address.getAddressDescribe()!=null){
            sql+=" address_describe=?,";
            o.add(address.getAddressDescribe());
        }
        sql=sql.substring(0,sql.length()-1);
        sql+=" where user_id=? ";
        o.add(address.getUserId());
        jdbcTemplate.update(sql,o.toArray());
    }

}
