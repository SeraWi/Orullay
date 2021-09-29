<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Service Error</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="<c:url value='/css/default/default.css'/>">
<link rel="stylesheet" href="<c:url value='/css/error/error.css'/>">
</head>
<body>
<%@ include file="/WEB-INF/frame/default/header.jsp"%>
   <div id="all">
    <section class="content">
         <h1>Service Error</h1>
        
        <p>
            기술적인 문제로 접속이 되지 않았습니다.<br>
            이용에 불편을 드려 죄송합니다.
         </p>
    
       <div class="btn-area"> 
                <a class="btn-area" href="<c:url value='/'/>">메인으로 가기</a>
       </div>

    </section>
    </div>

</body>
</html>