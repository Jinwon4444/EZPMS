<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../include/sidebar.jsp" %>

<script>
	window.onload = function()
	{
		$("#ntitle").focus();
		
		$("#btnSubmit").click(function(){
			DoSubmit();
		});			
	}	
	
	function DoCancle(nno)
	{
		if(confirm("공지사항 수정을 취소하시겠습니까?") == true)
		{
			document.location = "view.do?nno=" + nno;
		}
	}

	function DoSubmit()
	{
		if( $("#ntitle").val() == "" )
		{
			alert("제목을 입력하세요.");
			$("#ntitle").focus();
			return;
		}
		if( $("#nnote").val() == "" )
		{
			alert("내용을 입력하세요.");
			$("#nnote").focus();
			return;
		}	
		
		if(confirm("게시물을 변경하시겠습니까?") == true)
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
				<h4 class="m-0 font-weight-bold text-primary">공지사항 수정</h6>
			</div>
			<div class="card-body">
				<form id="modify" name="modify" action="modifyok.do" method="post" enctype="multipart/form-data">
				<input type="hidden" id="nno" name="nno" value="${ item.nno }">
					<div class="table-responsive">	
						<table class="table align-middle table-bordered" id="dataTable" width="100%" cellspacing="0">
							<tbody>
								<tr>
									<th class="table-primary text-center">제목</th>
									<td colspan="3">
										<input name="ntitle" id="ntitle" class="form-control mr-2" type="text" value="${ item.ntitle }" autofocus>
									</td>
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
											<textarea name="nnote" id="nnote" class="form-control mr-2" style="height:500px; resize:none;">${ item.nnote }</textarea>
										</div>
									</td>
								
								</tr>
								<tr>
									<th rowspan="2" class="table-primary text-center">첨부파일</th>
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
										<input type="file" name="files" id="files" multiple="multiple">
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="" style="width:100%;">
						<button type="button" class="btn btn-outline-danger float-right" onclick="DoCancle(${ item.nno })" style="width:100px">취소</button>
						
						<!-- submit 변경 -->
						<button type="button" id="btnSubmit" class="btn btn-outline-primary mr-2 float-right"  style="width:100px">수정 완료</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- 컨테이너 끝 -->
<!-- 메인컨텐츠 끝 -->
		
<%@ include file="../include/tail.jsp" %>