package com.interceptor;

import com.common.Const;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 登录拦截器
 */
public class LoginInter implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("Interceptor:"+request.getRequestURI());
        //获取session
        HttpSession session = request.getSession();
        //从session中获取登录对象
        Object loginUser = session.getAttribute(Const.LOGINKEY);
        //判断用户是否登录
        if(loginUser==null){
            //未登录，重定向到登录页面
            response.sendRedirect("/page/login-1.jsp");
            return false;
        }else {
            //登录了,放行
            return true;
        }
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
