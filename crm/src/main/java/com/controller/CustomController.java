package com.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.common.R;
import com.common.UIR;
import com.exception.FormException;
import com.pojo.Custom;
import com.service.CustomService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/custom")
public class CustomController {
    //引入业务层接口
    @Resource(name = "customServiceImpl")
    private CustomService customService;
    @RequestMapping("/add")
    @ResponseBody
    public R add(Custom custom)
    {
        try {
            System.out.println("custom:" + custom);
            boolean save = customService.save(custom);
            if (save) {
                return R.OK();
            } else {
                return R.ERROR();
            }
        }catch (Exception e)
        {
            throw new FormException(e);
        }

    }

    /**
     *  ?page=1&limit=15
     * @return
     */
    @RequestMapping("/list")
    @ResponseBody
    public UIR list(Integer page,Integer limit,Custom custom)
    {
        //返回給表格使用
        UIR uir=new UIR();
        //设置状态码
        uir.setCode(0);
        //设置消息
        uir.setMsg("");

        //设置分页条件
        Page<Custom> p  = new Page<>(page,limit);
        //设置查询条件
        QueryWrapper<Custom> customQueryWrapper = new QueryWrapper<>();
        if(custom.getCustomName()!=null && !custom.getCustomName().equals(""))
        {
            //设置根据customName进行模糊查询
            customQueryWrapper.like("customName",custom.getCustomName());
        }

        if(custom.getCustomPhone()!=null&&!custom.getCustomPhone().equals(""))
        {
            //设置手机号查询条件
            if(custom.getCustomPhone().length()==11) {
                //设置等值查找
                customQueryWrapper.eq("customPhone", custom.getCustomPhone());
            }else if(custom.getCustomPhone().length()>=2){
                //设置尾部查找
                customQueryWrapper.like("customPhone",custom.getCustomPhone());
            }

        }

        //带分页条件的查询
        Page<Custom> customPage = customService.page(p,customQueryWrapper);
        //获取分页条件之后的数据列表
        List<Custom> list= customPage.getRecords();
        //设置总条数
        uir.setCount(customPage.getTotal());
        //设置当前页展示的数据列表
        uir.setData(list);
        //返回
        return uir;



    }


}
