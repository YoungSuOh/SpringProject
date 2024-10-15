<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product Details</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f9;
        margin: 0;
        padding: 20px;
    }

    table {
        width: 100%;
        max-width: 800px;
        margin: auto;
        border-collapse: collapse;
        background-color: white;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
        overflow: hidden;
    }

    td {
        padding: 15px;
        vertical-align: top;
    }

    td img {
        border-radius: 8px;
    }

    tr:nth-child(odd) {
        background-color: #f9f9f9;
    }

    tr:nth-child(even) {
        background-color: #ffffff;
    }

    td[rowspan="3"] {
        width: 200px;
        padding-right: 20px;
    }

    td:first-child {
        text-align: center;
    }

    td[width="250"] {
        font-weight: bold;
        color: #333;
    }

    td[width="250"] span {
        font-weight: normal;
        color: #555;
        text-indent: 10pt;
    }

    pre {
        white-space: pre-wrap;
        word-wrap: break-word;
        background-color: #f4f4f4;
        padding: 10px;
        border-radius: 4px;
        font-size: 14px;
        color: #555;
    }

    /* 버튼 스타일 */
    a button {
        background-color: #007BFF;
        color: white;
        border: none;
        padding: 10px 20px;
        margin: 10px;
        font-size: 16px;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    a button:hover {
        background-color: #0056b3;
    }

    a {
        text-decoration: none;
    }

    .button-container {
        text-align: center;
        margin-top: 20px;
    }

</style>
</head>
<body>
    <table>
        <tr>
            <td rowspan="3">
                <img src="https://kr.object.ncloudstorage.com/my-bucket1/storage/${userUploadDTO.imageFileName }"
                alt="${userUploadDTO.imageFileName }" width="200" height="200">
            </td>
            <td width="250">번호: <span>${userUploadDTO.seq}</span></td>
        </tr>
        <tr>
            <td>상품명: <span>${userUploadDTO.imageName}</span></td>
        </tr>
        <tr>
            <td>파일명: <span>${userUploadDTO.imageOriginalFileName}</span></td>
        </tr>
        <tr>
            <td colspan="2" height="200">
                <pre>${userUploadDTO.imageContent}</pre>
            </td>
        </tr>
    </table>

    <!-- 버튼 컨테이너 -->
    <div class="button-container">
        <a href="/spring/user/uploadList"><button type="button">목록</button></a>
        <a href="/spring/user/uploadUpdateForm?seq=${userUploadDTO.seq}"><button type="button">수정</button></a>
    </div>
</body>
</html>

