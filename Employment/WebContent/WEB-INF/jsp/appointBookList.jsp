<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%@include file="common/tag.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>借阅图书列表</title>
    <%@include file="common/head.jsp" %>
</head>
<body>
<div class="container">
    <div class="panel panel-default">
        <div class="panel-heading text-center">
            <h2>您已借阅图书列表</h2>
        </div>
		<div class="panel-body">
            <table class="table table-hover">
                <thead>
                <tr> 
                	<th>ID</th>
                    <th>图书ID</th>
                    <th>图书名称</th>
                    <th>借阅时间</th> 
                    <th>续借次数</th>
                    <th>图书简介</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${appointList}" var="sk">
                    <tr>
                    	<td>${sk.id}</td> 
                        <td>${sk.book.bookId}</td>
                        <td>${sk.book.name}</td>
                        <td>${sk.startDate}</td>
                        <td>${sk.againTimes}<c:if test="${sk.isBack!=1 && sk.againTimes<2 }">&nbsp;|&nbsp;<a href="#" onclick="againappoint(${sk.id})">续借</a></c:if></td> 
                        <td width="350px">${sk.book.introd}</td> 
                        <c:if test="${sk.isBack!=1 }"><td><a class="btn btn-primary btn-lg" href="#" onclick="unapprove(${sk.book.bookId})">退借</a></td></c:if>
                        <c:if test="${sk.isBack==1 }"><td>已归还</td></c:if>
                    </tr>
                </c:forEach>
                </tbody>
            </table> 
        </div>

        
    </div>
</div>
<div style="clear:both"></div>
	<div style="">
		<ul class="pager">
			<c:if test="${totalPage>=2 }">
				<c:if test="${totalPage-1>=page}">
					<li><a
						onclick="conditionAndPage('/books/appoint?page=${page+1}')"
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
							onclick="conditionAndPage('/books/appoint?page=${v}')" href="#">${v }</a></li>
					</c:if>
				</c:forEach>
				<c:if test="${page-1>=1}">
					<li><a
						onclick="conditionAndPage('/books/appoint?page=${page-1}')"
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

<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="<%= request.getContextPath()%>/script/jquery.min.js"></script>
<script src="<%= request.getContextPath()%>/script/bootstrap.min.js"></script>
<script type="text/javascript">
function unapprove(bookId){
	var params={};
	params.bookId=bookId;
	var url ='<%= request.getContextPath()%>'+'/books/'+bookId+'/unappoint';
	$.ajax({
		url:url,
		type:'post',
		//contentType: "application/json; charset=utf-8",
		//data:params,
		datatype:'text', 
		async:false,                       //同步调用，保证先执行result=true,后再执行return result;
		success:function(data){
			//alert(data);
			if(data.result=='true'){
				window.location.reload();
				alert("退借成功！");
				result;
			}else if(data.result=='nologin'){
				alert("请先登陆！");
				result;
			}else if(data.result=='error'){
				alert("失败！");
				result;
			}
		},
		error : function(data){
	      alert("进入了error方法"+data);
	 	}
	});
}
function againappoint(id){
	//var params={};
	//params.bookId=bookId;
	var url ='<%= request.getContextPath()%>'+'/books/'+id+'/againappoint';
	$.ajax({
		url:url,
		type:'post',
		//contentType: "application/json; charset=utf-8",
		//data:params,
		datatype:'text', 
		async:false,                       //同步调用，保证先执行result=true,后再执行return result;
		success:function(data){
			//alert(data);
			if(data.result=='true'){
				window.location.reload();
				alert("续借成功！");
				result;
			}else if(data.result=='nologin'){
				alert("请先登陆！");
				result;
			}else if(data.result=='error'){
				alert("失败！");
				result;
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
</body>
</html>