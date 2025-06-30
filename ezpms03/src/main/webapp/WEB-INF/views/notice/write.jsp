<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../include/sidebar.jsp" %>
	
<!-- 메인컨텐츠 시작 -->
<!-- 컨테이너 시작 -->
<script>
	window.onload = function()
	{
		$("#ntitle").focus();
		
		$("#btnSubmit").click(function(){
			DoSubmit();
		});			
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
		
		
		if(confirm("게시물을 등록하시겠습니까?") == true)
		{
			//document.write.submit();
			//$("form").submit();
			$("#write").submit();
		}		
	}
</script>
<div class="w-100">
	<div class="container-fluid">
		<br>
		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h4 class="m-0 font-weight-bold text-primary">공지사항 작성</h6>
			</div>
			<div class="card-body">
				<form id="write" name="write" action="${pageContext.request.contextPath}/notice/writeok.do" method="post" enctype="multipart/form-data">
					<div class="table-responsive">	
						<table class="table align-middle table-bordered" id="dataTable" width="100%" cellspacing="0">
							<tbody>
								<tr>
									<th class="table-primary text-center">제목</th>
									<td colspan="3">
										<input name="ntitle" id="ntitle" class="form-control mr-2" type="text" placeholder="" autofocus>
									</td>
								</tr>
								<tr>
									<th class="table-primary text-center" style="width:10%">작성자</th>
									<td style="width:40%" colspan="3">${ login.name }</td>
								</tr>
								<tr>
									<th class="table-primary text-center" >내용</th>
									<td colspan="3">
										<div style="min-height:300px">
											<textarea name="nnote" id="nnote" class="form-control mr-2" style="height:500px; resize:none;"></textarea>
										</div>
									</td>
								
								</tr>
								<tr>
									<th class="table-primary text-center">첨부파일</th>
									<td colspan="3">
										<input type="file" name="files" id="file" multiple="multiple">
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="" style="width:100%;">
						<button type="button" class="btn btn-outline-danger float-right" onclick="location.href='list.do'" style="width:100px">취소</button>
						
						<!-- submit 변경 -->
						<button type="button" id="btnSubmit" class="btn btn-outline-primary mr-2 float-right" style="width:100px">등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- 컨테이너 끝 -->
<!-- 메인컨텐츠 끝 -->
		
<%@ include file="../include/tail.jsp" %>