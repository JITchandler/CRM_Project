<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="layuimini-container layuimini-page-anim">
    <div class="layuimini-main">

        <fieldset class="table-search-fieldset">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">客户姓名</label>
                            <div class="layui-input-inline">
                                <input type="text" name="customName" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label" style="width: 200px">客户固定电话</label>
                            <div class="layui-input-inline">
                                <input type="text" name="customPhone" autocomplete="off" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-inline">
                            <button type="submit" class="layui-btn layui-btn-primary"  lay-submit lay-filter="data-search-btn"><i class="layui-icon"> </i> 搜 索</button>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>

        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"> 添加 </button>
                <button class="layui-btn layui-btn-sm layui-btn-danger data-delete-btn" lay-event="delete"> 删除 </button>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
        </script>

    </div>
</div>

<script>
    layui.use(['form', 'table','miniPage','element'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table,
            miniPage = layui.miniPage;

        table.render({
            elem: '#currentTableId',
            url: '/custom/list',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                {field: 'customId',  title: '客户编号', sort: true},
                {field: 'customName',  title: '客户姓名'},
                {field: 'customFrom',  title: '客户来源', },
                {field: 'customWork',  title: '客户工作行业'},
                {field: 'customLevel', title: '客户等级',hide:true},
                {field: 'customTel',  title: '客户联系方式',hide:true},
                {field: 'customPhone', title: '客户固定电话', },
                {field: 'customCode',  title: '客户编码',hide:true},
                {field: 'customAddress', title: '客户家庭住址', hide:true},
                {title: '操作', minWidth: 150, toolbar: '#currentTableBar', align: "center"}
            ]],
            limits: [ 5,15, 25, 50],
            limit: 15,
            page: true,
            skin: 'line',

            done: function(res, curr, count){
                if(res.data.length ==0)
                {
                    if(curr == 1) {
                        return;
                    }
                    table.reload('currentTableId', {
                        page: {
                            curr: 1
                        }
                    });

                }

            }
        });

        // 监听搜索操作
        form.on('submit(data-search-btn)', function (data) {
            // var result = JSON.stringify(data.field);
            // layer.alert(result, {
            //     title: '最终的搜索信息'
            // });

            //执行搜索重载
            table.reload('currentTableId', {
                page: {
                    curr: 1
                }
                , where: {
                    customName:data.field.customName,
                    customPhone:data.field.customPhone
                }
            }, 'data');

            return false;
        });

        /**
         * toolbar事件监听
         */
        table.on('toolbar(currentTableFilter)', function (obj) {
            if (obj.event === 'add') {   // 监听添加操作
                var content = miniPage.getHrefContent('page/custom/add.jsp');
                var openWH = miniPage.getOpenWidthHeight();

                var index = layer.open({
                    title: '添加用户',
                    type: 1,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: [openWH[0] + 'px', openWH[1] + 'px'],
                    offset: [openWH[2] + 'px', openWH[3] + 'px'],
                    content: content,
                    end:function () {
                        //当前层关闭之后做的事情
                        //刷新当前的表格
                        table.reload("currentTableId")
                    }
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            } else if (obj.event === 'delete') {  // 监听删除操作
                var checkStatus = table.checkStatus('currentTableId')
                    , data = checkStatus.data;
                let ids=[];
                for(let i=0;i<data.length;i++)
                {
                    ids.push(data[i].customId);
                }
                layer.confirm('真的删除行么', function (index) {
                    deleteByIds(ids)
                    layer.close(index);


                });


            }
        });

        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });

        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            // console.log(data);
            if (obj.event === 'edit') {

                var content = miniPage.getHrefContent('page/custom/edit.jsp?customId='+data.customId);
                var openWH = miniPage.getOpenWidthHeight();

                var index = layer.open({
                    title: '编辑',
                    type: 1,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: [openWH[0] + 'px', openWH[1] + 'px'],
                    offset: [openWH[2] + 'px', openWH[3] + 'px'],
                    content: content,
                    end:function () {
                        //当前层关闭之后做的事情
                        //刷新当前的表格
                        table.reload("currentTableId")
                    }
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } else if (obj.event === 'delete') {
                let ids=[];
                ids.push(data.customId);
                layer.confirm('真的删除行么', function (index) {
                    deleteByIds(ids)
                    layer.close(index);
                });
            }
        });
        /**
         * 公共的批量删除函数
         * @param ids
         * @returns {boolean}
         */
        function deleteByIds(ids)
        {
            $.ajax(
                {
                    async:false, //设置Ajax请求是同步的，
                    url:"/custom/deleteByCustomIds",//请求地址
                    method:'post',//请求方式
                    data:{ids:ids},//请求参数是object
                    traditional:true ,// 如果数据中有数组，就拆开来
                    contentType:'application/x-www-form-urlencoded; charset=UTF-8',//请求参数的类型，默认的是表单的类型
                    dataType:'json',//将返回的数据强项战场js的对象
                    success(data,txtStatus,xhr)
                    {
                        if(data.code == 200){
                            //成功
                            var index = layer.alert("删除成功" ,{
                                title: '提示信息'
                            }, function () {
                                // 关闭弹出层
                                layer.close(index);
                                table.reload("currentTableId")
                            });

                        }else
                        {
                            //失败
                            var index = layer.alert("删除失败" ,{
                                title: '提示信息'
                            }, function () {
                                // 关闭弹出层
                                layer.close(index);
                            });
                        }
                    }

                })
            return r;
        }

    });


</script>