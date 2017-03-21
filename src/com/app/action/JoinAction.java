package com.app.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.app.beans.user;
import com.app.controller.CommandAction;
import com.app.dao.userDao;

public class JoinAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		boolean result;

		request.setCharacterEncoding("utf-8");

		user User = new user();
		User.setId(request.getParameter("id"));
		User.setPassword(request.getParameter("password"));
		User.setName(request.getParameter("name"));
		User.setDepartment(request.getParameter("department"));
		User.setTel(request.getParameter("tel"));
		result = userDao.getInstance().getUserJoin(User);

		if(result){
			request.setAttribute("success", "회원가입에 성공하셨습니다. 로그인 해주세요.");
			return "/views/main/login.jsp";
		}else{
			request.setAttribute("error", "이미 존재하는 학번입니다. 확인 후 다시 시도해주세요.");
			return "/views/main/join.jsp";
		}
	}
}
