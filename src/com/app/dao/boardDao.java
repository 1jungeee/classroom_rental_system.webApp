package com.app.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.app.beans.board;
import com.app.beans.boardComment;
import com.app.beans.timetable;
import com.app.beans.user;

public class boardDao extends CommonDao {

	public static boardDao getInstance() {
		boardDao _instance = new boardDao();
		return _instance;
	}

	/* 게시글 리스트 조회 */
	public ArrayList<board> getBoardList() throws SQLException {
		ResultSet rs = null;
		ArrayList<board> result = new ArrayList<board>();
		String sql = "SELECT * FROM BOARD ORDER BY TO_NUMBER(BOARD_ID) DESC";
		rs = openConnection().executeQuery(sql);
		while (rs.next()) {
			board bb = new board();
			bb.setBoard_index(rs.getString("BOARD_ID"));
			bb.setUser_id(rs.getString("USER_ID"));
			bb.setUser_name(rs.getString("USER_NAME"));
			bb.setBoard_title(rs.getString("BOARD_TITLE"));
			bb.setBoard_body(rs.getString("BOARD_BODY"));
			bb.setBoard_bodyType(rs.getString("BOARD_BODYTYPE"));
			bb.setBoard_file(rs.getString("BOARD_FILE"));
			bb.setDate(rs.getString("BOARD_DATE"));
			result.add(bb);
		}
		closeConnection();
		return result;
	}

	/* 게시글 작성 */
	public boolean getBoardPost(board Board) {
		ResultSet rs = null;
		boolean result = false;
		String sql = "INSERT INTO BOARD VALUES(RES_ID_SEQ.NEXTVAL,'" + Board.getUser_id() + "','" + Board.getUser_name()
				+ "','" + Board.getBoard_title() + "','" + Board.getBoard_body() + "','" + Board.getBoard_bodyType()
				+ "','" + Board.getBoard_file() + "','" + Board.getDate() + "')";

		try {
			rs = openConnection().executeQuery(sql);
			result = rs.next(); // 게시글 추가시 ture
		} catch (SQLException e) {
			System.err.println(e);
			result = false; // 게시글 추가 실패시 false
		} finally {
			closeConnection();
		}
		return result;
	}

	/* 게시글 읽기 */
	public board getBoardPostRead(String postIndex) throws SQLException {
		ResultSet rs = null;
		board result = new board();
		/* 게시글 내용 읽어오기 */
		String sql = "SELECT * FROM BOARD WHERE BOARD_ID ='" + postIndex + "'";
		rs = openConnection().executeQuery(sql);
		while (rs.next()) {
			result.setBoard_index(rs.getString("BOARD_ID"));
			result.setUser_id(rs.getString("USER_ID"));
			result.setUser_name(rs.getString("USER_NAME"));
			result.setBoard_title(rs.getString("BOARD_TITLE"));
			result.setBoard_body(rs.getString("BOARD_BODY"));
			result.setBoard_bodyType(rs.getString("BOARD_BODYTYPE"));
			result.setBoard_file(rs.getString("BOARD_FILE"));
			result.setDate(rs.getString("BOARD_DATE"));
		}
		
		closeConnection();
		return result;
	}

	/* 게시글 삭제 */
	public String getDeletePost(String postIndex) throws SQLException {
		ResultSet rs = null;
		String result = "";
		String sql = "DELETE FROM BOARD WHERE BOARD_ID ='" + postIndex + "'";

		try {
			rs = openConnection().executeQuery(sql);
			result = "DeleteTrue"; // 게시글 삭제 시 ture
		} catch (SQLException e) {
			System.err.println(e);
			result = "DeleteFalse"; // 게시글 삭제 실패시 false
		} finally {
			closeConnection();
		}
		
		return result;
	}

	/* 댓글 리스트 조회 */
	public ArrayList<boardComment> getBoardCommentList(String boardIndex) throws SQLException {
		ResultSet rs = null;
		ArrayList<boardComment> result = new ArrayList<boardComment>();
		String sql = "SELECT * FROM BCOMMENT WHERE BCOMMENT_BOARDID ='"+boardIndex+"' ORDER BY TO_NUMBER(BCOMMENT_INDEX) ASC";
		rs = openConnection().executeQuery(sql);
		while (rs.next()) {
			boardComment bc = new boardComment();
			bc.setBoardid(rs.getString("BCOMMENT_BOARDID"));
			bc.setBody(rs.getString("BCOMMENT_BODY"));
			bc.setDate(rs.getString("BCOMMENT_DATE"));
			bc.setId(rs.getString("BCOMMENT_ID"));
			bc.setName(rs.getString("BCOMMENT_NAME"));
			result.add(bc);
		}
		closeConnection();
		return result;
	}
	
	/* 댓글 작성 */
	public String getBoardPostComment(boardComment Comment) {
		ResultSet rs = null;
		String result = "";
		String sql = "INSERT INTO BCOMMENT VALUES(BCOMMENT_ID_SEQ.NEXTVAL,'" + Comment.getId() + "','" + Comment.getName()
				+ "','" + Comment.getBody() + "','" + Comment.getDate() + "','" + Comment.getBoardid() + "')";

		try {
			rs = openConnection().executeQuery(sql);
			result = "CommentTrue"; // 댓글 추가시 ture
		} catch (SQLException e) {
			System.err.println(e);
			result = "CommentFalse"; // 댓글 추가 실패시 false
		} finally {
			closeConnection();
		}
		return result;
	}

}