package com.app.dao;

import java.sql.*;

public class CommonDao {

	// 공통적으로 쓰일 접속에 관련된 정보 변수들을 상수로 선언
	private final String driverName = "oracle.jdbc.driver.OracleDriver";
	private final String url = "jdbc:oracle:thin:@finalwebproject.c82x1jiwzyrm.ap-northeast-2.rds.amazonaws.com:1521:orcl";
	private final String db_id = "root";
	private final String db_pw = "12345678";
	// 접속에 필요한 변수를 선언
	private Connection con = null;
	private Statement stmt = null;
	// db 접속정보를 가지고, 접속후에 SQL문을 사용하기위해 필요한 statement객체를 반환하는 openConnection 메소드를 구현
	public Statement openConnection() {
		try {
			Class.forName(driverName);
			con = DriverManager.getConnection(url, db_id, db_pw);
			stmt = con.createStatement();
		} catch (Exception e) {
			System.err.println("Oracle DB 연결 문제 발생!");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		return stmt;
	}

	// 접속을 종료하기위한 closeConnection 메소드를 구현
	public void closeConnection() {
		try {
			if (!con.isClosed()) // 닫히지 않았으면
				con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}