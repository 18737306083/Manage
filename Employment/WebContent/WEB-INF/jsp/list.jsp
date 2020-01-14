<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%@include file="common/tag.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>图书列表</title>
    <%@include file="common/head.jsp" %>
</head>
<body>
<div class="container">
    <div class="panel panel-default">
        <div class="panel-heading text-center">
            <h2>图书列表</h2>
        </div>
        <form name="firstForm" action="<%= request.getContextPath()%>/books/search" method="post" >
        	<div class="panel-heading ">
        	    <table class="table table-bookName">
        	       <thead>
        	       		<tr> 
        					<th width="90" align="lift">图书名称：</th>
        					<th width="150" align="lift">
        						<input type="text" name="name" class="allInput" value="${name}" placeholder="输入检索书名..." />
        					</th>
        					<th width="60" align="lift">类别：</th>
        					<th width="120" align="lift">
        						<select name="category">
        							<option value="-">--未选择--</option>
        							<c:forEach items="${categorys }" var="cate" >
        								<c:if test="${cate.id == category }"><option value="${cate.id }" selected="selected">${cate.category }</option></c:if>
        								<option value="${cate.id }">${cate.category }</option>
        							</c:forEach>
        						</select>
        					</th>
        					<th> 
        						<input type="submit" id="tabSub" value="检索" /> 
        					</th>
        					<c:if test="${sessionScope.READER!=null&&sessionScope.READER.id=='admin' }"><th style="text-align:right">
        						<span class="config"><a href="#" onclick="config()">系统参数</a></span>
        					</th></c:if>
        					<c:if test="${sessionScope.READER!=null}"><th style="text-align:right">
        						<span class="config"><a href="<%= request.getContextPath()%>/books/unlogin" >退出登录</a></span>
        					</th></c:if> 
        				</tr> 
        	       </thead> 
        	    </table> 
         	</div>
        </form>
       	
        
        <div class="panel-body">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>图书ID</th>
                    <th>图书名称</th>
                    <th>馆藏数量</th> 
                    <th>类别</th>
                    <th>详细</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="sk">
                    <tr>
                        <td>${sk.bookId}</td>
                        <td>${sk.name}</td>
                        <td>${sk.number}</td>
                        <td>${sk.bookType.category}</td>
                        <td><a class="btn btn-info" href="<%= request.getContextPath()%>/books/${sk.bookId}/detail " target="_blank">详细</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table> 
        </div>
		<div style="clear:both"></div>
	<div style="">
		<ul class="pager">
			<c:if test="${totalPage>=2 }">
				<c:if test="${totalPage-1>=page}">
					<li><a
						onclick="conditionAndPage('/books/list?page=${page+1}')"
						href="#">下一页</a></li>
				</c:if>
				<c:if test="${totalPage==page}">
					<li><a>下一页</a></li>
				</c:if>
				<c:forEach begin="${page-2<0?1:page-2}"
					end="${page+2>totalPage?totalPage:page+2}"
					var="v">
					<c:if test="${v>0 and v<totalPage+1 }">
						<li><a
							onclick="conditionAndPage('/books/list?page=${v}')" href="#">${v }</a></li>
					</c:if>
				</c:forEach>
				<c:if test="${page-1>=1}">
					<li><a
						onclick="conditionAndPage('/books/list?page=${page-1}')"
						href="#">上一页</a></li>
				</c:if>
				<c:if test="${1==page}">
					<li><a>上一页</a></li>
				</c:if>
			</c:if>
		</ul>
	</div>
        
    </div>
</div>
<div id="varifyModal" class="modal fade"> 
    <div class="modal-dialog"> 
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title text-center">
                    <span class="glyphicon glyphicon-studentId"> </span>系统常规参数设置:
                </h3>
            </div>

            <div class="modal-body">
                <div class="row">
                    <div class="col-xs-8 col-xs-offset-2">
                        <input type="text" name="limitTime" id="limitTime"
                               placeholder="借阅天数 ..." class="form-control">
                    </div>
                    <div class="col-xs-8 col-xs-offset-2">
                        <select name="category" id="category" class="form-control">
        					<option value="0">教师--${limitDate }天</option>
        					<c:forEach items="${colleges }" var="coll" >
        						<option value="${coll.id }">${coll.collegeName }--${coll.limitDate }天</option>
        					</c:forEach>
        				</select>
                    </div>
                    <div class="col-xs-8 col-xs-offset-2">
                        <input type="text" name="limitCount" id="limitCount"
                               placeholder="学生|老师借阅本数限制,例如：5 |15" class="form-control">
                    </div>
                </div>
            </div>

            <div class="modal-footer">
               		<!--  验证信息 -->
                <span id="studentMessage" class="glyphicon"> </span>
                <button type="button" id="configBtn" onclick="configclick()" class="btn btn-success">
                    <span class="glyphicon glyphicon-student"></span>
                    Submit
                </button>
            </div>
        </div>
    </div> 
</div>


<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="http://apps.bdimg.com/libs/jquery/2.0.0/jquery.min.js"></script>

<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="http://apps.bdimg.com/libs/bootstrap/3.3.0/js/bootstrap.min.js"></script>
</body>
<script type="text/javascript">
function config(){
	var  IdAndPasswordModal=$('#varifyModal');
	IdAndPasswordModal.modal({
		show: true,//显示弹出层
        backdrop: 'static',//禁止位置关闭
        keyboard: false//关闭键盘事件
	});
}
function configclick(){
	var limitTime=$('#limitTime').val();
	var	category=$('#category').val();
	var limitCount=$('#limitCount').val();
	var verifyUrl='<%= request.getContextPath()%>'+'/books'+'/config';
	var params={};
	params.limitTime=limitTime;
	params.category=category;
	params.limitCount=limitCount;
	
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
				alert("设置成功！");
				result=true;
			}else{
				alert("设置失败！");
				result=false;
			}
		},
		error : function(data){
	      alert("进入了error方法"+data);
	 	}
	});
		
}

function conditionAndPage(url){
	
	window.location.href='<%= request.getContextPath()%>'+url;
}
</script>
</html>

