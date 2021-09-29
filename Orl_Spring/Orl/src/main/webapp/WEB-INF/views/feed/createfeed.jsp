<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CREATE FEED</title>
	<link rel="stylesheet" href="<c:url value='/css/default/default.css'/>">
	<link rel="stylesheet" href="<c:url value='/css/feed/createFeed.css'/>">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<style>
.hide {
	display: none;
}
</style>
</head>

<body>

<!-- 09.24. 태그 / 해시태그 -->

	<!-- 피드 작성 폼 -->
	<form method="post" enctype="multipart/form-data" id="feedform">
		
		<!-- 모달창 시작 -->
		<section class="container_create">
		
			<!-- 모달창 종료 버튼 -->
			<button type="reset" class="c_close">
				<img src="<c:url value="/images/feed/feedw/close.png"/>">
			</button>

			<!-- 왼쪽 프리뷰 영역 -->
			<section class="c_leftbox" id="image_container">
				<img id="preview-img" src="<c:url value="/images/feed/feedw/noImage.png"/>">
			</section>

			<!-- 오른쪽 컨텐츠 영역 -->
			<section class="c_rightbox">
			
				<!-- 작성자 프로필 영역 -->
				<div class="c_profile">
				
					<!-- 작성자 프로필 -->
					<div class="c_photo">
						<button onclick="location.href = '<c:url value="/feed/userfeed/${sessionScope.memberVo.memberIdx}"/>'">	<!-- 수정(09.17.우리) -->
							<img src="<c:url value="/images/member/profile/${member.memberProfile}"/>" alt="profile-img">	<!-- 수정(09.17.우리) -->
						</button>
					</div>
					
					<!-- 작성자 닉네임 -->
					<a href="<c:url value="/feed/userFeed/${sessionScope.memberVo.memberIdx}"/>"
						class="c_nickname">${sessionScope.memberVo.memberNickname}
					</a>

					<!-- 파일 업로드 버튼 -->
					<div class="filebox">
						<label for="fileupload">사진선택</label>
						<input type="file" name="boardPhoto" id="fileupload" onchange="readURL(this);">
					</div>
					
				</div>
				<!-- 작성자 프로필 영역 끝 -->
				
				<!-- 입력 영역 -->
					<!-- 게시글 입력 -->
					<div class="contentsbox">
						<p>게시글</p>
						<textarea placeholder="게시글을 입력해주세요" name="boardDiscription" id="boardDiscription" autocomplete="off"></textarea>
						<!-- 수정 (09.17.우리) -->
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
					
					<!-- 피드 작성 버튼 -->
					<div class="submit">
						<input type="submit" class="feed_submit" value="게시">
					</div>
				<!-- 입력 영역 끝 -->
				
			</section>
			<!-- 오른쪽 컨텐츠 영역 끝 -->

		</section>
		<!-- 모달창 끝 -->
		
	</form>
	<!-- 피드 작성 폼 끝 -->





	<script>
	
	/* 부트 서버 */
	const bootUrl = 'http://3.36.48.110:8083';
		
	$(document).ready(function() {
		
		
		
		/* 폼 내용 서버에 제공 */
		$('#feedform').on('submit', function (e) {
			$(this).submit();
		});
		
		
		
		/* 태그 시작 */
		
			var tag = {};
			var tagCounter = 0;
			
			/* 입력 값을 태그로 생성 */
			function addTag(value) {
				tag[tagCounter] = value;
				tagCounter++;
			}
			
			
			
			/* 태그 입력 */
			$('#tag').on('keypress', function(e) {
				
				var self = $(this);
				
				/* 엔터키나 스페이스바 눌렀을 때 실행 */
				if(e.key == "Enter" || e.keyCode == 32) {
					
					var tagValue = self.val();
					
					/* 닉네임 체크 ajax */
					$.ajax({
						url : bootUrl+'/feed/createfeed/nicknameCheck',
						type: 'GET',
						data: {	 //보내는 데이터 : 입력받은 닉네임 보내기
							memberNickname : tagValue
						},
						success: function(data) { //받는 데이터 : Y or N
							
							//존재하는 닉네임
							if(data == 'Y') {
								
								if(tagValue !== "") {
									
									/* noTag 삭제 */
									$('.noTag').addClass('hide');
									
									var result = Object.values(tag).filter(function (word) {
										return word == tagValue;
									})
									
									//태그 중복 확인	
									if(result.length == 0) {									/* 09.24.수정 : tag-del-btn */
										$('#tag-list').append("<li class='tag-item'>@" + tagValue + "<span class='tag-del-btn' idx='" + tagCounter + "'> x" +
						                		"</span><input type='hidden' name='tag' id='rdTag' value=" + tagValue + "></li>");
										addTag(tagValue);
										self.val("");
									} else {
										alert('이미 등록된 닉네임입니다');
									}
								}
								
							} else {
								alert('존재하지 않는 닉네임입니다');
								return false;
							}
						}
					}); /* 닉네임 체크 ajax 끝 */
					
					e.preventDefault();
				}
				
			}); /* 태그 입력 끝 */
							/* 09.24.수정 : tag-del-btn */
			$(document).on("click", ".tag-del-btn", function (e) {
				
				var tagIndex = $(this).attr("idx");
				tag[tagIndex] = "";
				$(this).parent().remove();
				
				tagCounter--;	/* 09.24.추가 */
				
 				if(tagIndex == 0) {	/* 09.24.추가 */
					$('.noTag').removeClass('hide');	/* 09.24.추가 */					
				}	/* 09.24.추가 */
				
			});

		/* 태그 끝 */
			
		
		
		/* 해시태그 시작 */
		
			var hashTag = {};
			var hashtagCounter = 0;
				
			/* 입력 값을 태그로 생성 */
			function addHashtag(value) {
				hashTag[hashtagCounter] = value;
				hashtagCounter++; /* del-btn의 고유 id */
			}
			
			/* 해시태그 입력 */
			$('#hashtag').on('keypress', function (e) {
					
				var self = $(this);
					
				/* 엔터키나 스페이스바 눌렀을 때 실행 */
				if(e.key == "Enter" || e.keyCode == 32) {
					var hashtagValue = self.val();	//값 가져오기
								
					if(hashtagValue !== "") {
						
						$('.noHashtag').addClass('hide');
						
						//같은 태그 있는지 검사하고 있으면 해당 값이 array로 리턴된다
						var result = Object.values(hashTag).filter(function (word) {
			            	return word == hashtagValue;
			            })
	
			            // 해시태그 중복 확인
			            if (result.length == 0) {
			            	$("#hashtag-list").append(								/* 09.24.수정 : hashtag-del-btn */
			            			"<li class='hashtag-item'>#" + hashtagValue + "<span class='hashtag-del-btn' idx='" + hashtagCounter + "'> x" +
			                		"</span><input type='hidden' name='hashtag' id='rdTag' value=" + hashtagValue + "></li>");
			            	
			            	addHashtag(hashtagValue);
			                self.val("");
			                
						} else {
							alert("이미 등록된 해시태그입니다");
			                }
			            }
			            e.preventDefault(); // SpaceBar시 빈공간x
					}
					
				});
			
			/* 09.24.수정 : hashtag-del-btn */
			$(document).on("click", ".hashtag-del-btn", function (e) {
				var hashTagIndex = $(this).attr("idx");
				hashTag[hashTagIndex] = "";
				$(this).parent().remove();
				
				hashtagCounter--;	/* 09.24.추가 */
				
 				if(hashTagIndex == 0) {	/* 09.24.추가 */
					$('.noHashtag').removeClass('hide');	/* 09.24.추가 */					
				}	/* 09.24.추가 */
				
			});
	
		/* 해시태그 끝 */
	
	}); /* document ready END */
	
	
	
	/* 모달창 on off */
	$(function() {
			
		/* on */
		$(".modalbtn_createfeed").click(function() {
			$(".modal_createfeed").fadeIn();
			$("html, body").addClass("not_scroll");
		});

		/* off */
		$(".c_close").click(function() {
			$(".modal_createfeed").fadeOut();
			$("html, body").removeClass("not_scroll");
			/* 프리뷰 리셋 */
			$('#preview-img').attr('src', '<c:url value="/images/feed/feedw/noImage.png"/>');
			/* 태그 리셋 */
			$('#tag-list').empty();
			/* 해시태그 리셋 */
			$("#hashtag-list").empty();
		});
			
	});

	/* 선택 사진 프리뷰 처리 */
	function readURL(input) {
			
		/* Preview load */
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#preview-img').attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
			
	};
		
	/* 파일 선택 여부 체크 */
	$('.feed_submit').click(function(memberIdx, memberIdx){
			
		var file = $('#fileupload').val();
			
		if(!file){
			alert('사진을 선택해주세요');
			return false;
		} alert('게시 되었습니다');
			
	});
		
	/* 게시글 입력창 줄바꿈 */
	$('#boardDiscription').click(function(){
		var html = $('#boardDiscription').val().replace(/(?:\r\n|\r|\n)/g, '<br />');
	});
		
	</script>

</body>

</html>