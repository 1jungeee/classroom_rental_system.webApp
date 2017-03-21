package com.app.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.app.beans.classroom;
import com.app.beans.reservation;
import com.app.beans.timetable;

public class classroomDao extends CommonDao {
	public static classroomDao getInstance() {
		classroomDao _instance = new classroomDao();
		return _instance;
	}

	/* 건물조회 */
	public ArrayList<String> getBuildingList() throws SQLException {
		ResultSet rs = null;
		ArrayList<String> result = new ArrayList<String>();
	    String sql = "SELECT * FROM BUILDING";
        rs = openConnection().executeQuery(sql);
        while(rs.next()){
        	result.add(rs.getString("BD_ID"));
        }
	    closeConnection();
	    return result;
	}

	/* 강의실조회 */
	public ArrayList<classroom> getClassRoomList(String building) throws SQLException {
		ResultSet rs = null;
		ArrayList<classroom> result = new ArrayList<classroom>();
	    String sql = "SELECT CLASSROOM.CR_ID, CLASSROOM.CR_NAME FROM CLASSROOM INNER JOIN BUILDING ON CLASSROOM.CR_BUILDING = BUILDING.BD_ID WHERE CLASSROOM.CR_BUILDING ='"+building+"'";
        rs = openConnection().executeQuery(sql);
        while(rs.next()){
        	classroom cr = new classroom();
        	cr.setId(rs.getString("CR_ID"));
        	cr.setName(rs.getString("CR_NAME"));
        	result.add(cr);
        }
	    closeConnection();
	    return result;
	}

	/* 고정 시간표 조회 */
	public ArrayList<timetable> getTimeTableList(String classroom) throws SQLException {
		ResultSet rs = null;
		ArrayList<timetable> result = new ArrayList<timetable>();
	    String sql = "SELECT * FROM TIMETABLE WHERE TT_CR = '"+classroom+"'";
        rs = openConnection().executeQuery(sql);
        while(rs.next()){
        	timetable tt = new timetable();
        	tt.setDate(rs.getString("TT_DATE"));
        	String temp[] = rs.getString("TT_TIME").split(",");
        	tt.setTime(temp);
        	tt.setName(rs.getString("TT_NAME"));
        	result.add(tt);
        }
	    closeConnection();
	    return result;
	}

	/* 강의실 예약 현황 조회 */
	public ArrayList<reservation> getReservationTableList(String toWeek, String classroom) throws SQLException {
		ResultSet rs = null;
		ArrayList<reservation> result = new ArrayList<reservation>();
	    String sql = "SELECT * FROM RESERVATION WHERE RES_CR = '"+classroom+"' AND RES_ALLDATE = '"+toWeek+"'";
        rs = openConnection().executeQuery(sql);
        while(rs.next()){
        	reservation rr = new reservation();
			rr.setUser_name(rs.getString("RES_USERNAME"));
			rr.setUser_id(rs.getString("RES_USERID"));
			rr.setUser_department(rs.getString("RES_USERDEPARTMENT"));
			rr.setUser_tel(rs.getString("RES_USERTEL"));
			rr.setRental_name(rs.getString("RES_CR"));
			rr.setRental_state(rs.getString("RES_IS"));
			rr.setRental_alldate(rs.getString("RES_ALLDATE"));
			rr.setRental_date(rs.getString("RES_DATE"));
			rr.setRental_chk_time(rs.getString("RES_TIME"));
			rr.setRental_reason(rs.getString("RES_AIM"));
			rr.setRental_chk_agree(rs.getString("RES_AGREE"));
        	result.add(rr);
        }
	    closeConnection();
	    return result;
	}
	
	/* 강의실 사용 신청서 추가 */
	public boolean getAddReservation(reservation report) throws SQLException {
		ResultSet rs = null;
	    boolean result = false;
		String sql = "INSERT INTO RESERVATION VALUES(RES_ID_SEQ.NEXTVAL,'"+"false'"+",'"+report.getRental_name()+"','"+report.getRental_alldate()+"','"+report.getRental_date()+"','"+report.getRental_chk_time()+"','"+report.getRental_reason()+"','"+report.getUser_name()+"','"+report.getUser_id()+"','"+report.getUser_department()+"','"+report.getUser_tel()+"','"+report.getRental_chk_agree()+"')";
	    try {
			rs = openConnection().executeQuery(sql);
			result = rs.next(); // 신청서 추가시 ture
		} catch (SQLException e) {
			result = false; // 신청서 추가 실패시 false
		} finally {
		    closeConnection();
		}
	    return result;
	}
}
