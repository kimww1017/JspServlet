<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	include 지시어 : 공통으로 사용할 JSP파일을 생성한 후 
					 현재문서에 포함시킬 때 사용한다. 
					 각각의 JSP파일 상단에는 반드시 page 지시어가 삽입되어야 한다.
					 단, 하나의 JSP파일에서 page지시어가 중복선언되면 안된다.
 --%>
<%@ include file = "IncludePage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IncludeMain.jsp</title>
<!-- CSS코드는 양이 많으므로  외부파일로 선언하여현재문서에 링크시킨다. -->
<link rel="stylesheet" href="./css/div_layout.css" />
</head>
<body>
	<div class="AllWrap">
		<div class="header">
			<!-- GNB영역 -->
			<%@ include file="../common/Top.jsp" %>
		</div>
		<div class="body">
			<div class="left_menu">
				<!-- LNB영역(Local Navigation Bar) -->
				<%@ include file="../common/Left.jsp" %>
			</div>
			<div class="contents">
				<!-- Contents영역 -->
				
				<h2>오늘의 날짜 : <%=todayStr %></h2>
				<br /><br />
				
				박수진은 10일 인스타그램에 특별한 멘트는 없이 하트 이모티콘(🤍)만 
				<br /><br />
				남긴 채 사진을 게재했다. 
				<br /><br />
				화보 촬영 현장으로 추정된다. 
				<br /><br />
				흰색 민소매 조끼에 흰색 바지 차림인 박수진이 시크한 눈빛을 보내며 
				<br /><br />
				멋들어진 포즈를 취하고 있다. 박수진을 대표하는 특유의 단발머리와 
				<br /><br />
				여전한 청순미모가 단연 시선을 강탈한다.
				<br /><br />
				박수진의 공개 활동이 예상되는 사진이다. 특히 걸그룹 슈가 동료였던 
				<br /><br />
				가수 겸 배우 아유미(37)도 "넘 이쁜거아니닝😍"이란 댓글을 남겼다.
				<br /><br />
				박수진은 슈가로 2001년 데뷔했다. 배우로 '꽃보다 남자', 
				<br /><br />
				'천만번 사랑해', '내 여자친구는 구미호', '넝쿨째 굴러온 당신' 등 
				<br /><br />
				여러 작품에 출연했다. 특히 절친인 배우 김성은(37)과 함께 진행한 
				<br /><br />
				맛집 예능 '테이스티 로드'가 대중의 큰 사랑 받았다.				
				<br /><br />
			</div>
		</div>
	</div>
	<div class="copyright">
	<!-- Copyright -->
		<%@ include file="../common/Copyright.jsp" %>
	</div>
</body>
</html>