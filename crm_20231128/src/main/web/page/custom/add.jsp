<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="layuimini-main">

    <div class="layui-form layuimini-form">
        <div class="layui-form-item">
            <label class="layui-form-label required">客户姓名</label>
            <div class="layui-input-block">
                <input type="text" name="customName" lay-verify="required" lay-reqtext="客户姓名不能为空" placeholder="请输入客户姓名" value="" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">客户来源</label>
            <div class="layui-input-block">
                <input type="text" name="customFrom" placeholder="请输入客户来源" value="" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">客户工作行业</label>
            <div class="layui-input-block">
                <input type="text" name="customWork" placeholder="请输入客户工作行业" value="" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">客户等级</label>
            <div class="layui-input-block">
                <input type="radio" name="customLevel" value="普通用户" title="普通用户" checked="">
                <input type="radio" name="customLevel" value="VIP用户" title="VIP用户">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">客户联系方式</label>
            <div class="layui-input-block">
                <input type="text" name="customTel"  placeholder="请输入客户联系方式" value="" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">客户固定电话</label>
            <div class="layui-input-block">
                <input type="text" name="customPhone" lay-verify="phone"  placeholder="请输入客户固定电话" value="" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">客户编码</label>
            <div class="layui-input-block">
                <input type="text" name="customCode"  placeholder="请输入客户编码" value="" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">客户家庭住址</label>
            <div class="layui-input-block">
                <input type="text" name="customAddress"  placeholder="请输入客户家庭住址" value="" class="layui-input">
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

        /**
         * 表单输入项的验证
         */
        form.verify({
            username: function(value, item){ //value：表单的值、item：表单的DOM对象
                if(!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)){
                    return '用户名不能有特殊字符';
                }
                if(/(^\_)|(\__)|(\_+$)/.test(value)){
                    return '用户名首尾不能出现下划线\'_\'';
                }
                if(/^\d+\d+\d$/.test(value)){
                    return '用户名不能全为数字';
                }

                //如果不想自动弹出默认提示框，可以直接返回 true，这时你可以通过其他任意方式提示（v2.5.7 新增）
                if(value === 'xxx'){
                    alert('用户名不能为敏感词');
                    return true;
                }
            }

            //我们既支持上述函数式的方式，也支持下述数组的形式
            //数组的两个值分别代表：[正则匹配、匹配不符时的提示文字]
            ,phone: [
                /^1[3|5|7|8|9][0-9]{9}$/
                ,'手机号码必须以13、15、17、18、19开头，并且是11位'
            ]
        });

        // 当前弹出层，防止ID被覆盖
        var parentIndex = layer.index;

        //监听提交
        form.on('submit(saveBtn)', function (data) {
            //发送ajax给服务器
            $.ajax({
                url:'/custom/add',//请求地址
                method:'post',//请求方式
                data:data.field,//请求参数是object
                traditional:true,//请求中如果有数组，拆开来发送，例如 a=[1,2] 拆开后是 a=1&a=2
                contentType:'application/x-www-form-urlencoded; charset=UTF-8',//请求参数的类型，默认是表单的类型
                dataType:'json',//将返回的数据强行转换成js的对象
                success(data,txtStatus,xhr){
                    if(data.code==200){
                        //关闭当前层
                        var index = layer.alert("添加成", {
                            title: '提示信息'
                        }, function () {
                            // 关闭弹出层
                            layer.close(index);
                            layer.close(parentIndex);
                        });
                    }else {
                        //失败
                        var index = layer.alert("添加失败", {
                            title: '提示信息'
                        }, function () {
                            // 关闭弹出层
                            layer.close(index);
                            layer.close(parentIndex);
                        });
                    }
                }

            })



            return false;
        });

    });
</script>