package com.common;

import lombok.Data;

/**
 * 请求返回的对象
 */
@Data
public class R {
    //返回状态码
    private int code;
    //返回的消息
    private String msg;
    //返回的数据
    private Object data;

    /**
     * 默认的成功对象
     * @return
     */
    public static R OK(){
        R r=new R();
        r.code=200;
        r.msg="SUCCESS";
        return r;
    }

    /**
     * 默认的失败对象
     * @return
     */
    public static R ERROR(){
        R r=new R();
        r.code=700;
        r.msg="ERROR";
        return r;
    }

}
