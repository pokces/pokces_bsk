package com.bsk.dao.impl;

import com.bsk.dao.ProductDao;
import com.bsk.po.Product;
import com.bsk.util.DataSourceUtil;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ProductDaoImpl implements ProductDao {
    private JdbcTemplate jdbcTemplate = new JdbcTemplate(DataSourceUtil.getDataSource());

    @Override
    public List<Product> getProduct(Product product) {
        String sql = "select * from t_product where ";
        ArrayList<Object> arr=new ArrayList<>();
        if(product.getProductId()!=null){
            sql+=" product_id=? and";
            arr.add(product.getProductId());
        }else{
            sql+=" product_id is not null and";
        }
        if(product.getProductName()!=null){
            sql+=" product_name=? and";
            arr.add(product.getProductName());
        }
        if(product.getProductPic()!=null){
            sql+=" product_pic=? and";
            arr.add(product.getProductPic());
        }
        if(product.getProductPrice()!=null){
            sql+=" product_price=? and";
            arr.add(product.getProductPrice());
        }
        if(product.getProductDescribe()!=null){
            sql+=" product_describe=? and";
            arr.add(product.getProductDescribe());
        }
        if(product.getCategoryId()!=null){
            sql+=" category_id=? and";
            arr.add(product.getCategoryId());
        }
        if(product.getProductStatus()!=null){
            sql+=" product_status=? and";
            arr.add(product.getProductStatus());
        }
        sql=sql.substring(0,sql.length()-4);
        List<Product> products=new ArrayList<>();
        try {
            products = jdbcTemplate.query(sql, arr.toArray(), new BeanPropertyRowMapper<>(Product.class));
        } catch (Exception e) {
        }
        return products;
    }

    @Override
    public void addProduct(Product product) {
        String sql = "INSERT into t_product(product_pic,product_name,product_price,product_describe,category_id) VALUES(?,?,?,?,?)";
        Object[] o={product.getProductPic(),product.getProductName(),product.getProductPrice(),product.getProductDescribe(),product.getCategoryId()};
        jdbcTemplate.update(sql,o);
    }

    @Override
    public void delProduct(Integer id) {
        String sql="DELETE FROM t_product WHERE product_id=?";
        Object[] o={id};
        jdbcTemplate.update(sql,o);
    }

    @Override
    public void setProduct(Product product) {
        String sql="UPDATE t_product SET";
        ArrayList<Object> o=new ArrayList<>();
        if(product.getProductName()!=null){
            sql+=" product_name=?,";
            o.add(product.getProductName());
        }
        if(product.getProductPic()!=null){
            sql+=" product_pic=?,";
            o.add(product.getProductPic());
        }
        if(product.getProductPrice()!=null){
            sql+=" product_price=?,";
            o.add(product.getProductPrice());
        }
        if(product.getProductDescribe()!=null){
            sql+=" product_describe=?,";
            o.add(product.getProductDescribe());
        }
        if(product.getCategoryId()!=null){
            sql+=" category_id=?,";
            o.add(product.getCategoryId());
        }
        if(product.getProductStatus()!=null){
            sql+=" product_status=?,";
            o.add(product.getProductStatus());
        }
        sql=sql.substring(0,sql.length()-1);
        sql+=" where product_id=? ";
        o.add(product.getProductId());
        jdbcTemplate.update(sql,o.toArray());
    }

    @Override
    public List<Product> getProductcondition(Product product, int pageNum, int pageSize) {
        String sql = "select * from t_product where ";
        ArrayList<Object> arr=new ArrayList<>();
        if(product.getProductName()!=null){
            product.setProductName("%"+product.getProductName()+"%");
            sql+=" product_name like ? and";
            arr.add(product.getProductName());
        }else{
            sql+=" product_name is not null and";
        }
        if(product.getCategoryId()!=null){
            sql+=" category_id=? and";
            arr.add(product.getCategoryId());
        }
        sql=sql.substring(0,sql.length()-4);
        if(pageNum>0&&pageSize>0){
            sql+=" limit "+(pageNum-1)*pageSize+","+pageSize;
        }
        List<Product> products=new ArrayList<>();
        try {
            products = jdbcTemplate.query(sql, arr.toArray(), new BeanPropertyRowMapper<>(Product.class));
        } catch (Exception e) {
        }
        return products;
    }
}
