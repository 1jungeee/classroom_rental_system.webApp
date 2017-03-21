<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!doctype html>
<head>
<meta charset="UTF-8">
<title>강의실 예약 웹 어플리케이션</title>
<!-- jquery lib load -->
<script type="text/javascript"
	src="/classroom_rental/resources/lib/jquery/jquery-3.1.1.min.js"></script>
<!-- bootstrap lib load -->
<link rel="stylesheet"
	href="/classroom_rental/resources/lib/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="/classroom_rental/resources/lib/bootstrap/css/bootstrap-theme.min.css">
<script type="text/javascript"
	src="/classroom_rental/resources/lib/bootstrap/js/bootstrap.min.js"></script>
<!-- main css load -->
<link rel="stylesheet"
	href="/classroom_rental/resources/lib/default/main-style.css">
</head>
<body>
	<div id="wrap">
		<div class="container">
			<h1 class="page-header">
				<a href="/classroom_rental/"><img
					src="/classroom_rental/resources/images/logo.png" width="65px"></a>
			</h1>
			<p class="lead">강의실 예약 시스템_김원정(201403038).WebApp</p>
			<br>
			<div>
				<div class="menu">
					<ul class="nav nav-pills">
						<li class="active"><a href="/classroom_rental/">홈</a></li>
						<%
							/* 세션이 존재할 경우 */
							if (session.getAttribute("isAdmin") != null) {
								/* 관리자일 경우 */
								if (session.getAttribute("isAdmin").equals("1")) {
						%>
						<li><a href="/classroom_rental/adminRentalMng.do">강의실 대여
								관리</a></li>
						<li><a href="/classroom_rental/classroomRentalList.do">강의실
								대여</a></li>
						<li><a href="/classroom_rental/views/admin/notice_mng.jsp">공지사항
								등록</a></li>
						<li><a href="/classroom_rental/boardList.do">게시판</a></li>
						<li><a href="/classroom_rental/userRentalMng.do">나의 신청현황</a></li>
						<li><a href="/classroom_rental/logout.do">로그아웃</a></li>
						<li style="float: right;"><a href="#"><%=session.getAttribute("name")%>님
								환영합니다.</a></li>
						<%
							/* 일반 사용자일 경우 */
								} else {
						%>
						<li><a href="/classroom_rental/classroomRentalList.do">강의실
								대여</a></li>
						<li><a href="/classroom_rental/boardList.do">게시판</a></li>
						<li><a href="/classroom_rental/userRentalMng.do">나의 신청현황</a></li>
						<li><a href="/classroom_rental/logout.do">로그아웃</a></li>
						<li style="float: right;"><a href="#"><%=session.getAttribute("name")%>님
								환영합니다.</a></li>
						<%
							}
								/* 세션이 없을 경우 */
							} else {
						%>
						<li><a href="/classroom_rental/boardList.do">게시판</a></li>
						<li><a href="/classroom_rental/views/main/login.jsp">로그인</a></li>
						<li><a href="/classroom_rental/views/main/join.jsp">회원가입</a></li>
						<%
							}
						%>
					</ul>
				</div>
			</div>
			<div class="content">
				<!-- 구분선 삽입 -->
				<hr />
				<!-- //구분선 삽입 -->
				<br>
				<div class="row">
					<div class="col-xs-6 col-md-4 text-center" style="padding-bottom: 30px">
						<span style="font-size: 1.5em"><a href="/classroom_rental/">홈(Home)</a></span><br>
						<img src="/classroom_rental/resources/images/sitemap_img/home.PNG" width="300px" class="img-thumbnail">
					</div>
					<div class="col-xs-6 col-md-4 text-center" style="padding-bottom: 30px">
						<span style="font-size: 1.5em"><a href="/classroom_rental/boardList.do">게시판(Board)</a></span><br>
						<img src="/classroom_rental/resources/images/sitemap_img/board.PNG" width="300px" class="img-thumbnail">
					</div>
					<div class="col-xs-6 col-md-4 text-center" style="padding-bottom: 30px">
						<span style="font-size: 1.5em"><a href="/classroom_rental/views/main/login.jsp">로그인(Login)</a></span><br>
						<img src="/classroom_rental/resources/images/sitemap_img/login.PNG" width="300px" class="img-thumbnail">
					</div>
					<div class="col-xs-6 col-md-4 text-center" style="padding-bottom: 30px">
						<span style="font-size: 1.5em"><a href="/classroom_rental/views/main/join.jsp">회원가입(Join)</a></span><br>
						<img src="/classroom_rental/resources/images/sitemap_img/join.PNG" width="300px" class="img-thumbnail">
					</div>
					<div class="col-xs-6 col-md-4 text-center" style="padding-bottom: 30px">
						<span style="font-size: 1.5em"><a href="/classroom_rental/classroomRentalList.do">강의실 대여(Rental)</a></span><br>
						<img src="/classroom_rental/resources/images/sitemap_img/rental.PNG"width="300px" class="img-thumbnail">
					</div>
					<div class="col-xs-6 col-md-4 text-center" style="padding-bottom: 30px">
						<span style="font-size: 1.5em"><a href="/classroom_rental/userRentalMng.do">신청현황 확인(MyRental)</a></span><br>
						<img src="/classroom_rental/resources/images/sitemap_img/myrental.PNG" width="300px" class="img-thumbnail">
					</div>
				</div>
				<br>
				<!-- 구분선 삽입 -->
				<hr />
				<footer>
					<div class="container">
						<p>
							<span>Copyright © 2016 | <a href="https://www.bible.ac.kr">bible.ac.kr</a></span>
							<span style="float: right;"><a
								href="/classroom_rental/views/main/site_map.jsp">+사이트 맵</a></span>
						</p>
					</div>
				</footer>
</body>
</html>