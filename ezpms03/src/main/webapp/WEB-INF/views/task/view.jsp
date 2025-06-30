<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../include/sidebar.jsp" %>
	
<!-- 메인컨텐츠 시작 -->
<!-- 컨테이너 시작 -->
<div class="w-100">
	<div class="container-fluid">
		<br>
		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h4 class="m-0 font-weight-bold text-primary">과제 상세</h6>
			</div>
			<div class="card-body">
				<form action="#" method="post" enctype="multipart/form-data">
					<div class="table-responsive">	
						<table class="table align-middle table-bordered" id="dataTable" width="100%" cellspacing="0">
							<tbody>
								<tr>
									<th class="table-primary text-center">제목</th>
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
									<th class="table-primary text-center" >내용</th>
									<td colspan="3">
										<div style="min-height:300px">
											${ item.tnote }
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
								<tr>
									<th class="table-primary text-center">과제평가</th>
									<td colspan="3" class="text-center">
										<div class="w-100 p-1 border bg-body-secondary">
											<div class="d-inline-block" style="width:7%">학생수</div>
											<div class="d-inline-block" style="width:15%">이름</div>
											<div class="d-inline-block" style="width:25%">전화번호</div>
											<div class="d-inline-block" style="width:20%">제출현황</div>
											<div class="d-inline-block" style="width:10%">점수</div>
											<div class="d-inline-block" style="width:20%">평가</div>
										</div>
										<c:forEach var="list" items="${ list }">
											<c:set var="i" value="${ i+1 }"/>
											<div class="w-100 p-1 border-bottom">
												<div class="d-inline-block" style="width:7%">${ i }</div>
												<div class="d-inline-block" style="width:15%">${ list.name }</div>
												<div class="d-inline-block" style="width:25%">${ list.tel }</div>
												<c:choose>
													<c:when test="${ list.answer eq null or list.answer eq '' }">
														<div class="d-inline-block" style="width:20%"> 미제출 </div>
													</c:when>
													<c:otherwise>
														<div class="d-inline-block" style="width:20%"> 제출 </div>
													</c:otherwise>
												</c:choose>
												<div class="d-inline-block" style="width:10%">${ list.score }</div>
												<div class="d-inline-block" style="width:20%">
													<c:choose>
														<c:when test="${ list.answer eq null or list.answer eq '' }">
														</c:when>
														<c:otherwise>
															<button type="button" class="btn btn btn-secondary btn-sm" onclick="location.href='${pageContext.request.contextPath}/task/evaluate.do?tno='+${item.tno}+'&sno=${list.sno}'">평가하기</button>
														</c:otherwise>
													</c:choose>
												</div>
											</div>
										</c:forEach>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="" style="width:100%;">
						<button type="button" class="btn btn-outline-primary" onclick="location.href='${pageContext.request.contextPath}/task/list.do'" style="width:100px">목록</button>
						<button type="button" class="btn btn-outline-primary float-right" onclick="location.href='${pageContext.request.contextPath}/task/modify.do?tno='+${item.tno}" style="width:100px">수정</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- 컨테이너 끝 -->
<!-- 메인컨텐츠 끝 -->
		
<%@ include file="../include/tail.jsp" %>