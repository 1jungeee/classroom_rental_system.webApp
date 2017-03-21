package com.app.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.app.beans.reservation;
import com.app.controller.CommandAction;
import com.app.dao.classroomDao;

public class ClassroomRentalFormReportAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		boolean result = false;
		request.setCharacterEncoding("utf-8");
		
		String tmp_user_name = request.getParameter("user_name");
		String tmp_user_id = request.getParameter("user_id");
		String tmp_user_department = request.getParameter("user_department");
		String tmp_user_tel = request.getParameter("user_tel");
		String tmp_rental_name = request.getParameter("rental_name");
		String tmp_rental_alldate = request.getParameter("rental_alldate");
		String tmp_rental_reason = request.getParameter("rental_reason");
		// 줄바꿈 치환
		tmp_rental_reason = tmp_rental_reason.replace("\r\n","<br>");
		String tmp_rental_agree = request.getParameter("rental_chk_agree");
		
		// 예약시간을 7주로 나누어 몫과 나머지를 기준으로 월요일~일요일까지 예약시간 넣기(','로 나눔)
		String[] tmp_rental_chk_time = request.getParameterValues("rental_chk_time");
		String[] tmp_rental_date = new String[7];
		// ""(공백)으로 초기화
		for (int i=0; i<tmp_rental_date.length; i++) {
			tmp_rental_date[i] = "";
		}
		for (String temp : tmp_rental_chk_time) {
			if (Integer.parseInt(temp)%7 == 1) {			// 월요일 - 나머지가 1일 경우
				tmp_rental_date[0] += (Integer.parseInt(temp)/7)+1+",";
			} else if (Integer.parseInt(temp)%7 == 2) {	// 화요일 - 나머지가 2일 경우
				tmp_rental_date[1] += (Integer.parseInt(temp)/7)+1+",";
			} else if (Integer.parseInt(temp)%7 == 3) {	// 수요일 - 나머지가 3일 경우
				tmp_rental_date[2] += (Integer.parseInt(temp)/7)+1+",";
			} else if (Integer.parseInt(temp)%7 == 4) {	// 목요일 - 나머지가 4일 경우
				tmp_rental_date[3] += (Integer.parseInt(temp)/7)+1+",";
			} else if (Integer.parseInt(temp)%7 == 5) {	// 금요일 - 나머지가 5일 경우
				tmp_rental_date[4] += (Integer.parseInt(temp)/7)+1+",";
			} else if (Integer.parseInt(temp)%7 == 6) {	// 토요일 - 나머지가 6일 경우
				tmp_rental_date[5] += (Integer.parseInt(temp)/7)+1+",";
			} else if (Integer.parseInt(temp)%7 == 0) {	// 일요일 - 나머지가 0일 경우
				tmp_rental_date[6] += (Integer.parseInt(temp)/7)+",";
			} else {
				
			}
		}
		// 예약한 날짜만 마지막 ',' 지우고 beans 객체를 만들어 DB에 추가하기
		for (int i=0; i<tmp_rental_date.length; i++) {
			// 예약시간이 존재한다면 
			if (!tmp_rental_date[i].equals("")) {
				// 마지막 ',' 지우기
				tmp_rental_date[i] = tmp_rental_date[i].substring(0, tmp_rental_date[i].length()-1);
				// reservation beans 객체 생성 및 값 셋팅
				reservation report = new reservation();
				report.setUser_name(tmp_user_name);
				report.setUser_id(tmp_user_id);
				report.setUser_department(tmp_user_department);
				report.setUser_tel(tmp_user_tel);
				report.setRental_name(tmp_rental_name);
				report.setRental_alldate(tmp_rental_alldate);
				report.setRental_date(String.valueOf(i+1));
				report.setRental_chk_time(tmp_rental_date[i]);
				report.setRental_reason(tmp_rental_reason);
				report.setRental_chk_agree("true");
				// DB에 강의실 사용 신청서 추가(RESERVATION TABLE)
				result = classroomDao.getInstance().getAddReservation(report);
			}
		}

		if(result){
			request.setAttribute("result", "1");
			return "/views/rental/classroom_rental_form.jsp";
		}else{
			request.setAttribute("result", "2");
			return "/views/rental/classroom_rental_form.jsp";
		}
	}
}
