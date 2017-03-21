package com.app.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.app.beans.reservation;
import com.app.beans.timetable;
import com.app.controller.CommandAction;
import com.app.dao.classroomDao;

public class ClassroomRentalListSearchAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		request.setCharacterEncoding("utf-8");

		String category1 = request.getParameter("category1");
		String category3 = request.getParameter("category3");
		
		// 고정 강의 시간표
		ArrayList<timetable> timeTableList = new ArrayList<timetable>();
		timeTableList = classroomDao.getInstance().getTimeTableList(category3);
		
		// 강의실 예약 현황
		ArrayList<reservation> reservationTableList = new ArrayList<reservation>();
		reservationTableList = classroomDao.getInstance().getReservationTableList(category1,category3);

		/** 
		 * 고정 강의 시간표 및 강의실 예약 현황을 담을 2차원 배열 : 요일/시간
		 * [1]고정강의시간표, [2]예약승인, [3]예약대기, [4]예약반려
		 **/
		String timeTables[][] = new String[7][48];
		/* 고정 강의 시간표 담기 */
		for (int i = 0; i < timeTableList.size(); i++) {
			for (int j = 0; j < timeTableList.get(i).getTime().length; j++) {
				timeTables[(Integer.parseInt(timeTableList.get(i).getDate()) - 1)][(Integer
						.parseInt(timeTableList.get(i).getTime()[j]) - 1)] = "[1]"+timeTableList.get(i).getName();
			}
		}
		/* 강의실 예약 현황 담기 */
		for (int i = 0; i < reservationTableList.size(); i++) {
			String[] tmp_time = reservationTableList.get(i).getRental_chk_time().split(",");
			String tmp_state = "";
			if (reservationTableList.get(i).getRental_state().equals("true")) {
				tmp_state = "[2]";
			} else if (reservationTableList.get(i).getRental_state().equals("false")) {
				tmp_state = "[3]";
			} else if (reservationTableList.get(i).getRental_state().equals("reject")) {
				tmp_state = "[4]";
			} else { }
			
			for (int j = 0; j < tmp_time.length; j++) {
				timeTables[(Integer.parseInt(reservationTableList.get(i).getRental_date()) - 1)][(Integer
						.parseInt(tmp_time[j]) - 1)] = tmp_state + reservationTableList.get(i).getUser_name();
			}
		}
		
		/** View에 반환할 테이블 작성 **/
		String timeTablesResult = "";
		for (int i = 0; i < timeTables[0].length; i++) {
			if (i % 2 == 0) {
				timeTablesResult += "<tr><td rowspan='2' class='text-center' style='background-color: #f0ad4e; vertical-align:middle;'>"
						+ String.format("%02d", (i / 2)) + ":00</td>";
			} else {
				timeTablesResult += "<tr>";
			}
			for (int j = 0; j < timeTables.length; j++) {
				if (timeTables[j][i] == null) {
					timeTablesResult += "<td style='height:34px;'></td>";
				} else {
					// 고정 시간표 및 예약 현황이 존재할 경우
					String timeTablesTemp = timeTables[j][i];
					// 상태 : [1]고정강의시간표=노란, [2]예약승인=파란, [3]예약대기=빨간
					if (timeTablesTemp.substring(0, 3).equals("[1]")) {
						timeTablesTemp = (timeTablesTemp.length() > 8) ? timeTablesTemp.substring(3, 8) + ".." : timeTablesTemp.substring(3, timeTablesTemp.length());
						timeTablesResult += "<td class='text-center' nowrap style='height:34px; overflow: hidden; font-size:12px; background-color:#fcf8e3;'>" + timeTablesTemp + "</td>";
					} else if (timeTablesTemp.substring(0, 3).equals("[2]")) {
						timeTablesTemp = (timeTablesTemp.length() > 8) ? "[승인]" + timeTablesTemp.substring(3, 8) + ".." : "[승인]" + timeTablesTemp.substring(3, timeTablesTemp.length());
						timeTablesResult += "<td class='text-center' nowrap style='height:34px; overflow: hidden; font-size:12px; background-color:#d9edf7;'>" + timeTablesTemp + "</td>";
					} else if (timeTablesTemp.substring(0, 3).equals("[3]")) {
						timeTablesTemp = (timeTablesTemp.length() > 8) ? "[대기]" + timeTablesTemp.substring(3, 8) + ".." : "[대기]" + timeTablesTemp.substring(3, timeTablesTemp.length());
						timeTablesResult += "<td class='text-center' nowrap style='height:34px; overflow: hidden; font-size:12px; background-color:#f2dede;'>" + timeTablesTemp + "</td>";
					} else if (timeTablesTemp.substring(0, 3).equals("[4]")) {
						timeTablesResult += "<td style='height:34px;'></td>";
					} else {
						
					}
					
				}
			}
			timeTablesResult += "</tr>";
		}

		request.setAttribute("timetable", timeTablesResult);
		return "/views/rental/rental_event/tmp_classroom_search.jsp";
	}

}
