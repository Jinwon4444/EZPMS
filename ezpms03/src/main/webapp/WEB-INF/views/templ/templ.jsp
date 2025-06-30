<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>template</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<!-- Custom styles for this template-->
<link href="../css/sb-admin-2.css" rel="stylesheet">

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
				<a class="nav-link px-3" href="#">로그아웃</a>
			</div>
		</div>
	</header>
	<!-- topbar 끝 -->
	
	<!-- Page Wrapper -->
    <div id="wrapper">
		<!-- 사이드바 시작 -->
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
			id="accordionSidebar">
			<br>
	
			<!-- 사이드바 프로필 -->
			<div class="sidebar-card d-lg-flex">
				<img class="sidebar-card-illustration mb-2"
					src="../img/undraw_profile.svg" alt="...">
				<p class="text-center mb-2">
					<strong>홍깅동님</strong>
				</p>
				<a class="btn btn-success btn-sm" href="#">내 정보</a>
			</div>
	
			<!-- 가름선 -->
			<hr class="sidebar-divider my-0 bs-light">
	
			<!-- 사이드바 메뉴 -->
			<li class="nav-item my-1">
				<a class="nav-link" href="../notice/list.jsp"> 
					<i class="fas fa-fw fa-tachometer-alt"></i> 
					<span>공지사항</span>
				</a>
			</li>
	
			<!-- 가름선 -->
			<hr class="sidebar-divider my-0">
	
			<!-- 사이드바 메뉴 -->
			<li class="nav-item my-1"><a class="nav-link"
				href="../learn/list.jsp"> <i class="fas fa-fw fa-chart-area"></i>
					<span>수강목록</span></a></li>
					
			<!-- 가름선 -->
			<hr class="sidebar-divider my-0">
	
			<!-- 사이드바 메뉴 -->
			<li class="nav-item active my-1"><a class="nav-link"
				href="../learn/signlist.jsp"> <i
					class="fas fa-fw fa-chart-area"></i> <span>수강신청</span></a></li>
	
			<!-- 가름선 -->
			<hr class="sidebar-divider d-none d-md-block">
		</ul>
		<!-- 사이드바 끝 -->
		
		<div class="w-100">
		<!-- 수강 list 템플릿 시작 -->
			<!-- 공지사항 시작 -->
			<div class="container-fluid">
				<br>
				<!-- DataTales Example -->
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h4 class="m-0 font-weight-bold text-primary">공지사항</h6>
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-sm-12 col-md-6 mb-2">
								<a href="#" class="btn btn-outline-primary mr-2">
									<span class="text-white-50">
									</span> <span class="text">공지등록</span>
								</a>
								<a href="#" class="btn btn-outline-danger mr-2">
									<span class="text-white-50">
									</span> <span class="text">삭제</span>
								</a>
							</div>
							<div class="col-sm-12 col-md-6 mb-2">
								<form class="d-flex justify-content-sm-end" role="search">
									<select class="form-select w-25" aria-label="Default select example">
										<option value="1" selected>제목</option>
										<option value="2">작성자</option>
									</select>
							        <input class="form-control w-50 mr-2" type="search" placeholder="Search" aria-label="Search">
							        <button class="btn btn-outline-primary" type="submit">Search</button>
								</form>
							</div>
						</div>
						<div class="table-responsive">	
							<table class="table align-middle table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
								<thead class="align-middle table-primary">
									<tr>
										<!--  class="d-none"를 추가하여 학생에게는 checkbox를 숨겨야함 -->
										<th><input type="checkbox"></th>
										<th>번호</th>
										<th>제목</th>
										<th>작성일</th>
										<th>작성자</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><input type="checkbox"></td>
										<td>01</td>
										<td  class="position-relative text-left"><a href="view.jsp" class="stretched-link">공지사항입니다</a></td>
										<td>2011/04/25</td>
										<td>관리자</td>
									</tr>
									<tr>
										<td><input type="checkbox"></td>
										<td>02</td>
										<td  class="position-relative text-left"><a href="view.jsp" class="stretched-link">두번째공지사항입니다</a></td>
										<td>2011/04/25</td>
										<td>관리자</td>
									</tr>
									<tr>
										<td><input type="checkbox"></td>
										<td>03</td>
										<td  class="position-relative text-left"><a href="view.jsp" class="stretched-link">서버 임시 점검 안내</a></td>
										<td>2011/04/25</td>
										<td>관리자</td>
									</tr>
								</tbody>
							</table>
							<ul class="pagination">
								<li class="paginate_button page-item previous disabled" id="dataTable_previous"><a href="#" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>
								<li class="paginate_button page-item active"><a href="#" aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link">1</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="2" tabindex="0" class="page-link">2</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="3" tabindex="0" class="page-link">3</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="4" tabindex="0" class="page-link">4</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="5" tabindex="0" class="page-link">5</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="6" tabindex="0" class="page-link">6</a></li>
								<li class="paginate_button page-item next" id="dataTable_next"><a href="#" aria-controls="dataTable" data-dt-idx="7" tabindex="0" class="page-link">Next</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<!-- 공지사항 끝 -->
			
			<!-- 수강목록 시작 -->
			<div class="container-fluid">
				<br>
				<!-- DataTales Example -->
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h4 class="m-0 font-weight-bold text-primary">수강목록</h6>
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-sm-12 col-md-6 mb-2"></div>
							<div class="col-sm-12 col-md-6 mb-2">
								<form class="d-flex justify-content-sm-end" role="search">
									<select class="form-select w-25" aria-label="Default select example">
										<option value="1" selected>제목</option>
										<option value="2">작성자</option>
									</select>
							        <input class="form-control w-50 mr-2" type="search" placeholder="Search" aria-label="Search">
							        <button class="btn btn-outline-primary" type="submit">Search</button>
								</form>
							</div>
						</div>
						<div class="table-responsive">	
							<table class="table align-middle table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
								<thead class="align-middle table-primary">
									<tr>
										<th>번호</th>
										<th>강의명</th>
										<th>강의기간</th>
										<th>과제</th>
										<th><div style="min-width:60px">상세</div></th>
	                                    </tr>
								</thead>
								<tbody>
									<tr>
										<td>01</td>
										<td  class="position-relative text-left"><a href="view.jsp" class="stretched-link">읽기와 토론</a></td>
										<td>2011/04/25 ~ 2012/04/25</td>
										<td><img class="quest" src="../img/document_quest.png" width="25" height="30"></td>
										<td>
											<a href="#" class="btn btn-outline-primary">
												<span class="text-white-50">
												</span> <span class="text">상세</span>
											</a>
										</td>
									</tr>
									<tr>
										<td>02</td>
										<td  class="position-relative text-left"><a href="view.jsp" class="stretched-link">선형대수학1</a></td>
										<td>2011/04/25 ~ 2012/04/25</td>
										<td>-</td>
										<td>
											<a href="#" class="btn btn-outline-primary">
												<span class="text-white-50">
												</span> <span class="text">상세</span>
											</a>
										</td>
									</tr>
									<tr>
										<td>03</td>
										<td  class="position-relative text-left"><a href="view.jsp" class="stretched-link">반도체 이론의 이해와 실험 반도체 이론의 이해와 실험 반도체 이론의 이해와 실험</a></td>
										<td>2011/04/25 ~ 2012/04/25</td>
										<td><img class="quest" src="../img/document_quest.png" width="25" height="30"></td>
										<td>
											<a href="#" class="btn btn-outline-primary">
												<span class="text-white-50">
												</span> <span class="text">상세</span>
											</a>
										</td>
									</tr>
								</tbody>
							</table>
							<ul class="pagination">
								<li class="paginate_button page-item previous disabled" id="dataTable_previous"><a href="#" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>
								<li class="paginate_button page-item active"><a href="#" aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link">1</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="2" tabindex="0" class="page-link">2</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="3" tabindex="0" class="page-link">3</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="4" tabindex="0" class="page-link">4</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="5" tabindex="0" class="page-link">5</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="6" tabindex="0" class="page-link">6</a></li>
								<li class="paginate_button page-item next" id="dataTable_next"><a href="#" aria-controls="dataTable" data-dt-idx="7" tabindex="0" class="page-link">Next</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<!-- 수강목록 끝 -->
			
			<!-- 수강신청 시작 -->
			<div class="container-fluid">
				<br>
				<!-- DataTales Example -->
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h4 class="m-0 font-weight-bold text-primary">수강신청</h6>
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-sm-12 col-md-6 mb-2">
								<select class="form-select w-25 mr-2" aria-label="Default select example">
									<option selected>요일전체</option>
									<option value="1">월요일</option>
									<option value="2">화요일</option>
									<option value="3">수요일</option>
									<option value="4">목요일</option>
									<option value="5">금요일</option>
								</select>
								<select class="form-select w-25 mr-2" aria-label="Default select example">
									<option selected>교사전체</option>
									<option value="1">이진선</option>
									<option value="2">박현진</option>
								</select>
							</div>
							<div class="col-sm-12 col-md-6 mb-2">
								<form class="d-flex justify-content-sm-end" role="search">
									<select class="form-select w-25" aria-label="Default select example">
										<option value="1" selected>과목</option>
										<option value="2">담당교수</option>
									</select>
							        <input class="form-control w-50 mr-2" type="search" placeholder="Search" aria-label="Search">
							        <button class="btn btn-outline-primary" type="submit">Search</button>
								</form>
							</div>
						</div>
						<div class="table-responsive">	
							<table class="table align-middle table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
								<thead class="align-middle table-primary">
									<tr>
										<!--  class="d-none"를 추가하여 학생에게는 checkbox를 숨겨야함 -->
										<th><input type="checkbox"></th>
										<th>번호</th>
										<th>과목</th>
										<th>강의기간</th>
										<th>강의시간</th>
										<th>담당교수</th>
										<th><div style="min-width:60px">상세</div></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><input type="checkbox"></td>
										<td>01</td>
										<td  class="position-relative text-left"><a href="view.jsp" class="stretched-link">읽기와 토론</a></td>
										<td>2011/04/25~2011/06/30</td>
										<td>금 1,2</td>
										<td>이진선</td>
										<td>
											<a href="#" class="btn btn-outline-primary">
												<span class="text-white-50">
												</span> <span class="text">상세</span>
											</a>
										</td>
									</tr>
									<tr>
										<td><input type="checkbox"></td>
										<td>02</td>
										<td  class="position-relative text-left"><a href="view.jsp" class="stretched-link">읽기와 토론</a></td>
										<td>2011/04/25~2011/06/30</td>
										<td>목 1</td>
										<td>이진선</td>
										<td>
											<a href="#" class="btn btn-outline-primary">
												<span class="text-white-50">
												</span> <span class="text">상세</span>
											</a>
										</td>
									</tr>
									<tr>
										<td><input type="checkbox"></td>
										<td>03</td>
										<td  class="position-relative text-left"><a href="view.jsp" class="stretched-link">프로그래밍 실습</a></td>
										<td>2011/04/25~2011/06/30</td>
										<td>월 3,4</td>
										<td>박현진</td>
										<td>
											<a href="#" class="btn btn-outline-primary">
												<span class="text-white-50">
												</span> <span class="text">상세</span>
											</a>
										</td>
									</tr>
								</tbody>
							</table>
							<ul class="pagination">
								<li class="paginate_button page-item previous disabled" id="dataTable_previous"><a href="#" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>
								<li class="paginate_button page-item active"><a href="#" aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link">1</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="2" tabindex="0" class="page-link">2</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="3" tabindex="0" class="page-link">3</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="4" tabindex="0" class="page-link">4</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="5" tabindex="0" class="page-link">5</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="6" tabindex="0" class="page-link">6</a></li>
								<li class="paginate_button page-item next" id="dataTable_next"><a href="#" aria-controls="dataTable" data-dt-idx="7" tabindex="0" class="page-link">Next</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<!-- 수강신청 끝 -->
			
			<!-- 과제목록 시작 -->
			<div class="container-fluid">
				<br>
				<!-- DataTales Example -->
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h4 class="m-0 font-weight-bold text-primary">과제목록</h6>
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-sm-12 col-md-6 mb-2">
							</div>
							<div class="col-sm-12 col-md-6 mb-2">
								<form class="d-flex justify-content-sm-end" role="search">
									<select class="form-select w-25" aria-label="Default select example">
										<option value="1" selected>제목</option>
										<option value="2">마감일</option>
									</select>
							        <input class="form-control w-50 mr-2" type="search" placeholder="Search" aria-label="Search">
							        <button class="btn btn-outline-primary" type="submit">Search</button>
								</form>
							</div>
						</div>
						<div class="table-responsive">	
							<table class="table align-middle table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
								<thead class="align-middle table-primary">
									<tr>
										<th>번호</th>
										<th>제목</th>
										<th>진행</th>
										<th>점수</th>
										<th>마감일</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>01</td>
										<td  class="position-relative text-left"><a href="view.jsp" class="stretched-link">문제풀이 14쪽</a></td>
										<td class="text-danger">미제출</td>
										<td>-</td>
										<td>2011/04/25 23:59:59</td>										
									</tr>
									<tr>
										<td>02</td>
										<td  class="position-relative text-left"><a href="view.jsp" class="stretched-link">xxx에 대한 자신의 생각을 제출하시오</a></td>
										<td class="text-success">제출완료</td>
										<td>-</td>
										<td>2011/04/25 23:59:59</td>										
									</tr>
									<tr>
										<td>03</td>
										<td  class="position-relative text-left"><a href="view.jsp" class="stretched-link">레포트 과제</a></td>
										<td class="text-black">평가완료</td>
										<td>25/30</td>
										<td>2011/04/25 23:59:59</td>										
									</tr>
								</tbody>
							</table>
							<ul class="pagination">
								<li class="paginate_button page-item previous disabled" id="dataTable_previous"><a href="#" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>
								<li class="paginate_button page-item active"><a href="#" aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link">1</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="2" tabindex="0" class="page-link">2</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="3" tabindex="0" class="page-link">3</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="4" tabindex="0" class="page-link">4</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="5" tabindex="0" class="page-link">5</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="6" tabindex="0" class="page-link">6</a></li>
								<li class="paginate_button page-item next" id="dataTable_next"><a href="#" aria-controls="dataTable" data-dt-idx="7" tabindex="0" class="page-link">Next</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<!-- 과제목록 끝 -->
		<!-- 수강 list 템플릿 끝 -->
		
		
		<!-- 강의 list 템플릿 시작 -->
			<!-- 강의목록 시작 -->
			<div class="container-fluid">
				<br>
				<!-- DataTales Example -->
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h4 class="m-0 font-weight-bold text-primary">강의목록</h6>
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-sm-12 col-md-6 mb-2">
								<a href="#" class="btn btn-outline-primary mr-2">
									<span class="text-white-50">
									</span> <span class="text">강의등록</span>
								</a>
							</div>
							<div class="col-sm-12 col-md-6 mb-2">
								<form class="d-flex justify-content-sm-end" role="search">
									<select class="form-select w-25" aria-label="Default select example">
										<option value="1" selected>강의명</option>
										<option value="2">상태</option>
									</select>
							        <input class="form-control w-50 mr-2" type="search" placeholder="Search" aria-label="Search">
							        <button class="btn btn-outline-primary" type="submit">Search</button>
								</form>
							</div>
						</div>
						<div class="table-responsive">	
							<table class="table align-middle table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
								<thead class="align-middle table-primary">
									<tr>
										<th>번호</th>
										<th>담당교수</th>
										<th>강의명</th>
										<th>강의기간</th>
										<th>상태</th>
										<th><div style="min-width:60px">상세</div></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>01</td>
										<td>고길동</td>
										<td class="text-left">강의입니다</td>
										<td>2011/04/25 ~ 2011/05/25</td>
										<td class="text-secondary">시작전</td>
										<td>
											<a href="#" class="btn btn-outline-primary">
												<span class="text-white-50">
												</span> <span class="text">상세</span>
											</a>
										</td>
									</tr>
									<tr>
										<td>02</td>
										<td>고길동</td>
										<td class="text-left">강의입니다</td>
										<td>2011/04/25 ~ 2011/05/25</td>
										<td class="text-success">강의중</td>
										<td>
											<a href="#" class="btn btn-outline-primary">
												<span class="text-white-50">
												</span> <span class="text">상세</span>
											</a>
										</td>
									</tr>
										<td>03</td>
										<td>고길동</td>
										<td class="text-left">강의입니다</td>
										<td>2011/04/25 ~ 2011/05/25</td>
										<td class="text-black">강의종료</td>
										<td>
											<a href="#" class="btn btn-outline-primary">
												<span class="text-white-50">
												</span> <span class="text">상세</span>
											</a>
										</td>
									</tr>
								</tbody>
							</table>
							<ul class="pagination">
								<li class="paginate_button page-item previous disabled" id="dataTable_previous"><a href="#" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>
								<li class="paginate_button page-item active"><a href="#" aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link">1</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="2" tabindex="0" class="page-link">2</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="3" tabindex="0" class="page-link">3</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="4" tabindex="0" class="page-link">4</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="5" tabindex="0" class="page-link">5</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="6" tabindex="0" class="page-link">6</a></li>
								<li class="paginate_button page-item next" id="dataTable_next"><a href="#" aria-controls="dataTable" data-dt-idx="7" tabindex="0" class="page-link">Next</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<!-- 강의목록 끝 -->
			
			<!-- 과제목록 시작 -->
			<div class="container-fluid">
				<br>
				<!-- DataTales Example -->
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h4 class="m-0 font-weight-bold text-primary">과제목록</h6>
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-sm-12 col-md-6 mb-2">
							</div>
							<div class="col-sm-12 col-md-6 mb-2">
								<form class="d-flex justify-content-sm-end" role="search">
									<select class="form-select w-25" aria-label="Default select example">
										<option value="1" selected>강의명</option>
										<option value="2">상태</option>
									</select>
							        <input class="form-control w-50 mr-2" type="search" placeholder="Search" aria-label="Search">
							        <button class="btn btn-outline-primary" type="submit">Search</button>
								</form>
							</div>
						</div>
						<div class="accordion" id="accordionExample">
							<div class="accordion-item">
							<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
								<div class="table-responsive">	
									<table class="table align-middle table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
										<thead class="align-middle table-primary">
											<tr>
												<th>번호</th>
												<th style="width:400px">강의명</th>
												<th>인원수</th>
												<th>과제수</th>
												<th>상태</th>
												<th>마감일</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>01</td>
												<td class="text-left">강의입니다</td>
												<td>30</td>
												<td>3</td>
												<td class="text-secondary">시작전</td>
												<td>2011/04/25 ~ 2011/05/25</td>
		
											</tr>
										</tbody>
									</table>
								</div>
						    </button>
								<div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
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
													<tr>
														<td>문제풀이</td>
														<td>25/30</td>
														<td>2025.01.30</td>
														<td class="text-danger">체점전</td>
														<td>
															<a href="#" class="btn btn-outline-primary">
																<span class="text-white-50">
																</span> <span class="text">상세</span>
															</a>
														</td>
													</tr>
													<tr>
														<td>문제풀이</td>
														<td>25/30</td>
														<td>2025.01.30</td>
														<td class="text-success">체점중</td>
														<td>
															<a href="#" class="btn btn-outline-primary">
																<span class="text-white-50">
																</span> <span class="text">상세</span>
															</a>
														</td>
													</tr>
													<tr>
														<td>문제풀이</td>
														<td>25/30</td>
														<td>2025.01.30</td>
														<td class="text-black">체점완료</td>
														<td>
															<a href="#" class="btn btn-outline-primary">
																<span class="text-white-50">
																</span> <span class="text">상세</span>
															</a>
														</td>
													</tr>
												</tbody>
												<tfoot>
													<a href="#" class="btn btn-outline-primary mr-2 mb-1">
														<span class="text-white-50">
														</span> <span class="text">과제등록</span>
													</a>
												</tfoot>
											</table>
										</div>
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingTwo">
									<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
										<div class="table-responsive">	
											<table class="table align-middle table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
												<thead class="align-middle table-primary">
													<tr>
														<th>번호</th>
														<th style="width:400px">강의명</th>
														<th>인원수</th>
														<th>과제수</th>
														<th>상태</th>
														<th>마감일</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>02</td>
														<td class="text-left">읽기와 토론</td>
														<td>30</td>
														<td>3</td>
														<td class="text-success">강의중</td>
														<td>2011/04/25 ~ 2011/05/25</td>
													</tr>
												</tbody>
											</table>
										</div>
									</button>
								</h2>
								<div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<div class="table-responsive">	
											<table class="table align-middle table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
												<thead class="table-secondary">
													<tr>
														<th>과제</th>
														<th>제출인원</th>
														<th>마감일</th>
														<th>상태</th>
														<th>상세</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>문제풀이</td>
														<td>25/30</td>
														<td>2025.01.30</td>
														<td class="text-danger">체점전</td>
														<td>
															<a href="#" class="btn btn-outline-primary">
																<span class="text-white-50">
																</span> <span class="text">상세</span>
															</a>
														</td>
													</tr>
													<tr>
														<td>문제풀이</td>
														<td>25/30</td>
														<td>2025.01.30</td>
														<td class="text-success">체점중</td>
														<td>
															<a href="#" class="btn btn-outline-primary">
																<span class="text-white-50">
																</span> <span class="text">상세</span>
															</a>
														</td>
													</tr>
													<tr>
														<td>문제풀이</td>
														<td>25/30</td>
														<td>2025.01.30</td>
														<td class="text-black">체점완료</td>
														<td>
															<a href="#" class="btn btn-outline-primary">
																<span class="text-white-50">
																</span> <span class="text">상세</span>
															</a>
														</td>
													</tr>
												</tbody>
												<tfoot>
													<a href="#" class="btn btn-outline-primary mr-2 mb-1">
														<span class="text-white-50">
														</span> <span class="text">과제등록</span>
													</a>
												</tfoot>
											</table>
										</div>
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingThree">
									<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
										<div class="table-responsive">	
											<table class="table align-middle table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
												<thead class="align-middle table-primary">
													<tr>
														<th>번호</th>
														<th style="width:400px">강의명</th>
														<th>인원수</th>
														<th>과제수</th>
														<th>상태</th>
														<th>마감일</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>03</td>
														<td class="text-left">공학수학</td>
														<td>30</td>
														<td>1</td>
														<td class="text-black">강의종료</td>
														<td>2011/04/25 ~ 2011/05/25</td>
				
													</tr>
												</tbody>
											</table>
										</div>
									</button>
								</h2>
								<div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
									<div class="accordion-body">
										<div class="table-responsive">	
											<table class="table align-middle table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
												<thead class="table-secondary">
													<tr>
														<th>과제</th>
														<th>제출인원</th>
														<th>마감일</th>
														<th>상태</th>
														<th>상세</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>문제풀이</td>
														<td>25/30</td>
														<td>2025.01.30</td>
														<td>체점완료</td>
														<td>
															<a href="#" class="btn btn-outline-primary">
																<span class="text-white-50">
																</span> <span class="text">상세</span>
															</a>
														</td>
													</tr>
												</tbody>
												<tfoot>
													<a href="#" class="btn btn-outline-primary mr-2 mb-1">
														<span class="text-white-50">
														</span> <span class="text">과제등록</span>
													</a>
												</tfoot>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 과제목록 끝 -->
		<!-- 강의 list 템플릿 끝 -->
			
			
		<!-- 관리자 list 템플릿 시작 -->
			<!-- 회원목록 시작 -->
			<div class="container-fluid">
				<br>
				<!-- DataTales Example -->
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h4 class="m-0 font-weight-bold text-primary">회원목록</h4>
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-sm-12 col-md-6 mb-2">
								이름<input class="form-control w-50 ml-3 d-inline-block" type="search" placeholder="Search" aria-label="Search">
							</div>
							<div class="col-sm-12 col-md-6 mb-2">
								전화번호 <input class="form-control w-50 ml-3 d-inline-block" type="search" placeholder="Search" aria-label="Search">
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 col-md-6 mb-4">
								성별<select class="form-select w-25 ml-3" aria-label="Default select example">
										<option selected>성별전체</option>
										<option value="1">남자</option>
										<option value="2">여자</option>
									</select>
							</div>
							<div class="col-sm-12 col-md-6 mb-4">
								직책 <select class="form-select w-25 ml-5" aria-label="Default select example">
										<option selected>직책전체</option>
										<option value="1">교사</option>
										<option value="2">학생</option>
									</select>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 col-md-6 mb-2">
								<select class="form-select w-25" aria-label="Default select example">
									<option value="1" selected>제목</option>
									<option value="2">작성자</option>
								</select>
								<a href="#" class="btn btn-outline-primary mr-2">
									<span class="text-white-50">
									</span> <span class="text">정렬</span>
								</a>
								<a href="#" class="btn btn-outline-danger mr-2">
									<span class="text-white-50">
									</span> <span class="text">선택삭제</span>
								</a>
							</div>
							<div class="col-sm-12 col-md-6 mb-2">
								<form class="d-flex justify-content-sm-end" role="search">
							        <button class="btn btn-outline-primary" type="submit">Search</button>
								</form>
							</div>
						</div>
						<div class="table-responsive">	
							<table class="table align-middle table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
								<thead class="align-middle table-primary">
									<tr>
										<th><input type="checkbox"></th>
										<th>번호</th>
										<th>이름</th>
										<th>생년월일</th>
										<th>성별</th>
										<th>전화번호</th>
										<th>직책</th>
										<th><div style="min-width:60px">상세</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><input type="checkbox"></td>
										<td>01</td>
										<td>홍길동</td>
										<td>2011/04/25</td>
										<td>남자</td>
										<td>010-8888-7777</td>
										<td>학생</td>
										<td>
											<a href="#" class="btn btn-outline-primary">
												<span class="text-white-50">
												</span> <span class="text">상세</span>
											</a>
										</td>
									</tr>
									<tr>
										<td><input type="checkbox"></td>
										<td>02</td>
										<td>전우치</td>
										<td>2000/01/11</td>
										<td>남자</td>
										<td>010-6666-5555</td>
										<td>선생</td>
										<td>
											<a href="#" class="btn btn-outline-primary">
												<span class="text-white-50">
												</span> <span class="text">상세</span>
											</a>
										</td>
									</tr>
									<tr>
										<td><input type="checkbox"></td>
										<td>03</td>
										<td>admin</td>
										<td>1999/09/19</td>
										<td>여자</td>
										<td>010-1111-2222</td>
										<td>관리자</td>
										<td>
											<a href="#" class="btn btn-outline-primary">
												<span class="text-white-50">
												</span> <span class="text">상세</span>
											</a>
										</td>
									</tr>
								</tbody>
							</table>
							<ul class="pagination">
								<li class="paginate_button page-item previous disabled" id="dataTable_previous"><a href="#" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>
								<li class="paginate_button page-item active"><a href="#" aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link">1</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="2" tabindex="0" class="page-link">2</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="3" tabindex="0" class="page-link">3</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="4" tabindex="0" class="page-link">4</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="5" tabindex="0" class="page-link">5</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="6" tabindex="0" class="page-link">6</a></li>
								<li class="paginate_button page-item next" id="dataTable_next"><a href="#" aria-controls="dataTable" data-dt-idx="7" tabindex="0" class="page-link">Next</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<!-- 회원목록 끝 -->
			
			<!-- 관리자 강의목록 시작 -->
			<div class="container-fluid">
				<br>
				<!-- DataTales Example -->
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h4 class="m-0 font-weight-bold text-primary">강의목록</h4>
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-sm-12 col-md-6 mb-2">
								강의명 &nbsp&nbsp<input class="form-control w-75 ml-4 d-inline-block" type="search" placeholder="Search" aria-label="Search">
							</div>
							<div class="col-sm-12 col-md-6 mb-2"></div>
						</div>
						<div class="row">
							<div class="col-sm-12 col-md-6 mb-4">
								담당교수 <input class="form-control w-50 ml-3 d-inline-block" type="search" placeholder="Search" aria-label="Search">
							</div>
							<div class="col-sm-12 col-md-6 mb-4">
								상태 <select class="form-select w-25 ml-5" aria-label="Default select example">
										<option selected>상태전체</option>
										<option value="1">등록전</option>
										<option value="2">확정</option>
										<option value="3">완료</option>
									</select>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 col-md-6 mb-2">
								<select class="form-select w-25" aria-label="Default select example">
									<option value="1" selected>번호</option>
									<option value="2">강의명</option>
									<option value="3">담당교수</option>
								</select>
								<a href="#" class="btn btn-outline-primary mr-2">
									<span class="text-white-50">
									</span> <span class="text">정렬</span>
								</a>
								<a href="#" class="btn btn-outline-danger mr-2">
									<span class="text-white-50">
									</span> <span class="text">선택삭제</span>
								</a>
							</div>
							<div class="col-sm-12 col-md-6 mb-2">
								<form class="d-flex justify-content-sm-end" role="search">
							        <button class="btn btn-outline-primary" type="submit">Search</button>
								</form>
							</div>
						</div>
						<div class="table-responsive">	
							<table class="table align-middle table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
								<thead class="align-middle table-primary">
									<tr>
										<th><input type="checkbox"></th>
										<th>번호</th>
										<th>담당교수</th>
										<th>강의명</th>
										<th>강의기간/날짜</th>
										<th>상태</th>
										<th><div style="min-width:60px">상세</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><input type="checkbox"></td>
										<td>01</td>
										<td>홍길동</td>
										<td class="text-left">산업발전의 이해</td>
										<td>2011/04/25 ~ 2014/04/25</td>
										<td class="text-danger">등록전</td>
										<td>
											<a href="#" class="btn btn-outline-primary">
												<span class="text-white-50">
												</span> <span class="text">상세</span>
											</a>
										</td>
									</tr>
									<tr>
										<td><input type="checkbox"></td>
										<td>02</td>
										<td>전우치</td>
										<td class="text-left">프로그래밍 개론</td>
										<td>2011/04/25 ~ 2014/04/25</td>
										<td class="text-success">확정</td>
										<td>
											<a href="#" class="btn btn-outline-primary">
												<span class="text-white-50">
												</span> <span class="text">상세</span>
											</a>
										</td>
									</tr>
									<tr>
										<td><input type="checkbox"></td>
										<td>03</td>
										<td>가렌</td>
										<td class="text-left">영어 독해와 청해</td>
										<td>2011/04/25 ~ 2014/04/25</td>
										<td>만료</td>
										<td>
											<a href="#" class="btn btn-outline-primary">
												<span class="text-white-50">
												</span> <span class="text">상세</span>
											</a>
										</td>
									</tr>
								</tbody>
							</table>
							<ul class="pagination">
								<li class="paginate_button page-item previous disabled" id="dataTable_previous"><a href="#" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>
								<li class="paginate_button page-item active"><a href="#" aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link">1</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="2" tabindex="0" class="page-link">2</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="3" tabindex="0" class="page-link">3</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="4" tabindex="0" class="page-link">4</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="5" tabindex="0" class="page-link">5</a></li>
								<li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="6" tabindex="0" class="page-link">6</a></li>
								<li class="paginate_button page-item next" id="dataTable_next"><a href="#" aria-controls="dataTable" data-dt-idx="7" tabindex="0" class="page-link">Next</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<!-- 관리자 강의목록 끝 -->
		<!-- 관리자 list 템플릿 시작 -->
		
		</div>
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
			integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
			crossorigin="anonymous"></script>
</body>
</html>