package com.app.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.app.beans.classroom;
import com.app.beans.reservation;

public class adminDao extends CommonDao {
	
	public static adminDao getInstance() {
		adminDao _instance = new adminDao();
		return _instance;
	}

	/* 강의실 대여 신청서 조회 */
	public ArrayList<reservation> getRentalReportList() throws SQLException {
		ResultSet rs = null;
		ArrayList<reservation> result = new ArrayList<reservation>();
		String sql = "SELECT * FROM RESERVATION ORDER BY TO_NUMBER(RES_ID) DESC";
		rs = openConnection().executeQuery(sql);
		int count=1;
		while (rs.next()) {
			reservation rr = new reservation();
			rr.setUser_name(rs.getString("RES_USERNAME"));
			rr.setUser_id(rs.getString("RES_USERID"));
			rr.setUser_department(rs.getString("RES_USERDEPARTMENT"));
			rr.setUser_tel(rs.getString("RES_USERTEL"));
			rr.setRental_name(rs.getString("RES_CR"));
			rr.setRental_state(rs.getString("RES_IS"));
			rr.setRental_alldate(rs.getString("RES_ALLDATE") + "-" + rs.getString("RES_DATE"));
			rr.setRental_date(String.valueOf(count++) + "," + rs.getString("RES_ID"));
			rr.setRental_chk_time(rs.getString("RES_TIME"));
			rr.setRental_reason(rs.getString("RES_AIM"));
			rr.setRental_chk_agree(rs.getString("RES_AGREE"));
			result.add(rr);
		}
		closeConnection();
		return result;
	}

	public boolean getEditRentalState(String id, String state) throws SQLException {
		ResultSet rs = null;
		String sql = "UPDATE RESERVATION SET RES_IS='"+state+"' WHERE RES_ID='"+id+"'";
		rs = openConnection().executeQuery(sql);
		boolean result = rs.next();
	    closeConnection();
	    return result;
	}
}