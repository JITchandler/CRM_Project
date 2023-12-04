package com.filter;

import com.common.Const;

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

    //存放放行的uri地址集合
    private List<String> excludeURI=new ArrayList<>();
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        excludeURI.add("/page/login-1.jsp");
        excludeURI.add("/favicon.ico");
        excludeURI.add("/system/login");
        excludeURI.add("/captcha");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        //将请求转换成HTTP协议的request
        HttpServletRequest req=(HttpServletRequest)request;
        HttpServletResponse resp=(HttpServletResponse)response;
        //获取请求的uri
        String requestURI = req.getRequestURI();
        //排除放行的uri
        if(
                requestURI.endsWith("css")||
                requestURI.endsWith("js")||
                requestURI.endsWith("otf")||
                requestURI.endsWith("eot")||
                requestURI.endsWith("svg")||
                requestURI.endsWith("ttf")||
                requestURI.endsWith("woff")||
                requestURI.endsWith("woff2")||
                requestURI.startsWith("/api")||
                requestURI.startsWith("/images")||
                excludeURI.contains(requestURI)){
            chain.doFilter(request,response);
            return;
        }
        //获取session
        HttpSession session = req.getSession();
        //从session中获取登录对象
        Object loginUser = session.getAttribute(Const.LOGINKEY);
        if(loginUser==null){
            //未登录
            resp.sendRedirect("/page/login-1.jsp");
            return;
        }else {
            //已登录，放行
            chain.doFilter(request,response);
        }

    }

    @Override
    public void destroy() {

    }
}
