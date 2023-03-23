package com.bsk.dao;

import com.bsk.po.Product;

import java.util.List;

public interface ProductDao {
    List<Product> getProduct(Product product);
    void addProduct(Product product);
    void delProduct(Integer id);
    void setProduct(Product product);
    List<Product> getProductcondition(Product product,int pageNum,int pageSize);
}
