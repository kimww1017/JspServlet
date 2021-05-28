<%@page import="utils.JSFunction"%>
<%@page import="homework.MembershipDAO"%>
<%@page import="homework.MembershipDTO"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String[] paramArr = new String[20];
int idx = 0;
Enumeration<String> forms = request.getParameterNames();
while(forms.hasMoreElements()){	
	String paramName = (String)forms.nextElement();	
	paramArr[idx++] = request.getParameter(paramName);
}
MembershipDTO dto = new MembershipDTO();

dto.setUser_id(paramArr[0]);
dto.setPass(paramArr[1]);
dto.setName(paramArr[3]);   
dto.setGender(paramArr[4]);   
dto.setBirthday(paramArr[5]); 
dto.setZipcode(paramArr[6]);
dto.setAddress1(paramArr[7]);
dto.setAddress2(paramArr[8]);
dto.setEmail(paramArr[9]+"@"+paramArr[10]  );
dto.setMobile(paramArr[12]+"-"+paramArr[13]+"-"+paramArr[14]);
dto.setTel(paramArr[15]+"-"+paramArr[16]+"-"+paramArr[17]);

MembershipDAO dao = new MembershipDAO(application);
int result = dao.memberRegist(dto);
if(result==1){
	JSFunction.alertLocation("회원가입이 완료되었습니다", "memberList.jsp", out);
}
else{
	JSFunction.alertBack("회원가입시 오류가 발생하였습니다", out);
}
%>