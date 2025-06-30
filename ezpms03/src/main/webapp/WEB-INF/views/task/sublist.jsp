<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ezen.vo.taskVO" %>

<%
	//오늘 날짜 가져오기
	Date today = new Date();
	
	// 리스트 가져오기 (request에서 'list' 속성을 가져옵니다.)
	List<taskVO> list = (List<taskVO>) request.getAttribute("list");
	
	// SimpleDateFormat 객체 생성
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
%>
<div class="accordion-body">
	<div class="table-responsive">	
		<table class="table align-middle table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
			<thead class="table-secondary">
				<tr>
					<th>과제</th>
					<th>제출인원</th>
					<th>마감일</th>
					<th>상태</th>
					<th><div style="min-width:60px">상세</th>
				</tr>
			</thead>
			<tbody>
				<%
					int colno = 0;
					for(taskVO item : list)
					{
					    // 시작일과 종료일 가져오기
					    String TendStr = item.getTend();

					    // 날짜 문자열을 Date 객체로 변환
					    Date enddate = formatter.parse(TendStr);
						%>
					<tr>
						<td><%= item.getTtitle() %></td>
						<td><%= item.getCount() %>/${ student }</td>
						<td><%= item.getTend() %></td>
						<%
							if(today.before(enddate))
							{
								%>
								<td class="text-danger">제출마감전</td>
								<%
							}
							else if(today.after(enddate))
							{
								%>
								<td class="text-black">제출마감</td>
								<%
							}
						%>
						<td>
							<button type="button" class="btn btn-outline-primary" onclick="location.href='${pageContext.request.contextPath}/task/view.do?tno=<%= item.getTno()%>'">상세</button>
						</td>
					</tr>
					<%
					}
				%>
			</tbody>
			<tfoot>
				<button type="button" class="btn btn btn-outline-primary mr-2 mb-1" onclick="location.href='${pageContext.request.contextPath}/task/write.do?lno='+${search.no}">과제등록</button>
			</tfoot>
		</table>
	</div>
</div>	