package com.bsk.controller;

import com.bsk.dao.impl.UserDaoImpl;
import com.bsk.po.User;
import com.bsk.util.CodeImgUtil;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.Base64;
import java.util.List;
import java.util.Map;

@WebServlet("/ServletUser")
public class ServletUser extends ServletBase {
    private UserDaoImpl userDao = new UserDaoImpl();

    private User fullElement(HttpServletRequest request) {
        Map<String, String[]> parameterMap = request.getParameterMap();
        User user = new User();
        try {
            BeanUtils.populate(user, parameterMap);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
        return user;
    }

    public void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = fullElement(request);
        String base64encodedString = Base64.getEncoder().encodeToString(user.getUserPwd().getBytes("utf-8"));
        user.setUserPwd(base64encodedString);
        List<User> users = userDao.getUser(user, 0, 0);
        int usernum = users.size();
        if(usernum!=0){
            user=users.get(0);
        }else{
            user=null;
        }
        if (user == null) {
            response.getWriter().write("账户或者密码错误");
        }else if(user.getUserStatus().equals("N")){
            response.getWriter().write("账户已停用");
        } else {
            request.getSession().setAttribute("loginuser", user);
            response.getWriter().write("Y");
        }

    }

    public void regist(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = fullElement(request);
        String base64encodedString = Base64.getEncoder().encodeToString(user.getUserPwd().getBytes("utf-8"));
        user.setUserPwd(base64encodedString);
        System.out.println(user);
        User u = new User();
        u.setUserTel(user.getUserTel());
        if (userDao.getUser(u, 0, 0).size()==0) {
            userDao.addUser(user);
            user = userDao.getUser(user, 0, 0).get(0);
            request.getSession().setAttribute("loginuser", user);
            response.getWriter().write("Y");
        } else {
            response.getWriter().write("电话号码已经存在");
        }

    }

    public void setUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = fullElement(request);
        userDao.setUser(user);
        User log = (User) request.getSession().getAttribute("loginuser");
        User u = new User();
        u.setUserId(log.getUserId());
        u = userDao.getUser(u, 0, 0).get(0);
        request.getSession().setAttribute("loginuser", u);

    }

    public void loginout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getSession().removeAttribute("loginuser");
        response.sendRedirect("main.jsp");
    }

    public void updatePass(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String imgcode = request.getParameter("imgcode");//获取用户输入的验证码
        String oldpass = request.getParameter("oldPass");//获取用户输入的"原密码"
        String newpwd = request.getParameter("userPwd");//获取用户输入的新密码
        String code = (String) request.getSession().getAttribute("code");//正确的验证码
        User loginuser = (User) request.getSession().getAttribute("loginuser");//获取登录用户
        oldpass = Base64.getEncoder().encodeToString(oldpass.getBytes("utf-8"));
        newpwd = Base64.getEncoder().encodeToString(newpwd.getBytes("utf-8"));
        if (!code.equals(imgcode)) {//判断验证码是否正确
            response.getWriter().write("e1");
        } else if (!oldpass.equals(loginuser.getUserPwd())) {//判断用户输入的原密码是否是当前登录用户的旧密码
            response.getWriter().write("e2");
        } else if (loginuser.getUserPwd().equals(newpwd)) {//判断新密码是否与旧密码重复
            response.getWriter().write("e3");
        } else {
            User user = fullElement(request);
            String base64encodedString = Base64.getEncoder().encodeToString(user.getUserPwd().getBytes("utf-8"));
            user.setUserPwd(base64encodedString);
            userDao.setUser(user);
            request.getSession().removeAttribute("loginuser");
            response.sendRedirect("main.jsp");
        }
    }

    public void CodeImg(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        String code = CodeImgUtil.drawImage(out);
        System.out.println(code);
        request.getSession().setAttribute("code", code);
        ServletOutputStream outputStream = response.getOutputStream();
        out.writeTo(outputStream);

    }

    public void jumpUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int page = 1;
        User checkuser = new User();
        if (request.getParameter("page") == null) {
            request.getSession().setAttribute("currentpage", 1);
        } else {
            page = Integer.parseInt(request.getParameter("page"));
            request.getSession().setAttribute("currentpage", page);
        }
        String starttime=null;
        String endtime=null;
        String tel=null;
        if(request.getParameter("remove")!=null&&!("".equals(request.getParameter("remove")))){
            if(request.getParameter("remove").equals("y")){
                request.getSession().removeAttribute("starttime");
                request.getSession().removeAttribute("endtime");
                request.getSession().removeAttribute("tel");
            }
        }
        if(request.getParameter("starttime")!=null&&!("".equals(request.getParameter("starttime")))){
            starttime=request.getParameter("starttime");
            request.getSession().setAttribute("starttime",starttime);
        }
        if(request.getParameter("endtime")!=null&&!("".equals(request.getParameter("endtime")))){
            endtime=request.getParameter("endtime");
            request.getSession().setAttribute("endtime",endtime);
        }
        if(request.getParameter("tel")!=null&&!("".equals(request.getParameter("tel")))){
            tel=request.getParameter("tel");
            request.getSession().setAttribute("tel",tel);
        }

        starttime=(String)request.getSession().getAttribute("starttime");
        endtime=(String)request.getSession().getAttribute("endtime");
        tel=(String)request.getSession().getAttribute("tel");
        int size = userDao.getUserTimeTel(starttime,endtime,tel, 0, 0).size();
        int maxpage=size%5==0?size/5:size/5+1;

        request.getSession().setAttribute("maxpage", maxpage);

        List<User> user = userDao.getUserTimeTel(starttime,endtime,tel, page, 5);
        request.getSession().setAttribute("alluser", user);
        response.sendRedirect("user_list.jsp");

    }

    public void changeStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = fullElement(request);
        userDao.setUser(user);
    }
    public void reSetPass(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = fullElement(request);
        user.setUserPwd("123456");
        String base64encodedString = Base64.getEncoder().encodeToString(user.getUserPwd().getBytes("utf-8"));
        user.setUserPwd(base64encodedString);
        userDao.setUser(user);
    }
}
