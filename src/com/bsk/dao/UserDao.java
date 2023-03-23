package com.bsk.dao;

import com.bsk.po.User;

import java.util.List;

public interface UserDao {

    List<User> selectUserList(User user);

    List<User> getUser(User user,int pageNum,int pageSize);

    void addUser(User user);

    void setUser(User user);

    List<User> getUserTimeTel(String start,String end,String tel,int pageNum,int pageSize);

}
