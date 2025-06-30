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
	function subDelete()
	{
		var lno_list = "";
		
		$("input:checkbox[name='lno']").each(function() {
			if( this.checked == true)
			{
				if(lno_list != "") lno_list += ",";
				lno_list += this.value;	
			}
		});	
		console.log(lno_list);
		
		if(lno_list == "")
		{
			return;
		}
		if( confirm("선택된 강의를 삭제하시겠습니까?") == false)
		{
			return;	
		}
		document.location = "${pageContext.request.contextPath}/mgrlecture/delete.do?lno=" + lno_list;
	}
	
	function SetCheck()
	{
		$("input:checkbox[name='lno']").each(function() {
			this.checked = $("#chkAll").is(":checked");
		});
	}
	
	function btnSearch()
	{
		$("#list").submit();
	}
</script>
<div class="w-100">		
<!-- 관리자 list 템플릿 시작 -->
	<!-- 관리자 강의목록 시작 -->
	<div class="container-fluid">
		<br>
		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h4 class="m-0 font-weight-bold text-primary">강의 관리</h4>
			</div>
			<div class="card-body">
				<form id="list" action="list.do" role="search">
					<div class="row">
						<div class="col-sm-12 col-md-6 mb-2">
							강의명 &nbsp&nbsp<input class="form-control w-75 ml-4 d-inline-block" name="title" type="search" placeholder="Search" aria-label="Search">
						</div>
						<div class="col-sm-12 col-md-6 mb-2"></div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-6 mb-2">
							담당교수 <input class="form-control w-50 ml-3 d-inline-block" name="name" type="search" placeholder="Search" aria-label="Search">
						</div>
						<div class="col-sm-12 col-md-6 mb-2">
							상태 <select class="form-select w-25 ml-5" name="state" aria-label="Default select example">
									<option value="" <c:if test ="${ state eq '' }">selected="selected"</c:if>>상태전체</option>
									<option value="1" <c:if test ="${ state eq '1' }">selected="selected"</c:if>>시작전</option>
									<option value="2" <c:if test ="${ state eq '2' }">selected="selected"</c:if>>강의중</option>
									<option value="3" <c:if test ="${ state eq '3' }">selected="selected"</c:if>>강의종료</option>
								</select>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-6 mb-2">
							정렬 
							<select class="form-select w-25 ml-5" name="sort" aria-label="Default select example">
								<option value="" <c:if test ="${ search.sort eq '' }">selected="selected"</c:if>>날짜순</option>
								<option value="ltitle" <c:if test ="${ search.sort eq 'ltitle' }">selected="selected"</c:if>>강의명순</option>
								<option value="u.name" <c:if test ="${ search.sort eq 'u.name' }">selected="selected"</c:if>>담당교수순</option>
							</select>
						</div>
						<div class="col-sm-12 col-md-6 mb-2">
					        <button class="btn btn-outline-primary float-right" onclick="btnSearch()">Search</button>
						</div>
					</div>
				</form>
				<div class="table-responsive">	
					<table class="table align-middle table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
						<thead class="align-middle table-primary">
							<tr>
								<th><input type="checkbox" id="chkAll" onclick="SetCheck();"></th>
								<th>검색수</th>
								<th>담당교수</th>
								<th>강의명</th>
								<th>강의기간/날짜</th>
								<th>상태</th>
								<th><div style="min-width:60px">상세</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="seqno" value="${ total - ((search.pageno - 1) * 10) + 1 }"></c:set>
							<%
							for(lectureVO item : list)
							{
							    // 시작일과 종료일 가져오기
							    String lstartStr = item.getLstart();
							    String lendStr = item.getLend();

							    // 날짜 문자열을 Date 객체로 변환
							    Date startdate = formatter.parse(lstartStr);
							    Date enddate = formatter.parse(lendStr);
								%>
								<tr>
									<td><input type="checkbox" name="lno" value="<%= item.getLno() %>"></td>
									<td>${ seqno = seqno - 1 }</td>
									<td><%= item.getName() %></td>
									<td class="text-left"><%= item.getLtitle() %></td>
									<td><%= item.getLstart() %> ~ <%= item.getLend() %></td>
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
									<td>
										<button type="button" class="btn btn-outline-primary" onclick="location.href='${pageContext.request.contextPath}/lecture/view.do?lno= <%= item.getLno() %>'">상세</button>
									</td>
								</tr>
								<%
							}
							%>
						</tbody>
						</tbody>
					</table>
					<ul class="pagination">
						<c:if test="${ startbk > 10 }"> 
							<li class="paginate_button page-item previous" id="dataTable_previous"><a href="list.do?page=${startbk - 1}&title=${ search.keyword }&name=${ search.keyword2 }&state=${ state }" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>
						</c:if> 
					 	<c:forEach var="page" begin="${startbk}" end="${endbk}">
					 		<c:choose>
					 			<c:when test="${page == search.pageno}"> 
						 			<li class="paginate_button page-item active">
						 			<a href="list.do?page=${page}&title=${ search.keyword }&name=${ search.keyword2 }&state=${ state }" aria-controls="dataTable" data-dt-idx="${page}" tabindex="0" class="page-link">${page}</a></li>
					 			</c:when>
					 			<c:otherwise>
							 		<li class="paginate_button page-item">
							 		<a href="list.do?page=${page}&title=${ search.keyword }&name=${ search.keyword2 }&state=${ state }" aria-controls="dataTable" data-dt-idx="${page}" tabindex="0" class="page-link">${page}</a></li>
						 		</c:otherwise>
					 		</c:choose>
					 	</c:forEach>
					 	<c:if test="${ endbk < maxpage }"> 
					 		<li class="paginate_button page-item next" id="dataTable_next"><a href="list.do?page=${endbk + 1}&title=${ search.keyword }&name=${ search.keyword2 }&state=${ state }" aria-controls="dataTable" data-dt-idx="7" tabindex="0" class="page-link">Next</a></li>
					 	</c:if>
				 	</ul>
				</div>
				<button type="button" class="btn btn-danger mr-2" onclick="subDelete()" style="margin-top:-50px">선택강의 삭제</button>
			</div>
		</div>
	</div>
	<!-- 관리자 강의목록 끝 -->
<!-- 관리자 list 템플릿 시작 -->
</div>
		
<%@ include file="../include/tail.jsp" %>