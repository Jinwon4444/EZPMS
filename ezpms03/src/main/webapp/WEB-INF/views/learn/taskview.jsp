<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../include/sidebar.jsp" %>


<c:if test="${param.msg == 'fails'}">
    <script>
        alert("과제 수정 기간이 아닙니다.");
    </script>
</c:if>
<!-- 메인컨텐츠 시작 -->
<!-- 컨테이너 시작 -->
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
		alert("발송 할 메시지를 입력하세요.");
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
<div class="w-100">
	<div class="container-fluid">
		<br>
		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h4 class="m-0 font-weight-bold text-primary">과제 제출 상세</h4>
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
										<c:when test="${ subitem.score == '' and subitem.score == null }">
											<span style="color:red">평가전</span>
										</c:when>
										<c:otherwise>
											<span style="color:black">${ subitem.score }</span>
										</c:otherwise>
									</c:choose>		
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
										<div class="chatbox" style="height:200px; overflow:auto">교수님께 하고싶은 질문을 입력하세요.
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
						<button type="button" class="btn btn-outline-primary" onclick="location.href='tasklist.do?lno=${ item.lno }'" style="width:100px">목록</button>
						<button type="button" class="btn btn-outline-primary float-right" onclick="location.href='taskmodify.do?tno=${ item.tno }&sno=${ subitem.sno }'" style="width:100px">수정</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- 컨테이너 끝 -->
<!-- 메인컨텐츠 끝 -->
		
<%@ include file="../include/tail.jsp" %>