package com.app.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.app.beans.reservation;
import com.app.beans.user;

public class userDao extends CommonDao {
	public static userDao getInstance() {
		userDao _instance = new userDao();
		return _instance;
	}
	
	/* 회원가입 */
	public boolean getUserJoin(user User) {
		ResultSet rs = null;
	    boolean result = false;
		String sql = "INSERT INTO STUDENT VALUES('"+User.getId()+"','"+User.getPassword()+"','"+User.getName()+"','"+User.getDepartment()+"','"+User.getTel()+"','2')";
	    try {
			rs = openConnection().executeQuery(sql);
			result = rs.next(); // 회원 추가시 ture
		} catch (SQLException e) {
			result = false; // 회원 추가 실패시 false
		} finally {
		    closeConnection();
		}
	    return result;
	}

	/* 로그인 */
	public String getUserLogin(String id, String password) throws SQLException {
		ResultSet rs = null;
	    String result = null;
	    String sql = "SELECT * FROM STUDENT WHERE STD_ID = '"+id+"'";
        rs = openConnection().executeQuery(sql); // sql을 실행하기위해 연결을 열어 쿼리를 실행하고 rs에 반환
        if(rs.next()){
        	if(rs.getString("STD_PWD").equals(password)){
        		result = rs.getString("STD_ID");
        		result += "/"+rs.getString("STD_NAME");
        		result += "/"+rs.getString("STD_DEPARTMENT");
        		result += "/"+rs.getString("STD_TEL");
        		result += "/"+rs.getString("STD_ISADMIN");
        	}else{
        		result = "2";
        	}
        }else{
        	result = "1";
        }

	    closeConnection();
	    return result;
	}
	
	/* 나의 강의실 대여 현황 조회 */
	public ArrayList<reservation> getRentalReportList(String id) throws SQLException {
		ResultSet rs = null;
		ArrayList<reservation> result = new ArrayList<reservation>();
		String sql = "SELECT * FROM RESERVATION WHERE RES_USERID ='"+id+"' ORDER BY TO_NUMBER(RES_ID) DESC";
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

	public boolean getDeleteRentalReport(String rentalId) throws SQLException {
		ResultSet rs = null;
		String sql = "DELETE FROM RESERVATION WHERE RES_ID ='"+rentalId+"'";
		rs = openConnection().executeQuery(sql);
		boolean result = rs.next();
	    closeConnection();
	    
		return result;
	}
}
