package com.bsk.controller;

import com.bsk.dao.impl.AddressDaoImpl;
import com.bsk.po.Address;
import com.bsk.po.User;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.Map;

@WebServlet("/ServletAddress")
public class ServletAddress extends ServletBase {
    AddressDaoImpl addressDao=new AddressDaoImpl();
    public void jumpAddress(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Address address=new Address();
        try {
            address.setUserId(((User)request.getSession().getAttribute("loginuser")).getUserId());
        } catch (Exception e) {
        }
        List<Address> a = addressDao.getAddress(address);
        request.setAttribute("alladdress",a);
        request.getRequestDispatcher("address.jsp").forward(request,response);
    }
    public void setAddress(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Address address = fullElement(request);
        Integer loginuser = ((User) request.getSession().getAttribute("loginuser")).getUserId();
        address.setUserId(loginuser);
        Integer a=address.getAddressId();
        address.setAddressId(null);
        if(addressDao.getAddress(address).size()==0){
            address.setAddressId(a);
            addressDao.setAddress(address);
        }else {
            response.getWriter().write("e1");
        }
    }

    public void delAddress(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int addressId = Integer.parseInt(request.getParameter("addressId"));
        addressDao.delAddress(addressId);
    }
    public void addAddress(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Address address = fullElement(request);
        try {
            address.setUserId(((User)request.getSession().getAttribute("loginuser")).getUserId());
        } catch (Exception e) {
            address.setUserId(-1);
        }
        int size = addressDao.getAddress(address).size();
        if (size==0){
            addressDao.addAddress(address);
        }else{
            response.getWriter().write("e1");
        }

    }

    private Address fullElement(HttpServletRequest request) {
        Map<String, String[]> parameterMap = request.getParameterMap();
        Address address = new Address();
        try {
            BeanUtils.populate(address, parameterMap);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
        return address;
    }
}
