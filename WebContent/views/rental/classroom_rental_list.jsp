<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<head>
	<meta charset="UTF-8">
	<title>강의실 예약 웹 어플리케이션 - 강의실 예약현황</title>
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
				<a href="/classroom_rental/"><img
					src="/classroom_rental/resources/images/logo.png" width="65px"></a>
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
						<li class="active"><a href="/classroom_rental/classroomRentalList.do">강의실 대여</a></li>
						<li><a href="/classroom_rental/views/admin/notice_mng.jsp">공지사항 등록</a></li>
						<li><a href="/classroom_rental/boardList.do">게시판</a></li>
						<li><a href="/classroom_rental/userRentalMng.do">나의 신청현황</a></li>
						<li><a href="/classroom_rental/logout.do">로그아웃</a></li>
						<li style="float: right;"><a href="#"><%=session.getAttribute("name")%>님 환영합니다.</a></li>
						<%
								/* 일반 사용자일 경우 */
								} else {
						%>
						<li class="active"><a href="/classroom_rental/classroomRentalList.do">강의실 대여</a></li>
						<li><a href="/classroom_rental/boardList.do">게시판</a></li>
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
				<hr><br>
				<!-- 카테고리 별 검색 -->
				<form class="form-inline">
					<div class="form-group" style="float: right;">
						<div class="form-group">
							<input type="week" id="category1" name="category1"
								class="form-control" value="${category1}" style="width:180px;">&nbsp;
						</div>
						<div class="form-group">
							<select class="form-control" id="category2" name="category2" onchange="category2Func()" style="width:105px;">
								<c:forEach items="${category2}" var="building">
									<option value="${building}">${building}</option>
								</c:forEach>
							</select>&nbsp;
						</div>
						<div class="form-group">
							<select class="form-control" id="category3" name="category3" onchange="category3Func()" style="width:145px;">
								<c:forEach items="${category3}" var="classRoom">
									<option value="${classRoom.id},${classRoom.name}">${classRoom.name}</option>
								</c:forEach>
							</select>&nbsp;
						</div>
						<div class="form-group">
							<input type="text" id="category4" name="category4"
								class="form-control"  disabled placeholder="Enter search" style="width:145px;">&nbsp;
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-default" onclick="search()">
								<span class="glyphicon glyphicon-search"></span> 검색하기
							</button>
						</div>
					</div>
				</form>
				<br><br><br>
				<!-- 강의실 예약 현황 리스트 -->
				<div style="padding-bottom:7px;">
					<ul class="nav nav-pills">
						<li><button type="button" class="btn btn-circle btn-sm" style="background-color: #f2dede">대기</button></li>
						<li><button type="button" class="btn btn-circle btn-sm" style="background-color: #d9edf7">승인</button></li>
						<li><button type="button" class="btn btn-circle btn-sm" style="background-color: #fcf8e3">고정</button></li>
						<li style="float: right;">
							<button type="button" class="btn btn-default" onclick="rentalFormOpen()"><span class="glyphicon glyphicon-edit"></span> 대여 신청하기</button>
						</li>
						<li style="float: right;">
							<button type="button" class="btn btn-default" id="search_btn">${category1}, ${category2[0]}, ${category3[0].name}</button>&nbsp;&nbsp;
						</li>
					</ul>
				</div>
				<div id="timetable">
					<table class="table table-bordered" style="table-layout:fixed;">
						<tr style="background-color: #f0ad4e;">
							<th class="text-center">시간</th>
							<th class="text-center">월</th>
							<th class="text-center">화</th>
							<th class="text-center">수</th>
							<th class="text-center">목</th>
							<th class="text-center">금</th>
							<th class="text-center">토</th>
							<th class="text-center">일</th>
						</tr>
					${timetable}
					</table>
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
	
	
	<!-- 예약하기 Modal-->
	<div id="rentalModal" class="modal fade" role="dialog">
		<div class="modal-dialog" style="width:80%">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">강의실 사용 신청서</h4>
				</div>
				<div class="modal-body">
					<iframe name="rental" src="views/rental/classroom_rental_form.jsp" width="100%" height="800px;" style="border: 0 solid #FFFFFF;"></iframe>
				</div>
			</div>
		</div>
	</div>
	
	
	<script>
	
	$(document).ready(function() {
		/* 선택된 카테고리2 내용을 검색창(category3)에 기본값으로  초기화하기 */
		category3Func();
	});
	
	/* 선택된 카테고리2 내용을 검색창(category3)에 기본값으로  초기화하기 */
	function category3Func() {
		document.getElementById("category4").value = $("#category3").val().split(",")[1];
	}
	

	
	/* 건물명으로 DB 조회해서 강의실(category3) 리스트 가져오기 */
	function category2Func() {
		var category2 = "category2="+$("#category2").val();
		$.ajax({
			url : "/classroom_rental/classroomRentalListCategory.do",
			type : "GET",
			data : category2,
			success : ajaxCategory3S,
			error : ajaxCategory3E
		});
	}
	
	/* 강의실 리스트 가져오기 비동기통신이 성공일 경우 */
	function ajaxCategory3S(resdata) {
		$("#category3").html(resdata);
		category3Func();
	}
	
	/* 강의실 리스트 가져오기 비동기통신이 실패일 경우 */
	function ajaxCategory3E() {
		alert("유효하지 않은 요청입니다. 확인 후 다시 요청하여주세요.");
	}


	
	/* 검색하기 */
	function search() {
		/* 건물 id 값 및 시간으로 DB 조회해서 시간표 및 예약현황 리스트 가져오기 */
		var category1 = "category1="+$("#category1").val()+"&";
		var category3 = "category3="+$("#category3").val().split(",")[0];
		$.ajax({
			url : "/classroom_rental/classroomRentalListSearch.do",
			type : "GET",
			data : category1+category3,
			success : ajaxSearchS,
			error : ajaxSearchE
		});
	}
	
	/* 검색하기 비동기통신이 성공일 경우 */
	function ajaxSearchS(resdata) {
		$("#search_btn").html($("#category1").val()+", "+$("#category2").val()+", "+$("#category3").val().split(",")[1]);
		$("#timetable").html(resdata);
	}
	
	/* 검색하기 비동기통신이 실패일 경우 */
	function ajaxSearchE() {
		alert("유효하지 않은 요청입니다. 확인 후 다시 요청하여주세요.");
	}
	
	

	/* 예약하기 신청 완료 */
	function rentalModalSuccess() {
		$('#rentalModal').modal('toggle');
		//추가된 강의실 예약신청에 따른 페이지 리로드
		location.href = '/classroom_rental/classroomRentalList.do';
	}

	/* 예약하기 모달 오픈 */
	function rentalFormOpen() {
		/* 강의실 예약 신청서 폼 초기화 */
		rental.rentalInit();
		$('#rentalModal').modal('toggle');
	}

	/* 예약하기 모달 닫기 */
	function rentalFormClose() {
		$('#rentalModal').modal('toggle');
	}
	</script>
</body>
</html>