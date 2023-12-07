package com.exception;

import com.common.R;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 全局异常处理
 */
@ControllerAdvice
public class GlobalExceptionHandler {
    /**
     * 处理表单异常
     * @param e
     * @return
     */
    @ExceptionHandler(FormException.class)
    @ResponseBody
    public R formException(FormException e)
    {
       R r=R.ERROR();
       r.setMsg(e.getMessage());
       return  r;
    }

}
