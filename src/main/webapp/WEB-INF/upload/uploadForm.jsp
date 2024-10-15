<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <style>
    body {
        font-family: 'Arial', sans-serif;
        background: linear-gradient(135deg, #f9f9f9, #ffccf9);
        background-image: url('../image/sakura_back4.jpg');
        background-size: cover;
        background-repeat: no-repeat;
        background-attachment: fixed;
        background-position: center;
        color: #333;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    form {
        background-color: rgba(255, 255, 255, 0.9);
        border-radius: 15px;
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
        padding: 30px;
        max-width: 500px;
        width: 100%;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        padding: 10px;
        text-align: left;
        font-size: 16px;
    }

    input[type="text"], textarea {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 14px;
        box-sizing: border-box;
    }

    .file-drop-zone {
        border: 2px dashed #ccc;
        padding: 20px;
        text-align: center;
        margin-top: 10px;
        border-radius: 5px;
        background-color: #f9f9f9;
        color: #888;
        position: relative;
    }

    .file-drop-zone.dragover {
        background-color: #f0f0f0;
        border-color: #ffb6c1;
    }

    input[type="file"] {
        display: none; /* Hide the original file input */
    }

    input[type="submit"], input[type="reset"] {
        background-color: #ffb6c1;
        color: white;
        border: none;
        padding: 12px 25px;
        border-radius: 8px;
        cursor: pointer;
        font-size: 14px;
        transition: background-color 0.3s ease;
    }

    input[type="submit"]:hover, input[type="reset"]:hover {
        background-color: #ff7f7f;
    }

    td[colspan="2"] textarea {
        resize: none;
    }

    td[colspan="2"] {
        text-align: center;
    }

    .image-preview {
    	position: relative;
        max-width: 100%;
        height: auto;
        margin-top: 15px;
        display: none;
        border: 1px solid #ddd;
        border-radius: 5px;
        padding: 5px;
        background-color: #fff;
        /* 이미지 크기를 제한하여 페이지 레이아웃이 깨지지 않도록 설정 */
        max-height: 100px; /* 이미지의 최대 높이 제한 */
        object-fit: contain; /* 이미지 비율을 유지하면서 박스 안에 맞춤 */
    }
</style> -->
</head>
<body>
<form method="post" enctype="multipart/form-data" action="/spring/user/upload">
	<table>
	<tr>
		<th>상품명</th>
		<td>
			<input type="text" name="imageName" size="35">
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<textarea name="imageContent" rows="10" cols="50"></textarea>
		</td>
	</tr>
	<%--
	<tr>
		<td colspan="2">
			<input type="file" name="img">
		</td>
	</tr>
	<!-- 다중 업로드할 때는 name 속성의 이름이 같아야 한다. => 서버에서 배열로 받기 때문임 @RequestParam MultipartFile[] img -->
	<tr>
		<td colspan="2">
			<input type="file" name="img">
		</td>
	</tr>
	 --%>
	 
	 <!-- 한번에 여러개(드래그)선택 -->
	 <tr>
		<td colspan="2">
			<input type="file" name="img[]" multiple="multiple"> <!-- 이러면 서버에 넘어갈 때 List로 넘어간다. -->
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="submit" value="이미지 업로드">
			<input type="reset" value="취소" id="resetButton">
		</td>
	</tr>
	</table>
</form>

<script>
    const fileDropZone = document.getElementById('fileDropZone');
    const fileInput = document.getElementById('fileInput');
    const imagePreview = document.getElementById('imagePreview');
    const resetButton = document.getElementById('resetButton');

    // 드래그 앤 드롭 기능 추가
    fileDropZone.addEventListener('dragover', function(e) {
        e.preventDefault();
        fileDropZone.classList.add('dragover');
    });

    fileDropZone.addEventListener('dragleave', function(e) {
        e.preventDefault();
        fileDropZone.classList.remove('dragover');
    });

    fileDropZone.addEventListener('drop', function(e) {
        e.preventDefault();
        fileDropZone.classList.remove('dragover');

        const files = e.dataTransfer.files;
        if (files.length > 0) {
            fileInput.files = files; // 파일을 input에 전달
            previewImage(files[0]); // 이미지 미리보기 함수 호출
        }
    });

    // 클릭 시 파일 선택 창 열기
    fileDropZone.addEventListener('click', function() {
        fileInput.click();
    });

    // 파일 선택 후 미리보기 표시
    fileInput.addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            previewImage(file);
        }
    });

    // 이미지 미리보기 함수
    function previewImage(file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            imagePreview.src = e.target.result;
            imagePreview.style.display = 'block'; // 이미지 미리보기 표시
        };
        reader.readAsDataURL(file); // 파일을 데이터 URL로 변환
    }

    // 리셋 버튼 클릭 시 이미지 미리보기 삭제
    resetButton.addEventListener('click', function() {
        imagePreview.style.display = 'none'; // 미리보기 숨기기
        imagePreview.src = ''; // 이미지 소스 초기화
    });
</script>
</body>
</html>
