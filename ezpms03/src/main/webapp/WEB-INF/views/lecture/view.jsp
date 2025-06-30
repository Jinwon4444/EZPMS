<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../include/sidebar.jsp" %>
	
<script>

function DoModify(lno)
{
	//시간비교용 변수 선언 및 초기화
	let startDate = new Date("${item.lstart}");
	let endDate = new Date("${item.lend}");
	let today = new Date();
	
	if(today > startDate) 
	{
		alert("수정 가능 기간이 아닙니다.");
		return;
	}
	else
	{
		document.location = "modify.do?lno=" + lno;
	}
}

function mgrModify(lno)
{
	document.location = "${pageContext.request.contextPath}/mgrlecture/modify.do?lno=" + lno;	
}

function learnDelete(name, userid)
{
	if(confirm(name + "님의 수강을 취소하시겠습니까?"))
	{
		document.location = "${pageContext.request.contextPath}/mgrlecture/learndelete.do?userid=" + userid + "&lno=" + ${item.lno};	
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
				<h4 class="m-0 font-weight-bold text-primary">강의 내용</h4>
			</div>
			<div class="card-body">
				<form action="#" method="post" enctype="multipart/form-data">
					<div class="table-responsive">	
						<table class="table align-middle table-bordered" id="dataTable" width="100%" cellspacing="0">
							<tbody>
								<tr>
									<th class="table-primary text-center" style="width:10%">강의명</th>
									<td colspan="3">
										${ item.ltitle }
									</td>
								</tr>
								<tr>
									<th class="table-primary text-center" >담당교수</th>
									<td style="width:40%" colspan="3">${ item.name }</td>
								</tr>
								<tr>
									<th class="table-primary text-center" >강의기간</th>
									<td style="width:40%">
										${ item.lstart } ~ ${ item.lend } / ${ item.ltime }
									</td>
									<th class="table-primary text-center" style="width:10%">수강인원</th>
									<td>
										${ item.llimit }
									</td>
								</tr>
								<tr>
									<th class="table-primary text-center" >내용</th>
									<td colspan="3">
										<div style="min-height:300px">
											${ item.lnote }
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
									<th class="table-primary text-center">수강중인<br>학생</th>
									<td colspan="3" class="text-center">
										<c:if test="${ login.level eq 'T' }">
											<div class="w-100 p-1 border bg-body-secondary">
												<div class="d-inline-block" style="width:5%">학생수</div>
												<div class="d-inline-block" style="width:15%">이름</div>
												<div class="d-inline-block" style="width:10%">성별</div>
												<div class="d-inline-block" style="width:13%">생년월일</div>
												<div class="d-inline-block" style="width:20%">전화번호</div>
												<div class="d-inline-block" style="width:28%">이메일</div>
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
										</c:if>
										<c:if test="${ login.level eq 'M' }">
											<div class="w-100 p-1 border bg-body-secondary">
												<div class="d-inline-block" style="width:5%">번호</div>
												<div class="d-inline-block" style="width:15%">이름</div>
												<div class="d-inline-block" style="width:10%">성별</div>
												<div class="d-inline-block" style="width:13%">생년월일</div>
												<div class="d-inline-block" style="width:15%">전화번호</div>
												<div class="d-inline-block" style="width:20%">이메일</div>
												<div class="d-inline-block" style="width:13%">수강</div>
											</div>
											<c:forEach var="item" items="${ list }">
												<c:set var="i" value="${ i+1 }"/>
												<div class="w-100 p-1 border-bottom">
													<div class="d-inline-block" style="width:5%">${ i }</div>
													<div class="d-inline-block" style="width:15%">${ item.name }</div>
													<div class="d-inline-block" style="width:10%">${ item.gender }</div>
													<div class="d-inline-block" style="width:13%">${ item.birthday }</div>
													<div class="d-inline-block" style="width:15%">${ item.tel }</div>
													<div class="d-inline-block" style="width:20%">${ item.email }</div>
													<div class="d-inline-block" style="width:13%">
														<button type="button" onclick="learnDelete('${ item.name }', '${ item.userid }')" class="btn btn-outline-danger">수강취소</button>
													</div>
												</div>
											</c:forEach>
										</c:if>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="" style="width:100%;">
						<c:if test="${ login.level eq 'T' }">
							<button type="button" class="btn btn-outline-primary" onclick="location.href='${pageContext.request.contextPath}/lecture/list.do'" style="width:100px">목록</button>
							<button type="button" class="btn btn-outline-primary float-right" onclick="DoModify(${ item.lno })" style="width:100px">수정</button>
						</c:if>
						<c:if test="${ login.level eq 'M' }">
							<button type="button" class="btn btn-outline-primary" onclick="location.href='${pageContext.request.contextPath}/mgrlecture/list.do'" style="width:100px">목록</button>
							<button type="button" class="btn btn-outline-primary float-right" onclick="mgrModify(${ item.lno })" style="width:100px">수정</button>
						</c:if>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- 컨테이너 끝 -->
<!-- 메인컨텐츠 끝 -->
		
<%@ include file="../include/tail.jsp" %>