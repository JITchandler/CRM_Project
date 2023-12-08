package com.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

@Data
public class Custom {

  @TableId(type = IdType.AUTO)//主键自增
  private long customId;
  private String customName;
  private String customFrom;
  private String customWork;
  private String customLevel;
  private String customTel;
  private String customPhone;
  private String customCode;
  private String customAddress;




}
