<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../include/sidebar.jsp" %>


<script>
	window.onload = function()
	{
		$("#ltitle").focus();

		let fullTime = "${ item.ltime }"; // 예: "화요일 1,2교시"
		let parts = fullTime.split(" "); // ["화요일", "1,2교시"]
		let day = parts[0];
		let time = parts[1];

		// select에서 해당 요일 선택되게
		$("#day").val(day);

		// input에는 시간만
		$("#ltime").val(time);
	}
	function DoCancle(lno)
	{
		if(confirm("강의 수정을 취소하시겠습니까?") == true)
		{
			document.location = "view.do?lno=" + lno;
		}
	}

	function DoSubmit()
	{
		//시간비교용 변수 선언 및 초기화
		let startDate = new Date($("#lstart").val());
		let endDate = new Date($("#lend").val());
		let today = new Date();
		
		if( $("#ltitle").val() == "" )
		{
			alert("제목을 입력하세요.");
			$("#ltitle").focus();
			return;
		}
		if( $("#lnote").val() == "" )
		{
			alert("내용을 입력하세요.");
			$("#lnote").focus();
			return;
		}
		if( $("#lstart").val() == "" )
		{
			alert("시작일을 입력하세요.");
			$("#lstart").focus();
			return;
		}
		if( $("#lend").val() == "" )
		{
			alert("종료일을 입력하세요.");
			$("#lend").focus();
			return;
		}
		// 시간비교는 date변수로 통합하였음
		if(startDate > endDate) 
		{
			alert("강의 시작일은 종료일보다 앞서야 합니다.");
			$("#lstart").focus();
			return;
		}
		if(today > startDate) 
		{
			alert("강의 시작일은 오늘보다 앞서야 합니다.");
			$("#lstart").focus();
			return;
		}
		if ($("#day").val() == "day")
		{
			alert("요일을 선택하세요.");
			$("#day").focus();
			return;
		}
		if( $("#ltime").val() == "" )
		{
			alert("강의시간을 입력하세요.");
			$("#ltime").focus();
			return;
		}
		let day = $("#day").val();
		let time = $("#ltime").val();
		$("#ltime").val(day + " " + time);
		
		
		
		if(confirm("강의를 수정하시겠습니까?") == true)
		{
			$("#modify").submit();
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
				<h4 class="m-0 font-weight-bold text-primary">강의 수정</h6>
			</div>
			<div class="card-body">
				<form id="modify" name="modify" action="modifyok.do" method="post" enctype="multipart/form-data">
				<input type="hidden" id="lno" name="lno" value="${ item.lno }">
					<div class="table-responsive">	
						<table class="table align-middle table-bordered" id="dataTable" width="100%" cellspacing="0">
							<tbody>
								<tr>
									<th class="table-primary text-center" style="width:5%">강의명</th>
									<td colspan="3">
										<input name="ltitle" id="ltitle" class="form-control mr-2" type="text" value="${ item.ltitle }" autofocus>
									</td>
								</tr>
								<tr>
									<th class="table-primary text-center">담당교수</th>
									<td style="width:40%" colspan="3">${ item.name }</td>
								</tr>
								<tr>
									<th class="table-primary text-center">강의기간</th>
									<td>
										<input type="date" id="lstart" name="lstart" class="form-control d-inline-block mr-2" value="${ item.lstart }" style="width:150px"> ~ 
										<input type="date" id="lend" name="lend" class="form-control d-inline-block ml-2 mr-2" value="${ item.lend }" style="width:150px"> / 
										<select id="day" name="day" class="form-select" aria-label="Default select example" style="width:120px">
											<option value="day">요일선택</option>
											<option value="월요일">월요일</option>
											<option value="화요일">화요일</option>
											<option value="수요일">수요일</option>
											<option value="목요일">목요일</option>
											<option value="금요일">금요일</option>
										</select>
										<input type="text" name="ltime" id="ltime" class="form-control d-inline-block ml-2" style="width:120px">
									</td>
								</tr>
								<tr>
									<th class="table-primary text-center">내용</th>
									<td colspan="3">
										<div style="min-height:300px">
											<textarea name="lnote" id="lnote" class="form-control mr-2" style="height:500px; resize:none;">${ item.lnote }</textarea>
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
										<input type="file" name="files" id="files" multiple="multiple">
									</td>
								</tr>
								<tr>
									<th class="table-primary text-center">수강중인<br>학생</th>
									<td colspan="3" class="text-center">
										<div class="w-100 p-1 border bg-body-secondary">
											<div class="d-inline-block" style="width:10%">번호</div>
											<div class="d-inline-block" style="width:15%">이름</div>
											<div class="d-inline-block" style="width:10%">성별</div>
											<div class="d-inline-block" style="width:28%">생년월일</div>
											<div class="d-inline-block" style="width:33%">전화번호</div>
										</div>
										<c:forEach var="item" items="${ list }">
											<c:set var="i" value="${ i+1 }"/>
											<div class="w-100 p-1 border-bottom">
												<div class="d-inline-block" style="width:5%">${ i }</div>
												<div class="d-inline-block" style="width:15%">${ item.name }</div>
												<div class="d-inline-block" style="width:10%">${ item.gender }</div>
												<div class="d-inline-block" style="width:13%">${ item.birthday }</div>
												<div class="d-inline-block" style="width:20%">${ item.tel }</div>
												<div class="d-inline-block" style="width:28%">${ item.email }</div>
											</div>
										</c:forEach>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="" style="width:100%;">
						<button type="button" class="btn btn-outline-danger float-right" onclick="DoCancle(${ item.lno })" style="width:100px">취소</button>
						
						<!-- submit 변경 -->
						<button type="button" class="btn btn-outline-primary mr-2 float-right" onclick="DoSubmit()" style="width:100px">수정 완료</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- 컨테이너 끝 -->
<!-- 메인컨텐츠 끝 -->

<%@ include file="../include/tail.jsp" %>