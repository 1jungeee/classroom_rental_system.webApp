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
						<li class="active"><a href="/classroom_rental/">홈</a></li>
						<%
							/* 세션이 존재할 경우 */
							if (session.getAttribute("isAdmin") != null) { 
								/* 관리자일 경우 */
								if (session.getAttribute("isAdmin").equals("1")) {
						%>
						<li><a href="/classroom_rental/adminRentalMng.do">강의실 대여 관리</a></li>
						<li><a href="/classroom_rental/classroomRentalList.do">강의실 대여</a></li>
						<li><a href="/classroom_rental/views/admin/notice_mng.jsp">공지사항 등록</a></li>
						<li><a href="/classroom_rental/boardList.do">게시판</a></li>
						<li><a href="/classroom_rental/userRentalMng.do">나의 신청현황</a></li>
						<li><a href="/classroom_rental/logout.do">로그아웃</a></li>
						<li style="float: right;"><a href="#"><%=session.getAttribute("name")%>님 환영합니다.</a></li>
						<%
								/* 일반 사용자일 경우 */
								} else {
						%>
						<li><a href="/classroom_rental/classroomRentalList.do">강의실 대여</a></li>
						<li><a href="/classroom_rental/boardList.do">게시판</a></li>
						<li><a href="/classroom_rental/userRentalMng.do">나의 신청현황</a></li>
						<li><a href="/classroom_rental/logout.do">로그아웃</a></li>
						<li style="float: right;"><a href="#"><%=session.getAttribute("name")%>님 환영합니다.</a></li>
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
				<hr/>
				<!-- //구분선 삽입 -->
				<div class="row">
					<div class="col-md-4">
						<h2>강의실 대여</h2>
						<p class="text-justify">한국성서대학교 캠퍼스 내의 빈 강의실을 무료로 대여해줍니다. 교내 학생이라면 비용의 제한없이 무료로 대여 신청이 가능합니다. 간단한 신청서를 제출해주시면 해당 관리자가 확인 후 승인이 이루어지면 대여가 완료됩니다.</p>
						<p><a class="btn" style="background-color:#fcf8e3;" href="/classroom_rental/classroomRentalList.do" role="button">강의실 대여하러 가기 »</a></p>
					</div>
					<div class="col-md-4">
						<h2>게시판</h2>
						<p class="text-justify">강의실 예약 서비스의 공개 게시판 입니다. 회원 비회원 모두 게시글을 열람하실 수 있으나 게시글 작성 및 댓글 서비스는 회원에 한해 가능합니다. 해당 서비스와 관련하여 다양한 의견, 문의, 자유글 등을 기재하실 수 있습니다.</p>
						<p><a class="btn" style="background-color:#fcf8e3;" href="/classroom_rental/boardList.do" role="button">게시판 가기 »</a></p>
					</div>
					<div class="col-md-4">
						<h2>사이트 문의</h2>
						<p class="text-justify">해당 서비스는 아직 구현이 완료되지 않아 준비중 입니다. 관련 문의사항이나 개발에 관한 의견이 있으신 분은 컴퓨터소프트웨어학과 3학년에 재학 중인 김원정 학생을 찾아 문의 해주면 정말 감사하겠습니다.</p>
						<p><a class="btn" style="background-color:#fcf8e3;" href="#" role="button">문의하러 가기 »</a></p>
					</div>
				</div>
				<!-- 구분선 삽입 -->
				<hr/>
				<!-- //구분선 삽입 -->
				<br>
				<div id="main_area">
					<!-- Slider -->
					<div class="row">
						<div class="col-xs-12" id="slider">
							<div class="row">
								<div class="col-sm-8" id="carousel-bounding-box">
									<div class="carousel slide" id="myCarousel">
										<!-- Carousel items -->
										<div class="carousel-inner">
											<div class="active item" data-slide-number="0">
												<img src="/classroom_rental/resources/images/carousel_img/room1.jpg">
											</div>
											<div class="item" data-slide-number="1">
												<img src="/classroom_rental/resources/images/carousel_img/room2.jpg">
											</div>
											<div class="item" data-slide-number="2">
												<img src="/classroom_rental/resources/images/carousel_img/room3.jpg">
											</div>
											<div class="item" data-slide-number="3">
												<img src="/classroom_rental/resources/images/carousel_img/room4.jpg">
											</div>
											<div class="item" data-slide-number="4">
												<img src="/classroom_rental/resources/images/carousel_img/room5.jpg">
											</div>
											<div class="item" data-slide-number="5">
												<img src="/classroom_rental/resources/images/carousel_img/room6.jpg">
											</div>
										</div>
										<!-- Carousel nav -->
										<a class="left carousel-control" href="#myCarousel"
											role="button" data-slide="prev"> <span
											class="glyphicon glyphicon-chevron-left"></span>
										</a> <a class="right carousel-control" href="#myCarousel"
											role="button" data-slide="next"> <span
											class="glyphicon glyphicon-chevron-right"></span>
										</a>
									</div>
								</div>

								<div class="col-sm-4" id="carousel-text"></div>

								<div id="slide-content" style="display: none;">
									<div id="slide-content-0">
										<h2>로고스홀</h2>
										<p>» 좌석수 : 연결식 의자 659석</p>
										<p>» 이용가능 설비 : 특수조명, 빔프로젝터, 음향, 피아노</p>
										<p>» 현수막 길이 : 800 cm</p>
										<p>» 용도 : 공연, 세미나, 결혼식</p>
										<p class="sub-text">
											<a href="/classroom_rental/classroomRentalList.do">» 대여하러 가기</a>
										</p>
									</div>

									<div id="slide-content-1">
										<h2>정보 2실</h2>
										<p>» 컴퓨터소프트웨어학과 3학년 과실</p>
										<p>» 컴퓨터소프트웨어학과 3학년 학생들만 신청 가능</p>
										<p class="sub-text">
											<a href="/classroom_rental/classroomRentalList.do">» 대여하러 가기</a>
										</p>
									</div>

									<div id="slide-content-2">
										<h2>갈멜관 305호</h2>
										<p>» 이용가능 설비 : 빔프로젝터, 피아노</p>
										<p class="sub-text">
											<a href="/classroom_rental/classroomRentalList.do">» 대여하러 가기</a>
										</p>
									</div>
									<div id="slide-content-3">
										<h2>모리아관 303호</h2>
										<p>» 이용가능 설비 : 빔프로젝터</p>
										<p class="sub-text">
											<a href="/classroom_rental/classroomRentalList.do">» 대여하러 가기</a>
										</p>
									</div>
									<div id="slide-content-4">
										<h2>천마홀</h2>
										<p>밀알관 지하 1층</p>
										<p>» 이용가능 설비 : 빔프로젝터</p>
										<p class="sub-text">
											<a href="/classroom_rental/classroomRentalList.do">» 대여하러 가기</a>
										</p>
									</div>
									<div id="slide-content-5">
										<h2>복음관 301호</h2>
										<p>» 이용가능 설비 : 빔프로젝터</p>
										<p class="sub-text">
											<a href="/classroom_rental/classroomRentalList.do">» 대여하러 가기</a>
										</p>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!--/Slider-->

					<div class="row hidden-xs" id="slider-thumbs">
						<!-- Bottom switcher of slider -->
						<ul class="hide-bullets">
							<li class="col-sm-2"><a class="thumbnail"
								id="carousel-selector-0"><img
									src="/classroom_rental/resources/images/carousel_img/room1.jpg"></a></li>
							<li class="col-sm-2"><a class="thumbnail"
								id="carousel-selector-1"><img
									src="/classroom_rental/resources/images/carousel_img/room2.jpg"></a></li>
							<li class="col-sm-2"><a class="thumbnail"
								id="carousel-selector-2"><img
									src="/classroom_rental/resources/images/carousel_img/room3.jpg"></a></li>
							<li class="col-sm-2"><a class="thumbnail"
								id="carousel-selector-3"><img
									src="/classroom_rental/resources/images/carousel_img/room4.jpg"></a></li>
							<li class="col-sm-2"><a class="thumbnail"
								id="carousel-selector-4"><img
									src="/classroom_rental/resources/images/carousel_img/room5.jpg"></a></li>
							<li class="col-sm-2"><a class="thumbnail"
								id="carousel-selector-5"><img
									src="/classroom_rental/resources/images/carousel_img/room6.jpg"></a></li>
						</ul>
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
		jQuery(document).ready(function($) {
			$('#myCarousel').carousel({
				interval : 5000
			});

			$('#carousel-text').html($('#slide-content-0').html());

			$('[id^=carousel-selector-]').click(function() {
				var id = this.id.substr(this.id.lastIndexOf("-") + 1);
				var id = parseInt(id);
				$('#myCarousel').carousel(id);
			});

			$('#myCarousel').on('slid.bs.carousel', function(e) {
				var id = $('.item.active').data('slide-number');
				$('#carousel-text').html($('#slide-content-' + id).html());
			});
		});
	</script>
</body>
</html>