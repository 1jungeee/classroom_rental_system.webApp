<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<head>
	<meta charset="UTF-8">
	<title>강의실 예약 웹 어플리케이션 - 로그인</title>
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
	<!-- 로그인 상태에서 접속할 경우(세션체크) -->
	<%if(session.getAttribute("name")!=null){ %>
	<script>alert("먼저 로그아웃 해주세요."); location.href="/classroom_rental/";</script>
	<%}%>
	<div id="wrap">
		<div class="container">
			<h1 class="page-header">
				<a href="/classroom_rental/"><img src="/classroom_rental/resources/images/logo.png" width="65px"></a>
			</h1>
			<p class="lead">강의실 예약 시스템_김원정(201403038).WebApp</p><br>
			<div>
				<div class="menu">
					<ul class="nav nav-pills">
						<li><a href="/classroom_rental/">홈</a></li>
						<li><a href="/classroom_rental/boardList.do">게시판</a></li>
						<li class="active"><a href="/classroom_rental/views/main/login.jsp">로그인</a></li>
						<li><a href="/classroom_rental/views/main/join.jsp">회원가입</a></li>
					</ul>
				</div>
			</div>
			<div class="content">
				<div class="col-md-4 col-md-offset-4">
					<div style="color:blue; margin-bottom:5px;" class="text-center">
						<!-- 성공 메시지가 존재할 경우 -->
						${success}
					</div>
					<div style="color:red; margin-bottom:5px;" class="text-center">
						<!-- 에러 메시지가 존재할 경우 -->
						${error}
					</div> 
					<h2>로그인</h2>
					<div>
						<form id="loginForm" action="/classroom_rental/login.do" method="POST">
							<p>
								<input id="id" name="id" type="number" placeholder="201403038" class="form-control">
							</p>
							<p>
								<input id="password" name="password" type="password" placeholder="******" class="form-control" onkeypress="if(event.keyCode==13) {formCheck(); return false;}">
							</p>
						</form>
							<p>
								<button onclick="formCheck()" class="btn btn-lg btn-warning btn-block">Login</button>
							</p>
							<p class="text-right">
								아직 회원이 아니신가요? |&nbsp;<a href="/classroom_rental/views/main/join.jsp">회원가입</a>
							</p>
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
		/* 폼 입력 값 유효성 체크 */
		function formCheck() {
			// 입력 값 유효성 체크1: 입력 값을 모두 입력하였는지
			if ($("#id").val() == ""){
				alert("아이디를 입력하여 주세요."); // 경고창을 띄우고
				$("#id").focus(); // 해당 태그에 포커스
				return false; // 함수 호출 종료
			} else if ($("#password").val() == ""){
				alert("비밀번호를 입력하여 주세요.");
				$("#password").focus();
				return false;
			} else {
				// 유효성 체크에 이상이 없을 경우 회원가입 폼 전송
				$("#loginForm").submit();
			}
		}
	</script>
</body>
</html>