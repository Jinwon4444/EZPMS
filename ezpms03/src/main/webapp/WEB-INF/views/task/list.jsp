<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../include/sidebar.jsp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ezen.vo.lectureVO" %>

<%
	//오늘 날짜 가져오기
	Date today = new Date();
	
	// 리스트 가져오기 (request에서 'list' 속성을 가져옵니다.)
	List<lectureVO> list = (List<lectureVO>) request.getAttribute("list");
	
	// SimpleDateFormat 객체 생성
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
%>	
<script>
var prevObj = null;
function ShowList(obj,lno)
{
	curObj = $(obj).parent().find("#listData");
	if(prevObj != null)
	{
		$(prevObj).toggle();	
	}
	prevObj = curObj;							
	//$(curObj).toggle();
	
	$.ajax({
		type: "get",
		url : "sublist.do?lno=" + lno,
		dataType: "html",
		success : function(data){
			// 통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
			$(curObj).html(data);
			$(curObj).toggle();
		},
		error: function(xhr, status, error){
			// 통신 오류 발생시	
		},
		complete : function(){
			// 통신이 성공하거나 실패했어도 마지막으로 이 함수를 타게된다.
		}			
	});					
}
</script>	
<div class="w-100">		
<!-- 강의 list 템플릿 시작 -->
	<!-- 과제목록 시작 -->
	<div class="container-fluid">
		<br>
		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h4 class="m-0 font-weight-bold text-primary">과제 관리</h4>
			</div>
			<div class="card-body">
				<div class="row">
					<div class="col-sm-12 col-md-6 mb-2">
					</div>
					<div class="col-sm-12 col-md-6 mb-2">
						<form class="d-flex justify-content-sm-end" role="search">
							<select name="index" class="form-select w-25" aria-label="Default select example">
								<option value="l.ltitle" selected>강의명</option>
							</select>
					        <input name="keyword" class="form-control w-50 mr-2" type="search" placeholder="Search" aria-label="Search">
					        <button class="btn btn-outline-primary" type="submit">Search</button>
						</form>
					</div>
				</div>
				<div class="accordion" id="accordionExample">
					<c:set var="seqno" value="${ total - ((search.pageno - 1) * 5) + 1 }"></c:set>
					<%
					int colno = 0;
					for(lectureVO item : list)
					{
					    // 시작일과 종료일 가져오기
					    String lstartStr = item.getLstart();
					    String lendStr = item.getLend();
					    colno++;

					    // 날짜 문자열을 Date 객체로 변환
					    Date startdate = formatter.parse(lstartStr);
					    Date enddate = formatter.parse(lendStr);
						%>
						<div class="accordion-item">
							<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#<%= colno %>" aria-expanded="true" aria-controls="<%= colno %>"
							onclick="ShowList(this,'<%= item.getLno() %>')">
								<div class="table-responsive">	
									<table class="table align-middle table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
										<thead class="align-middle table-primary">
											<tr>
												<th>번호</th>
												<th style="width:400px">강의명</th>
												<th>인원수</th>
												<th>과제수</th>
												<th>상태</th>
												<th>강의기간</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>${ seqno = seqno - 1 }</td>
												<td class="text-left"><%= item.getLtitle() %></td>
												<td><%= item.getScount() %></td>
												<td><%= item.getTcount() %></td>
												<%
													if(today.before(startdate))
													{
														%>
														<td class="text-secondary">시작전</td>
														<%
													}
													else if(today.after(enddate))
													{
														%>
														<td class="text-black">강의종료</td>
														<%
													}
													else
													{
														%>
														<td class="text-success">강의중</td>
														<%
													}
												%>
												<td><%= item.getLstart() %> ~ <%= item.getLend() %></td>
		
											</tr>
										</tbody>
									</table>
								</div>
						    </button>
						    <div id="listData" style="display:none" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
						    </div>
						</div>
						<%
					}
					%>
					<ul class="pagination">
						<c:set var="index" value="${search.index}" />
						<c:set var="keyword" value="${search.keyword}" />
						<c:if test="${ startbk > 5 }"> 
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
</div>
	<!-- 과제목록 끝 -->
<!-- 강의 list 템플릿 끝 -->
</div>

<%@ include file="../include/tail.jsp" %>