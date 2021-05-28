<%@page import="utils.BoardPage"%>
<%@page import="homework.MembershipDTO"%>
<%@page import="java.util.List"%>
<%@page import="common.BoardConfig"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="homework.MembershipDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
MembershipDAO dao = new MembershipDAO(application);
Map<String, Object> param = new HashMap<String, Object>();

String searchField = request.getParameter("searchField");//검색할 필드명
String searchWord = request.getParameter("searchWord");//검색어
String queryStr = "";
if(searchWord!=null){
	param.put("searchField", searchField);
	param.put("searchWord", searchWord);
	queryStr = "&searchField="+searchField+"&searchWord="+searchWord;
}
int totalCount = dao.memberCount(param);

/**** 페이지처리 start ***/
int pageSize = BoardConfig.PAGE_PER_SIZE;
int blockPage = BoardConfig.PAGE_PER_BLOCK;
int totalPage = (int)Math.ceil((double)totalCount/pageSize);
int pageNum = 1;
String pageTemp = request.getParameter("pageNum");
if(pageTemp!=null && !pageTemp.equals(""))
	pageNum = Integer.parseInt(pageTemp);
int start = (pageNum-1) * pageSize + 1;
int end = pageNum * pageSize;
param.put("start", start);
param.put("end", end);
/***페이지처리 end ***/

//목록에 실제 출력할 레코드를 얻어오기 위한 메소드 호출
List<MembershipDTO> memberLists = dao.memberListPage(param);
//자원해제
dao.close();
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
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
<table class="table table-bordered table-hover table-striped">
	<colgroup>
		<col width="80px"/>
		<col width="*"/>
		<col width="80px"/>
		<col width="120px"/>
		<col width="150px"/>
		<col width="170px"/>
		<col width="120px"/>
	</colgroup>			
	<tr>
		<th class="text-center">번호</th>
		<th class="text-center">아이디</th>
		<th class="text-center">이름</th>
		<th class="text-center">핸드폰번호</th>
		<th class="text-center">이메일</th>
		<th class="text-center">가입날짜</th>
		<th class="text-center"></th>
	</tr>
<%
if(memberLists.isEmpty()){
	//컬렉션에 저장된 데이터가 없다면...
%>
		<tr>
			<td colspan="7" align="center">
				등록된 회원이 없습니다^^*
			</td>
		</tr>
<%
}
else{
	int vNum = 0;
	int countNum = 0;	
	for(MembershipDTO dto : memberLists)
	{
		vNum = totalCount - (((pageNum-1) * pageSize) + countNum++);
%>	
	<tr>
		<td class="text-center"><%=vNum %></td>
		<td><a href="memberView.jsp?user_id=<%=dto.getUser_id() %>&pageNum=<%=pageNum %>"><%=dto.getUser_id() %></a></td>
		<td class="text-center"><%=dto.getName() %></td>
		<td class="text-center"><%=dto.getMobile() %></td>
		<td class="text-center"><%=dto.getEmail() %></td>
		<td class="text-center"><%=dto.getRegidate() %></td>
		<td class="text-center">
			<button type="button" onclick="location.href='memberEdit.jsp?user_id=<%=dto.getUser_id() %>';">수정</button>
			<button type="button" onclick="memberDelete('<%=dto.getUser_id() %>');">삭제</button>
		</td>
	</tr>
<%
	} 
}
%>	
</table>
<script>
function memberDelete(user_id){
	if(confirm("회원을 삭제하시겠습니까?")){
		location.href="memberDelete.jsp?user_id="+user_id;
	}
}
</script>
<table width="100%">
	<tr align="center">
		<td>
			<%=BoardPage.pagingStr(totalCount, pageSize, blockPage, 
					pageNum, request.getRequestURI(), queryStr)%>							 
		</td>
		<td width="100">
			<button onclick="location.href='memberRegistForm.jsp';">회원 가입</button>
		</td>
	</tr>
</table>	
</div>	
</body>
</html>