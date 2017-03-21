package com.app.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.app.controller.CommandAction;
import com.app.dao.boardDao;
import com.app.dao.userDao;

public class BoardPostDeleteAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		String result = "";

		request.setCharacterEncoding("utf-8");
		String postIndex = request.getParameter("postIndex");
		
		result = boardDao.getInstance().getDeletePost(postIndex);
		request.setAttribute("result", result);

		return "/views/board/board_read.jsp";
	}
}
