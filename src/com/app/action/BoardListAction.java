package com.app.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.app.beans.board;
import com.app.controller.CommandAction;
import com.app.dao.boardDao;

public class BoardListAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		request.setCharacterEncoding("utf-8");
		ArrayList<board> boardList = boardDao.getInstance().getBoardList();
		request.setAttribute("boardList", boardList); // 셋팅된 게시글 리스트를 뷰에 포워드
		
		return "/views/board/board_list.jsp";
	}
}
