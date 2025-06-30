<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>
<script>
document.getElementById("page-top").className = "bg-gradient-primary";

function btnSubmit()
{
	if( $("#name").val() == "" )
	{
		alert("이름을 입력하세요.");
		$("#name").focus();
		return;
	}
	if( $("#email").val() == "" )
	{
		alert("이메일을 입력하세요.");
		$("#email").focus();
		return;
	}
	if( $("#checkfinish").val() != "Y")
	{
		alert("인증이 완료되지 않았습니다.");
		$("#check").focus();
		return;
	}
	
	$.ajax({
		type: "post",
		url : "idfind.do",
		data :
		{
			name : $("#name").val(),
			email : $("#email").val()
		},
		dataType: "html",
		success : function(data){
			// 통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
			data = data.trim();
			ary = data.split(":");
			code = ary[0]; //Y,N,F,X
			msg  = ary[1];
			if(code == "X")
			{
				alert("아이디가 존재하지 않습니다.");
			} else if(code == "Y")
			{	
				alert("찾으시는 아이디는 " + msg + " 입니다.");
				document.location = "${pageContext.request.contextPath}/login/login.do";
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

function btnCancle()
{
	if(confirm("아이디 찾기를 종료하시겠습니까?") == true)
	{
		document.location = "${pageContext.request.contextPath}/login/login.do";	
	}
}

function btnCheck()
{
	$("#btncheck").text("인증번호 재발송");
	$("#btncheck").attr("disabled", true);
	$("#btncheckok").attr("disabled", false);
	
	$.ajax({
		type: "post",
		url : "mailsend.do",
		data :
		{
			email : $("#email").val()
		},
		dataType: "html",
		success : function(data){
			// 통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
			data = data.trim();
			$("#btncheck").attr("disabled", false);
			if(data == "F")
			{
				alert("이메일 형식이 아닙니다.");
				$("#email").focus();
			} else if(data == "S")
			{
				alert("인증번호가 발송되었습니다.");
				$("#check").focus();
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

function btnCheckOk()
{
	if( $("#check").val() == "" )
	{
		alert("인증번호를 입력하세요.");
		$("#check").focus();
		return;
	}
	
	$.ajax({
		type: "post",
		url : "mailcheck.do",
		data :
		{
			check : $("#check").val()
		},
		dataType: "html",
		success : function(data){
			// 통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
			data = data.trim();
			if(data == "F")
			{
				alert("인증번호가 일치하지 않습니다.");
				$("#check").focus();
			} else if(data == "S")
			{
				alert("인증이 완료되었습니다.");
				$("#checkfinish").val("Y");
				$("#check").attr("readonly", true);
				$("#btncheck").attr("disabled", true);
				$("#btncheckok").attr("disabled", true);
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
								<h1 class="h4 text-gray-900 mb-4">아이디 찾기</h1>
							</div>
							<form class="user">
								<div class="form-group">
									<input type="text" class="form-control form-control-user" id="name" aria-describedby="emailHelp" placeholder="이름">
								</div>
								<div class="form-group d-flex">
									<input type="text" class="form-control form-control-user w-75" id="email" placeholder="e-mail">
									<button type="button" id="btncheck" class="btn btn-outline-primary btn-user w-25 p-0" onclick="btnCheck()">인증번호 받기</button>
								</div>
								<div class="form-group d-flex">
									<input type="text" class="form-control form-control-user w-75" id="check" placeholder="인증번호">
									<input type="hidden" id="checkfinish">
									<button type="button" id="btncheckok" class="btn btn-outline-warning btn-user w-25 p-0" onclick="btnCheckOk()">인증번호 확인</button>
								</div>
								<a href="javascript:btnSubmit()" class="btn btn-primary btn-user btn-block"> 아이디 찾기 </a>
								<a href="javascript:btnCancle()" class="btn btn-danger btn-user btn-block">취소</a>
								<hr>
							</form>
							<div class="d-flex justify-content-between">
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