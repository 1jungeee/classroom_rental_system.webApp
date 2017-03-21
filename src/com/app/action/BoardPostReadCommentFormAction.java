package com.app.action;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.app.beans.boardComment;
import com.app.controller.CommandAction;
import com.app.dao.boardDao;

public class BoardPostReadCommentFormAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		String result = "";

		request.setCharacterEncoding("utf-8");

		// 댓글 작성 날짜 및 시간을 위한  date 객체
		Date toDate = new Date();
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		// boardComment 객체 생성
		boardComment Comment = new boardComment();
		Comment.setId(request.getParameter("commentId"));
		Comment.setName(request.getParameter("commentName"));
		Comment.setBody(request.getParameter("commentBody"));
		Comment.setDate(sd.format(toDate));
		Comment.setBoardid(request.getParameter("commentIndex"));
		
		// 해당 게시물 인덱스
		String postIndex = request.getParameter("commentIndex");
		
		// 디비에 추가
		result = boardDao.getInstance().getBoardPostComment(Comment);
		
		request.setAttribute("result", result);
		
		return "/boardPostRead.do?board_index="+postIndex;
	}
}
