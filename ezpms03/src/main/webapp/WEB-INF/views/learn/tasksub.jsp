<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../include/sidebar.jsp" %>

<c:if test="${param.msg == 'fails'}">
    <script>
        alert("과제 제출 권한이없습니다.");
    </script>
</c:if>
<script>
function DoSub(tno)
{
	if( $("#answer").val() == "" )
	{
		alert("답안을 입력하세요.");
		$("#answer").focus();
		return;
	}
	
	if(confirm("과제를 제출하시겠습니까?") == true)
	{
		$("#tasksub").submit();
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
				<h4 class="m-0 font-weight-bold text-primary">과제 제출</h6>
			</div>
			<div class="card-body">
				<form action="tasksubok.do" id="tasksub" name="tasksub" method="post" enctype="multipart/form-data">
					<input type="hidden" name="tno" value="${ item.tno }">
					<input type="hidden" name="tend" value="${ item.tend }">
					<div class="table-responsive">	
						<table class="table align-middle table-bordered" id="dataTable" width="100%" cellspacing="0">
							<tbody>
								<tr>
									<th class="table-primary text-center">과제</th>
									<td colspan="3">
										${ item.ttitle }
									</td>
								</tr>
								<tr>
									<th class="table-primary text-center" style="width:10%">마감일</th>
									<td>
										${ item.tend }
									</td>
								</tr>
								<tr>
									<th class="table-primary text-center" rowspan="2" >내용</th>
									<td colspan="3">
										<div style="min-height:200px">
											${ item.tnote }
										</div>
									</td>
								</tr>
								<tr>
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
									<th class="table-primary text-center">답안</th>
									<td colspan="3">
										<div style="min-height:300px">
											<textarea name="answer" id="answer" class="form-control mr-2" style="height:300px; resize:none;" placeholder="과제 작성란입니다."></textarea>
										</div>
									</td>
								</tr>
								<tr>
									<th class="table-primary text-center">첨부파일</th>
									<td colspan="3">
										<input type="file" multiple="multiple" name="files">
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="" style="width:100%;">
						<button type="button" class="btn btn-outline-danger float-right" onclick="location.href='tasklist.do?lno=${ item.lno }'" style="width:100px">취소</button>
						
						<!-- submit 변경 -->
						<button type="button" class="btn btn-outline-primary mr-2 float-right" onclick="DoSub(${ item.tno })" style="width:100px">과제 제출</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- 컨테이너 끝 -->
<!-- 메인컨텐츠 끝 -->
		
<%@ include file="../include/tail.jsp" %>