<%@page import="utils.JSFunction"%>
<%@page import="homework.MembershipDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String user_id = request.getParameter("user_id");
MembershipDAO dao = new MembershipDAO(application);
int result = dao.memberDelete(user_id);
if(result==1){
	JSFunction.alertLocation("회원정보 삭제가 완료되었습니다", "memberList.jsp", out);
}
else{
	JSFunction.alertBack("회원정보 삭제시 오류가 발생하였습니다", out);
}
%>