package com.app.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.app.beans.reservation;
import com.app.controller.CommandAction;
import com.app.dao.adminDao;

public class AdminRentalMngAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		request.setCharacterEncoding("utf-8");
		ArrayList<reservation> rentalReportList = adminDao.getInstance().getRentalReportList();
		request.setAttribute("rentalReportList", rentalReportList); // 셋팅된 강의실 대여 신청서 리스트를 뷰에 포워드
		
		return "/views/admin/rental_mng.jsp";
	}
}
