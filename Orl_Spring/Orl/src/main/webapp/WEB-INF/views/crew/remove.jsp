<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>크루 관리</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<%@ include file="/WEB-INF/frame/default/header.jsp"%>
</head>
<script>
const crewIdx = '${crewIdx}';
const memberIdx = '${sessionScope.memberVo.memberIdx}';
/*부트서버*/
const url = 'http://52.79.178.223:8081';
/*뷰 서버*/	
const url2 = '${pageContext.request.contextPath}';
</script>
<script src="<c:url value='/js/crew/crewDelete.js'/>"></script>
<body>
	<div class="section">
		<div class="box">
			<%@ include file="/WEB-INF/frame/crew/crew-manage-nav.jsp"%>
			<div class="edit_section">
				<form method="post">
					<table>
						<tr>
							<td><label for="crewname">크루명</label></td>
							<td>
								<p id="crewname" class="text_bold"></p>
							</td>
						</tr>
						<tr>
							<td><label for="confirm">확인</label></td>
							<td><input id="crewNameRe" type="text" class="form-control remove_input" name="crewName" placeholder="삭제를 원하시면 크루명을 입력해주세요."></td>
						</tr>
						<tr>
							<td></td>
							<td><input id="submit" type="submit" value="삭제" class="form-control btn-secondary"></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/frame/default/footer.jsp"%>
</html>