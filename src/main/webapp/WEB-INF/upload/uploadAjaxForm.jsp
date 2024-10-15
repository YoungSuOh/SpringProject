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
<form id="uploadAjaxForm">
	<table border="1">
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
	 <tr>
		<td colspan="2">
		<img id="camera" src="../image/카메라.png" width=50 height=50 alt="카메라">
		<span id="showImageList">이미지 미리보기</span>		
			<input type="file" name="img[]" id="img" multiple="multiple" style="visibility:hidden;">
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="button"  id="uploadAjaxBtn"  value="이미지 업로드">
			<input type="reset" value="취소" id="resetButton">
		</td>
	</tr>
	</table>
</form>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script> 
<script type="text/javascript" src="../js/uploadAjax.js"></script>
<script type="text/javascript">
$('#camera').click(function(){
	$('#img').trigger('click'); // 강제로 이벤트 발생시킴
});
/* 이미지 미리보기  */
$('#img').change(function(){
	$('#showImageList').empty(); // 이전 이미지 미리보기 제거
	
	for(let i=0; i<this.files.length; i++){
		readURL(this.files[i]); // 파일 읽기
	}
});
function readURL(file){
	let reader = new FileReader();
	
	reader.onload = function(e){
		let img = document.createElement('img'); // 새로운 img 요소 생성
		img.src = e.target.result; // 파일의 URL 설정
		img.width = 70; // 미리보기 이미지 크기 설정
		img.height = 70; 
		$('#showImageList').append(img); // 미리보기 리스트에 추가
	}
	reader.readAsDataURL(file); // 파일을 Data URL로 읽기
}
$('#uploadBtn').click(function(){
	
});
</script>
</body>
</html>
<!-- 
FileReader 란?
FileReader는 type이 file인 input 태그 또는 API 요청과 같은 인터페이스를 통해 
File 또는 Blob 객체를 편리하게 처리할수있는 방법을 제공하는 객체이며
abort, load, error와 같은 이벤트에서 발생한 프로세스를 처리하는데 주로 사용되며,
File 또는 Blob 객체를 읽어서 result 속성에 저장한다.

FileReader도 비동기로 동작한다.

FileReader.onload()
load 이벤트의 핸들러. 이 이벤트는 읽기 동작이 성공적으로 완료되었을 때마다 발생한다.
 -->
