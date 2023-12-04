package com.pojo;

import lombok.Data;

@Data
public class Custom {

  private Long customId;// null
  private String customName;
  private String customFrom;
  private String customWork;
  private String customLevel;
  private String customTel;
  private String customPhone;
  private String customCode;
  private String customAddress;

 // private double score;// 0:参加考试了，但是得了0分  null:缺考

}
