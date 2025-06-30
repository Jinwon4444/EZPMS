<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../include/sidebar.jsp" %>

<script>
function subDelete()
{
	var nno_list = "";
	
	$("input:checkbox[name='nno']").each(function() {
		if( this.checked == true)
		{
			if(nno_list != "") nno_list += ",";
			nno_list += this.value;	
		}
	});	
	//alert(nno_list);
	if( confirm("선택된 자료를 삭제하시겠습니까?") == false)
	{
		return;	
	}
	document.location = "delete.do?nno=" + nno_list;
}

function SetCheck()
{
	$("input:checkbox[name='nno']").each(function() {
		this.checked = $("#chkAll").is(":checked");
	});
}

</script>
<div class="w-100">
	<!-- 메인컨텐츠 시작 -->
	<!-- 컨테이너 시작 -->
	<div class="container-fluid">
		<br>
		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h4 class="m-0 font-weight-bold text-primary">공지사항</h6>
			</div>
			<div class="card-body">
				<div class="row">
					<div class="col-sm-12 col-md-6 mb-2">
						<c:if test="${ level eq 'M' or level eq 'T' }">
							<button type="button" class="btn btn-outline-primary" onclick="location.href='${pageContext.request.contextPath}/notice/write.do'">공지등록</button>
						</c:if>
						<c:if test="${ level eq 'M' }">
							<button type="button" class="btn btn-outline-danger" onclick="subDelete()">삭제</button>
							<form id="deleteForm" action="delete.do" method="post"></form>
						</c:if>
					</div>
					<div class="col-sm-12 col-md-6 mb-2">
						<form action="list.do" class="d-flex justify-content-sm-end" role="search">
							<select name="index" class="form-select w-25" aria-label="Default select example">
								<option value="n.ntitle" selected>제목</option>
								<option value="u.name">작성자</option>
							</select>
					        <input name="keyword" class="form-control w-50 me-2" type="search" placeholder="Search" aria-label="Search">
					        <button class="btn btn-outline-primary" type="submit">Search</button>
						</form>
					</div>
				</div>
				<div class="table-responsive">	
					<table class="table align-middle table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
						<thead class="align-middle table-primary">
							<tr>
								<!--  class="d-none"를 추가하여 학생에게는 checkbox를 숨겨야함 -->
								<c:if test="${ level eq 'M' }">
									<th><input type="checkbox" id="chkAll" onclick="SetCheck();"></th>
								</c:if>
								<th>번호</th>
								<th>제목</th>
								<th>작성일</th>
								<th>작성자</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="seqno" value="${ total - ((search.pageno - 1) * 10) + 1 }"></c:set>
							<c:forEach var="item" items="${ list }">
								<tr>
									<c:if test="${ level eq 'M' }">
										<td><input type="checkbox" name="nno" value="${ item.nno }"></td>
									</c:if>
									<td>${ seqno = seqno - 1 }</td>
									<td  class="position-relative text-left"><a href="${pageContext.request.contextPath}/notice/view.do?nno=${ item.nno }" class="stretched-link">${ item.ntitle }</a></td>
									<td>${ item.ndate }</td>
									<td>${ item.name }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<ul class="pagination">
						<c:set var="index" value="${search.index}" />
						<c:set var="keyword" value="${search.keyword}" />
						<c:if test="${ startbk > 10 }"> 
							<li class="paginate_button page-item previous" id="dataTable_previous"><a href="list.do?page=${startbk - 1}&index=${index}&keyword=${keyword}" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>
						</c:if> 
					 	<c:forEach var="page" begin="${startbk}" end="${endbk}">
					 		<c:choose>
					 			<c:when test="${page == search.pageno}"> 
						 			<li class="paginate_button page-item active">
						 			<a href="list.do?page=${page}&index=${index}&keyword=${keyword}" aria-controls="dataTable" data-dt-idx="${page}" tabindex="0" class="page-link">${page}</a></li>
					 			</c:when>
					 			<c:otherwise>
							 		<li class="paginate_button page-item">
							 		<a href="list.do?page=${page}&index=${index}&keyword=${keyword}" aria-controls="dataTable" data-dt-idx="${page}" tabindex="0" class="page-link">${page}</a></li>
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
	<!-- 컨테이너 끝 -->
	<!-- 메인컨텐츠 끝 -->
</div>

<%@ include file="../include/tail.jsp" %>