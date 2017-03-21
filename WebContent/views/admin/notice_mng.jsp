<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<!doctype html>
<head>
	<meta charset="UTF-8">
	<title>강의실 예약 웹 어플리케이션</title>
	<!-- jquery lib load -->
	<script type="text/javascript" src="/classroom_rental/resources/lib/jquery/jquery-3.1.1.min.js"></script>
	<!-- bootstrap lib load -->
	<link rel="stylesheet" href="/classroom_rental/resources/lib/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="/classroom_rental/resources/lib/bootstrap/css/bootstrap-theme.min.css">
	<script type="text/javascript" src="/classroom_rental/resources/lib/bootstrap/js/bootstrap.min.js"></script>
	<!-- main css load -->
	<link rel="stylesheet" href="/classroom_rental/resources/lib/default/main-style.css">
</head>
<body>
	<!-- 관리자 세션체크 -->
	<%if(session.getAttribute("isAdmin")!=null){ 
		/* 관리자 일 경우 */
		if(session.getAttribute("isAdmin").equals("1"))
		{
		}
		/* 관리자가 아닐 경우 */
		else
		{%>
			<script>alert("관리자만 접근 가능합니다."); location.href="/classroom_rental/";</script>
		<%}
	}
	/* 세션이 없을 경우 */
	else
	{%>
		<script>alert("관리자만 접근 가능합니다."); location.href="/classroom_rental/";</script>
	<%}%>
	<div id="wrap">
		<div class="container">
			<h1 class="page-header">
				<a href="/classroom_rental/"><img src="/classroom_rental/resources/images/logo.png" width="65px"></a>
			</h1>
			<p class="lead">강의실 예약 시스템_김원정(201403038).WebApp</p>
			<br>
			<div>
				<div class="menu">
					<ul class="nav nav-pills">
						<li><a href="/classroom_rental/">홈</a></li>
						<li><a href="/classroom_rental/adminRentalMng.do">강의실 대여 관리</a></li>
						<li><a href="/classroom_rental/classroomRentalList.do">강의실 대여</a></li>
						<li class="active"><a href="/classroom_rental/views/admin/notice_mng.jsp">공지사항 등록</a></li>
						<li><a href="/classroom_rental/boardList.do">게시판</a></li>
						<li><a href="/classroom_rental/userRentalMng.do">나의 신청현황</a></li>
						<li><a href="/classroom_rental/logout.do">로그아웃</a></li>
						<li style="float: right;"><a href="#"><%=session.getAttribute("name")%>님 환영합니다.</a></li>
					</ul>
				</div>
			</div>
			<div class="content">
				<!-- 구분선 삽입 -->
				<hr/>
				<br><br><br><br><br><br><br>
				<div class="text-center">
					<img src="/classroom_rental/resources/images/wait.jpg" width="700px">
				</div>
			</div>
		</div>
	</div>
	<footer>
		<div class="container">
			<p>
				<span>Copyright © 2016 | <a href="https://www.bible.ac.kr">bible.ac.kr</a></span>
				<span style="float: right;"><a href="/classroom_rental/views/main/site_map.jsp">+사이트 맵</a></span>
			</p>
		</div>
	</footer>