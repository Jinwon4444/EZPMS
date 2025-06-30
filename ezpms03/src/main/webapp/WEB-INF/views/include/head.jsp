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
		