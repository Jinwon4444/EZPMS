<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../include/sidebar.jsp" %>

<script>
	window.onload = function()
	{
		$("#ttitle").focus();
		
		$("#btnSubmit").click(function(){
			DoSubmit();
		});			
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
		
		if(confirm("과제를 등록하시겠습니까?") == true)
		{
			$("#taskwrite").submit();
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
				<h4 class="m-0 font-weight-bold text-primary">과제 등록</h6>
			</div>
			<div class="card-body">
				<form id="taskwrite" method="post" action="writeok.do" enctype="multipart/form-data">
					<div class="table-responsive">	
						<table class="table align-middle table-bordered" id="dataTable" width="100%" cellspacing="0">
							<tbody>
								<tr>
									<th class="table-primary text-center">제목</th>
									<td colspan="3">
										<input class="form-control mr-2" id="ttitle" name="ttitle" type="text" placeholder="" autofocus>
									</td>
								</tr>
								<tr>
									<th class="table-primary text-center" style="width:10%">마감일</th>
									<td>
										<input type="datetime-local" id="tend" name="tend" class="form-control d-inline-block mr-2" style="width:250px">
										<input type="hidden" name="lno" value="${ lno }">
									</td>
								</tr>
								<tr>
									<th class="table-primary text-center" >내용</th>
									<td colspan="3">
										<div style="min-height:300px">
											<textarea class="form-control mr-2" id="tnote" name="tnote" style="height:500px; resize:none;"></textarea>
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
						<button type="button" class="btn btn-outline-danger float-right" onclick="location.href='${pageContext.request.contextPath}/task/list.do'" style="width:100px">취소</button>
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