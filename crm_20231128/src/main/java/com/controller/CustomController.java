package com.controller;

import com.common.R;
import com.common.UIR;
import com.exception.FormException;
import com.pojo.Custom;
import com.service.CustomService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.rmi.server.UID;
import java.util.List;

/**
 * 客户api接口
 */
@Controller
@RequestMapping("/custom")
public class CustomController {

    //引入业务层接口
    @Resource(name = "customServiceImpl")
    private CustomService customService;

    @RequestMapping("/add")
    @ResponseBody
    public R add(Custom custom){
        try {
            System.out.println("custom:" + custom);
            boolean save = customService.save(custom);
            if (save) {
                return R.OK();
            } else {
                return R.ERROR();
            }
        }catch (Exception e){
            throw new FormException(e);
        }
    }

    @RequestMapping("/list")
    @ResponseBody
    public UIR list(){
        UIR uir=new UIR();
        uir.setCode(0);
        uir.setMsg("");
        List<Custom> list = customService.list();
        uir.setCount(list.size());
        uir.setData(list);
        return uir;
    }
}
