package com.controller;

import com.common.R;
import com.pojo.Custom;
import com.service.CustomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/test")
public class TestController {
    @Autowired
    private CustomService customService;
    @RequestMapping("/test.css")
    public R css(){
        List<Custom> list = customService.list();
        R r=R.OK();
        r.setData(list);
        return r;
    }
}
