<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!-- BootStrap, JQuery load -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<div class="container">
	<!-- 강의실 예약 신청서 양식 -->
	<form id="rentalForm" action="/classroom_rental/classroomRentalFormReport.do" method="POST">
		<!-- 신청자 인적 정보 -->
		<label class="control-label"><span class="glyphicon glyphicon-user"></span> 신청인 정보</label>
		<hr/>
		<div class="form-group row">
			<label for="inputName" class="col-sm-2 col-form-label">이름</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="inputName" disabled value="<%=session.getAttribute("name")%>">
				<input type="hidden" class="form-control" name="user_name" value="<%=session.getAttribute("name")%>">
			</div>
		</div>
		<div class="form-group row">
			<label for="inputNumber" class="col-sm-2 col-form-label">학번</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="inputNumber" disabled value="<%=session.getAttribute("id")%>">
				<input type="hidden" class="form-control" name="user_id" value="<%=session.getAttribute("id")%>">
			</div>
		</div>
		<div class="form-group row">
			<label for="inputDepartment" class="col-sm-2 col-form-label">학과</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="inputDepartment" disabled value="<%=session.getAttribute("department")%>">
				<input type="hidden" class="form-control" name="user_department" value="<%=session.getAttribute("department")%>">
			</div>
		</div>
		<div class="form-group row">
			<label for="inputTel" class="col-sm-2 col-form-label">전화번호</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="inputTel" disabled value="<%=session.getAttribute("tel")%>">
				<input type="hidden" class="form-control" name="user_tel" value="<%=session.getAttribute("tel")%>">
			</div>
		</div>
		<hr/><br>
		<!-- 신청 강의실 정보 -->
		<label class="control-label"><span class="glyphicon glyphicon-edit"></span> 대여 강의실 정보</label>
		<hr/>
		<div class="form-group row">
			<label for="rentalRoomName" class="col-sm-2 col-form-label">강의실명</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="rentalRoomName" disabled value="">
				<input type="hidden" class="form-control" name="rental_name" id="tmp_rentalRoomName" value="">
			</div>
		</div>
		<div class="form-group row">
			<label for="rentalTime" class="col-sm-2 col-form-label">사용일시</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="rentalTime" disabled value="">
				<input type="hidden" class="form-control" name="rental_alldate" id="tmp_rentalTime" value="">
			</div>
		</div>
		<div class="form-group row">
			<label for="rentalTable" class="col-sm-2 col-form-label">예약시간</label>
			<div class="col-sm-10">
				<div id="rentalTable"></div>
			</div>
		</div>
		<div class="form-group row">
			<label for="rentalReason" class="col-sm-2 col-form-label">사용목적</label>
			<div class="col-sm-10">
				<textarea class="form-control" name="rental_reason" id="rental_reason" rows="4" style="resize: none; wrap:hard;"></textarea>
			</div>
		</div>
		<hr/><br>
		<!-- 그 외 체크 사항 -->
		<label class="control-label"><span class="glyphicon glyphicon-check"></span> 그 외 체크 사항</label>
		<hr/>
		<div class="form-group row">
			<label for="rentalAgreement" class="col-sm-2 col-form-label">개인정보</label>
			<div class="col-sm-10">
				<textarea class="form-control" id="rentalAgreement" disabled rows="3" style="overflow:hidden; resize: none; wrap:hard;">※	이용목적 : 강의실 사용 신청 확인 및 변경 시 연락	※
※	이용할 개인 정보 : 성명, 휴대전화번호			※
※	본 신청서는 사용목적을 완료한 이후 즉시 파기함	※</textarea>
			</div>
		</div>
		<div class="form-group row">
			<label for="rentalInstructions" class="col-sm-2 col-form-label">유의사항</label>
			<div class="col-sm-10">
				<textarea class="form-control" id="rentalInstructions" disabled rows="3" style="overflow:hidden; resize: none; wrap:hard;">△ 강의실 사용 3일 전에 사용신청서를 제출해 주시기 바랍니다.
△ 학회, 동아리 등 지도(책임)교수가 있는 단체만 신청 가능합니다.
△ 사용 후 반드시 정리정돈을 해야 합니다.</textarea>
			</div>
		</div>
		<div class="form-group row">
			<label for="rentalStep" class="col-sm-2 col-form-label">예약절차</label>
			<div class="col-sm-10">
				<textarea class="form-control" id="rentalStep" disabled rows="3" style="overflow:hidden; resize: none; wrap:hard;">(신청)			학생		→	강의실 사용 신청서 작성
