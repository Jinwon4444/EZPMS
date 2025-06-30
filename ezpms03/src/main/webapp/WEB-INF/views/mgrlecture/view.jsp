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
				<h4 class="m-0 font-weight-bold text-primary">강의 내용</h6>
			</div>
			<div class="card-body">
				<form action="#" method="post" enctype="multipart/form-data">
					<div class="table-responsive">	
						<table class="table align-middle table-bordered" id="dataTable" width="100%" cellspacing="0">
							<tbody>
								<tr>
									<th class="table-primary text-center" style="width:10%">강의명</th>
									<td colspan="3">
										spring을 활용한 코딩 교육
									</td>
								</tr>
								<tr>
									<th class="table-primary text-center">담당교수</th>
									<td style="width:40%" colspan="3">고길동</td>
								</tr>
								<tr>
									<th class="table-primary text-center" >강의기간</th>
									<td style="width:40%">
										2025.03.01 ~ 2025.06.01 / 금요일 5,6교시
									</td>
									<th class="table-primary text-center" style="width:10%">수강인원</th>
									<td>
										15/30
									</td>
								</tr>
								<tr>
									<th class="table-primary text-center" >내용</th>
									<td colspan="3">
										<div style="min-height:300px">
											spring 코딩 교육 내용입니다<br>
											spring 코딩 교육 내용입니다<br>
											spring 코딩 교육 내용입니다<br>
											spring 코딩 교육 내용입니다<br>
											spring 코딩 교육 내용입니다<br>
										</div>
									</td>
								</tr>
								<tr>
									<th class="table-primary text-center">첨부파일</th>
									<td colspan="3">
										file.txt, file.txt
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
										<div class="w-100 p-1 border-bottom">
											<div class="d-inline-block" style="width:10%">01</div>
											<div class="d-inline-block" style="width:15%">홍길동</div>
											<div class="d-inline-block" style="width:10%">남자</div>
											<div class="d-inline-block" style="width:28%">1999.01.01</div>
											<div class="d-inline-block" style="width:33%">010-1234-5678</div>
										</div>
										<div class="w-100 p-1 border-bottom">
											<div class="d-inline-block" style="width:10%">02</div>
											<div class="d-inline-block" style="width:15%">홍길동</div>
											<div class="d-inline-block" style="width:10%">남자</div>
											<div class="d-inline-block" style="width:28%">1999.01.01</div>
											<div class="d-inline-block" style="width:33%">010-1234-5678</div>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="" style="width:100%;">
						<button type="button" class="btn btn-outline-primary" onclick="location.href='${pageContext.request.contextPath}/mgrlecture/list.do'" style="width:100px">목록</button>
						<button type="button" class="btn btn-outline-danger float-right" style="width:100px">삭제</button>
						<button type="button" class="btn btn-outline-primary mr-2 float-right" onclick="location.href='${pageContext.request.contextPath}/mgrlecture/modify.do'" style="width:100px">수정</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- 컨테이너 끝 -->
<!-- 메인컨텐츠 끝 -->
		
<%@ include file="../include/tail.jsp" %>