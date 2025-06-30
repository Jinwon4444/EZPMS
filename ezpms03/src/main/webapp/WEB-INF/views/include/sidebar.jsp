<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- 사이드바 시작 -->
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
			id="accordionSidebar">
			<br>
	
			<!-- 사이드바 프로필 -->
			<div class="sidebar-card d-lg-flex">
				<img class="sidebar-card-illustration mb-2"
					src="../resources/img/undraw_profile.svg" alt="...">
				<p class="text-center mb-2">
					<strong>${ login.name } 님</strong>
				</p>
				<a class="btn btn-success btn-sm" href="${pageContext.request.contextPath}/login/mypage.do">내 정보</a>
			</div>
	
			<!-- 가름선 -->
			<hr class="sidebar-divider my-0 bs-light">
	
			<!-- 사이드바 메뉴 -->
			<li class="nav-item my-1">
				<a class="nav-link" href="${pageContext.request.contextPath}/notice/list.do"> 
					<i class="fas fa-fw fa-tachometer-alt"></i> 
					<span>공지사항</span>
				</a>
			</li>
			<c:if test="${ login.level eq 'S' }">
				<!-- 가름선 -->
				<hr class="sidebar-divider my-0">
		
				<!-- 사이드바 메뉴 -->
				<li class="nav-item my-1"><a class="nav-link"
					href="${pageContext.request.contextPath}/learn/list.do"> <i class="fas fa-fw fa-chart-area"></i>
						<span>수강목록</span></a></li>
						
				<!-- 가름선 -->
				<hr class="sidebar-divider my-0">
		
				<!-- 사이드바 메뉴 -->
				<li class="nav-item my-1"><a class="nav-link"
					href="${pageContext.request.contextPath}/learn/signlist.do"> <i
						class="fas fa-fw fa-chart-area"></i> <span>수강신청</span></a></li>
				<!-- 가름선 -->
				<hr class="sidebar-divider my-0">
			</c:if>
			
			<c:if test="${ login.level eq 'T' }">
				<!-- 가름선 -->
				<hr class="sidebar-divider my-0">
		
				<!-- 사이드바 메뉴 -->
				<li class="nav-item my-1"><a class="nav-link"
					href="${pageContext.request.contextPath}/lecture/list.do"> <i class="fas fa-fw fa-chart-area"></i>
						<span>강의관리</span></a></li>
						
				<!-- 가름선 -->
				<hr class="sidebar-divider my-0">
		
				<!-- 사이드바 메뉴 -->
				<li class="nav-item my-1"><a class="nav-link"
					href="${pageContext.request.contextPath}/task/list.do"> <i
						class="fas fa-fw fa-chart-area"></i> <span>과제관리</span></a></li>
				
				<!-- 가름선 -->
				<hr class="sidebar-divider my-0">
			</c:if>
			
			<c:if test="${ login.level eq 'M' }">
				<!-- 가름선 -->
				<hr class="sidebar-divider my-0">
						
				<!-- 사이드바 메뉴 -->
				<li class="nav-item my-1"><a class="nav-link"
					href="${pageContext.request.contextPath}/mgrmember/list.do"> <i class="fas fa-fw fa-chart-area"></i>
						<span>회원관리</span></a></li>
						
				<!-- 가름선 -->
				<hr class="sidebar-divider my-0">
		
				<!-- 사이드바 메뉴 -->
				<li class="nav-item my-1"><a class="nav-link"
					href="${pageContext.request.contextPath}/mgrlecture/list.do"> <i
						class="fas fa-fw fa-chart-area"></i> <span>강의관리</span></a></li>
		
				<!-- 가름선 -->
				<hr class="sidebar-divider d-none d-md-block">
			</c:if>
		</ul>
		<!-- 사이드바 끝 -->