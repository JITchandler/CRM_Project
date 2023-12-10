package com.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebFilter("/*")

public class LoginFilter implements Filter {
    private List<String> excludeURI = new ArrayList<>();
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        excludeURI.add("/page/login-1.jsp");

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        //将请求转换为Http形式的request
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp =(HttpServletResponse) response;
        //获取请求的URI
        String requestURI = req.getRequestURI();
        //排除方向的URI
        if(excludeURI.contains(requestURI))
        {
            chain.doFilter(request,response);
            return;
        }
        System.out.println("Filter: "+requestURI);
        HttpSession session = req.getSession();
        Object loginUser = session.getAttribute("loginUser");
        if(loginUser==null){
            //如果用户没有登录
            resp.sendRedirect("/page/login-1.jsp");
            return;

        }else {
            //用户登录了，就放行
            chain.doFilter(request,response);
        }





    }

    @Override
    public void destroy() {

    }
}