(승인 및 거절)		교학팀	→	신청서 확인 및 승인 혹은 거절
(승인여부안내)		학생		→	내 신청서 현황 확인하기</textarea>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">동의여부</label>
			<div class="col-sm-10">
				<div class="form-check">
				<label class="form-check-label">
					<input class="form-check-input" name="rental_chk_agree" type="checkbox"> 위 모든 사항에 동의하여 강의실 사용 신청서를 작성합니다.
				</label>
				</div>
			</div>
		</div>
	</form>
	
	<hr/><br>
	<!-- 신청하기 및 취소 버튼 -->
	<div class="text-center">
		<a class="btn btn-warning" role="button" onclick="sendForm()">신청하기 »</a>&nbsp;&nbsp;&nbsp;
		<a class="btn btn-warning" role="button" onclick="closeForm()">작성취소 »</a>
	</div>
</div>


<script>
$(document).ready(function() {
	if ("${result}"=="1") {
		alert("강의실 사용 신청서가 정상적으로 제출되었습니다.");
		parent.rentalModalSuccess();
	} else if ("${result}"=="1") {
		alert("유효하지 않은 요청입니다. 확인 후 관리자에게 문의해주시기 바랍니다.");
		parent.rentalModalSuccess();
	} else { }
});

/* 신청서 내용 초기화 */
function rentalInit(){
	document.getElementById('rentalRoomName').value = parent.document.getElementById('category2').value + "-" + parent.document.getElementById('category4').value;
	document.getElementById('tmp_rentalRoomName').value = parent.document.getElementById('category3').value.split(",")[0];
	document.getElementById('rentalTime').value = parent.document.getElementById('category1').value;
	document.getElementById('tmp_rentalTime').value = parent.document.getElementById('category1').value;
	
	/* 건물 id 값 및 시간으로 DB 조회해서 예약 가능한 시간 리스트 가져오기 */
	var category1 = "category1="+parent.document.getElementById('category1').value+"&";
	var category3 = "category3="+parent.document.getElementById('category3').value.split(",")[0];
	
	$.ajax({
		url : "/classroom_rental/classroomRentalForm.do",
		type : "GET",
		data : category1+category3,
		success : ajaxRentalSearchS,
		error : ajaxRentalSearchE
	});
}

/* 예약 가능한 시간 조회 비동기통신이 성공일 경우 */
function ajaxRentalSearchS(resdata) {
	$("#rentalTable").html(resdata);
}

/* 예약 가능한 시간 조회 비동기통신이 실패일 경우 */
function ajaxRentalSearchE() {
	alert("유효하지 않은 요청입니다. 확인 후 다시 요청하여주세요.");
}



/* 강의실 사용 신청서 제출 */
function sendForm() {
	formCheck();
}

/* 폼 입력 값 유효성 체크 */
function formCheck() {
	// 예약시간 체크박스 값
	var useRentalTime_chkbox = document.getElementsByName('rental_chk_time');
	// 사용목적 값
	var rentalReason = document.getElementById('rental_reason').value;
	// 동의 여부
	var rentalAgree_chkbox = document.getElementsByName('rental_chk_agree');
	
	// 예약시간에 하나라도 체크가 되어있으면 isUseRentalTime = true
	var isUseRentalTime = false;
	for (var i=0; i<useRentalTime_chkbox.length; i++) {
		if (useRentalTime_chkbox[i].checked == true) {
			isUseRentalTime = true;
		}
	}
	if (isUseRentalTime == false) {
		alert("하나 이상의 사용시간을 선택해주세요 !")
	} else if (rentalReason == "") {
		alert("사용목적을 입력해주세요 !")
	} else if (rentalAgree_chkbox[0].checked == false) {
		alert("그 외 체크사항에 동의하여주세요 !")
	} else {
		// 유효성 체크에 이상이 없을 경우 강의실 사용 신청서 폼 전송
		$("#rentalForm").submit();
	}
}

/* 강의실 사용 신청서 작성취소 */
function closeForm() {
	parent.rentalFormClose();
}
</script>
