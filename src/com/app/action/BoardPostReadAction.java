package com.app.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.app.beans.board;
import com.app.beans.boardComment;
import com.app.controller.CommandAction;
import com.app.dao.boardDao;

public class BoardPostReadAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		request.setCharacterEncoding("utf-8");
		
		// 게시글 내용 가져오기
		board boardRead = boardDao.getInstance().getBoardPostRead(request.getParameter("board_index"));
		
		// 해당 게시글 댓글 리스트 가져오기
		ArrayList<boardComment> boardCommentList = boardDao.getInstance().getBoardCommentList(request.getParameter("board_index"));
		
		
		// 게시글 관리 관련 권한 뷰에 포워드를 위한 조건식
		// 회원이면
		if (request.getSession().getAttribute("id") != null)
		{
			// 글 작성자 혹은 관리자가 요청했을 경우
			if (boardRead.getUser_id().equals(request.getSession().getAttribute("id")) || request.getSession().getAttribute("isAdmin").equals("1"))
			{
				request.setAttribute("mng", "1"); // 글 작성자임
			}
			// 아닐경우
			else
			{
				request.setAttribute("mng", "2"); // 글 작성자가 아님
			}
		}
		// 비회원이면
		else
		{
			request.setAttribute("mng", "3"); // 비회원임
		}
		
		// 게시글 내용 뷰에 포워드
		request.setAttribute("boardRead", boardRead);
		
		// 해당 게시글 댓글 리스트 뷰에 포워드
		request.setAttribute("boardCommentList", boardCommentList);
		
		
		return "/views/board/board_read.jsp";
	}
}
