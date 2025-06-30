<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../include/sidebar.jsp" %>

<script>
function DoCancle()
{
	if(confirm("과제 수정을 취소하시겠습니까?") == true)
	{
		document.location = "${pageContext.request.contextPath}/task/view.do?tno="+${item.tno};
	}
}

function DoSubmit()
{
	if( $("#ttitle").val() == "" )
	{
		alert("제목을 입력하세요.");
		$("#ttitle").focus();
		return;
	}
	if( $("#tnote").val() == "" )
	{
		alert("내용을 입력하세요.");
		$("#tnote").focus();
		return;
	}
	if( $("#tend").val() == "" )
	{
		alert("마감일을 선택하세요.");
		$("#tend").focus();
		return;
	}
	
	if(confirm("과제를 수정하시겠습니까? 수정 시 예전 파일은 무조건 삭제됩니다.") == true)
	{
		$("#modify").submit();
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
				<h4 class="m-0 font-weight-bold text-primary">과제 수정</h6>
			</div>
			<div class="card-body">
				<form id="modify" action="modifyok.do" method="post" enctype="multipart/form-data">
					<div class="table-responsive">
						<table class="table align-middle table-bordered" id="dataTable" width="100%" cellspacing="0">
							<tbody>
								<tr>
									<th class="table-primary text-center">제목</th>
									<td colspan="3">
										<input name="ttitle" id="ttitle" class="form-control mr-2" type="text" value="${ item.ttitle }" autofocus>
										<input type="hidden" name="tno" value="${ item.tno }">
									</td>
								</tr>
								<tr>
									<th class="table-primary text-center" style="width:10%">마감일</th>
									<td>
										<input type="datetime-local" id="tend" name="tend" class="form-control d-inline-block mr-2" style="width:250px" value="${ item.tend }">
									</td>
								</tr>
								<tr>
									<th class="table-primary text-center" >내용</th>
									<td colspan="3">
										<div style="min-height:300px">
											<textarea name="tnote" id="tnote" class="form-control mr-2" style="height:500px; resize:none;">${ item.tnote }</textarea>
										</div>
									</td>
								</tr>
								<tr>
									<th class="table-primary text-center" rowspan="2">첨부파일</th>
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
								<tr>
									<td colspan="3">
										<input type="file" name="files" id="files" multiple="multiple" name="files">
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="" style="width:100%;">
						<button type="button" class="btn btn-outline-danger float-right" onclick="DoCancle()" style="width:100px">취소</button>
						
						<button type="button" class="btn btn-outline-primary mr-2 float-right" onclick="DoSubmit()" style="width:100px">수정 완료</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- 컨테이너 끝 -->
<!-- 메인컨텐츠 끝 -->
		
<%@ include file="../include/tail.jsp" %>