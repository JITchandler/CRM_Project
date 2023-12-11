package com.controller;

import com.common.Const;
import com.common.R;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

/**
 * 系统api
 */
@Controller
@RequestMapping("/system")
public class SystemController {

    /**
     * 用户登录
     * @param name 账号
     * @param pwd 密码
     * @return
     */
    @RequestMapping("/login")
    @ResponseBody
    public R login(String name , String pwd,String captcha, HttpSession httpSession){
        //获取session中的验证码
        String sessionCaptcha = (String) httpSession.getAttribute("captcha");
        if(!sessionCaptcha.equals(captcha)){
            R r=R.ERROR();
            r.setMsg("验证码错误");
            return r;
        }
        //判断管理员的账号
        if(Const.ADMINNAME.equals(name)&&Const.ADMINPWD.equals(pwd)){
            //登录成功，往session中注添加登录用户属性
            httpSession.setAttribute(Const.LOGINKEY,Const.ADMINNAME);
            R r = R.OK();
            return r;
        }
        //判断普通员工的账号

        R r= R.ERROR();
        r.setMsg("账号或密码错误");
        return r;
    }


    @RequestMapping("/logout")
    @ResponseBody
    public R logout(HttpSession session){
        //销毁会话
        session.invalidate();
        return R.OK();
    }
}
