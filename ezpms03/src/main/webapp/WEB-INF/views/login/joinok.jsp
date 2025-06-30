<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>
<script>
document.getElementById("page-top").className = "bg-gradient-primary";
</script>


<div class="container">
	<!-- Outer Row -->
	<div class="row justify-content-center">
		<div class="col-xl-5 col-md-7 mt-5 pt-5"><br><br><br><br><br>
			<div class="card o-hidden border-0 shadow-lg my-5">
				<div class="card-body p-0">
					<!-- Nested Row within Card Body -->
					<div class="w-100">
						<div class="pt-5 pb-4">
							<div class="text-center">
								<h1 class="h4 text-gray-900 my-4">회원가입이 완료되었습니다.</h1>
							</div>
						</div>
						<div style="width:100%; text-align: center">
							<button type="button" class="btn btn-primary my-4" onclick="location.href='${pageContext.request.contextPath}/login/login.do'" style="width:150px">확인</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="../include/tail.jsp" %>