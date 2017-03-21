package com.app.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.app.controller.CommandAction;
import com.app.dao.adminDao;

public class AdminRentalMngStateChangeAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		boolean result;
		
		request.setCharacterEncoding("utf-8");
		String state = request.getParameter("state");
		String rentalId = request.getParameter("rentalId");
		
		result = adminDao.getInstance().getEditRentalState(rentalId, state);
		request.setAttribute("result", result);
		
		return "/views/admin/rental_mng.jsp";
	}
}
