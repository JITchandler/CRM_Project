<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="layuimini-main">

    <div class="layui-form layuimini-form">
        <div class="layui-form-item">
            <label class="layui-form-label required">客户姓名</label>
            <div class="layui-input-block">
                <input type="text" name="customName" lay-verify="required" lay-reqtext="客户姓名不能为空" placeholder="请输入客户姓名" value="" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label ">客户来源</label>
            <div class="layui-input-block">
                <input type="text" name="customFrom" placeholder="请输入客户来源" value="" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label ">客户等级</label>
            <div class="layui-input-block">
                <input type="radio" name="sex" value="普通用户" title="普通用户" checked="">
                <input type="radio" name="sex" value="VIP用户" title="VIP用户">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label ">客户工作行业</label>
            <div class="layui-input-block">
                <input type="text" name="customWork" placeholder="请输入客户工作行业" value="" class="layui-input">
            </div>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label ">客户联系方式</label>
            <div class="layui-input-block">
                <input type="text" name="customTel" placeholder="请输入客户联系方式" value="" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label ">客户固定电话</label>
            <div class="layui-input-block">
                <input type="text" name="customPhone" placeholder="请输入客户固定电话" value="" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label ">客户编码</label>
            <div class="layui-input-block">
                <input type="text" name="customCode" placeholder="请输入客户编码" value="" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label ">客户家庭住址</label>
            <div class="layui-input-block">
                <input type="text" name="customAddress" placeholder="请输入客户家庭住址" value="" class="layui-input">
            </div>
        </div>



        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认保存</button>
            </div>
        </div>
    </div>
</div>
<script>
    layui.use(['form', 'table'], function () {
        var form = layui.form,
            layer = layui.layer,
            table = layui.table,
            $ = layui.$;

        /**
         * 初始化表单，要加上，不然刷新部分组件可能会不加载
         */
        form.render();

        // 当前弹出层，防止ID被覆盖
        var parentIndex = layer.index;

        //监听提交
        form.on('submit(saveBtn)', function (data) {
            var index = layer.alert(JSON.stringify(data.field), {
                title: '最终的提交信息'
            }, function () {

                // 关闭弹出层
                layer.close(index);
                layer.close(parentIndex);

            });


            return false;
        });

    });
</script>