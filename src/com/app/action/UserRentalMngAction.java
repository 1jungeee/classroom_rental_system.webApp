package com.app.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.app.beans.reservation;
import com.app.controller.CommandAction;
import com.app.dao.userDao;

public class UserRentalMngAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		request.setCharacterEncoding("utf-8");
		String id = String.valueOf(request.getSession().getAttribute("id"));
		ArrayList<reservation> rentalReportList = userDao.getInstance().getRentalReportList(id);
		request.setAttribute("rentalReportList", rentalReportList); // 셋팅된 강의실 대여 신청서 리스트를 뷰에 포워드
		
		return "/views/user/rental_mng.jsp";
	}
}
