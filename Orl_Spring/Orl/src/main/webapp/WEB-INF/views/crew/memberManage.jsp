<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>크루 관리</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
const crewIdx = '${crewIdx}';
const sessionMemberIdx = '${sessionScope.memberVo.memberIdx}';
/*부트서버*/
const url = 'http://52.79.178.223:8081';
/*뷰 서버*/	
const url2 = '${pageContext.request.contextPath}';
/*s3 경로*/
const crewFileUrl = 'https://minju-aws-bucket.s3.ap-northeast-2.amazonaws.com//fileupload/crew';
</script>
<script src="<c:url value='/js/crew/memberManage.js'/>"></script>
<%@ include file="/WEB-INF/frame/default/header.jsp"%>
</head>
<body>
	<div class="section">
		<div class="box">
			<%@ include file="/WEB-INF/frame/crew/crew-manage-nav.jsp"%>
			<div class="edit_section">
				<label for="crewname">크루명</label>
					<table id="crewMemberList" class="table table-hover">
					</table>
			</div>
		</div>
	</div>
</body>
</body>
<%@ include file="/WEB-INF/frame/default/footer.jsp"%>
</html>