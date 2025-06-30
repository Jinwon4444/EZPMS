<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../include/sidebar.jsp" %>
<script>
function DoSub(tno)
{
	if( $("#answer").val() == "" )
	{
		alert("답안을 입력하세요.");
		$("#answer").focus();
		return;
	}
	
	if(confirm("과제를 수정하시겠습니까?") == true)
	{
		$("#taskmodify").submit();
	}
}
function DoCancle(tno)
{
	if(confirm("공지사항 수정을 취소하시겠습니까?") == true)
	{
		document.location = "taskview.do?tno=" + tno;
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
				<form action="taskmodifyok.do" id="taskmodify" name="taskmodify" method="post" enctype="multipart/form-data">
				<input type="hidden" name="tend" value="${ item.tend }">
				<input type="hidden" name="sno" value="${ subitem.sno }">
				<input type="hidden" name="tno" value="${ item.tno }">
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
									<th class="table-primary text-center">내용</th>
									<td colspan="3">
										<div style="min-height:200px">
											${ item.tnote }
										</div>
									</td>
								</tr>
								<tr>
									<th class="table-primary text-center">답안</th>
									<td colspan="3">
										<div style="min-height:300px">
											<textarea name="answer" id="answer" class="form-control mr-2" style="height:300px; resize:none;" placeholder="과제 작성란입니다.">${ subitem.answer }</textarea>
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
										<input type="file" multiple="multiple" name="files">
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="" style="width:100%;">
						<button type="button" class="btn btn-outline-danger float-right" onclick="DoCancle(${ item.tno })" style="width:100px">취소</button>
						
						<!-- submit 변경 -->
						<button type="button" class="btn btn-outline-primary mr-2 float-right" onclick="DoSub(${ item.tno })" style="width:100px">수정 완료</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- 컨테이너 끝 -->
<!-- 메인컨텐츠 끝 -->

<%@ include file="../include/tail.jsp" %>