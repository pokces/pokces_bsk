package com.bsk.dao.impl;

import com.bsk.dao.CategoryDao;
import com.bsk.po.Category;
import com.bsk.util.DataSourceUtil;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.ArrayList;
import java.util.List;

public class CategoryDaoImpl implements CategoryDao {
    private JdbcTemplate jdbcTemplate = new JdbcTemplate(DataSourceUtil.getDataSource());
    @Override
    public List<Category> getCategory(Category category) {
        String sql = "select * from t_category where ";
        ArrayList<Object> arr = new ArrayList<>();
        if (category.getCategoryId()!=null){
            sql+="category_id=? and ";
            arr.add(category.getCategoryId());
        }else {
            sql+="category_id is not null and ";
        }
        if(category.getCategoryName()!=null){
            sql+="category_name=? and ";
            arr.add(category.getCategoryName());

        }
        sql=sql.substring(0,sql.length()-4);
        List<Category> categoryList=new ArrayList<>();
        try {
            categoryList = jdbcTemplate.query(sql, arr.toArray(), new BeanPropertyRowMapper<>(Category.class));
        }catch (Exception e){
        }
       return categoryList;

    }

    @Override
    public void setCategory(Category category) {
        String sql="UPDATE t_category SET ";
        ArrayList<Object> arr=new ArrayList<>();
        if(category.getCategoryName()!=null){
            sql+=" category_name=? and ";
            arr.add(category.getCategoryName());
        }
        sql=sql.substring(0,sql.length()-4);
        sql+="where category_id=?";
        arr.add(category.getCategoryId());
        jdbcTemplate.update(sql,arr.toArray());
    }

    @Override
    public void delCategory(Integer id) {
        String sql="DELETE FROM t_category WHERE category_id=?";
        Object[] o={id};
        jdbcTemplate.update(sql,o);
    }

    @Override
    public void addCategory(Category category) {
        String sql = "INSERT into t_category(category_name) VALUES(?)";
        Object[] o={category.getCategoryName()};
        jdbcTemplate.update(sql,o);
    }

}
