<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%@include file="common/tag.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>借阅详情页</title>
    <%@include file="common/head.jsp" %>
</head>
<body>
<div class="container">
    <div class="panel panel-default">
        <div class="panel-heading text-center">
     	   	<h2>图书详情</h2>
        </div>
        <div class="panel-body">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>图书ID</th>
                    <th>图书名称</th> 
                    <th>图书简介</th>
                    <th>剩余数量</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                	<tr>
                		<td>${book.bookId}</td>
                		<td>${book.name}</td>
                		<td width="400px">${book.introd}</td> 
                		<td>${book.number }</td>
                		<td><a class="btn btn-info" href="#" onclick="approve(${book.bookId})">借阅</a></td>
                	</tr>  
                </tbody>
             </table> 
           </div>  
           <div class="panel-body text-center">
            	<h2 class="text-danger">  
            		<!--用来展示借阅控件-->
            		<span class="glyphicon" id="appoint-box"></span> <!--在js里面调用这个id还可以动态显示一些其他东西，例如动态时间等（需要插件）-->
            		 
            		<span class="glyphicon">
            			<c:if test="${sessionScope.READER!=null }"><a class="btn btn-primary btn-lg" href="<%= request.getContextPath()%>/books/appoint" target="_blank">查看我的已借阅书籍</a></c:if>
            			<c:if test="${sessionScope.READER==null }"><a class="btn btn-primary btn-lg" onclick="showVarifyModal()" href="#" >查看我的已借阅书籍</a></c:if>
            		</span>
            	</h2>           <!--如何获取该页面弹出层输入的学生ID， 传给上面的url-->
        	</div>
    </div>	 	
            		  
</div>
   <!--  登录弹出层 输入电话   -->
<div id="varifyModal" class="modal fade"> 
    <div class="modal-dialog"> 
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title text-center">
                    <span class="glyphicon glyphicon-studentId"> </span>请输入学号和密码:
                </h3>
            </div>

            <div class="modal-body">
                <div class="row">
                    <div class="col-xs-8 col-xs-offset-2">
                        <input type="text" name="id" id="studentIdKey"
                               placeholder="填写学号..." class="form-control">
                    </div>
                    <div class="col-xs-8 col-xs-offset-2">
                        <input type="password" name="password" id="passwordKey"
                               placeholder="输入密码..." class="form-control">
                    </div>
                </div>
            </div>

            <div class="modal-footer">
               		<!--  验证信息 -->
                <span id="studentMessage" class="glyphicon"> </span>
                <button type="button" id="studentBtn" onclick="studentBtnclick()" class="btn btn-success">
                    <span class="glyphicon glyphicon-student"></span>
                    Submit
                </button>
            </div>
        </div>
    </div> 
</div>  

</body>
<%--jQery文件,务必在bootstrap.min.js之前引入--%>
<script src="<%= request.getContextPath()%>/script/jquery.min.js"></script>
<script src="<%= request.getContextPath()%>/script/bootstrap.min.js"></script>
<%--使用CDN 获取公共js http://www.bootcdn.cn/--%>
<%--jQuery Cookie操作插件--%>
<script src="http://cdn.bootcss.com/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
<%--jQuery countDown倒计时插件--%>
<script src="http://cdn.bootcss.com/jquery.countdown/2.1.0/jquery.countdown.min.js"></script>

<script src="<%= request.getContextPath()%>/script/bookappointment.js" type="text/javascript"></script>

<script type="text/javascript">
    /* $(function () {
        //使用EL表达式传入参数
        bookappointment.detail.init({
            bookId:${book.bookId}  
             
        });
    }) */
    function showVarifyModal(){
    	var  IdAndPasswordModal=$('#varifyModal');
		IdAndPasswordModal.modal({
			show: true,//显示弹出层
            backdrop: 'static',//禁止位置关闭
            keyboard: false//关闭键盘事件
		});
    }
    function studentBtnclick(){
		var studentId=$('#studentIdKey').val();
			console.log("studentId:"+studentId);
		var password=$('#passwordKey').val();
			console.log("password:"+password);
		//调用validateStudent函数验证用户id和密码。
		var temp=validateStudent(studentId,password);
		console.log(temp);
		if(temp=="nothing"){
			$('#studentMessage').hide().html('<label class="label label-danger">学号或密码为空!</label>').show(300);
		/* }else if(temp=="typerror"){
			$('#studentMessage').hide().html('<label class="label label-danger">格式不正确!</label>').show(300);
		 */}else if(temp=="mismatch"){
			console.log("已经调用验证函数！");
			$('#studentMessage').hide().html('<label class="label label-danger">学号密码不匹配!</label>').show(300);
		}else if(temp=="success"){
			 //学号与密码匹配正确，将学号密码保存在cookie中。不设置cookie过期时间，这样即为session模式，关闭浏览器就不保存密码了。
			$.cookie('studentId', studentId, {  path: '/books'}); 
			$.cookie('password', password, {  path: '/books'}); 
			// 跳转到借阅逻辑 
			var appointbox=$('#appoint-box');
			bookappointment.appointment(bookId,studentId,appointbox);
		}
	}
  	
</script>
<script type="text/javascript">
//验证学号和密码
function validateStudent(studentId,password){
	console.log("studentId"+studentId);
	if(!studentId||!password){
		return "nothing";
	/* }else if(studentId.length!=8||password.length<6 ){
		return "typerror"; */
	}else {
		if(verifyWithDatabase(studentId, password)){
			console.log("验证成功！");
			return "success";
		}else{
			console.log("验证失败！");
			return "mismatch";
		}
	}  
}
//将学号和用户名与数据库匹配
function verifyWithDatabase(studentId,password){
	var result=false;
	var params={};
	params.readerId=studentId;
	params.password=password;
	console.log("params.password:"+params.password);
	var verifyUrl='<%= request.getContextPath()%>'+'/books'+'/verify';
	$.ajax({
		type:'post',
		url:verifyUrl,
		data:params,
		datatype:'text', 
		async:false,                       //同步调用，保证先执行result=true,后再执行return result;
		success:function(data){
			//alert(data);
			if(data.result=='SUCCESS'){
				//alert(data);
				window.location.reload();
				//弹出登录成功！
				alert("登陆成功！");
				result=true;
			}else{
				result=false;
			}
		},
		error : function(data){
	      alert("进入了error方法"+data);
	 	}
	});
	console.log("我是验证结果："+result);
	return result;
	
}
function approve(id){
	var url ='<%= request.getContextPath()%>'+'/books/'+id+'/appoint ';
	$.ajax({
		type:'post',
		url:url,
		//data:params,
		datatype:'text', 
		async:false,                       //同步调用，保证先执行result=true,后再执行return result;
		success:function(data){
			//alert(data);
			if(data.result=='true'){
				window.location.reload();
				alert("借阅成功！");
				result;
			}else if(data.result=='nologin'){
				alert("请先登陆！");
				result;
			}else if(data.result=='limit'){
				alert("已达到借阅！");
				result;
			}else if(data.result=='error'){
				alert("借阅失败！");
				result;
			}else if(data.result=='exist'){
				alert("重复借阅！");
				result;
			}else if(data.result=='weak'){
				alert("库存不足！");
				result;
			}
		},
		error : function(data){
	      alert("进入了error方法"+data);
	 	}
	});
}

</script>
</html>
