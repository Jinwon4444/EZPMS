<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>	
<%@ include file="../include/sidebar.jsp" %>


<c:if test="${param.msg == 'duplicate'}">
    <script>
        alert("이미 수강중인 과목입니다.");
    </script>
</c:if>
<c:if test="${param.msg == 'success'}">
    <script>
        alert("수강신청이 완료되었습니다.");
    </script>
</c:if>

<script>
function DoList() 
{
	if ( ${from eq 'signlist'} ) 
	{
		location.href = '${pageContext.request.contextPath}/learn/signlist.do';
	} 
	else 
	{
		location.href = '${pageContext.request.contextPath}/learn/list.do';
	}
}

function DoSign(lno)
{
	if(confirm("해당 과목을 수강신청 하시겠습니까?") == false)
	{
		return;	
	}
	document.location = "signok.do?lno=" + lno;
}

function DoDelete(lno)
{
	if(confirm("해당 과목을 수강포기 하시겠습니까?") == false)
	{
		return;	
	}
	document.location = "delete.do?lno=" + lno;
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
				<h4 class="m-0 font-weight-bold text-primary">강의 상세</h6>
			</div>
			<div class="card-body">
				<form action="#" method="post" enctype="multipart/form-data">
					<div class="table-responsive">	
						<table class="table align-middle table-bordered" id="dataTable" width="100%" cellspacing="0">
							<tbody>
								<tr>
									<th class="table-primary text-center" style="width:10%">강의명</th>
									<td colspan="3">
										${ item.ltitle }
									</td>
								</tr>
								<tr>
									<th class="table-primary text-center" >담당교수</th>
									<td style="width:40%" colspan="3">${ item.name }</td>
								</tr>
								<tr>
									<th class="table-primary text-center" >강의기간</th>
									<td style="width:40%">
										${ item.lstart } ~ ${ item.lend } / ${ item.ltime }
									</td>
									<th class="table-primary text-center" style="width:10%">수강인원</th>
									<td>
										${ item.llimit }
									</td>
								</tr>
								<tr>
									<th class="table-primary text-center" >내용</th>
									<td colspan="3">
										<div style="min-height:300px">
											${ item.lnote }
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
					<div class="" style="width:100%;">
						<button type="button" class="btn btn-outline-primary" onclick="DoList()" style="width:100px">목록</button>
						<c:choose>
							<c:when test="${from eq 'signlist'}">
								<!-- 수강신청 안 되어 있음 -->
								<button type="button" class="btn btn-outline-warning float-right" style="width:100px" onclick="DoSign(${ item.lno })">수강신청</button>
							</c:when>
							<c:otherwise>
								<!-- 수강신청 되어 있음 -->
								<button type="button" class="btn btn-outline-danger float-right" style="width:100px" onclick="DoDelete(${ item.lno })">수강포기</button>
							</c:otherwise>
						</c:choose>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- 컨테이너 끝 -->
<!-- 메인컨텐츠 끝 -->
		
<%@ include file="../include/tail.jsp" %>