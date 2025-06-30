<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../include/sidebar.jsp" %>

<script>
function subDelete()
{
	var id_list = "";
	
	$("input:checkbox[name='userid']").each(function() {
		if( this.checked == true)
		{
			if(id_list != "") id_list += ",";
			id_list += this.value;	
		}
	});	
	
	if(id_list == "")
	{
		return;
	}
	if( confirm("선택된 회원을 삭제하시겠습니까?") == false)
	{
		return;	
	}
	document.location = "${pageContext.request.contextPath}/mgrmember/delete.do?id=" + id_list;
}

function SetCheck()
{
	$("input:checkbox[name='userid']").each(function() {
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
	<!-- 회원목록 시작 -->
	<div class="container-fluid">
		<br>
		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h4 class="m-0 font-weight-bold text-primary">회원 관리</h4>
			</div>
			<div class="card-body">
				<form id="list" action="list.do" role="search">
					<div class="row">
						<div class="col-sm-12 col-md-6 mb-2">
							이름 
							<input class="form-control w-50 ml-3 d-inline-block" name="name" id="name" type="search" placeholder="Search" aria-label="Search">
						</div>
						<div class="col-sm-12 col-md-6 mb-4">
							상태 
							<select name="state" class="form-select w-25 ml-3" aria-label="Default select example">
								<option <c:if test ="${ s_state eq '' }">selected="selected"</c:if> value="">전체</option>
								<option <c:if test ="${ s_state eq 'Y' }">selected="selected"</c:if> value="Y">회원</option>
								<option <c:if test ="${ s_state eq 'N' }">selected="selected"</c:if> value="N">비회원</option>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-6 mb-4">
							성별
							<select name="gender" class="form-select w-25 ml-3" aria-label="Default select example">
								<option <c:if test ="${ s_gender eq '' }">selected="selected"</c:if> value="">전체</option>
								<option <c:if test ="${ s_gender eq 'M' }">selected="selected"</c:if> value="M">남자</option>
								<option <c:if test ="${ s_gender eq 'F' }">selected="selected"</c:if> value="F">여자</option>
							</select>
						</div>
						<div class="col-sm-12 col-md-6 mb-4">
							권한 
							<select name="level" class="form-select w-25 ml-3" aria-label="Default select example">
								<option <c:if test ="${ s_level eq '' }">selected="selected"</c:if> value="">전체</option>
								<option <c:if test ="${ s_level eq 'T' }">selected="selected"</c:if> value="T">교사</option>
								<option <c:if test ="${ s_level eq 'S' }">selected="selected"</c:if> value="S">학생</option>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-6 mb-3">
							정렬 
							<select name="sort" class="form-select w-25 ml-3" aria-label="Default select example">
								<option value="name" <c:if test ="${ search.sort eq 'name' }">selected="selected"</c:if>>이름순</option>
								<option value="birthday" <c:if test ="${ search.sort eq 'birthday' }">selected="selected"</c:if>>생년월일순</option>
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
								<th>이름</th>
								<th>생년월일</th>
								<th>성별</th>
								<th>전화번호</th>
								<th>이메일</th>
								<th>권한</th>
								<th>상태</th>
								<th><div style="min-width:50px">회원정보</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="seqno" value="${ total - ((search.pageno - 1) * 10) + 1 }"></c:set>
							<c:forEach var="item" items="${ list }">
								<c:choose>
									<c:when test="${ item.level eq 'M' }">
										
									</c:when>
									<c:otherwise>
											<tr>
												<td><input type="checkbox" name="userid" value="${ item.userid }"></td>
												<td>${ seqno = seqno - 1 }</td>
												<td>${ item.name }</td>
												<td>${ item.birthday }</td>
												<td>
													<c:if test="${ item.gender eq 'M' }">남</c:if>
													<c:if test="${ item.gender eq 'F' }">여</c:if>
												</td>
												<td>${ item.tel }</td>
												<td>${ item.email }</td>
												<td>
													<c:if test="${ item.level eq 'S'}">학생</c:if>
													<c:if test="${ item.level eq 'T'}">교사</c:if>
												</td>
												<td>
													<c:if test="${ item.state eq 'Y'}">회원</c:if>
													<c:if test="${ item.state eq 'N'}"><span style="color:red;">비회원</span></c:if>
												</td>
												<td>
													<button type="button" class="btn btn-outline-primary" onclick="location.href='${pageContext.request.contextPath}/mgrmember/modify.do?userid=${item.userid }'">수정</button>
												</td>
											</tr>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</tbody>
					</table>
					<div class="row mr-0 ml-0">
						<ul class="pagination">
							<c:set var="keyword" value="${search.keyword}" />
							<c:if test="${ startbk > 10 }"> 
								<li class="paginate_button page-item previous" id="dataTable_previous"><a href="list.do?page=${startbk - 1}&gender=${ s_gender }&level=${ s_level }&keyword=${keyword}" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>
							</c:if> 
						 	<c:forEach var="page" begin="${startbk}" end="${endbk}">
						 		<c:choose>
						 			<c:when test="${page == search.pageno}"> 
							 			<li class="paginate_button page-item active">
							 			<a href="list.do?page=${page}&state=${ s_state }&gender=${ s_gender }&level=${ s_level }&keyword=${keyword}" aria-controls="dataTable" data-dt-idx="${page}" tabindex="0" class="page-link">${page}</a></li>
						 			</c:when>
						 			<c:otherwise>
								 		<li class="paginate_button page-item">
								 		<a href="list.do?page=${page}&state=${ s_state }&gender=${ s_gender }&level=${ s_level }&keyword=${keyword}" aria-controls="dataTable" data-dt-idx="${page}" tabindex="0" class="page-link">${page}</a></li>
							 		</c:otherwise>
						 		</c:choose>
						 	</c:forEach>
						 	<c:if test="${ endbk < maxpage }"> 
						 		<li class="paginate_button page-item next" id="dataTable_next"><a href="list.do?page=${endbk + 1}&gender=${ s_gender }&level=${ s_level }&keyword=${keyword}" aria-controls="dataTable" data-dt-idx="7" tabindex="0" class="page-link">Next</a></li>
						 	</c:if>
					 	</ul>
						<div class="justify-content-md-end" style="margin-top:-30px">
							<c:if test="${ level eq 'M' }">
								<button type="button" class="btn btn-danger" onclick="subDelete()">선택회원 삭제</button>
								<button class="btn btn-warning float-right" type="button" onclick="document.location='${pageContext.request.contextPath}/mgrmember/regist.do'">교수 등록</button>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 회원목록 끝 -->
<!-- 관리자 list 템플릿 시작 -->
</div>
<%@ include file="../include/tail.jsp" %>