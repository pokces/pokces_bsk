package com.bsk.dao;

import com.bsk.po.Category;

import java.util.List;

public interface CategoryDao {
    List<Category> getCategory(Category category);
    void setCategory(Category category);
    void delCategory(Integer id);
    void addCategory(Category category);
}
