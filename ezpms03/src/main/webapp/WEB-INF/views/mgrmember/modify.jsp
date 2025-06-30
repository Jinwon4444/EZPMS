<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../include/sidebar.jsp" %>

<script>
	window.onload = function()
	{
		emailData = "${ data.email }"; 
		
		$("#exampleInputEmail").keyup(function(){
			DupCheckEmail();
		});
		
		$("#btnSubmit").click(function(){
			DoSubmit();
		});
		$("#btnModifypw").click(function(){
			doModifypw();
		});
		$("#btnMemberIn").click(function(){
			doMemberRestore();
		});
		$("#btnCancel").click(function(){
			window.history.back();	
		});
		
		if( $("#birthday").val() == "1900-01-01" )
		{
			$("#birthday").val("");
		}
	}
	
	function DoSubmit()
	{
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
		if( $("#birthday").val() == "" )
		{
			$("#birthday").val("1900-01-01");
		}
		if( $("#exampleInputEmail").val() == "")
		{
			alert("이메일을 입력하세요.");
			$("#exampleInputEmail").focus();
			return;
		}
		
		if(!($("#msgemail").text() == "현재 이메일 주소입니다." || $("#msgemail").text() == "사용가능한 이메일입니다."))
		{
			alert("이메일을 다시 체크하세요.");
			$("#exampleInputEmail").focus();
			return;
		}
		
		if( confirm("회원정보 수정을 완료하시겠습니까?") == true)
		{
			$("#modify").submit();
		}
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
		if(email == emailData)
		{
			$("#msgemail").html("현재 이메일 주소입니다.");
			return;
		}
		
		$.ajax({
			type: "get",
			url : "${pageContext.request.contextPath}/login/emailcheck.do?email=" + email,
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
	
	function doModifypw()
	{
		document.location = "${pageContext.request.contextPath}/login/pwdmodify.do?userid=${ data.userid }";
	}
	
	function doMemberRestore()
	{
		document.location = "${pageContext.request.contextPath}/mgrmember/restore.do?userid=${ data.userid }";
	}
</script>
<div class="w-100">
<!-- 관리자 list 템플릿 시작 -->
	<!-- 회원목록 시작 -->
	<div class="container-fluid">
		<br>
		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h4 class="m-0 font-weight-bold text-primary">회원정보 수정</h4>
			</div>
			<div class="card-body" style="padding: 100px 200px">
				<div class="table-responsive">
					<form id="modify" name="modify" method="post" action="${pageContext.request.contextPath}/mgrmember/modify.do">	
						<table class="table align-middle border border-left-0 border-right-0 text-center" id="dataTable" cellspacing="0">
							<tbody>
								<tr>
									<td class="text-left pl-4" style="width:15%;">아이디</td>
									<td class="text-left">
										${ data.userid }
									</td>
									<td style="width:5%; color:red;"></td>
								</tr>
								<tr>
									<td class="text-left pl-4">이름</td>
									<td>
										<input class="form-control mr-2" name="name" id="name" type="text" value="${ data.name }" >
									</td>
									<td style="width:5%; color:red;">*</td>
								</tr>
								<tr>
									<td class="text-left pl-4">전화번호</td>
									<td>
										<input class="form-control mr-2" name="tel" id="tel" type="text" value="${ data.tel }">
									</td>
									<td style="width:5%; color:red;">*</td>
								</tr>
								<tr>
									<td class="text-left pl-4">생년월일</td>
									<td>
										<input type="date" class="form-control float-left w-25" name="birthday" id="birthday" value="${ data.birthday }">
									</td>
									<td style="width:5%; color:red;">*</td>
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
										<input type="email" class="form-control form-control-user float-left" name="email" id="exampleInputEmail" aria-describedby="emailHelp" placeholder="@gmail.com" value="${ data.email }">
										<div id="msgemail" class="text-left pl-2">현재 이메일 주소입니다.</div>
										<input type="hidden" name="userid" value="${ data.userid }">
									</td>
									<td style="width:5%; color:red;">*</td>
								</tr>
							</tbody>
						</table>
					</form>
					<div style="width:100%;">
						<button type="button" class="btn btn-danger" style="width:130px" id="btnModifypw">비밀번호 변경</button>
						<c:if test="${ data.state eq 'N' }">
							<button type="button" class="btn btn-primary" style="width:100px" id="btnMemberIn">회원 복구</button>
						</c:if>
						<button type="button" class="btn btn-outline-danger float-right" id="btnCancel" style="width:100px">취소</button>
						<button type="button" class="btn btn-outline-primary mr-3 float-right" id="btnSubmit" style="width:100px">수정 완료</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 회원목록 끝 -->
<!-- 관리자 list 템플릿 시작 -->
</div>

<%@ include file="../include/tail.jsp" %>