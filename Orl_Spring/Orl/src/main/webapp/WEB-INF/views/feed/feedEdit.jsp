<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FEED EDIT</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
    <link rel="stylesheet" href="<c:url value='/css/default/default.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/feed/editFeed.css'/>">
<style>
.hide {
	display: none;
}
</style>
</head>
<body>

<!-- header -->
<%@ include file="/WEB-INF/frame/default/header.jsp"%>

	<!-- 전체 영역 시작 -->
	<div class="background">
	
	    <!-- 뒤로 가기 (피드 메인) -->
	    <div class="pageBack">
	        <button id="pageBack">
	            <img alt="pageBack" src="<c:url value="/images/feed/feedw/feedButton.png"/>">
	        </button>
	    </div>
	    <!-- 뒤로 가기 끝 -->
	
		<!-- 피드 수정 영역 시작 -->
	    <section class="container_edit">
	
	        <!-- 왼쪽 사진 영역 시작 -->
	        <section class="e_leftbox">
	
	            <!-- 피드 사진 -->
	            <img src="<c:url value="/images/feed/feedw/uploadfile/${selectFeedView.boardPhoto}"/>" alt="feed-img">
	
	        </section>
	        <!-- 왼쪽 사진 영역 끝 -->
	
	
	
	        <!-- 오른쪽 수정 영역 시작 -->
	        <section class="e_rightbox">
	
	            <!-- 게시자 프로필 영역 -->
	            <div class="e_profile">
	
	                <!-- 게시자 프로필 사진 -->
	                <div class="e_photo">
	                    <button onclick="location.href = '<c:url value="/feed/userfeed/${selectFeedView.memberIdx}"/>'">	<!-- 수정 (09.17.우리) -->
	                        <img src="<c:url value="/images/member/profile/${selectFeedView.memberProfile}"/>" alt="profile-img">	<!-- 수정 (09.16.우리) -->
	                    </button>
	                </div>
	
	                <!-- 게시자 닉네임 -->
	                <a href="<c:url value="/feed/userfeed/${selectFeedView.memberIdx}"/>" class="e_nickname">${selectFeedView.memberNickname}</a>	<!-- 수정 (09.17.우리) -->
	
	            </div>
	            <!-- 게시자 프로필 영역 끝 -->
	            
	            <!-- 수정 폼 시작 -->
	            <form method="post" enctype="multipart/form-data" id="feededitform">
	            	
	            	<!-- 게시글 입력 -->
		           	<div class="contentsbox">
						<p>게시글</p>
						<textarea name="boardDiscription" id="boardDiscription" autocomplete="off">${selectFeedView.boardDiscription}</textarea>	<!-- 수정 (09.17.우리) -->
					</div>
					
					<!-- 태그 입력 -->
					<div class="tagbox">
						<p>태그</p>
						<input type="text" placeholder="Enter" name="tag" id="tag" autocomplete="off">
						<div class="tagShow">
							<p class="noTag">태그된 닉네임이 없습니다</p>
							<ul id="tag-list">
								<!-- 태그 리스트 -->
							</ul>
						</div>
					</div>
					
					<!-- 해시태그 입력 -->
					<div class="hashtagbox">
						<p>해시태그</p>
						<input type="text" placeholder="Enter" name="hashtag" id="hashtag" autocomplete="off">
						
						<div class="hashtagShow">
							<p class="noHashtag">입력된 해시태그가 없습니다</p>
							<ul id="hashtag-list">
								<!-- 해시태그 리스트 -->
							</ul>
						</div>
					</div>
						
					<!-- 게시 버튼 -->
					<div class="submit">
						<input type="submit" class="edit_submit" onclick="edit_submit()" value="게시">
					</div>
					
				</form>
				<!-- 수정 폼 끝 -->
	
	        </section>
	        <!-- 오른쪽 수정 영역 끝 -->
	
	    </section>
	    <!-- 피드 수정 영역 끝 -->
	    
	</div>
	<!-- 전체 영역 끝 -->
	
	
	<%@ include file="/WEB-INF/frame/default/footer.jsp"%>



	<script>
	
	/* 부트 서버 */
	const bootUrl = 'http://3.36.48.110:8083';
	/* 저장된 태그 */
	const tag = '${selectFeedView.tag}';
	/* 저장된 해시태그 */
	const hashTag = '${selectFeedView.hashtag}';
	
	/* Feedview back */
	var view = '${selectFeedView.memberIdx}&${selectFeedView.boardIdx}';
	
	/* 뒤로 가기 (피드메인 or 유저 피드) */
	$('#pageBack').click(function(){
		location.href = '<c:url value="/feed/feedview/'+view+'"/>';
	});
	
	
	/* 수정 확인 */
	function edit_submit(){
		alert('수정되었습니다');
	}
	
	
	$(document).ready(function() {
		
	/* 폼 내용 서버에 제공 */
		$('#feedform').on('submit', function (e) {
			$(this).submit();
		});
		
	
	
	/* 태그 */
	
		/* 저장된 태그 리스트 */
		if(tag == null && tag[0]=="") {
			return;
		} else {
			
			console.log(tag);
			
			$('.noTag').addClass('hide');
			
			var str = [];
			var html = "";
			const tagArr = tag;
			
			str = tagArr.split(",");
			
			for(var idx=1; idx<str.length; idx++) {
																			/* 09.24.수정 */
				html += "<li class='tag-item'>@" + str[idx] + "<span class='tag-del-btn' idx='" + tagCounter + "'> x" +
				"</span><input type='hidden' name='tag' id='rdTag' value=" + str[idx] + "></li>";
			}
			$('#tag-list').html(html);
		}
	
		/* 추가하는 태그 */
		var addTag = {};
		var tagCounter = 0;
		
		/* 입력 값을 태그로 생성 */
		function inTag(value) {
			addTag[tagCounter] = value;
			tagCounter++;
		}
		
		/* 추가하는 태그 입력 */
		$('#tag').on('keypress', function (e) {
			
			var self = $(this);
				
			if(e.key == "Enter" || e.keyCode == 32) {
				var tagValue = self.val();
				
				/* 닉네임 체크 ajax */
				$.ajax({
					url : bootUrl+'/feed/createfeed/nicknameCheck',
					type: 'GET',
					data: {
						memberNickname : tagValue
					},
					success: function(data) {
						
						//존재하는 닉네임
						if(data == 'Y') {
							
							if(tagValue !== "") {
								
								$('.noTag').addClass('hide');
								
								var result = Object.values(addTag).filter(function (word) {
									return word == tagValue;
								})
								
								//태그 중복 확인
								if(result.length == 0) {													/* 09.24.수정 */
									$('#tag-list').append("<li class='tag-item'>@" + tagValue + "<span class='tag-del-btn' idx='" + tagCounter + "'> x" +
					                		"</span><input type='hidden' name='tag' id='rdTag' value=" + tagValue + "></li>");
									inTag(tagValue);
									self.val("");
								} else {
									alert('이미 등록된 닉네임입니다');
								}
							}
							
						} else {
							alert('존재하지 않는 닉네임 입니다');
							return false;
						}
					}
				}); /* 닉네임 체크 ajax 끝 */

		        e.preventDefault();
			}
				
		});/* 추가 태그 입력 끝 */
			
		$(document).on("click", ".tag-del-btn", function (e) {
			var tagIndex = $(this).attr("idx");
			addTag[tagIndex] = "";
			$(this).parent().remove();
			tagCounter--;	/* 09.24.추가 */
			
			if(tagIndex == 0) {	/* 09.24.추가 */
				$('.noTag').removeClass('hide');	/* 09.24.추가 */					
			}	/* 09.24.추가 */
			
		});
		
	/* 태그 끝 */
	
	
			
	/* 해시태그 */
	
		/* 저장된 해시태그 리스트 */
		if(hashTag == null) {
			return;
		} else {
			
			$('.noHashtag').addClass('hide');
			
			var str = [];
			var html = "";
			const hashTagArr = hashTag;
			
			str = hashTagArr.split(",");
			
			for(var idx=1; idx<str.length; idx++) {
																				/* 09.24.수정 */
				html += "<li class='hashtag-item'>#" + str[idx] + "<span class='hashtag-del-btn' idx='" + hashtagCounter + "'> x" +
				"</span><input type='hidden' name='hashtag' id='rdTag' value=" + str[idx] + "></li>";
			
			}
			$('#hashtag-list').html(html);
		}
	
		/* 추가하는 해시태그 */
		var addHashTag = {};
		var hashtagCounter = 0;
			
		/* 입력 값을 해시태그로 생성 */
		function inHashTag(value) {
			addHashTag[hashtagCounter] = value;
			hashtagCounter++;
		}

		/* 추가하는 해시태그 입력 */
		$('#hashtag').on('keypress', function (e) {
				
			var self = $(this);
				
			/* 엔터키나 스페이스바 눌렀을 때 실행 */
			if(e.key == "Enter" || e.keyCode == 32) {
				var hashtagValue = self.val();	//값 가져오기
							
				if(hashtagValue !== "") {
					
					$('.noHashtag').addClass('hide');
					
					var result = Object.values(addHashTag).filter(function (word) {
		            	return word == hashtagValue;
		            })

		            // 해시태그 중복 확인
		            if (result.length == 0) {
		            	$("#hashtag-list").append(
		            			"<li class='hashtag-item'>#" + hashtagValue + "<span class='hashtag-del-btn' idx='" + hashtagCounter + "'> x" +
		                		"</span><input type='hidden' name='hashtag' id='rdTag' value=" + hashtagValue + "></li>");
		            	
		            	inHashTag(hashtagValue);
		                self.val("");
		                
					} else {
						alert("태그값이 중복됩니다");
		                }
		            }
		            e.preventDefault(); // SpaceBar 시 빈공간이 생기지 않도록 방지
				}
				
			});
			
		$(document).on("click", ".hashtag-del-btn", function (e) {
			var hashTagIndex = $(this).attr("idx");
			addHashTag[hashTagIndex] = "";
			$(this).parent().remove();
			hashtagCounter--;	/* 09.24.추가 */
			
			if(hashTagIndex == 0) {	/* 09.24.추가 */
				$('.noHashtag').removeClass('hide');	/* 09.24.추가 */					
			}	/* 09.24.추가 */
			
		});
		
	/* 해시태그 끝 */

	
	
	});	
	
	</script>
	
</body>
</html>