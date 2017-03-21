<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<head>
	<meta charset="UTF-8">
	<title>강의실 예약 웹 어플리케이션 - 회원가입</title>
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
						<li><a href="/classroom_rental/views/main/login.jsp">로그인</a></li>
						<li class="active"><a href="/classroom_rental/views/main/join.jsp">회원가입</a></li>
					</ul>
				</div>
			</div>
			<div class="content">
				<div class="col-md-4 col-md-offset-4">
					<div style="color:red; margin-bottom:5px;" class="text-center">
						<!-- 에러 메시지가 존재할 경우 -->
						${error}
					</div>
					<h2>회원가입</h2>
					<div>
						<form id="joinForm" action="/classroom_rental/join.do" method="POST">
							<p>
								<input id="name" name="name" type="text" placeholder=" 김원정" class="form-control">
							</p>
							<p>
								<input id="id" name="id" type="number" placeholder=" 201403038" class="form-control">
							</p>
							<p>
								<input id="password" name="password" type="password" placeholder=" ********" class="form-control">
							</p>
							<p>
								<select class="form-control" id="department" name="department">
									<option value="컴퓨터소프트웨어학과" selected>컴퓨터소프트웨어학과</option>
									<option value="영유아보육학과">영유아보육학과</option>
									<option value="성서학과">성서학과</option>
									<option value="사회복지과">사회복지학과</option>
									<option value="간호학과">간호학과</option>
								</select>
							</p>
							<p>
								<input id="tel" name="tel" type="tel" placeholder=" 010-0000-0000" class="form-control" onkeypress="if(event.keyCode==13) {formCheck(); return false;}">
							</p>
						</form>
							<p>
								<button onclick="formCheck()" class="btn btn-lg btn-warning btn-block">Join</button>
							</p>
							<p class="text-right">
								이미 회원이신가요? |&nbsp;<a href="/classroom_rental/views/main/login.jsp">로그인</a>
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
			if ($("#name").val() == ""){
				alert("이름을 입력하여 주세요."); // 경고창을 띄우고
				$("#name").focus(); // 해당 태그에 포커스
				return false; // 함수 호출 종료
			} else if ($("#id").val() == ""){
				alert("학번을 입력하여 주세요.");
				$("#id").focus();
				return false;
			} else if ($("#password").val() == ""){
				alert("비밀번호를 입력하여 주세요.");
				$("#password").focus()
				return false;
			} else if ($("#tel").val() == ""){
				alert("전화번호를 입력하여 주세요.");
				$("tel").focus()
				return false;
			} else {
				
			}
			
			// 입력 값 유효성 체크2: 정규표현식 사용하여 학번, 전화번호 유효성 검사 진행(RegExp 객체의 match 메소드 사용)
			var regId = /^[0-9]{9}$/; //숫자만 9자리
			var regTel = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/; //전화번호 형식만 
			if (!$("#id").val().match(regId)) {
				alert("학번을 정확히 입력해주세요(9자리 숫자)");
				$("#id").focus();
				return false;
			} else if (!$("#tel").val().match(regTel)) {
				alert("전화번호 형식을 정확히 입력해주세요(xxx-xxxx-xxxx)");
				$("#tel").focus();
				return false;
			} else {
				// 유효성 체크에 이상이 없을 경우 회원가입 폼 전송
				$("#joinForm").submit();
			}
		}
	</script>
</body>
</html>
