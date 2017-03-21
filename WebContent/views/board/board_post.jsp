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
						<script>alert("회원만 가능합니다. 로그인 후 이용해주세요."); location.href="/classroom_rental/views/main/login.jsp";</script>
						<%
							}
						%>
					</ul>
				</div>
			</div>
			<div class="content">
				<!-- 구분선 삽입 -->
				<hr/><br> 
				<h4>게시글 작성하기</h4>
				<hr/>
				<div id="boardPost" style="">
				<!-- 강의실 예약 신청서 양식 -->
					<form id="boardPostForm" action="/classroom_rental/boardPostForm.do" enctype="multipart/form-data" method="POST">
						<!-- 게시글 내용 -->
						<div class="form-group row">
							<label for="inputTitle" class="col-sm-2 col-form-label">제목</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="inputTitle" name="board_title" value="">
							</div>
						</div>
						<div class="form-group row">
							<label for="inputName" class="col-sm-2 col-form-label">작성자</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="inputName" disabled value="<%=session.getAttribute("name")%>">
								<input type="hidden" class="form-control" name="user_name" value="<%=session.getAttribute("name")%>">
								<input type="hidden" class="form-control" name="user_id" value="<%=session.getAttribute("id")%>">
							</div>
						</div>
						<div class="form-group row">
							<label for="inputBody" class="col-sm-2 col-form-label">내용</label>
							<div class="col-sm-10">
								<textarea class="form-control" id="inputBody" name="board_body" rows="8" style="resize: none; wrap:hard;"></textarea>
							</div>
						</div>
						<div class="form-group row">
							<label for="inputBodyType" class="col-sm-2 col-form-label">내용 타입</label>
							<div class="col-sm-10">
								<input type="radio" id="inputBodyType" name="board_bodyType" value="text" checked> TEXT
								<input type="radio" id="inputBodyType" name="board_bodyType" value="html" disabled> HTML
							</div>
						</div>
						<div class="form-group row">
							<label for="inputFileUpload" class="col-sm-2 col-form-label">파일 첨부</label>
							<div class="col-sm-10">
								<input type="file" id="inputFileUpload" name="board_file" size="50" maxlength="50">
							</div>
						</div>
						<hr/>
					</form>
					
					<!-- 글 작성하기 및 취소 버튼 -->
					<div class="text-right">
						<button class="btn btn-warning" type="button" onClick="sendForm()">등록하기 »</button>&nbsp;&nbsp;
						<a href="/classroom_rental/views/board/board_post.jsp"><button class="btn btn-warning">다시쓰기 »</button>&nbsp;&nbsp;</a>
						<a href="/classroom_rental/boardList.do"><button class="btn btn-warning">목록으로 »</button></a>
					</div>
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
	
	<script>
	$(document).ready(function() {
		if ("${result}"=="true") {
			alert("게시글 작성에 성공하였습니다.");
			location.href = '/classroom_rental/boardList.do';
		} else if ("${result}"=="false") {
			alert("유효하지 않은 요청입니다. 확인 후 다시 시도해주시기 바랍니다.");
			location.href = '/classroom_rental/boardList.do';
		} else { } 
	});
	
	/* 게시글 작성 */
	function sendForm() {
		formCheck();
	}
	
	/* 게시글 폼 입력 값 유효성 체크 */
	function formCheck() {
		// 제목값
		var boardTitle = document.getElementById('inputTitle').value;
		// 내용
		var boardBody = document.getElementById('inputBody').value;
		
		if (boardTitle == "") {
			alert("글 제목을 입력해주세요 !");
			$("#inputTitle").focus();
		} else if (boardBody == "") {
			alert("글 내용을 입력해주세요 !")
			$("#inputBody").focus();
		} else {
			// 유효성 체크에 이상이 없을 경우 게시글 작성 폼 전송
			$("#boardPostForm").submit();
		}
	}
	
	</script>
</body>
</html>