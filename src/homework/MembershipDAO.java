package homework;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import model1.board.BoardDTO;

 

public class MembershipDAO {

	//DAO의 기본 멤버변수
	Connection con;//DB연결
	Statement stmt;//정적 쿼리 전송 및 실행
	PreparedStatement psmt;//동적 쿼리전송 및 실행
	ResultSet rs;//select결과반환
	
	public MembershipDAO(ServletContext application) {
		try {
			String drv = application.getInitParameter("JDBCDriver");
			String url = application.getInitParameter("ConnectionURL");
			String id = application.getInitParameter("OracleId");
			String pwd = application.getInitParameter("OraclePwd");
			
			Class.forName(drv);			 
			con = DriverManager.getConnection(url, id, pwd);
			System.out.println("Homework 연결성공");			 
		}
		catch(Exception e) {
			System.out.println("Homework 연결시 예외발생");
			e.printStackTrace();
		}
	}
	public void close() {
		try {
			if(rs!=null) rs.close();
			if(psmt!=null) psmt.close();
			if(con!=null) con.close();
		}
		catch(Exception e) {
			System.out.println("Oracle 자원반납시 예외발생");
		}
	}	
	public int memberRegist(MembershipDTO dto) {
		int result = 0;
		try {
			String query = "INSERT INTO membership ( "
				+ " user_id, pass, name, gender, birthday, zipcode, address1, address2, "
				+ " email, mobile, tel) "
				+ " VALUES ( "
				+ " ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getUser_id());
			psmt.setString(2, dto.getPass());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getGender());
			psmt.setString(5, dto.getBirthday());
			psmt.setString(6, dto.getZipcode());
			psmt.setString(7, dto.getAddress1());
			psmt.setString(8, dto.getAddress2());
			psmt.setString(9, dto.getEmail());
			psmt.setString(10, dto.getMobile());
			psmt.setString(11, dto.getTel());
			//쿼리문 실행
			result = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("회원가입 처리중 예외발생");
			e.printStackTrace();
		}
		return result;
	}
	//게시물 조회하기
	public MembershipDTO memberView(String user_id) {
		MembershipDTO dto = new MembershipDTO();
		
		String query = "SELECT * FROM membership " + 
				" WHERE user_id=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, user_id);
			rs = psmt.executeQuery();
			
			if(rs.next()) {				
				dto.setUser_id(rs.getString(1));
				dto.setPass(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setGender(rs.getString(4));
				dto.setBirthday(rs.getString(5));
				dto.setZipcode(rs.getString(6));
				dto.setAddress1(rs.getString(7));
				dto.setAddress2(rs.getString(8));
				dto.setEmail(rs.getString(9));
				dto.setMobile(rs.getString(10));
				dto.setTel(rs.getString(11));
				dto.setRegidate(rs.getString(12));
			}
		}
		catch(Exception e) {
			System.out.println("회원정보 조회중 예외발생");
			e.printStackTrace();
		}
		return dto;
	}
	public int memberCount(Map<String, Object> map) {
		int totalCount = 0;	
		
		String query = "SELECT COUNT(*) FROM membership ";
		//검색 파라미터가 있는 경우라면 where절을 추가한다. 
		if(map.get("searchWord")!=null) {
			query += " WHERE "+ map.get("searchField") +" "
					+ " LIKE '%"+ map.get("searchWord") +"%'";
		}
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			rs.next();
			totalCount = rs.getInt(1);
		}
		catch(Exception e) {
			System.out.println("게시물 카운트중 예외발생");
			e.printStackTrace();
		}

		return totalCount;
	}
	public List<MembershipDTO> memberList(Map<String,Object> map){
		
		List<MembershipDTO> members = new Vector<MembershipDTO>();
	
		String query = "SELECT * FROM membership ";
		if(map.get("searchWord")!=null){
			query +=" WHERE "+ map.get("searchField") +" "
			  +" LIKE '%"+ map.get("searchWord") +"%' "; 
		}
		query += " ORDER BY regidate DESC ";
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);	
			 
			while(rs.next()) {
				MembershipDTO dto = new MembershipDTO();

				dto.setUser_id(rs.getString("user_id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString("name"));  
				dto.setGender(rs.getString("gender"));   
				dto.setBirthday(rs.getString("birthday")); 
				dto.setZipcode(rs.getString("zipcode"));  
				dto.setAddress1(rs.getString("address1")); 
				dto.setAddress2(rs.getString("address2")); 
				dto.setEmail(rs.getString("email"));  
				dto.setMobile(rs.getString("mobile"));  
				dto.setTel(rs.getString("tel"));  
				dto.setRegidate(rs.getString("regidate"));
				
				members.add(dto);
			}
		}
		catch(Exception e) {
			System.out.println("회원 목록 조회1중 예외발생");
			e.printStackTrace();
		}
		return members;
	}
	//게시판 목록 출력시 페이지 처리
	public List<MembershipDTO> memberListPage(Map<String,Object> map){
		List<MembershipDTO> members = new Vector<MembershipDTO>();

		String query = " "
				+" SELECT * FROM ( "
				+"	 SELECT Tb.*, ROWNUM rNum FROM ( "
				+"	    SELECT * FROM membership ";
		if(map.get("searchWord")!=null)
		{
			query +=" WHERE "+ map.get("searchField") +" "
					+" LIKE '%"+ map.get("searchWord") +"%' "; 
		}
		query += " "
				+"    	ORDER BY regidate DESC "
				+"    ) Tb "
				+" ) "
				+" WHERE rNum BETWEEN ? AND ?";
		System.out.println("페이지쿼리:"+query);
		try {
			psmt = con.prepareStatement(query);
			//between절의 start와 end값을 인파라미터 설정
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			rs = psmt.executeQuery();
			while(rs.next()) {
				MembershipDTO dto = new MembershipDTO();
				
				dto.setUser_id(rs.getString("user_id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString("name"));  
				dto.setGender(rs.getString("gender"));   
				dto.setBirthday(rs.getString("birthday")); 
				dto.setZipcode(rs.getString("zipcode"));  
				dto.setAddress1(rs.getString("address1")); 
				dto.setAddress2(rs.getString("address2")); 
				dto.setEmail(rs.getString("email"));  
				dto.setMobile(rs.getString("mobile"));  
				dto.setTel(rs.getString("tel"));  
				dto.setRegidate(rs.getString("regidate"));
				
				members.add(dto);
			}
		}
		catch(Exception e) {
			System.out.println("회원 목록 조회2중 예외발생");
			e.printStackTrace();
		}
		return members;
	}
	public int memberUpdate(MembershipDTO dto) {
		int result = 0;
		try {
			String query = "UPDATE membership SET "
				+ " pass=?, name=?, gender=?, birthday=?, "
				+ " zipcode=?, address1=?, address2=?, "
				+ " email=?, mobile=?, tel=? "
				+ " WHERE user_id=?";
			psmt = con.prepareStatement(query);
			psmt.setString(11, dto.getUser_id());
			psmt.setString(1, dto.getPass());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getGender());
			psmt.setString(4, dto.getBirthday());
			psmt.setString(5, dto.getZipcode());
			psmt.setString(6, dto.getAddress1());
			psmt.setString(7, dto.getAddress2());
			psmt.setString(8, dto.getEmail());
			psmt.setString(9, dto.getMobile());
			psmt.setString(10, dto.getTel());
			//쿼리문 실행
			result = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("회원가입 처리중 예외발생");
			e.printStackTrace();
		}
		return result;
	}
	public int memberDelete(String user_id) {
		int result = 0;
		try {
			String query = "DELETE FROM membership WHERE user_id=?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, user_id);
			result = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("게시물 삭제중 예외발생");
			e.printStackTrace();
		}
		return result;
	}
}
