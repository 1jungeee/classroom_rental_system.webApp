<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
						<%
							/* 세션이 존재할 경우 */
							if (session.getAttribute("isAdmin") != null) { 
								/* 관리자일 경우 */
								if (session.getAttribute("isAdmin").equals("1")) {
						%>
						<li><a href="/classroom_rental/adminRentalMng.do">강의실 대여 관리</a></li>
						<li><a href="/classroom_rental/classroomRentalList.do">강의실 대여</a></li>
						<li><a href="/classroom_rental/views/admin/notice_mng.jsp">공지사항 등록</a></li>
						<li class="active"><a href="/classroom_rental/boardList.do">게시판</a></li>
						<li><a href="/classroom_rental/userRentalMng.do">나의 신청현황</a></li>
						<li><a href="/classroom_rental/logout.do">로그아웃</a></li>
						<li style="float: right;"><a href="#"><%=session.getAttribute("name")%>님 환영합니다.</a></li>
						<%
								/* 일반 사용자일 경우 */
								} else {
						%>
						<li><a href="/classroom_rental/classroomRentalList.do">강의실 대여</a></li>
						<li class="active"><a href="/classroom_rental/boardList.do">게시판</a></li>
						<li><a href="/classroom_rental/userRentalMng.do">나의 신청현황</a></li>
						<li><a href="/classroom_rental/logout.do">로그아웃</a></li>
						<li style="float: right;"><a href="#"><%=session.getAttribute("name")%>님 환영합니다.</a></li>
						<%
							}
							/* 세션이 없을 경우 */
							} else {
						%>
						<li class="active"><a href="/classroom_rental/boardList.do">게시판</a></li>
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
				<hr/><br> 
				<h4>게시글 목록</h4>
				<hr/>
				<!-- 게시판 리스트 -->
				<div id="boardList" style="overflow: auto">
					<table id="boardListContent" class="table">
						<tr style="color:black; background-color:#fcf8e3;">
							<th class="text-center">글번호</th>
							<th>글제목</th>
							<th class="text-center">글쓴이</th>
							<th class="text-center">날짜</th>
						</tr>
						<!-- 게시물이 존재할 경우 -->
						<c:choose>
						    <c:when test="${fn:length(boardList) > 0}">
						    	<c:forEach items="${boardList}" var="board" varStatus="status">
						    		<tr>
						    			<!-- 글번호 -->
						    			<td class="text-center">${status.count}</td>
						    			<!-- 글제목 -->
										<td><a href="/classroom_rental/boardPostRead.do?board_index=${board.board_index}">${board.board_title}</a></td>
						    			<!-- 글쓴이 -->
						    			<td class="text-center">${board.user_name}</td>
						    			<!-- 날짜 -->
						    			<td class="text-center">${board.date}</td>
						    		</tr>
								</c:forEach>
						    </c:when>
							<c:otherwise>
						    		<tr>
						    			<td rowspan="4">등록된 게시물이 없습니다.</td>
						    		</tr>
						    </c:otherwise>
					 	</c:choose>
				 	</table>
				</div>
				<!-- 글작성 버튼 -->
				<div class="text-right">
					<a href="/classroom_rental/views/board/board_post.jsp">
						<button type="button" class="btn btn-warning">
							<span class="glyphicon glyphicon-pencil"></span> 글 작성
		          		</button>
					</a>
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
</body>
</html>