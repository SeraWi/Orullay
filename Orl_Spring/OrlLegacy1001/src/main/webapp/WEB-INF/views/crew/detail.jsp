<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>크루 상세</title>
<link rel="stylesheet" href="<c:url value='/css/crew/crew-detail.css'/>">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We"
	crossorigin="anonymous">
<script defer
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
const crewTag = '${crew.crewTag}';
const crewIdx = '${crew.crewIdx}';
const memberIdx = '${sessionScope.memberVo.memberIdx}';
const currentPageNum = parseInt('${cri.currentPageNum}');
const url = '${pageContext.request.contextPath}';
</script>
<script src="<c:url value='/js/crew/detail.js'/>"></script>
<%@ include file="/WEB-INF/frame/default/header.jsp"%>
</head>
<body>
<c:if test="${updateResult eq 1}">
<script>
	alert('수정되었습니다.')
</script>
</c:if>
	<div class="section">
		<section>
			<div class="box">
				<div class="card">
				
					<div id="crew-img">
					</div>
					
					<div class="card-body">
					
						<div class="crew_name_section">
							<h3 id="crew-title" class="card-title"></h3>
							<div id="crew-Mng">
							</div>
						</div>
						
						<div id="crew-introduction">
						</div>
						
						<ul class="crew_hashtag" id="crewHashTag">
						</ul>
						
						<div class="crew_information">
							<div id="crewCap" class="crew_captain"></div>
							<div id="crew_number" class="crew_number"></div>
							<div id="crew_comment_number" class="crew_comment_number"></div>
						</div>
						
							<div class="join_section" id="joinToCrew">
								<button class="btn btn-light">가입하기</button>
							</div>
							<div class="join_section" id="outFromCrew">
								<button class="btn btn-light">탈퇴하기</button>
							</div>
            
					</div><!-- card-body 끝 -->
				</div><!-- card 끝 -->
				
				<div class="comment_section">
					<div class="comment_table">
						<table id="commentList">
							
						</table>
					</div>
					
					<div class="input_section">
						<div>
							<ul class="pagination" id="paging">
							</ul>
						</div>
						
						<div id="input-form">
							<div class="input_control">
								<div id="textinput">
									<input type="text" name="crewComment" class="form-control" id="crewComment">
								</div>
								<div id="textinput-readonly">
									<input type="text" name="crewComment" class="form-control" id="crewComment" readonly="readonly">
								</div>
								<div>
									<input type="submit" value="게시" class="btn1 btn-light form-control" id="submit">
								</div>
							</div>
						</div>
						
					</div>
				</div>
			</div>
		</section>
	</div>
	<%@ include file="/WEB-INF/frame/default/footer.jsp"%>
</body>
</html>