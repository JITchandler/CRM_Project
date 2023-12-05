package com.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mapper.CustomMapper;
import com.pojo.Custom;
import com.service.CustomService;
import org.springframework.stereotype.Service;

/**
 * 客户业务层实现类
 */
@Service("customServiceImpl")
public class CustomServiceImpl extends ServiceImpl<CustomMapper, Custom>implements CustomService {
}
