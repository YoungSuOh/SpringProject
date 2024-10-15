<%-- SpringProject/src/main/webapp/WEB-INF/user/writeForm.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="../image/sakura_favicon.png" type="image/png">
<link rel="stylesheet" href="../css/update.css">
<title>회원정보수정</title>
</head>
<body>
<div id="update-jsp">
	<div id="left">
		<div id="header">
			<a href="/spring/">
				<img src="../image/sakura_favicon.png" alt="Alarm Logo" alt="logo" width="50" height="50" />
				HOME
			</a>
		</div>
		<div id="profile">
			<img src="../image/mangom3.jpg" width="140" height="140" alt="mangom" />
		</div>
		<div id="links">
			<a id="logOutBtn" href="${context }/member/memberLogOut.do">로그아웃</a> |
			<a href="#">고객센터</a> |
			<a href="#">한국어</a>
		</div>
	</div>

	<div id="right">
		<div id="container">
			<div id="update-header">회원정보 수정</div>
			<form name="userUpdateForm" id="userUpdateForm">
				<table>
				<tr>
				     <th class="label">이름</th>
				     <td class="input">
				        <input type="text" name="name" id="name" />
				       <div id="nameDiv"></div>
				    </td>
				</tr>
				<tr>
				    <th class="label">아이디</th>
				    <td class="input">
				       <input type="text" name="id" id="id" value=${id} readonly />
				    </td>
				</tr>
				<tr>
				    <th class="label">비밀번호</th>
				    <td class="input">
				       <input type="password" name="pwd" id="pwd"/>
				       <div id="pwdDiv"></div>
				    </td>
				</tr>
				<tr>
					<td><input type="hidden" id="pg" name="pg" value="${pg}"/></td>
				</tr>
				<tr align="center">
			        <td colspan="2" height="20">
			            <button type="button" id="updateBtn" >회원정보 수정</button>
			            <button type="button" id="deleteBtn" onclick="location.href='/spring/user/deleteForm?id=${id}'">회원 탈퇴</button>
			            <button type="reset" id="resetBtn">초기화</button>
			        </td>
			    </tr>
			</table>
		</form>
			
		</div>
	</div>
</div>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/js/update.js"></script>
</body>
</html>