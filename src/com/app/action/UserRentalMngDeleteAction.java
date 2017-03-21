package com.app.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.app.controller.CommandAction;
import com.app.dao.adminDao;
import com.app.dao.userDao;

public class UserRentalMngDeleteAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		boolean result;
		
		request.setCharacterEncoding("utf-8");
		String rentalId = request.getParameter("rentalId");
		
		result = userDao.getInstance().getDeleteRentalReport(rentalId);
		request.setAttribute("result", result);
		
		return "/views/user/rental_mng.jsp";
	}
}
