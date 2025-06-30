<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>
<script>
	document.getElementById("page-top").className = "bg-gradient-primary";
	
	window.onload = function()
	{
		//$("#userid").val("sss");
		//$("#userpw").val("sss");
		
		$("#userid").focus();
		
		$("#btnLogin").click(function(){
			DoLogin();
		});
	}
	
	function SetUser(id,pw)
	{
		$("#userid").val(id);
		$("#userpw").val(pw);		
	}
	
	function DoLogin()
	{
		if( $("#userid").val() == "" )
		{
			alert("아이디를 입력하세요.");
			$("#userid").focus();
			return;
		}
		if( $("#userpw").val() == "" )
		{
			alert("비밀번호를 입력하세요.");
			$("#userpw").focus();
			return;
		}
		$.ajax({
			type: "post",
			url : "loginok.do",
			data :
			{
				userid : $("#userid").val(),
				userpw : $("#userpw").val()
			},
			dataType: "html",
			success : function(data){
				// 통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
				data = data.trim();
				if(data == "ERROR")
				{
					alert("아이디 또는 비밀번호가 일치하지 않습니다.");
				} else if(data == "NOT")
				{
					alert("탈퇴 상태인 회원입니다.");
				} else if(data == "S")
				{
					document.location = "${pageContext.request.contextPath}/login/mypage.do";	
				} else if(data == "T")
				{
					document.location = "${pageContext.request.contextPath}/login/mypage.do";	
				} else if(data == "M")
				{	
					document.location = "${pageContext.request.contextPath}/mgrmember/list.do";
				} else
				{
					alert("비정상적인 접근입니다.");
				}
			},
			error: function(xhr, status, error){
				// 통신 오류 발생시	
			},
			complete : function(){
				// 통신이 성공하거나 실패했어도 마지막으로 이 함수를 타게된다.
			}			
		});
	}
</script>

<div class="container">
	<!-- Outer Row -->
	<div class="row justify-content-center">
		<div class="col-xl-5 col-md-7 mt-5 pt-5"><br><br><br><br><br>
			<div class="card o-hidden border-0 shadow-lg my-5">
				<div class="card-body p-0">
				<!-- Nested Row within Card Body -->
					<div class="w-100">
						<div class="p-5">
							<div class="text-center">
								<h1 class="h4 text-gray-900 mb-4">로그인</h1>
							</div>
							<form class="user" id="login" name="login">
								<div class="form-group">
									<input type="text" class="form-control form-control-user" name="userid" id="userid" placeholder="ID">
								</div>
								<div class="form-group">
									<input type="password" class="form-control form-control-user" name="userpw" id="userpw" placeholder="Password">
								</div>
								<div class="form-group text-center pt-3">
									<button type="button" class="btn btn-primary btn-user" id="btnLogin" style="width:150px">Login</button>
								</div>
								<hr>
							</form>
							<a href="javascript:SetUser('teacher1','teacher1234')">교사</a><br>
							<a href="javascript:SetUser('sss1','sss1234')">학생1</a><br>
							<a href="javascript:SetUser('ezen','ezen1234')">관리자</a><br>
							<div class="d-flex justify-content-between">
								<div>
									<a class="small" href="${pageContext.request.contextPath}/login/idfind.do">아이디 찾기</a>
								</div>
								<div>
									<a class="small" href="${pageContext.request.contextPath}/login/pwdfind.do">비밀번호 찾기</a>
								</div>
								<div>
									<a class="small" href="${pageContext.request.contextPath}/login/join.do">회원가입</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="../include/tail.jsp" %>