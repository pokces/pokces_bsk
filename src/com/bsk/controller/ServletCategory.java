package com.bsk.controller;

import com.bsk.dao.impl.CategoryDaoImpl;
import com.bsk.dao.impl.ProductDaoImpl;
import com.bsk.po.Category;
import com.bsk.po.Product;
import com.bsk.po.User;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.Map;

@WebServlet("/ServletCategory")
public class ServletCategory extends ServletBase{
    CategoryDaoImpl categoryDao=new CategoryDaoImpl();
    ProductDaoImpl productDao=new ProductDaoImpl();
    public void getAllCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Category> category = categoryDao.getCategory(new Category());
        request.getSession().setAttribute("allCategory",category);
        response.sendRedirect("category.jsp");
    }
    public void modifyCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Category category = fullElement(request);
        Category check=new Category();
        check.setCategoryName(category.getCategoryName());
        if(categoryDao.getCategory(check).size()==0){
            categoryDao.setCategory(category);
            List<Category> c = categoryDao.getCategory(new Category());
            request.getSession().setAttribute("allCategory",c);
        }else{
            response.getWriter().write("e1");
        }
    }

    public void delCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Product product = new Product();
        product.setCategoryId(id);
        int size = productDao.getProduct(product).size();
        if(size==0){
            categoryDao.delCategory(id);
            List<Category> c = categoryDao.getCategory(new Category());
            request.getSession().setAttribute("allCategory",c);
        }else{
            response.getWriter().write("e1");
        }

    }
    public void addCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Category category = fullElement(request);
        int size = categoryDao.getCategory(category).size();
        if(size==0){
            categoryDao.addCategory(category);
            List<Category> c = categoryDao.getCategory(new Category());
            request.getSession().setAttribute("allCategory",c);
        }else{
            response.getWriter().write("分类名称重复");
        }
    }

    private Category fullElement(HttpServletRequest request) {
        Map<String, String[]> parameterMap = request.getParameterMap();
        Category category = new Category();
        try {
            BeanUtils.populate(category, parameterMap);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
        return category;
    }

}
