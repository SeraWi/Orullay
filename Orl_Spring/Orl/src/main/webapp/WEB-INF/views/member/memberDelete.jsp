<%@page import="com.bitcamp.orl.member.domain.Member"%>
<%@page import="com.mysql.cj.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>삭제중</title>
<c:if test="${result>0}">
	<script>
		alert('탈퇴되었습니다.');
		location.href = '<c:url value="/member/logout"/>';
	</script>
	
</c:if>

<c:if test="${result eq 0}">
	<script>
		alert('탈퇴가 실패하였습니다.');
		window.history.go(-1);
	</script>
</c:if>
</head>
</html>