<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>EZPMS</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<!-- Custom styles for this template-->
<link href="../resources/css/sb-admin-2.css" rel="stylesheet">
<script src="../resources/js/jquery-3.7.1.js"></script>
<style>
.popup {
    display: none;
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0, 0, 0, 0.4);
}

.popup-content {
    background-color: #fefefe;
    margin: 15% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 30%;
    text-align: center;
}

.close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.close:hover {
    color: black;
    text-decoration: none;
    cursor: pointer;
}
</style>
</head>
<body id="page-top">
	<!-- topbar 시작 -->
	<header
		class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
		<a class="navbar-brand col-md-3 col-lg-2 me-0 px-3" href="#">EZPMS</a>
		<!--  
	  <input class="form-control form-control-dark w-100" type="text" placeholder="Search" aria-label="Search">
	  -->
		<div class="navbar-nav">
			<div class="nav-item text-nowrap">
				<c:if test="${ sessionScope.login == null }">
					<a class="nav-link px-3" href="${pageContext.request.contextPath}/login/login.do">로그인</a>
				</c:if>
				<c:if test="${ sessionScope.login != null }">
					<a class="nav-link px-3" href="${pageContext.request.contextPath}/login/logout.do">로그아웃</a>
				</c:if>
			</div>
		</div>
	</header>
	<!-- topbar 끝 -->
	<!-- Page Wrapper -->
    <div id="wrapper">
<%@ include file="../include/sidebar.jsp" %>

<c:if test="${param.msg == 'fails'}">
    <script>
        alert("과제 평가 기간이 아닙니다.");
    </script>
</c:if>

<script>
var last_no = "0";
window.onload = function()
{
	GetMsg();
}

function GetMsg()
{
	var sno = $("#sno").val();
	$.ajax({
		type : "get",
		url: "${pageContext.request.contextPath}/chat/getmsg.do?no=" + last_no +"&sno=" + sno,
		dataType: "xml",
		success : function(data) 
		{	
			// 통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
			$(data).find("msg").each(function(){
				var no   = $(this).find("no").text();
				var name = $(this).find("name").text();
				var note = $(this).find("note").text();
				console.log("no=>" + no);
				console.log("note=>" + note);
				last_no = no;
				
				var org_html = $(".chatbox").html();
				org_html = org_html + "<br>\n" + name + " : "+ note;
				$(".chatbox").html(org_html);
				
				$(".chatbox").scrollTop($(".chatbox")[0].scrollHeight)
			});
		},
		error : function(xhr, status, error) 
		{
			// 통신 오류 발생시	
		}
	});
}

function SendMsg()
{
	if($("#msg").val() == "")
	{
		$("#msg").focus();
		return false;
	}	
	
	$.ajax({
		type : "post",
		url: "${pageContext.request.contextPath}/chat/sendmsg.do",
		dataType: "html",
		data : {
			msg : $("#msg").val(),	
			sno : $("#sno").val()
		},
		success : function(data) 
		{	
			//alert(data);
			$("#msg").val("");
			$("#msg").focus();		
			GetMsg();
		},
		error : function(xhr, status, error) 
		{
			// 통신 오류 발생시	
		}
	});					
	return false;
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
				<h4 class="m-0 font-weight-bold text-primary">과제 평가</h4>
			</div>
			<div class="card-body">
				<form name="qna" method="post" action="#" onsubmit="return SendMsg();">
					<div class="table-responsive">	
						<table class="table align-middle table-bordered" id="dataTable" width="100%" cellspacing="0">
							<tbody>
								<tr>
									<th class="table-primary text-center">과제</th>
									<td colspan="3">
										${ item.ttitle }
									</td>
								</tr>
								<tr>
									<th class="table-primary text-center" style="width:10%">마감일</th>
									<td colspan="3">
										${ item.tend }
									</td>
								</tr>
								<tr>
									<th class="table-primary text-center" style="width:10%">작성자</th>
									<td style="width:40%">
										${ subitem.name }
									</td>
									<th class="table-primary text-center" style="width:10%">점수</th>
									<td>
										<c:choose>
											<c:when test="${ subitem.score eq '' or subitem.score == null }">
												<span style="color:red">평가전</span>
											</c:when>
											<c:otherwise>
												<span style="color:black">${ subitem.score }</span>
											</c:otherwise>
										</c:choose>
										<button type="button" class="btn-sm btn-outline-primary ml-2" onclick="showPopup()" style="width:100px">평가</button>
										<div id="myPopup" class="popup">
											<div class="popup-content">
												<span class="close" onclick="closePopup()">&times;</span>
													점수 입력:
										    	<input type="text" id="scoreInput">
										    	<button onclick="saveScore()">저장</button>
										  	</div>
										</div>
									</td>
								</tr>
								<tr>
									<th class="table-primary text-center" >내용</th>
									<td colspan="3">
										<div style="min-height:200px">
											${ item.tnote }
										</div>
									</td>
								</tr>
								<tr>
									<th class="table-primary text-center">답안</th>
									<td colspan="3">
										<div style="min-height:200px">
											${ subitem.answer }
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
									<th class="table-primary text-center" rowspan="2">질의응답</th>
									<td colspan="3">
										<div class="chatbox" style="height:200px; overflow:auto">학생과 소통할 수 있는 화면입니다.
										</div>
									</td>
								</tr>
								<tr>
									<td colspan="3" style="width:90%">
										<input type="hidden" name="sno" id="sno" value="${ subitem.sno }">
										<input name="msg" id="msg" class="form-control d-inline-block" type="text" placeholder="" style="width:88%">
										<button type="submit" class="btn btn-outline-secondary d-inline-block float-right" style="width:10%">등록</button>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="" style="width:100%;">
						<button type="button" class="btn btn-outline-primary float-right" onclick="location.href='view.do?tno=${ item.tno }'" style="width:100px">확인</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script>
function showPopup() {
  document.getElementById("myPopup").style.display = "block";
}

function closePopup() {
  document.getElementById("myPopup").style.display = "none";
}

function saveScore() {
    let score = document.getElementById("scoreInput").value;
    
    document.location = "${pageContext.request.contextPath}/task/evaluateok.do?score=" + score + "&sno=" + ${subitem.sno} + "&tno=" + ${item.tno};
    
}
</script>
<!-- 컨테이너 끝 -->
<!-- 메인컨텐츠 끝 -->
		
		<%@ include file="../include/tail.jsp" %>