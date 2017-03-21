<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
						<li><a href="/classroom_rental/classroomRentalList.do">강의실 대여</a></li>
						<li><a href="/classroom_rental/views/admin/notice_mng.jsp">공지사항 등록</a></li>
						<li><a href="/classroom_rental/boardList.do">게시판</a></li>
						<li class="active"><a href="/classroom_rental/userRentalMng.do">나의 신청현황</a></li>
						<li><a href="/classroom_rental/logout.do">로그아웃</a></li>
						<li style="float: right;"><a href="#"><%=session.getAttribute("name")%>님 환영합니다.</a></li>
						<%
								/* 일반 사용자일 경우 */
								} else {
						%>
						<li><a href="/classroom_rental/classroomRentalList.do">강의실 대여</a></li>
						<li><a href="/classroom_rental/boardList.do">게시판</a></li>
						<li class="active"><a href="/classroom_rental/userRentalMng.do">나의 신청현황</a></li>
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
				<hr/>
				<!-- 강의실 대여 신청서 리스트 -->
				<div id="rentalList" style="height:overflow: auto">
					<table id="rentalListContent" class="table">
						<tr style="color:black; background-color:#fcf8e3;">
							<th>번호</th>
							<th>이름</th>
							<th>학번</th>
							<th>학과</th>
							<th>전화번호</th>
							<th>강의실명</th>
							<th>사용일시</th>
							<th>예약시간</th>
							<th class="text-center">사용목적</th>
							<th class="text-center">상태</th>
							<th class="text-center">신청 취소하기</th>
						</tr>
						<c:forEach items="${rentalReportList}" var="rentalReport">
							<tr>
								<td>
									${fn:substring(rentalReport.rental_date, 0, fn:indexOf(rentalReport.rental_date, ","))}
									<c:set var="tmp_rental_id" value="${fn:substring(rentalReport.rental_date, fn:indexOf(rentalReport.rental_date, ',')+1, fn:length(rentalReport.rental_date))}"/>
								</td>
								<td>${rentalReport.user_name}</td>
								<td>${rentalReport.user_id}</td>
								<td>
									<c:choose>
								       <c:when test="${fn:length(rentalReport.user_department) > 3}">${fn:substring(rentalReport.user_department,0,3)}...</c:when>
								       <c:when test="${fn:length(rentalReport.user_department) <= 3}">${rentalReport.user_department}</c:when>
								   </c:choose>
								</td>
								<td>${rentalReport.user_tel}</td>
								<td>${rentalReport.rental_name}</td>
								<td>${rentalReport.rental_alldate}</td>
								<td>
									<c:choose>
								       <c:when test="${fn:length(rentalReport.rental_chk_time) > 9}">${fn:substring(rentalReport.rental_chk_time,0,8)}...</c:when>
								       <c:when test="${fn:length(rentalReport.rental_chk_time) <= 9}">${rentalReport.rental_chk_time}</c:when>
								   </c:choose>
							   	</td>
								<td class="text-center">
									<button type="button" class="btn btn-default btn-sm"
										onClick="rentalUseReasonModalOpen('${rentalReport.rental_reason}')">
										<span class="glyphicon glyphicon-folder-open"></span>
									</button>
								</td>
								<td class="text-center">
									<c:choose>
									    <c:when test="${rentalReport.rental_state eq 'true'}">
											<button type="button" class="btn btn-success btn-sm" disabled="disabled">승인</button>
										</c:when>
									    <c:when test="${rentalReport.rental_state eq 'false'}">
											<button type="button" class="btn btn-info btn-sm" disabled="disabled">대기</button>
										</c:when>
									    <c:when test="${rentalReport.rental_state eq 'reject'}">
											<button type="button" class="btn btn-danger btn-sm" disabled="disabled">반려</button>
										</c:when>
									</c:choose>
								</td>
								<td class="text-center">
									<button type="button" class="btn btn-danger btn-sm"
										onClick="rentalDeleteModalOpen('${tmp_rental_id}')">
										<span class="glyphicon glyphicon-remove"></span>
									</button>
								</td>
							</tr>
						</c:forEach>
					</table>
					
					<!-- 사용목적 Modal-->
					<div id="rentalUseReasonModal" class="modal fade" role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">사용목적</h4>
								</div>
								<div class="modal-body" id="rentalUseReasonModalBody">
								</div>
							</div>
						</div>
					</div>
				
					<!-- 사용 신청 취소하기 Modal-->
					<div id="rentalDeleteModal" class="modal fade" role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">신청 취소하기</h4>
								</div>
								<div class="modal-body text-center" id="rentalDeleteModalBody">
									<div class="text-center">
										<h4>정말 취소하시겠습니까?</h3>
										<form action="/classroom_rental/userRentalMngDelete.do" method="POST" id="rentalDeleteForm">
											<input type="hidden" name="rentalId" id="rentalId" value="">
										</form>
									</div>
								</div>
								<div class="modal-footer">
									<button type="submit" form="rentalDeleteForm" class="btn btn-warning">YES</button>
									<button type="button" class="btn btn-warning" data-dismiss="modal">NO</button>
									<div class="text-center">
									</div>
								</div>
							</div>
						</div>
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
				alert("강의실 사용 신청서 취소에 성공하였습니다.");
				location.href = '/classroom_rental/userRentalMng.do';
			} else if ("${result}"=="false") {
				alert("유효하지 않은 요청입니다. 확인 후 다시 시도해주시기 바랍니다.");
				location.href = '/classroom_rental/userRentalMng.do';
			} else { } 
		});
		
		/* 사용목적 모달 */
		function rentalUseReasonModalOpen(useReason) {
			document.getElementById('rentalUseReasonModalBody').innerHTML="<p>"+useReason+"</p>";
			$('#rentalUseReasonModal').modal('toggle');
		}

		/* 신청취소 모달 */
		function rentalDeleteModalOpen(rentalId) {
			document.getElementById('rentalId').value = rentalId;
			$('#rentalDeleteModal').modal('toggle');
		}
		
	</script>