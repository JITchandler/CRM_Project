<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="layuimini-main">

    <div class="layui-form layuimini-form">
        <input type="hidden" name="customId" value="${param.customId}">
        <div class="layui-form-item">
            <label class="layui-form-label required">客户姓名</label>
            <div class="layui-input-block">
                <input id="customName" type="text" name="customName" lay-verify="required" lay-reqtext="客户姓名不能为空" placeholder="请输入客户姓名" value="" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label ">客户来源</label>
            <div class="layui-input-block">
                <input id="customFrom" type="text" name="customFrom" placeholder="请输入客户来源" value="" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label ">客户等级</label>
            <div class="layui-input-block">
                <input id="normal" type="radio" name="customLevel" value="普通用户" title="普通用户" >
                <input id="vip" type="radio" name="customLevel" value="VIP用户" title="VIP用户">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label ">客户工作行业</label>
            <div class="layui-input-block">
                <input id="customWork" type="text" name="customWork" placeholder="请输入客户工作行业" value="" class="layui-input">
            </div>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label ">客户联系方式</label>
            <div class="layui-input-block">
                <input id="customTel" type="text" name="customTel" placeholder="请输入客户联系方式" value="" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label ">客户固定电话</label>
            <div class="layui-input-block">
                <input id="customPhone" type="text" name="customPhone" lay-verify="phone" placeholder="请输入客户固定电话" value="" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label ">客户编码</label>
            <div class="layui-input-block">
                <input id="customCode" type="text" name="customCode" placeholder="请输入客户编码" value="" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label ">客户家庭住址</label>
            <div class="layui-input-block">
                <input id="customAddress" type="text" name="customAddress" placeholder="请输入客户家庭住址" value="" class="layui-input">
            </div>
        </div>



        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认保存</button>
            </div>
        </div>
    </div>
</div>
<%
    request.getParameter("customId");
%>
<script>
    layui.use(['form', 'table'], function () {
        var form = layui.form,
            layer = layui.layer,
            table = layui.table,
            $ = layui.$;
        <%--console.log(${param.customId})--%>
        //获取编辑用户的ID值
        var customId=${param.customId};
        //发送AJax，获取用户数据
        $.ajax(
            {
                url:"/custom/getByCustomId",//请求地址
                method:'post',//请求方式
                data:{customId:customId},//请求参数是object
                traditional:true ,// 如果数据中有数组，就拆开来
                contentType:'application/x-www-form-urlencoded; charset=UTF-8',//请求参数的类型，默认的是表单的类型
                dataType:'json',//将返回的数据强项战场js的对象
                success(data,txtStatus,xhr)
                {
                    if(data.code==200)
                    {
                        //有数据
                        let custom = data.data;
                        $("#customName").val(custom.customName);
                        $("#customFrom").val(custom.customFrom);
                        $("#customWork").val(custom.customWork);
                        $("#customTel").val(custom.customTel);
                        $("#customPhone").val(custom.customPhone);
                        $("#customAddress").val(custom.customAddress);
                        if(custom.customLevel == "普通用户")
                        {
                            $("#normal").attr("checked",true);
                        }else if(custom.customLevel == "VIP用户")
                        {
                            $("#vip").attr("checked",true);
                        }
                        //重新渲染
                        form.render();

                    }else
                    {
                        //没有数据
                    }

                }

            }
        );



        /**
         * 初始化表单，要加上，不然刷新部分组件可能会不加载
         */
        form.render();

        /**
         * 表单验证
         */
        form.verify({
            // 验证用户名，且为必填项
            username: function(value, elem){
                if (!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)) {
                    return '用户名不能有特殊字符';
                }
                if (/(^_)|(__)|(_+$)/.test(value)) {
                    return '用户名首尾不能出现下划线';
                }
                if (/^\d+$/.test(value)) {
                    return '用户名不能全为数字';
                }
            },
            // 验证手机号码，且为必填项
            phone: function(value, elem) {
                if (!/^1[3|5|7|8|9][0-9]{9}$/.test(value)) {
                    return '手机号码必须以13，15，17，18，19开头，并且是11位';
                }
            },
            // 验证座右铭，且为非必填项
            motto: function(value, elem) {
                if (!value) return; // 非必填
                // 自定义规则
                if (!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)) {
                    return '座右铭不能有特殊字符';
                }
            }
        });



            // 当前弹出层，防止ID被覆盖
        var parentIndex = layer.index;

        //监听提交
        form.on('submit(saveBtn)', function (data) {
            //发Ajax给服务器
            $.ajax(
                {
                    url:"/custom/edit",//请求地址
                    method:'post',//请求方式
                    data:data.field,//请求参数是object
                    traditional:true ,// 如果数据中有数组，就拆开来
                    contentType:'application/x-www-form-urlencoded; charset=UTF-8',//请求参数的类型，默认的是表单的类型
                    dataType:'json',//将返回的数据强项战场js的对象
                    success(data,txtStatus,xhr)
                    {
                        //关闭当前层
                       if(data.code==200)
                       {
                           var index = layer.alert("修改成功" ,{
                               title: '提示信息'
                           }, function () {

                               // 关闭弹出层
                               layer.close(index);
                               layer.close(parentIndex);

                           });
                       }else {
                           //失败
                           var index = layer.alert("修改失败" ,{
                               title: '提示信息'
                           }, function () {

                               // 关闭弹出层
                               layer.close(index);
                               layer.close(parentIndex);

                           });

                       }

                    }

                }
            );



            return false;
        });

    });
</script>