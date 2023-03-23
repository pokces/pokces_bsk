package com.bsk.dao.impl;

import java.util.ArrayList;
import java.util.List;

import com.bsk.dao.UserDao;
import com.bsk.po.User;
import com.bsk.util.DataSourceUtil;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;


public class UserDaoImpl implements UserDao {
    private JdbcTemplate jdbcTemplate = new JdbcTemplate(DataSourceUtil.getDataSource());

    @Override
    public List<User> selectUserList(User user) {

        return jdbcTemplate.query("select * from t_user", new BeanPropertyRowMapper<User>(User.class));
    }

    @Override
    public List<User> getUser(User user,int pageNum,int pageSize) {
        String sql = "select * from t_user where ";
        ArrayList<Object> arr = new ArrayList<>();
        if (user.getUserId() != null) {
            sql += "user_id=? and ";
            arr.add(user.getUserId());
        }else{
            sql+="user_id is not null and ";
        }
        if (user.getUserTel() != null) {
            sql += "user_tel=? and ";
            arr.add(user.getUserTel());
        }
        if (user.getUserPwd() != null) {
            sql += "user_pwd=? and ";
            arr.add(user.getUserPwd());
        }
        if (user.getUserName() != null) {
            sql += "user_name=? and ";
            arr.add(user.getUserName());
        }
        if (user.getUserSex() != null) {
            sql += "user_sex=? and ";
            arr.add(user.getUserSex());
        }
        if (user.getAddTime() != null) {
            sql += "add_time=? and ";
            arr.add(user.getAddTime());
        }
        if (user.getUserStatus() != null) {
            sql += "user_status=? and ";
            arr.add(user.getUserStatus());
        }
        if (user.getUserRole() != null) {
            sql += "user_role=? and ";
            arr.add(user.getUserRole());
        }
        sql=sql.substring(0,sql.length()-4);
        if(pageNum>0&&pageNum>0){
            sql+=" limit "+(pageNum-1)*pageSize+","+pageSize;
        }
        List<User> userList=new ArrayList<>();
        try {
            userList = jdbcTemplate.query(sql, arr.toArray(), new BeanPropertyRowMapper<User>(User.class));
        } catch (Exception e) {
        }
        return userList;
    }

    @Override
    public void addUser(User user) {
        String sql = "INSERT into t_user(user_tel,user_pwd,user_name,user_sex) VALUES(?,?,?,?)";
        Object[] o = {user.getUserTel(), user.getUserPwd(), user.getUserName(), user.getUserSex()};
        jdbcTemplate.update(sql, o);
    }

    @Override
    public void setUser(User user) {
        String sql="UPDATE t_user SET";
    ArrayList<Object> o=new ArrayList<>();
        if(user.getUserName()!=null){
        sql+=" user_name=?,";
        o.add(user.getUserName());
    }
        if(user.getUserTel()!=null){
        sql+=" user_tel=?,";
        o.add(user.getUserTel());
    }
        if(user.getUserPwd()!=null){
        sql+=" user_pwd=?,";
        o.add(user.getUserPwd());
    }
        if(user.getUserSex()!=null){
        sql+=" user_sex=?,";
        o.add(user.getUserSex());
    }
//        if(user.getAddTime()!=null){
//        sql+=" add_time=?,";
//        o.add(user.getAddTime());
//    }
        if(user.getUserStatus()!=null){
        sql+=" user_status=?,";
        o.add(user.getUserStatus());
    }
        if(user.getUserRole()!=null){
        sql+=" user_role=?,";
        o.add(user.getUserRole());
    }
    sql=sql.substring(0,sql.length()-1);
    sql+=" where user_id=? ";
    o.add(user.getUserId());
    jdbcTemplate.update(sql,o.toArray());
}

    @Override
    public List<User> getUserTimeTel(String start, String end, String tel,int pageNum,int pageSize) {
        String sql = "select * from t_user where ";
        ArrayList<Object> arr = new ArrayList<>();
        if(start!=null){
            sql+="add_time > ? and ";
            arr.add(start);
        }else{
            sql+="add_time is not null and ";
        }
        if(end!=null){
            sql+="add_time < ? and ";
            arr.add(end);
        }
        if(tel!=null){
            sql+="user_tel = ? and ";
            arr.add(tel);
        }
        sql+="user_role = ? and ";
        arr.add("U");
        sql=sql.substring(0,sql.length()-4);
        if(pageNum>0&&pageNum>0){
            sql+=" limit "+(pageNum-1)*pageSize+","+pageSize;
        }
        List<User> userList=new ArrayList<>();
        try {
            userList = jdbcTemplate.query(sql, arr.toArray(), new BeanPropertyRowMapper<User>(User.class));
        } catch (Exception e) {
        }
        return userList;
    }

}
