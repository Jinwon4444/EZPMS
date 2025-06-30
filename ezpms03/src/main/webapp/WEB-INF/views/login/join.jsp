<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>
<script>
	document.getElementById("page-top").className = "bg-gradient-primary";
	
	window.onload = function()
	{
		$("#userid").keyup(function(){
			DupCheckID();
		});
		
		$("#exampleInputEmail").keyup(function(){
			DupCheckEmail();
		});
		
		$("#btnSubmit").click(function(){
			DoSubmit();
		});
		
		if( $("#birthday").val() == "1900-01-01" )
		{
			$("#birthday").val("");
		}
		
		$("#btnCancel").click(function(){
			if(confirm("회원가입을 취소하시겠습니까?") == true)
			{
				document.location = "login.do";	
			}
		});
	}
	
	function DoSubmit()
	{
		if( $("#userid").val() == "" )
		{
			alert("아이디를 입력하세요.");
			$("#userid").focus();
			return;
		}
		if(idCheck == "Y")
		{
			alert("중복된 아이디이므로 가입을 진행 할 수 없습니다.");
			$("#userid").focus();
			return;
		}
		if( $("#userpw").val() == "" )
		{
			alert("비밀번호를 입력하세요.");
			$("#userpw").focus();
			return;
		}	
		if( $("#userpw").val() != $("#checkpw").val() )
		{
			alert("비밀번호가 일치하지 않습니다.");
			$("#userpw").focus();
			return;
		}	
		if( $("#name").val() == "" )
		{
			alert("이름을 입력하세요.");
			$("#name").focus();
			return;
		}
		if( $("#tel").val() == "" )
		{
			alert("전화번호를 입력하세요.");
			$("#tel").focus();
			return;
		}
		if( $("#exampleInputEmail").val() == "")
		{
			alert("이메일을 입력하세요.");
			$("#exampleInputEmail").focus();
			return;
		}
		if(emailCheck == "Y")
		{
			alert("중복된 이메일이므로 가입을 진행 할 수 없습니다.");
			$("#exampleInputEmail").focus();
			return;
		}
		if( $("#sign").val() == "")
		{
			alert("자동방지 가입코드를 입력하세요.");
			$("#sign").focus();
			return;
		}
		if( $("#birthday").val() == "" )
		{
			$("#birthday").val("1900-01-01");
		}
		
		$.ajax({
			type: "get",
			url : "getsign.do",
			dataType: "html",
			success : function(data){
				// 통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
				data = data.trim();
				if( data != $("#sign").val() )
				{
					//코드가 일치 하지 않음
					alert("자동가입 방지 코드가 일치하지 않습니다.");
				}else
				{
					//코드가 일치함.
					if( confirm("회원가입을 진행하시겠습니까?") == true)
					{
						$("#join").submit();
					}
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
	
	//아이디 실시간 검사
	function DupCheckID()
	{
		userid = $("#userid").val();
		if( userid == "" )
		{
			$("#msgid").html("아이디를 입력하세요.");
			return;
		}
		$.ajax({
			type: "get",
			url : "idcheck.do?id=" + userid,
			dataType: "html",
			success : function(data){
				// 통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
				data = data.trim();
				ary = data.split(":");
				code = ary[0]; //Y,N,X
				msg  = ary[1];
				idCheck = code;
				if(idCheck == "Y")
				{
					$("#msgid").html("<span style='color:red'>"+msg+"</span>");	
				} else
				{
					$("#msgid").html("<span style='color:black'>"+msg+"</span>");
				}
			},
			error: function(xhr, status, error){
				$("#msgemail").html("<span style='color:red'>아이디 형식이 아닙니다.</span>");
			},
			complete : function(){
				// 통신이 성공하거나 실패했어도 마지막으로 이 함수를 타게된다.
			}			
		});
	}
	
	//이메일 실시간 검사
	function DupCheckEmail()
	{
		email = $("#exampleInputEmail").val();
		if( email == "" )
		{
			$("#msgemail").html("이메일을 입력하세요.");
			return;
		}
		$.ajax({
			type: "get",
			url : "emailcheck.do?email=" + email,
			dataType: "html",
			success : function(data){
				// 통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
				data = data.trim();
				ary = data.split(":");
				code = ary[0]; //Y,N,F,X
				msg  = ary[1];
				emailCheck = code;
				if(emailCheck == "Y" || emailCheck == "F")
				{
					$("#msgemail").html("<span style='color:red'>"+msg+"</span>");	
				} else
				{
					$("#msgemail").html("<span style='color:black'>"+msg+"</span>");
				}
			},
			error: function(xhr, status, error){
				$("#msgemail").html("<span style='color:red'>이메일 형식이 아닙니다</span>");
			},
			complete : function(){
				// 통신이 성공하거나 실패했어도 마지막으로 이 함수를 타게된다.
			}			
		});
	}
</script>
		
<div class="w-100">
<!-- 관리자 list 템플릿 시작 -->
	<!-- 회원목록 시작 -->
	<div class="container-fluid" style="width:1000px">
		<br>
		<!-- DataTales Example -->
		<div class="card shadow mt-5">
			<div class="card-header py-3">
				<h4 class="m-0 font-weight-bold text-primary">회원가입</h4>
			</div>
			<div class="card-body" style="padding: 50px 100px">
				<div class="table-responsive">
					<div class="text-right"><span style="color:red;">*</span> 표시된 항목은 필수입력입니다.</div>
					<form id="join" name="join" method="post" action="${pageContext.request.contextPath}/login/joinok.do">
						<table class="table align-middle border border-left-0 border-right-0 text-center" id="dataTable" cellspacing="0">
							<tbody>
								<tr>
									<td class="text-left pl-4" style="width:25%;">아이디</td>
									<td>
										<input class="form-control mr-2" name="userid" id="userid" type="text" autofocus placeholder="아이디는 영문자와 숫자로만 입력하세요">
										<div id="msgid" class="text-left pl-2">아이디를 입력하세요.</div>
									</td>
									<td style="width:5%; color:red;">*</td>
								</tr>
								<tr>
									<td class="text-left pl-4">비밀번호</td>
									<td>
										<input class="form-control mr-2" name="userpw" id="userpw" type="text" placeholder="비밀번호는 영문자와 숫자로만 입력하세요">
									</td>
									<td style="width:5%; color:red;">*</td>
								</tr>
								<tr>
									<td class="text-left pl-4">비밀번호 확인</td>
									<td>
										<input class="form-control mr-2" id="checkpw" type="text" placeholder="비밀번호 확인">
									</td>
									<td style="width:5%; color:red;">*</td>
								</tr>
								<tr>
									<td class="text-left pl-4">이름</td>
									<td>
										<input class="form-control mr-2" name="name" id="name" type="text" placeholder="이름은 한글로만 입력하세요">
									</td>
									<td style="width:5%; color:red;">*</td>
								</tr>
								<tr>
									<td class="text-left pl-4">전화번호</td>
									<td>
										<input class="form-control mr-2" name="tel" id="tel" type="text" placeholder="전화번호는 숫자로만 입력하세요">
									</td>
									<td style="width:5%; color:red;">*</td>
								</tr>
								<tr>
									<td class="text-left pl-4">생년월일</td>
									<td>
										<input type="date" class="form-control float-left w-25" name="birthday" id="birthday">
									</td>
								</tr>
								<tr>
									<td class="text-left pl-4">성별</td>
									<td>
										<select class="form-select float-left w-25" name="gender" aria-label="Default select example">
											<option value="M" selected>남성</option>
											<option value="F">여성</option>
										</select>
									</td>
									<td style="width:5%; color:red;">*</td>
								</tr>
								<tr>
									<td class="text-left pl-4">이메일</td>
									<td>
										<input type="email" class="form-control form-control-user" name="email" id="exampleInputEmail" aria-describedby="emailHelp" placeholder="@gmail.com" >
										<div id="msgemail" class="text-left pl-2">이메일을 입력하세요.</div>
										<input type="hidden" name="level" value="S">
									</td>
									<td style="width:5%; color:red;">*</td>
								</tr>
								<tr>
									<td class="text-left pl-4" rowspan="2">자동가입 방지 문자</td>
									<td class="text-left">
										<img src="${pageContext.request.contextPath}/login/sign.do">
									</td>
									<td style="width:5%; color:red;"></td>
								</tr>
								<tr>
									<td class="text-left">
										<input type="text" id="sign" name="sign" size="10">
									</td>
									<td style="width:5%; color:red;">*</td>
								</tr>
							</tbody>
						</table>
						<div style="width:100%; text-align: center">
							<button type="button" class="btn btn-outline-primary mr-5" id="btnSubmit" style="width:150px">회원 가입</button>
							<button type="button" class="btn btn-outline-danger" id="btnCancel" style="width:150px">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- 회원목록 끝 -->
<!-- 관리자 list 템플릿 시작 -->
</div>

<%@ include file="../include/tail.jsp" %>