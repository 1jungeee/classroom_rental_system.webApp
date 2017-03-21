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
				<h4>게시글 읽기</h4>
				<hr/>
				<div id="boardPost" style="">
				<!-- 게시판 -->
					<form id="boardPostForm" action="#" method="POST">
						<!-- 게시글 제목 -->
						<div class="form-group row">
							<label for="inputTitle" class="col-sm-2 col-form-label">제목</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="inputTitle" disabled name="board_title" value="${boardRead.board_title}">
							</div>
						</div>
						<!-- 게시글 작성자 -->
						<div class="form-group row">
							<label for="inputName" class="col-sm-2 col-form-label">작성자</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="inputName" disabled value="${boardRead.user_name}">
							</div>
						</div>
						<!-- 게시글 내용 -->
						<div class="form-group row">
							<label for="inputBody" class="col-sm-2 col-form-label">내용</label>
							<div class="col-sm-10">
								<textarea class="form-control" id="inputBody" disabled name="board_body" rows="8" style="resize: none; wrap:hard;">${boardRead.board_body}</textarea>
							</div>
						</div>
						<!-- 첨부파일 -->
						<div class="form-group row">
							<label for="inputFile" class="col-sm-2 col-form-label">첨부파일</label>
							<div class="col-sm-10">
						<c:choose>
						    <c:when test="${boardRead.board_file eq 'null'}">
								<a href="#">
									<button type="button" class="btn btn-default btn-sm">
							        	<span class="glyphicon glyphicon-download-alt"></span> 첨부파일이 존재하지 않습니다.
							        </button>
							    </a>
						    </c:when>
							<c:otherwise>
								<a href="/classroom_rental/uploads/${boardRead.board_file}" download>
									<button type="button" class="btn btn-default btn-sm">
							        	<span class="glyphicon glyphicon-download-alt"></span>  ${boardRead.board_file}
							        </button>
							    </a>
						    </c:otherwise>
					 	</c:choose>
							</div>
						</div>
						<hr/>
					</form>
					
					<!-- 댓글 리스트 관련 -->
					<div>
						<form id="boardPostCommentListForm" action="#">
							<!-- 댓글이 존재할 경우 -->
							<c:choose>
							    <c:when test="${fn:length(boardCommentList) > 0}">
							    	<c:forEach items="${boardCommentList}" var="boardComment" varStatus="status">
										<div class="form-group row">
											<label for="inputTitle" class="col-sm-2 col-form-label">
										        <button type="button" class="btn btn-default btn-sm">
										          <span class="glyphicon glyphicon-comment"></span> ${boardComment.name}
										        </button>
										    </label>
											<div class="col-sm-10">
												<input type="text" class="form-control" id="inputTitle" disabled name="board_title" value=" ${boardComment.body}">
											</div>
										</div>
									</c:forEach>
							    </c:when>
								<c:otherwise>
									<div class="form-group row">
										<label for="inputTitle" class="col-sm-2 col-form-label">
									        <button type="button" class="btn btn-default btn-sm">
									          <span class="glyphicon glyphicon-comment"></span> ..
									        </button>
									    </label>
										<div class="col-sm-10">
											<input type="text" class="form-control" id="inputTitle" disabled name="board_title" value="등록된 댓글이 없습니다.">
										</div>
									</div>
							    </c:otherwise>
						 	</c:choose>
						</form>
					</div>
					
					<!-- 댓글 작성 및 글관리 - 작성자 혹은 관리자 : 비작성자 : 비회원 -->
					<c:choose>
					    <c:when test="${mng eq '1'}">
					    	<div>
								<form id="boardPostCommentForm" action="/classroom_rental/boardPostReadCommentForm.do" method="POST">
									<div class="form-group row">
										<label for="inputTitle" class="col-sm-2 col-form-label">
									        <button type="button" class="btn btn-default btn-sm">
									          <span class="glyphicon glyphicon-comment"></span> <%=session.getAttribute("name") %>
									        </button>
									    </label>
										<div class="col-sm-10">
											<input type="hidden" class="form-control" id="commentId" name="commentId" value="<%=session.getAttribute("id") %>">
											<input type="hidden" class="form-control" id="commentName" name="commentName" value="<%=session.getAttribute("name") %>">
											<input type="hidden" class="form-control" id="commentIndex" name="commentIndex" value="${boardRead.board_index}">
											<input type="text" class="form-control" id="commentBody" name="commentBody" placeholder="작성할 댓글 내용을 입력해주세요.">
										</div>
									</div>
								</form>
							</div>
							<div class="text-right">
								<button class="btn btn-warning" type="button" onClick="editPost()" disabled>글 수정하기 »</button>&nbsp;&nbsp;
								<button class="btn btn-warning" type="button" onClick="deletePost()" >글 삭제하기 »</button>&nbsp;&nbsp;
								<button class="btn btn-warning" type="button" onClick="sendComment()">댓글 작성하기 »</button>&nbsp;&nbsp;
								<a href="/classroom_rental/boardList.do"><button class="btn btn-warning">목록으로 »</button></a>
							</div>
					    </c:when>
					    <c:when test="${mng eq '2'}">
					    	<div>
								<form id="boardPostCommentForm" action="/classroom_rental/boardPostReadCommentForm.do" method="POST">
									<div class="form-group row">
										<label for="inputTitle" class="col-sm-2 col-form-label">
									        <button type="button" class="btn btn-default btn-sm">
									          <span class="glyphicon glyphicon-comment"></span> <%=session.getAttribute("name") %>
									        </button>
									    </label>
										<div class="col-sm-10">
											<input type="hidden" class="form-control" id="commentId" name="commentId" value="<%=session.getAttribute("id") %>">
											<input type="hidden" class="form-control" id="commentName" name="commentName" value="<%=session.getAttribute("name") %>">
											<input type="hidden" class="form-control" id="commentIndex" name="commentIndex" value="${boardRead.board_index}">
											<input type="text" class="form-control" id="commentBody" name="commentBody" placeholder="작성할 댓글 내용을 입력해주세요.">
										</div>
									</div>
								</form>
							</div>
							<div class="text-right">
								<button class="btn btn-warning" type="button" onClick="sendComment()">댓글 작성하기 »</button>&nbsp;&nbsp;
								<a href="/classroom_rental/boardList.do"><button class="btn btn-warning">목록으로 »</button></a>
							</div>
					    </c:when>
					    <c:when test="${mng eq '3'}">
					    	<div>
								<form id="boardPostCommentForm" action="#" method="POST">
									<div class="form-group row">
										<label for="inputTitle" class="col-sm-2 col-form-label">
									        <button type="button" class="btn btn-default btn-sm">
									          <span class="glyphicon glyphicon-comment"></span> 비회원
									        </button>
									    </label>
										<div class="col-sm-10">
											<input type="text" class="form-control" id="commentBody" disabled name="commentBody" value="댓글 작성은 회원만 가능합니다. 먼저 로그인 해주세요.">
										</div>
									</div>
								</form>
							</div>
							<div class="text-right">
								<a href="/classroom_rental/boardList.do"><button class="btn btn-warning">목록으로 »</button></a>
							</div>
					    </c:when>
				 	</c:choose>
					
					<!-- 글 삭제하기 Modal-->
					<div id="deletePostModal" class="modal fade" role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">게시글 삭제하기</h4>
								</div>
								<div class="modal-body text-center" id="rentalDeleteModalBody">
									<div class="text-center">
										<h4>정말 삭제하시겠습니까?</h3>
										<form action="/classroom_rental/boardPostDelete.do" method="POST" id="postDeleteForm">
											<input type="hidden" name="postIndex" id="postIndex" value="">
										</form>
									</div>
								</div>
								<div class="modal-footer">
									<button type="submit" form="postDeleteForm" class="btn btn-warning">YES</button>
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
			if ("${result}"=="DeleteTrue") {
				alert("게시글 삭제에 성공하였습니다.");
				location.href = '/classroom_rental/boardList.do';
			} else if ("${result}"=="DeleteFalse") {
				alert("유효하지 않은 요청입니다. 확인 후 다시 시도해주시기 바랍니다.");
				location.href = '/classroom_rental/boardList.do';
			} else if ("${result}"=="CommentTrue") {
				alert("댓글 작성에 성공하였습니다.");
			} else if ("${result}"=="CommentFalse") {
				alert("유효하지 않은 요청입니다. 확인 후 다시 시도해주시기 바랍니다.");
			} else { } 
		});
		
		function deletePost() {
			document.getElementById('postIndex').value = <%=request.getParameter("board_index")%>;
			$('#deletePostModal').modal('toggle');
		}
		
		// 댓글 작성
		function sendComment() {
			// 유효성 체크(댓글 내용)
			if ($("#commentBody").val() == "") {
				alert("댓글 내용을 입력하여 주세요."); // 경고창을 띄우고
				$("#commentBody").focus(); // 해당 태그에 포커스
			} else {
				$("#boardPostCommentForm").submit();
			}
		}
	</script>
</body>
</html>