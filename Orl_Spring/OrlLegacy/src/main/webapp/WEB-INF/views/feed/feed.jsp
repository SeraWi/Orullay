<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FEED</title>
<link rel="stylesheet" href="<c:url value='/css/default/default.css'/>">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
.display_none {
	display: none;
}
.btn_yellow {
	background-color: #fdef7b;
}
</style>
</head>
<body>

	<!-- 전체 영역 -->
	<div>
		<div class="feedmain">

			<!-- 상단 여백 -->
			<div class="top">
				<div></div>
				<div class="h1box">
					<div><h1>FEED</h1></div>
				</div>
				<div></div>
			</div>
			<!-- 상단 여백 끝 -->



			<!-- 메인 영역 시작 -->
			<div class="main">
				<!-- 메인-왼쪽 여백 -->
				<div class="leftbox"></div>

				<!-- 메인-중앙 영역 시작-->
				<div class="mainbox">

					<!-- 산 아이콘 -->
					<div class="mountain">
						<img src="<c:url value="/images/feed/feedw/mountain.png"/>">
					</div>

					<!--  피드 네비 시작 -->
					<div class="feednav">
					
						<!-- 피드 정렬 버튼 -->
						<div class="keyword">
							<!-- 기본 정렬 (최신순) -->
							<a id="currentFeedClick" class="btn_yellow">최신순</a>
							<!-- 선택 정렬 (인기순) -->
							<a id="likeFeedClick">인기순</a>
						</div>

						<!-- 피드 올리기 버튼 -->
						<div class="div_createfeed">
							<div>
								<button class="modalbtn_createfeed" onclick="loginCheck(${sessionScope.memberVo.memberIdx})">피드 올리기</button>
							</div>
						</div>

						<!-- 피드 검색 -->
						<form action="<c:url value="/feed/feedSearch"/>" method="post">
							<div class="search">
								<input type="text" placeholder="search" name="mySearch" autocomplete="off" required>
								<button type="submit">
									<img src="<c:url value="/images/feed/feedw/search.png"/>" alt="search">
								</button>
							</div>
						</form>
						<!-- 피드 검색 끝 -->

					</div>
					<!-- 피드 네비 끝 -->
					
					<!-- 피드 갤러리 영역 -->
					<div id="fBox" class="feedbox">
						<!-- feed list gallery ajax -->
					</div>
					<!-- 피드 갤러리 끝 -->
					
					<!-- 인기순 정렬 -->
		            <div class="feedbox display_none" id="likeFeedGallery">
		            
						<c:forEach var="feedOrderByLike" items="${feedOrderByLike}">
							<!-- 피드 하나 -->
		                    <div class="feed">
		                    	<!-- 피드 사진 -->
		                        <div class="feedsize">
		                        	<button class="modalbtn_feedview" type="button"
		                              		onclick="location.href='feedview/${feedOrderByLike.memberIdx}&${feedOrderByLike.boardIdx}'">
		                            	<img src="<c:url value="/images/feed/feedw/uploadfile/${feedOrderByLike.boardPhoto}"/>" class="feedimg" alt="feedimg">
		                           	</button>
		                        </div>
		                        <!-- 피드 사진 끝 -->
		                        
		                        <!-- 피드 정보 -->
		                        <div class="feedinfo">
		                        
		                        	<!-- 게시자 닉네임 -->
		                           	<div class="nickname">
		                            	<a href="<c:url value="/feed/userfeed/${feedOrderByLike.memberIdx}"/>" class="nickname2">${feedOrderByLike.memberNickname}</a>
		                           	</div>						<!-- 09.17.세라 -->
		                           
		                           	<!-- 피드 작성일 -->
		                           	<div>
		                              	<p><fmt:formatDate pattern="yyyy.MM.dd" value="${feedOrderByLike.boardDate}"/></p>
		                           	</div>
		                           
		                        </div>
		                        <!-- 피드 정보 끝 -->
		                        
		                     </div>
		                     <!-- 피드 하나 끝 -->
		                  </c:forEach>
		                  
		               </div>
		               <!-- 인기순 정렬 끝 -->

				</div>
				<!-- 메인-중앙영역 끝 -->

				<!-- 메인-오른쪽 여백 -->
				<div class="rightbox"></div>

			</div>
			<!-- 메인 영역 끝 -->

			<!-- 하단 여백 -->
			<div class="bottom"></div>

		</div>
	</div>
	<!-- 전체 영역 끝 -->





	<script>	
	
	/* document ready 시작 */
	$(document).ready(function() {
	
		/* ajax 최신순 피드 리스트 */
		$.ajax({
			url : '<c:url value="/feed/feedmain/selectNewFeed"/>',
			type : 'GET',
			success : function(data) {
				
				var memberIdx = '${sessionScope.memberVo.memberIdx}';
				showNewFeed(data);
				
			}
		});
		/* ajax 최신순 피드 리스트 끝 */
	
	});
	/* document ready 끝 */
	
	
	
	// 인기순 정렬	/* 09.20.우리 */
	$('#likeFeedClick').click(function() {
		$('#likeFeedGallery').removeClass('display_none');
		$('#fBox').addClass('display_none');
		$('#likeFeedClick').addClass('btn_yellow');
		$('#currentFeedClick').removeClass('btn_yellow');
	});

	// 다시 기본 정렬(최신순)	/* 09.20.우리 */
	$('#currentFeedClick').click(function() {
		$('#fBox').removeClass('display_none');
		$('#likeFeedGallery').addClass('display_none');
		$('#currentFeedClick').addClass('btn_yellow');
		$('#likeFeedClick').removeClass('btn_yellow');
	});
	
		
		
	/* 피드 정렬(최신) 시작 */
	function showNewFeed(list) {

		var html = '';

		$.each(list, function(index, item) {

				html += '<div class="feed">';
				html += '	<div class="feedsize">';
				html += '		<button class="modalbtn_feedview" type="button" onclick="feedLoginCheck('+ item.memberIdx + ', ' + item.boardIdx + ')">';
				html += '			<img src="<c:url value="/images/feed/feedw/uploadfile/'+item.boardPhoto+'"/>" class="feedimg" alt="feedimg">';
				html += '		</button>';
				html += '	</div>';
				html += '	<div class="feedinfo">';
				html += '		<div class="nickname">';
				html += '			<a onclick="feedNicknameCheck(' + item.memberIdx + ')" class="nickname2">' + item.memberNickname + '</a>';
				html += '		</div>';
 				html += '		<div>';
				html += '			<p>' + item.boardDate + '</p>';
				html += '		</div>';
				html += '	</div>';
				html += '</div>';

			})

		$('#fBox').html(html);

	};
	/* 피드 정렬(최신) 끝 */
		


	/* 피드올리기 -> 로그인 체크 */
	function loginCheck(memberIdx) {
			
		var idx = memberIdx;
		if(!idx) {
			alert('로그인 후 이용 가능합니다');
			location.href = '<c:url value="/member/login"/>';
		} else {
			return
		}
	}
		
		

	/* 피드 상세보기 -> 로그인 체크 */
	function feedLoginCheck(memberIdx, boardIdx) {

		var myIdx = '${sessionScope.memberVo.memberIdx}';
		var memberIdx = memberIdx;
		var boardIdx = boardIdx;

		if (!myIdx) {
			alert('로그인 후 이용 가능합니다');
			location.href = '<c:url value="/member/login"/>';
		} else {
			location.href = '<c:url value="/feed/feedview/'+memberIdx+'&'+boardIdx+'"/>';
		}

	};
		
		

	/* 게시자 닉네임 클릭 -> 로그인 체크 */
	function feedNicknameCheck(memberIdx) {

		/* login check */
		var myIdx = '${sessionScope.memberVo.memberIdx}';
		var memberIdx = memberIdx;

		if (!myIdx) {
			alert('로그인 후 이용 가능합니다');
			location.href = '<c:url value="/member/login"/>';
		} else {
			location.href = '<c:url value="/feed/userfeed/'+memberIdx+'"/>';	/* 09.17.우리 */
		}

	}
		
	</script>


</body>
</html>