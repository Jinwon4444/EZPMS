<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../include/sidebar.jsp" %>
		
<div class="w-100">
<!-- 수강 list 템플릿 시작 -->
	<!-- 과제목록 시작 -->
	<div class="container-fluid">
		<br>
		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h4 class="m-0 font-weight-bold text-primary">과제 목록</h4>
			</div>
			<div class="card-body">
				<div class="row">
					<div class="col-sm-12 col-md-6 mb-2">
					</div>
					<div class="col-sm-12 col-md-6 mb-2">
						<form action="tasklist.do" class="d-flex justify-content-sm-end" role="search">
						<input type="hidden" name="lno" value="${ search.no }">
							<select name="index" class="form-select w-25" aria-label="Default select example">
								<option value="t.ttitle" selected>제목</option>
								<option value="t.tend">마감일</option>
							</select>
					        <input name="keyword" class="form-control w-50 mr-2" type="search" placeholder="Search" aria-label="Search">
					        <button class="btn btn-outline-primary" type="submit">Search</button>
						</form>
					</div>
				</div>
				<div class="table-responsive">	
					<table class="table align-middle table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
						<thead class="align-middle table-primary">
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>진행</th>
								<th>점수</th>
								<th>마감일</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="seqno" value="${ total - ((search.pageno - 1) * 10) + 1 }"></c:set>
							<c:forEach var="item" items="${ list }">
								<tr>
									<td>${ seqno = seqno - 1 }</td>
									<c:choose>
					 					<c:when test="${item.userid == null and item.score == null}">
					 						<td class="position-relative text-left"><a href="tasksub.do?tno=${ item.tno }" class="stretched-link">${ item.ttitle }</a></td>
											<td class="text-danger">미제출</td>
											<td>-</td>
										</c:when>
										<c:when  test="${item.userid != null and item.score == null}">
											<td class="position-relative text-left"><a href="taskview.do?tno=${ item.tno }&sno=${ item.sno }" class="stretched-link">${ item.ttitle }</a></td>
											<td class="text-success">제출완료</td>
											<td>-</td>
										</c:when>
										<c:otherwise>
											<td class="position-relative text-left"><a href="taskview.do?tno=${ item.tno }&sno=${ item.sno }" class="stretched-link">${ item.ttitle }</a></td>
											<td class="text-black">평가완료</td>
											<td>${item.score}</td>
										</c:otherwise>
									</c:choose>
									<td>${ item.tend }</td>										
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
	<!-- 과제목록 끝 -->
<!-- 수강 list 템플릿 끝 -->
</div>
		
<%@ include file="../include/tail.jsp" %>