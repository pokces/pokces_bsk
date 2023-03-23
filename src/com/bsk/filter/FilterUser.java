package com.bsk.filter;


import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/*")
public class FilterUser implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {

        HttpServletRequest re = (HttpServletRequest) req;
        HttpServletResponse res = (HttpServletResponse) resp;
        res.setContentType("text/html;charset=UTF-8");
        re.setCharacterEncoding("utf-8");
        String requestURL = re.getRequestURL().toString();
        if(re.getSession().getAttribute("loginuser")==null){
            if(requestURL.contains("user_list.jsp")||requestURL.contains("user_info.jsp")||requestURL.contains("product.jsp")||
                    requestURL.contains("order_submit.jsp")||requestURL.contains("order.jsp")||
                    requestURL.contains("member.jsp")||requestURL.contains("jumpAddress")||requestURL.contains("jumpUser")||
                    requestURL.contains("getAllCategory")||requestURL.contains("jumpProduct")||requestURL.contains("jumpOrderManage")) {
                    res.sendRedirect("main.jsp");
            }else{
                chain.doFilter(req, resp);
            }
        }else{
            chain.doFilter(req, resp);
        }

    }

    public void init(FilterConfig config) throws ServletException {

    }

}
