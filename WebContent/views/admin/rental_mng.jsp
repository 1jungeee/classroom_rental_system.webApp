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
	<!-- moment(날짜관련) lib load -->
	<script type="text/javascript"	src="/classroom_rental/resources/lib/moment/moment.js"></script>
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
						<li class="active"><a href="/classroom_rental/adminRentalMng.do">강의실 대여 관리</a></li>
						<li><a href="/classroom_rental/classroomRentalList.do">강의실 대여</a></li>
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
				<!-- 강의실 대여 신청서 리스트 -->
				<div id="rentalList" style="overflow: auto">
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
								<td>
									<input type="text" style="border:none;" id="rentalDate_${fn:substring(rentalReport.rental_date, 0, fn:indexOf(rentalReport.rental_date, ','))}" value="${rentalReport.rental_alldate}"/>
								</td>
								<input type="hidden" id="rentalDateH_${fn:substring(rentalReport.rental_date, 0, fn:indexOf(rentalReport.rental_date, ','))}" value="${rentalReport.rental_alldate}"/>
								<script>
									/* 날짜포맷변경 */
									console.log($("#rentalDateH_${fn:substring(rentalReport.rental_date, 0, fn:indexOf(rentalReport.rental_date, ','))}").val());
									var day = $("#rentalDateH_${fn:substring(rentalReport.rental_date, 0, fn:indexOf(rentalReport.rental_date, ','))}").val();
									var year = day.substr(0,4); // 조회조건의 년도 가져오기
									var week = day.substr(6,2); // 조회조건의 주 가져오기
									var m = new moment(); // 날짜 포맷관련 moment 객체 선언
									m.locale();
									m.year(year); // 년도 셋팅
									m.week(week); // 주 셋팅
									console.log(m.format('L'));
									if(m.format('L').substr(0,1) == '0'){
										month = m.format('L').substr(1,1);
									}else{
										month = m.format('L').substr(0,2);
									}
									//월요일을 중심으로한 주차 구하기
								    var minusDay = 0;  //차일 변수
								    var wkDtStr = m.format('L').substr(6,4)+""+m.format('L').substr(0,2)+""+m.format('L').substr(3,2); //주차를 계산할 날짜 
									//계산하고 싶은 달 시작일 1일
								    var stDtStr = wkDtStr.substring(0,6) + "01";
								    var stDtCal = new Date( stDtStr.substring(0,4) , stDtStr.substring(4,6) , stDtStr.substring(6,8) );
								    //요일 구하기
								    var weekCal = new Date( wkDtStr.substring(0,4) , ( wkDtStr.substring(4,6) - 1 ) , wkDtStr.substring(6,8) );
								    //주차를 계산하고싶은 일 달력 생성
								    var wkDtCal = new Date( wkDtStr.substring(0,4) , wkDtStr.substring(4,6) , wkDtStr.substring(6,8) );
								    //매달 시작일에 따른 빼줘야 하는 값
								    var week = new Array( 1, 0, 5, 4, 3, 2, 1 );
								    minusDay = wkDtCal.getDate() - stDtCal.getDate() - week[ weekCal.getDay() ] ;
								    //만약 2일부터 1주차인데 1일을 입력했을경우 혹은 년도가 바뀔경우
								    if( ( minusDay - week[ weekCal.getDay() ] ) < 0 ){
								        wkDtCal.setDate( stDtCal.getDate() - 1 );
								        stDtCal.setDate( stDtCal.getDate() - wkDtCal.getDate() );
								        minusDay = wkDtCal.getDate() - stDtCal.getDate();
								    }
								    var weekNm = minusDay / 7 + 1;
								    console.log(day.substr(9,1));
								    if(day.substr(9,1)=='1'){
										$("#rentalDate_${fn:substring(rentalReport.rental_date, 0, fn:indexOf(rentalReport.rental_date, ','))}").val(m.format('L').substr(6,4)+"년 "+month+"월 "+parseInt(weekNm)+"주 월요일");
									}else if(day.substr(9,1)=='1'){
										$("#rentalDate_${fn:substring(rentalReport.rental_date, 0, fn:indexOf(rentalReport.rental_date, ','))}").val(m.format('L').substr(6,4)+"년 "+month+"월 "+parseInt(weekNm)+"주 화요일");
									}else if(day.substr(9,1)=='1'){
										$("#rentalDate_${fn:substring(rentalReport.rental_date, 0, fn:indexOf(rentalReport.rental_date, ','))}").val(m.format('L').substr(6,4)+"년 "+month+"월 "+parseInt(weekNm)+"주 수요일");
									}else if(day.substr(9,1)=='1'){
										$("#rentalDate_${fn:substring(rentalReport.rental_date, 0, fn:indexOf(rentalReport.rental_date, ','))}").val(m.format('L').substr(6,4)+"년 "+month+"월 "+parseInt(weekNm)+"주 목요일");
									}else if(day.substr(9,1)=='1'){
										$("#rentalDate_${fn:substring(rentalReport.rental_date, 0, fn:indexOf(rentalReport.rental_date, ','))}").val(m.format('L').substr(6,4)+"년 "+month+"월 "+parseInt(weekNm)+"주 금요일");
									}else if(day.substr(9,1)=='1'){
										$("#rentalDate_${fn:substring(rentalReport.rental_date, 0, fn:indexOf(rentalReport.rental_date, ','))}").val(m.format('L').substr(6,4)+"년 "+month+"월 "+parseInt(weekNm)+"주 토요일");
									}else{
										$("#rentalDate_${fn:substring(rentalReport.rental_date, 0, fn:indexOf(rentalReport.rental_date, ','))}").val(m.format('L').substr(6,4)+"년 "+month+"월 "+parseInt(weekNm)+"주 일요일");
									}
								    
								</script>
								<td>
									<c:choose>
								       <c:when test="${fn:length(rentalReport.rental_chk_time) > 9}">${fn:substring(rentalReport.rental_chk_time,0,8)}...</c:when>
								       <c:when test="${fn:length(rentalReport.rental_chk_time) <= 9}">${rentalReport.rental_chk_time}</c:when>
								   </c:choose>
							   	</td>
							   	
							   	<!--<td>
							   	<c:choose>
							       <c:when test="${fn:indexOf(rentalReport.rental_chk_time, '1') != -1}">0</c:when>
								</c:choose>
							   	</td>-->
							   	
								<td class="text-center">
									<button type="button" class="btn btn-default btn-sm"
										onClick="rentalUseReasonModalOpen('${rentalReport.rental_reason}')">
										<span class="glyphicon glyphicon-folder-open"></span>
									</button>
								</td>
								<td class="text-center">
									<c:choose>
									    <c:when test="${rentalReport.rental_state eq 'true'}">
											<button type="button" class="btn btn-success btn-sm"
												onClick="rentalStateChangeModalOpen('true','${tmp_rental_id}')">
												승인 <span class="glyphicon glyphicon-edit"></span>
											</button>
										</c:when>
									    <c:when test="${rentalReport.rental_state eq 'false'}">
											<button type="button" class="btn btn-info btn-sm"
												onClick="rentalStateChangeModalOpen('false','${tmp_rental_id}')">
												대기 <span class="glyphicon glyphicon-edit"></span>
											</button>
										</c:when>
									    <c:when test="${rentalReport.rental_state eq 'reject'}">
											<button type="button" class="btn btn-danger btn-sm"
												onClick="rentalStateChangeModalOpen('reject','${tmp_rental_id}')">
												반려 <span class="glyphicon glyphicon-edit"></span>
											</button>
										</c:when>
									</c:choose>
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
				
					<!-- 상태 변경 Modal-->
					<div id="rentalStateChangeModal" class="modal fade" role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">상태 변경하기</h4>
								</div>
								<div class="modal-body text-center" id="rentalStateChangeModalBody">
									<form action="/classroom_rental/adminRentalMngStateChange.do" method="POST" id="stateChngForm">
										<input type="radio" name="state" id="true" value="true" checked> 승인&nbsp;&nbsp;&nbsp;
										<input type="radio" name="state" id="false" value="false"> 대기&nbsp;&nbsp;&nbsp;
										<input type="radio" name="state" id="reject" value="reject"> 반려
										<input type="hidden" name="rentalId" id="rentalId" value="">
									</form>
								</div>
								<div class="modal-footer">
									<button type="submit" form="stateChngForm" class="btn btn-warning">변경하기</button>
									<button type="button" class="btn btn-warning" data-dismiss="modal">취소</button>
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
				<span>Copyright © 2017 | <a href="https://www.bible.ac.kr">bible.ac.kr</a></span>
				<span style="float: right;"><a href="/classroom_rental/views/main/site_map.jsp">+사이트 맵</a></span>
			</p>
		</div>
	</footer>
	
	<script>
		$(document).ready(function() {
			if ("${result}"=="true") {
				alert("상태 변경에 성공하였습니다.");
				location.href = '/classroom_rental/adminRentalMng.do';
			} else if ("${result}"=="false") {
				alert("유효하지 않은 요청입니다. 확인 후 다시 시도해주시기 바랍니다.");
				location.href = '/classroom_rental/adminRentalMng.do';
			} else { } 
			
		});
		
		/* 사용목적 모달 */
		function rentalUseReasonModalOpen(useReason) {
			document.getElementById('rentalUseReasonModalBody').innerHTML="<p>"+useReason+"</p>";
			$('#rentalUseReasonModal').modal('toggle');
		}

		/* 상태변경 모달 */
		function rentalStateChangeModalOpen(state, rentalId) {
			if (state=="true") {
				document.getElementsByName('state')[0].checked = true;
			} else if (state=="false") {
				document.getElementsByName('state')[1].checked = true;
			} else if (state=="reject") {
				document.getElementsByName('state')[2].checked = true;
			} else { }
			document.getElementById('rentalId').value = rentalId;
			$('#rentalStateChangeModal').modal('toggle');
		}
		
	</script>