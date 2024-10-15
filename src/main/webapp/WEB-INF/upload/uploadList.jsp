<%-- SpringProject/src/main/webapp/WEB-INF/user/uploadList.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.user.bean.UserUploadDTO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="../image/sakura_favicon.png" type="image/png">
<link rel="stylesheet" href="../css/uploadList.css">
<title>파일 목록</title>
</head>
<body>
<div id="header">
   <a href="/spring/">
      <img src="../image/sakura_favicon.png" alt="sakura" alt="logo" width="50" height="50" />
      HOME
   </a>
</div>
<div id="container">
   <div class="formTitle">파일 목록</div>
   
   <input type="hidden" id="pg" value="${pg}"/>
   <div class="card">
      <div id="card-title">이미지 삭제 & 검색</div>
      <div id="card-content">
      	 <!-- 전체 선택 체크박스 -->
         <input type="checkbox" id="all_check" class="check-size" /> 전체 선택
         <button type="button" id="deleteBtn" class="cardBtn">선택 삭제</button>
         
         <div id="search-div">
            <select class="search-opt">
                <optgroup label="검색 항목">
                    <option value="movie-code">이미지 번호</option>
                    <option value="movie-title" selected="selected">상품명</option>
                </optgroup>
            </select>
            <input id="title-box" class="input-box"/>
            <button id="searchBtn" class="cardBtn">검색</button>
         </div>
      </div>
   </div>   
   
   <table>
       <tr>
          <th width="100">
              번호
          </th>
          <th width="300">이미지</th>
          <th width="150">상품명</th>
       </tr>
       <c:forEach var="userUploadDTO" items="${list }">
          <tr>
             <td align="center">
                <input type="checkbox" class="board-list-check" value="${userUploadDTO.seq}" /> ${userUploadDTO.seq }
             </td>      
             <td align="center">
                <a href="/spring/user/uploadView?seq=${userUploadDTO.seq}">                   
                   <img src="https://kr.object.ncloudstorage.com/my-bucket1/storage/${userUploadDTO.imageFileName }" alt="${userUploadDTO.imageFileName }" width="70" height="70"/>
                </a>
             </td>
             <td align="center">${userUploadDTO.imageName }</td>
          </tr>
      </c:forEach>      
   </table>
    
   <div id="page-block">${userUploadPaging.pagingHTML }</div>
</div>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script> 
<script type="text/javascript" src="../js/uploadList.js"></script>
</body>
</html>