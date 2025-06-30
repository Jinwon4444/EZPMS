<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../include/sidebar.jsp" %>

<script>
function btnExit()
{
	if(confirm("정말로 탈퇴하시겠습니까?"))
	{
		location.href="${pageContext.request.contextPath}/login/exit.do";
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
				<h4 class="m-0 font-weight-bold text-primary">내 정보</h6>
			</div>
			<div class="card-body" style="padding: 100px 300px">
				<div class="table-responsive">	
					<table class="table align-middle table-bordered" id="dataTable" width="100%" cellspacing="0">
						<tbody>
							<tr>
								<th class="table-primary text-center" style="width:15%">이름</th>
								<td>${ data.name }</td>
							</tr>
							<tr>
								<th class="table-primary text-center">성별</th>
								<td>
									<c:if test="${ data.gender eq 'M'}">
										남성
									</c:if>
									<c:if test="${ data.gender eq 'F'}">
										여성
									</c:if>
								</td>
							</tr>
							<tr>
								<th class="table-primary text-center">권한</th>
								<td>
									<c:if test="${ data.level eq 'S'}">
										학생
									</c:if>
									<c:if test="${ data.level eq 'T'}">
										교사
									</c:if>
									<c:if test="${ data.level eq 'M'}">
										관리자
									</c:if>
								</td>
							</tr>
							<tr>
								<th class="table-primary text-center">생년월일</th>
								<td>
									<c:choose>
										<c:when test="${ data.birthday eq '1900-01-01'}">
											-
										</c:when>
										<c:otherwise>
											${ data.birthday }
										</c:otherwise> 
									</c:choose>
								</td>
							</tr>
							<tr>
								<th class="table-primary text-center">전화번호</th>
								<td>${ data.tel }</td>
							</tr>
							<tr>
								<th class="table-primary text-center">이메일</th>
								<td>${ data.email }</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="float-right mb-5" style="width:100%;">
					<c:if test="${data.level eq 'S' or data.level eq 'T'}">
						<button type="button" class="btn btn-outline-primary float-right" onclick="location.href='${pageContext.request.contextPath}/login/pwdmodify.do'" style="width:150px">비밀번호 변경</button>
						<button type="button" class="btn btn-outline-danger float-left" onclick="btnExit()" style="width:150px">회원탈퇴</button>
					</c:if>
				</div>
				<c:if test="${data.level eq 'S'}">
					<div class="text-center mb-3">
						<a href="${pageContext.request.contextPath}/learn/list.do"><strong style="color:red">제출해야 하는 과제가 ${ count } 개 있습니다.</strong></a> 
					</div>
				</c:if>
				<div class="text-center">
					<c:if test="${data.level eq 'S' or data.level eq 'T'}">
					회원정보 변경에 관해선 학사팀에 문의해주시길 바랍니다.
					</c:if>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 컨테이너 끝 -->
<!-- 메인컨텐츠 끝 -->
		
<%@ include file="../include/tail.jsp" %>