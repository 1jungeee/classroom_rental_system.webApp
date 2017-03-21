package com.app.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.app.controller.CommandAction;
import com.app.dao.userDao;

public class LoginAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		String result = null;

		request.setCharacterEncoding("utf-8");

		result = userDao.getInstance().getUserLogin(request.getParameter("id"), request.getParameter("password"));

		if(result.equals("1")){
			request.setAttribute("error", "존재하지 않은 아이디 입니다.");
			return "/views/main/login.jsp";
		}else if(result.equals("2")){
			request.setAttribute("error", "비밀번호가 일치하지 않습니다.");
			return "/views/main/login.jsp";
		}else{
			//세션 추가 - id, name
			String sessionValue[] = result.split("/");
			request.getSession().setAttribute("id", sessionValue[0]);
			request.getSession().setAttribute("name", sessionValue[1]);
			request.getSession().setAttribute("department", sessionValue[2]);
			request.getSession().setAttribute("tel", sessionValue[3]);
			request.getSession().setAttribute("isAdmin", sessionValue[4]);
			return "/";
		}
	}
}
