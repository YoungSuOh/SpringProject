<%-- SpringProject/src/main/webapp/WEB-INF/user/writeForm.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f9;
	margin: 0;
	padding: 20px;
}

#write-jsp {
	display: flex;
	max-width: 1200px;
	margin: 0 auto;
	background-color: white;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	padding: 20px;
}

#left {
	width: 20%;
	padding: 20px;
	background-color: #f8f8f8;
	border-radius: 8px;
	text-align: center;
}

#left img {
	border-radius: 50%;
	margin-bottom: 20px;
}

#links a {
	display: block;
	color: #333;
	font-size: 14px;
	margin: 5px 0;
	text-decoration: none;
}

#links a:hover {
	text-decoration: underline;
}

#right {
	width: 75%;
	margin-left: 20px;
	padding: 20px;
}

#container {
	background-color: #ffffff;
	padding: 30px;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
}

#edit-header {
	font-size: 24px;
	font-weight: bold;
	margin-bottom: 20px;
	text-align: center;
}

form {
	max-width: 600px;
	margin: 0 auto;
}

table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	padding: 10px;
	text-align: left;
	vertical-align: top;
}

th.label {
	width: 30%;
	font-weight: bold;
	color: #333;
	text-align: right;
	padding-right: 20px;
}

td.input input {
	width: 100%;
	padding: 10px;
	font-size: 14px;
	border: 1px solid #ddd;
	border-radius: 4px;
	background-color: #f9f9f9;
	box-sizing: border-box;
}

input[type="file"] {
	padding: 5px;
	background-color: white;
}

td input[type="file"] {
	width: 100%;
}

tr.align-center td {
	text-align: center;
}

button {
	background-color: #007BFF;
	color: white;
	border: none;
	padding: 10px 20px;
	font-size: 16px;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s ease;
	margin-right: 10px;
}

button:hover {
	background-color: #0056b3;
}

button#resetBtn {
	background-color: #6c757d;
}

button#resetBtn:hover {
	background-color: #5a6268;
}

td[colspan="2"] {
	padding-top: 20px;
}
</style>
</head>
<body>
	<div id="write-jsp">
		<div id="left">
			<div id="header">
				<a href="${pageContext.request.contextPath}"> <img
					src="../image/logo.jpeg" alt="logo" width="50" height="50" /> HOME
				</a>
			</div>
			<div id="profile">
				<img src="../image/mangom3.jpg" width="140" height="140"
					alt="mangom" />
			</div>
			<div id="links">
				<a id="logOutBtn" href="${context }/member/memberLogOut.do">로그아웃</a>
				| <a href="#">고객센터</a> | <a href="#">한국어</a>
			</div>
		</div>

		<div id="right">
			<div id="container">
				<div id="edit-header">회원가입</div>
				<form name="uploadUpdateForm" id="uploadUpdateForm">
				<input type="hidden" name="seq" value="${userUploadDTO.seq }" />
					<table>
						<tr>
							<th class="label">상품명</th>
							<td class="input"><input type="text" name="imageName"
								id="imageName" value="${ userUploadDTO.imageName}" /></td>
						</tr>
						<tr>
							<th class="label">상품 내용</th>
							<td class="input"><input type="text" name="imageContent"
								id="imageContent" value="${ userUploadDTO.imageContent}" /></td>
						</tr>
						<tr>
							<th class="label">상품사진</th>
							<td class="input">
								<!-- 업로드된 이미지 미리보기 --> <img id="imagePreview"
								src="https://kr.object.ncloudstorage.com/my-bucket1/storage/${ userUploadDTO.imageFileName }"
								alt="이미지 미리보기" width="100" height="100" /> <br /> <!-- 파일 선택 input -->
								<input type="file" name="img" id="img" />
							</td>
						</tr>
						<tr class="align-center">
							<td colspan="2" height="20">
								<button type="button" id="updateImageBtn">글 수정</button>
								<button type="reset" id="resetBtn">초기화</button>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="../js/uploadUpdate.js"></script>
	<script>
   document.getElementById('img').addEventListener('change', function(event) {
      const file = event.target.files[0];
      if (file) {
         const reader = new FileReader();
         reader.onload = function(e) {
            document.getElementById('imagePreview').src = e.target.result; // 미리보기 이미지 업데이트
         };
         reader.readAsDataURL(file); // 파일을 Data URL로 읽기
      }
   });
</script>
</body>
</html>
