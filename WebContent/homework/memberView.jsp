<%@page import="homework.MembershipDTO"%>
<%@page import="homework.MembershipDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String user_id = request.getParameter("user_id");
String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");

String queryStr = "";
if(searchWord!=null){
	//검색 파라미터 추가하기
	queryStr = "&searchField="+searchField+"&searchWord="+searchWord;
}

int pageNum = 1;
String pageTemp = request.getParameter("pageNum");
if(pageTemp!=null && !pageTemp.equals(""))
	pageNum = Integer.parseInt(pageTemp);

MembershipDAO dao = new MembershipDAO(application);
MembershipDTO dto = dao.memberView(user_id);
dao.close();
%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<style>
*{ font-size:12px; font-family:verdana; }
</style>
</head>
<body>
<div class="container">
<h2>회원 리스트</h2>
<table class="table table-bordered table-striped">
	<tr>
		<th>아이디</th>
		<td><%=dto.getUser_id() %></td>
		<th>이름</th>
		<td><%=dto.getName() %></td>
	</tr>
	<tr>
		<th>비밀번호</th>
		<td><%=dto.getPass() %></td>
		<th>생년월일</th>
		<td><%=dto.getBirthday() %></td>
	</tr>
	<tr>
		<th>우편번호</th>
		<td><%=dto.getZipcode() %></td>
		<th>전체주소</th>
		<td><%=dto.getAddress1() %> <%=dto.getAddress2() %></td>
	</tr>
	<tr>
		<th>이메일</th>
		<td><%=dto.getEmail() %></td>
		<th>휴대폰번호</th>
		<td><%=dto.getMobile() %></td>
	</tr>
	<tr>
		<th>전화번호</th>
		<td><%=dto.getTel() %></td>
		<th>회원가입일</th>
		<td><%=dto.getRegidate() %></td>
	</tr>
</table>
<table width="100%">
	<tr>
		<td class="text-center">
			<button onclick="location.href='memberList.jsp?pageNum=<%=pageNum %>';">회원 목록</button>
		</td>
	</tr>
</table>
</div>
</body>
</html>