<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../include/sidebar.jsp" %>

<script>

	function btnSubmit()
	{
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
		
		if( $("#sign").val() == "")
		{
			alert("자동방지 가입코드를 입력하세요.");
			$("#sign").focus();
			return;
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
					alert("매크로 방지 코드가 일치하지 않습니다.");
				}else
				{
					//코드가 일치함.
					if( confirm("비밀번호를 변경하시겠습니까?") == true)
					{
						$("#modifypwd").submit();
						alert("비밀번호가 변경되었습니다.");
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
	
	function btnCancle()
	{
		if(${ data.level eq "M"})
		{
			document.location = "${pageContext.request.contextPath}/mgrmember/list.do";
		} else
		{
			document.location = "${pageContext.request.contextPath}/login/mypage.do";	
		}
	}
</script>

<!-- 메인컨텐츠 시작 -->
<!-- 컨테이너 시작 -->
<div class="w-100">
	<div class="container-fluid">
		<br>
		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h4 class="m-0 font-weight-bold text-primary">비밀번호 변경</h6>
			</div>
			<div class="card-body" style="padding: 100px 300px">
				<div class="p-5" id="findpw" name="findpw">
					<c:if test="${memberid ne ''}">
						<div class="form-group">
							비밀번호 변경할 회원 아이디 : ${ memberid }
						</div>
					</c:if>
					<form class="user" id="modifypwd" method="post" action="${pageContext.request.contextPath}/login/pwdmodify.do">
						<div class="form-group">
							<c:if test="${ data.level eq 'M'}">
								<input type="hidden" name="selectid" value="${ memberid }">
							</c:if>
							<input type="password" id="userpw" name="userpw" class="form-control form-control-user" placeholder="변경할 비밀번호">
						</div>
						<div class="form-group d-flex">
							<input type="password" id="checkpw" class="form-control form-control-user" placeholder="비밀번호 확인">
						</div>
						<div class="form-group text-center">
							<div>자동 방지 문자</div>
							<div class="mb-3"><img src="${pageContext.request.contextPath}/login/sign.do"></div>
							<div><input type="text" class="form-control form-control-user" id="sign" name="sign" size="15" placeholder="자동방지문자 입력"></div>
						</div>
						<a href="javascript:btnSubmit()" class="btn btn-primary btn-user btn-block">변경완료</a>
						<a href="javascript:btnCancle()" class="btn btn-danger btn-user btn-block">취소</a>
						<hr>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 컨테이너 끝 -->
<!-- 메인컨텐츠 끝 -->

<%@ include file="../include/tail.jsp" %>