<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../include/sidebar.jsp" %>


<script>
function DoDelete(nno)
{
	if(confirm("해당 게시물을 삭제하시겠습니까?") == false)
	{
		return;	
	}
	document.location = "delete.do?nno=" + nno;
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
				<h4 class="m-0 font-weight-bold text-primary">공지사항 상세</h4>
			</div>
			<div class="card-body">
				<div class="table-responsive">	
					<table class="table align-middle table-bordered" id="dataTable" width="100%" cellspacing="0">
						<tbody>
							<tr>
								<th class="table-primary text-center">제목</th>
								<td colspan="3">${ item.ntitle }</td>
							</tr>
							<tr>
								<th class="table-primary text-center" style="width:10%">작성자</th>
								<td style="width:40%">${ item.name }</td>
								<th class="table-primary text-center" style="width:10%">작성일</th>
								<td>${ item.ndate }</td>
							</tr>
							<tr>
								<th class="table-primary text-center" >내용</th>
								<td colspan="3">
									<div style="min-height:300px">
									${ item.nnote }
									</div>
								</td>
							
							</tr>
							<tr>
								<th class="table-primary text-center">첨부파일</th>
								<td colspan="3">
									<c:choose>
										<c:when test="${ empty files }">
										첨부파일이 없습니다.
										</c:when>
										<c:otherwise>
											<!-- files는 VO List이므로 file에 하나씩 대입하기때문에 fname은 file.fname이 된다 -->
											<c:forEach var="file" items="${ files }">
												<a href="down.do?name=${ file.fname }&file=${ file.pname }">${file.fname}</a><br>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="float-right" style="width:100%;">
					<button type="button" class="btn btn-outline-primary" onclick="location.href='${pageContext.request.contextPath}/notice/list.do'" style="width:100px">목록</button>
					<c:if test="${login.userid eq item.userid or login.level eq 'M'}">
						<button type="button" class="btn btn-outline-danger float-right" onclick="DoDelete(${ item.nno })" style="width:100px">삭제</button>
						<button type="button" class="btn btn-outline-primary mr-2 float-right" onclick="location.href='${pageContext.request.contextPath}/notice/modify.do?nno=${ item.nno }'" style="width:100px">수정</button>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 컨테이너 끝 -->
<!-- 메인컨텐츠 끝 -->
		
<%@ include file="../include/tail.jsp" %>