<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../include/sidebar.jsp" %>

<script>
//날짜 비교용 Date 객체 생성
	window.onload = function()
	{
		$("#ltitle").focus();	
	}
	function DoCancle()
	{
		if(confirm("강의 등록을 취소하시겠습니까?") == true)
		{
			document.location = "list.do";
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
		
		
		
		if( $("#llimit").val() == "" )
		{
			alert("제한인원을 입력하세요.");
			$("#llimit").focus();
			return;
		}
		
		
		if(confirm("강의를 등록하시겠습니까?") == true)
		{
			$("#write").submit();
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
				<h4 class="m-0 font-weight-bold text-primary">강의 등록</h4>
			</div>
			<div class="card-body">
				<form id="write" name="write" action="writeok.do" method="post" enctype="multipart/form-data">
					<div class="table-responsive">	
						<table class="table align-middle table-bordered" id="dataTable" width="100%" cellspacing="0">
							<tbody>
								<tr>
									<th class="table-primary text-center" style="width:10%">강의명</th>
									<td colspan="3">
										<input name="ltitle" id="ltitle" class="form-control mr-2" type="text" placeholder="" autofocus>
									</td>
								</tr>
								<tr>
									<th class="table-primary text-center" >담당교수</th>
									<td style="width:40%" colspan="3">${ login.name }</td>
								</tr>
								<tr>
									<th class="table-primary text-center" >강의기간</th>
									<td style="width:50%">
										<input type="date" name="lstart" id="lstart" class="form-control d-inline-block mr-2" style="width:150px"> ~ 
										<input type="date" name="lend" id="lend" class="form-control d-inline-block ml-2 mr-2" style="width:150px"> / 
										<select id="day" name="day" class="form-select" aria-label="Default select example" style="width:120px">
											<option value="day" selected>요일선택</option>
											<option value="월요일">월요일</option>
											<option value="화요일">화요일</option>
											<option value="수요일">수요일</option>
											<option value="목요일">목요일</option>
											<option value="금요일">금요일</option>
										</select>
										<input type="text" name="ltime" id="ltime" class="form-control d-inline-block ml-2" style="width:120px" placeholder="교시">
									</td>
									<th class="table-primary text-center" style="width:10%">최대인원수</th>
									<td>
										<input name="llimit" id="llimit" class="form-control d-inline-block mr-2" type="text" style="width:150px"> 명
									</td>
								</tr>
								<tr>
									<th class="table-primary text-center" >내용</th>
									<td colspan="3">
										<div style="min-height:300px">
											<textarea name="lnote" id="lnote" class="form-control mr-2" style="height:500px; resize:none;"></textarea>
										</div>
									</td>
								
								</tr>
								<tr>
									<th class="table-primary text-center">첨부파일</th>
									<td colspan="3">
										<input type="file" name="files" id="file" multiple="multiple">
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="" style="width:100%;">
						<button type="button" class="btn btn-outline-danger float-right" onclick="DoCancle()" style="width:100px">취소</button>
						<!-- submit 변경 -->
						<button type="button" onclick="DoSubmit()" class="btn btn-outline-primary mr-2 float-right" style="width:100px">등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- 컨테이너 끝 -->
<!-- 메인컨텐츠 끝 -->
		
<%@ include file="../include/tail.jsp" %>