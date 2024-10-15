<%-- SpringProject/src/main/webapp/WEB-INF/index.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="./image/sakura_favicon.png" type="image/png">
<link rel="stylesheet" href="./css/index.css">
<title>Bitcamp Spring</title>
</head>
<body>
	<canvas id="sakuraCanvas"></canvas>

	<a id="logo" href="/spring/"> <img src="./image/sakura_logo.png"
		alt="logo" />
	</a>

	<div id="container">
		<div class="menuContainer">
			<p>
				<a class="menuLink" href="/spring/user/writeForm">회원가입</a>
			</p>
			<p>
				<a class="menuLink" href="/spring/user/login">로그인</a>
			</p>
			<p>
				<a class="menuLink" href="/spring/user/list">출력</a>
			</p>
			<p>
				<a class="menuLink" href="/spring/user/uploadForm">파일 업로드</a>
			</p>
			<p>
				<a class="menuLink" href="/spring/user/uploadAjaxForm">파일 업로드 AJAX</a>
			</p>
			<p>
				<a class="menuLink" href="/spring/user/uploadList">파일 리스트</a>
			</p>
		</div>
	</div>
	<script src="./js/sakura.js"></script>

</body>
</html>

<!-- 
Spring Framework + Maven + MySQL + MyBatis(@Mapper 사용) + JSP(jquery)
storage -> 가상의 주소, 이 곳을 중심으로 파일 업로드

 -->