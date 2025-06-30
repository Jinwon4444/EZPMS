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
function DoSign(lno)
{
	if(confirm("해당 과목을 수강신청 하시겠습니까?") == false)
	{
		return;	
	}
	document.location = "signok.do?lno=" + lno;
}
</script>
	

<div class="w-100">
<!-- 수강 list 템플릿 시작 -->
	<!-- 수강신청 시작 -->
	<div class="container-fluid">
		<br>
		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h4 class="m-0 font-weight-bold text-primary">수강 신청</h4>
			</div>
			<div class="card-body">
				<div class="row mb-2">
					<form action="signlist.do" class="d-flex justify-content-sm-end float-right" role="search">
						<select name="day" id="day" class="form-select" aria-label="Default select example" style="width: 120px">
							<option value="day" selected>요일전체</option>
							<option value="월요일">월요일</option>
							<option value="화요일">화요일</option>
							<option value="수요일">수요일</option>
							<option value="목요일">목요일</option>
							<option value="금요일">금요일</option>
						</select>
						<select  name="index" class="form-select" aria-label="Default select example" style="width: 120px">
							<option value="l.ltitle" selected>강의명</option>
							<option value="u.name">담당교수</option>
						</select>
				        <input  name="keyword" class="form-control mr-2" type="search" placeholder="Search" aria-label="Search" style="width: 300px">
				        <button class="btn btn-outline-primary" type="submit">Search</button>
					</form>
				</div>
				<div class="table-responsive">	
					<table class="table align-middle table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
						<thead class="align-middle table-primary">
							<tr>
								<!--  class="d-none"를 추가하여 학생에게는 checkbox를 숨겨야함 -->
								<th>번호</th>
								<th>강의명</th>
								<th>강의기간</th>
								<th>강의시간</th>
								<th>담당교수</th>
								<th><div style="min-width:60px">수강신청</div></th>
							</tr>
						</thead>
						<tbody>
							<c:set var="seqno" value="${ total - ((search.pageno - 1) * 10) + 1 }"></c:set>
							<c:forEach var="item" items="${ list }">
								<tr>
									<td>${ seqno = seqno - 1 }</td>
									<td  class="position-relative text-left"><a href="${pageContext.request.contextPath}/learn/view.do?lno=${ item.lno }&from=signlist" class="stretched-link">${ item.ltitle }</a></td>
									<td>${ item.lstart }~${ item.lend }</td>
									<td>${ item.ltime }</td>
									<td>${ item.name }</td>
									<td><button type="button" class="btn btn-outline-warning" style="width:100px" onclick="DoSign(${ item.lno })">수강신청</button></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<ul class="pagination">
						<c:set var="index" value="${search.index}" />
						<c:set var="keyword" value="${search.keyword}" />
						<c:set var="day" value="${search.day}" />
						<c:if test="${ startbk > 10 }"> 
							<li class="paginate_button page-item previous" id="dataTable_previous"><a href="list.do?page=${startbk - 1}&index=${index}&keyword=${keyword}" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>
						</c:if> 
					 	<c:forEach var="page" begin="${startbk}" end="${endbk}">
					 		<c:choose>
					 			<c:when test="${page == search.pageno}"> 
						 			<li class="paginate_button page-item active">
						 			<a href="signlist.do?page=${page}&index=${index}&keyword=${keyword}&day=${day}" aria-controls="dataTable" data-dt-idx="${page}" tabindex="0" class="page-link">${page}</a></li>
					 			</c:when>
					 			<c:otherwise>
							 		<li class="paginate_button page-item">
							 		<a href="signlist.do?page=${page}&index=${index}&keyword=${keyword}&day=${day}" aria-controls="dataTable" data-dt-idx="${page}" tabindex="0" class="page-link">${page}</a></li>
						 		</c:otherwise>
					 		</c:choose>
					 	</c:forEach>
					 	<c:if test="${ endbk < maxpage }"> 
					 		<li class="paginate_button page-item next" id="dataTable_next"><a href="list.do?page=${endbk + 1}&index=${index}&keyword=${keyword}" aria-controls="dataTable" data-dt-idx="7" tabindex="0" class="page-link">Next</a></li>
					 	</c:if>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- 수강신청 끝 -->
<!-- 수강 list 템플릿 끝 -->
</div>
		
<%@ include file="../include/tail.jsp" %>