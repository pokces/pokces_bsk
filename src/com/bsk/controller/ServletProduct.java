package com.bsk.controller;

import com.bsk.dao.impl.CategoryDaoImpl;
import com.bsk.dao.impl.ProductDaoImpl;
import com.bsk.po.Category;
import com.bsk.po.Product;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@WebServlet("/ServletProduct")
public class ServletProduct extends ServletBase{
    ProductDaoImpl productDao=new ProductDaoImpl();
    CategoryDaoImpl categoryDao=new CategoryDaoImpl();
    public void jumpProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int pagesize = 2;
        int pagenum=1;
        Product product=new Product();

        if(request.getParameter("mode")!=null&&!"".equals(request.getParameter("mode"))){
            request.getSession().removeAttribute("serachname");
            request.getSession().removeAttribute("serachtype");
        }
        if(request.getParameter("serachname")!=null&&!"".equals(request.getParameter("serachname"))){
            product.setProductName(request.getParameter("serachname"));
            request.getSession().setAttribute("serachname",request.getParameter("serachname"));
        }
        if(request.getParameter("serachtype")!=null&&!"".equals(request.getParameter("serachtype"))){
            List<Category> serachtype = categoryDao.getCategory(new Category(request.getParameter("serachtype")));
            if(serachtype.size()==0){
            }else{
                product.setCategoryId(serachtype.get(0).getCategoryId());
                request.getSession().setAttribute("serachtype",serachtype.get(0).getCategoryId());
            }
        }
        product.setProductName((String)request.getSession().getAttribute("serachname"));
        product.setCategoryId((Integer) request.getSession().getAttribute("serachtype"));
        if (request.getParameter("page") == null) {
            request.getSession().setAttribute("CurrentProductpage", 1);
        } else {
            pagenum = Integer.parseInt(request.getParameter("page"));
            request.getSession().setAttribute("CurrentProductpage", pagenum);
        }
        int count= productDao.getProductcondition(product,0,0).size();
        int maxpage=count%pagesize==0?count/pagesize:count/pagesize+1;
        request.getSession().setAttribute("CurrentProductMaxPage",maxpage);
        List<Product> productcondition = productDao.getProductcondition(product, pagenum, pagesize);
        request.getSession().setAttribute("products",productcondition);
        List<Category> categorys = categoryDao.getCategory(new Category());
        request.getSession().setAttribute("categorys",categorys);
        response.sendRedirect("product.jsp");

    }

    public void setProduce(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Product product = fullElement(request);
        productDao.setProduct(product);
    }
    public void delProduce(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productId = request.getParameter("productId");
        Product product = new Product();
        product.setProductId(Integer.parseInt(productId));
        product = productDao.getProduct(product).get(0);
        String realPath = this.getServletContext().getRealPath("/upload/"+product.getProductPic());
        File file = new File(realPath);
        file.delete();
        productDao.delProduct(Integer.parseInt(productId));
    }
    public void addProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String s = "无图片";
        Product pro=new Product();
        pro.setProductName("无名称");
        pro.setProductPrice(0.0);
        pro.setProductDescribe("无描述");
        pro.setCategoryId(0);
        DiskFileItemFactory diskFileItemFactory=new DiskFileItemFactory();
        ServletFileUpload servletFileUpload=new ServletFileUpload(diskFileItemFactory);
        try {
            List<FileItem> fileItems = servletFileUpload.parseRequest(request);
            for (FileItem fileItem : fileItems) {
                if(fileItem.isFormField()){
                    String string = fileItem.getString("utf-8");
                    String fieldName = fileItem.getFieldName();
                    if(fieldName.equals("productName")&&!"".equals(string)){
                        pro.setProductName(string);
                    }else if(fieldName.equals("productPrice")&&!"".equals(string)){
                        pro.setProductPrice(Double.parseDouble(string));
                    }else if(fieldName.equals("productDescribe")&&!"".equals(string)){
                        pro.setProductDescribe(string);
                    }else if(fieldName.equals("addcategory")&&!"".equals(string)){
                        Category category = new Category(string);
                        category= categoryDao.getCategory(category).get(0);
                        int id = categoryDao.getCategory(new Category(string)).get(0).getCategoryId();
                        pro.setCategoryId(id);
                    }
                }else{
                    if(fileItem.getSize()!=0){
                        s = uploadFile(fileItem);
                    }
                }
            }
        } catch (FileUploadException e) {
            e.printStackTrace();
        }
        pro.setProductPic(s);
        productDao.addProduct(pro);
        response.sendRedirect("ServletProduct?m=jumpProduct");
    }
    private Product fullElement(HttpServletRequest request) {
        Map<String, String[]> parameterMap = request.getParameterMap();
        Product product = new Product();
        try {
            BeanUtils.populate(product, parameterMap);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
        return product;
    }
    private String uploadFile(FileItem fileItem) {
        String realPath = this.getServletContext().getRealPath("/upload");
        File dir = new File(realPath);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        String filename = fileItem.getName();
        if (filename != null) {
            String extend = filename.substring(filename.indexOf("."));
            filename = UUID.randomUUID() + extend;
        }
        try {
            fileItem.write(new File(realPath, "/" + filename));
        } catch (Exception e) {
            e.printStackTrace();
        }

        return filename;
    }

    public void modifyProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        String s = null;
        Product pro=new Product();
        boolean delpic=false;
        String page="1";
        DiskFileItemFactory diskFileItemFactory=new DiskFileItemFactory();
        ServletFileUpload servletFileUpload=new ServletFileUpload(diskFileItemFactory);
        try {
            List<FileItem> fileItems = servletFileUpload.parseRequest(request);
            for (FileItem fileItem : fileItems) {
                if(fileItem.isFormField()){
                    String string = fileItem.getString("utf-8");
                    String fieldName = fileItem.getFieldName();
                    if(fieldName.equals("productName")&&!"".equals(string)){
                        pro.setProductName(string);
                    }else if(fieldName.equals("productPrice")&&!"".equals(string)){
                        pro.setProductPrice(Double.parseDouble(string));
                    }else if(fieldName.equals("productDescribe")&&!"".equals(string)){
                        pro.setProductDescribe(string);
                    }else if(fieldName.equals("productId")&&!"".equals(string)){
                        pro.setProductId(Integer.parseInt(string));
                    }else if(fieldName.equals("currentpage")&&!"".equals(string)){
                        page=string;
                    }else if(fieldName.equals("addcategory")&&!"".equals(string)){
                        Category category = new Category(string);
                        int id = categoryDao.getCategory(new Category(string)).get(0).getCategoryId();
                        pro.setCategoryId(id);
                    }
                }else{
                    if(fileItem.getSize()!=0){
                        s = uploadFile(fileItem);
                        delpic=true;
                    }
                }
            }
        } catch (FileUploadException e) {
            e.printStackTrace();
        }
        if(delpic){
            Product delpropic=new Product();
            delpropic.setProductId(pro.getProductId());
            String productPic = productDao.getProduct(delpropic).get(0).getProductPic();
            File oldpic=new File(this.getServletContext().getRealPath("/upload/")+productPic);
            oldpic.delete();
        }
        pro.setProductPic(s);
        productDao.setProduct(pro);
        response.sendRedirect("ServletProduct?m=jumpProduct&page="+page);
    }
    public void menuGetProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        String mode = request.getParameter("mode");
        List<Category> allCategory = categoryDao.getCategory(new Category());
        request.setAttribute("allCategory",allCategory);
        if(mode!=null&&!"".equals(mode)){
            Product product = new Product();
            product.setProductStatus("Y");
            if(!mode.equals("all")){
                product.setCategoryId(Integer.parseInt(mode));
                request.setAttribute("ultype",mode);
            }else{
                request.setAttribute("ultype",0);
            }
            List<Product> allProduct = productDao.getProduct(product);
            request.setAttribute("allProduct",allProduct);
        }
        request.getRequestDispatcher("menu.jsp").forward(request,response);
    }
    public void checkName(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        String name = request.getParameter("name");
        Product product = new Product();
        product.setProductName(name);
        if(productDao.getProduct(product).size()==0){
            response.getWriter().write("ok");
        }else{
            response.getWriter().write("e1");
        }
    }
}
