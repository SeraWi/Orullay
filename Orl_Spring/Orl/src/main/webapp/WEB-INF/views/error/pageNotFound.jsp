<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Page Not Found</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="<c:url value='/css/default/default.css'/>">
<link rel="stylesheet" href="<c:url value='/css/error/error.css'/>">
</head>
<body>
<%@ include file="/WEB-INF/frame/default/header.jsp"%>
   <div id="all">
    <section class="content">
         <h1>Page Not Found</h1>
        
        <p>
           요청하신 페이지는 삭제되었거나, 일시적으로 사용이 중단되었습니다.<br>
              동일한 문제가 지속적으로 발생하는 경우 고객센터로 문의 부탁드립니다. 
         </p>
    
       <div class="btn-area"> 
                <a class="btn-area" href="<c:url value='/'/>">메인으로 가기</a>
       </div>

    </section>
    </div>

</body>
</html>