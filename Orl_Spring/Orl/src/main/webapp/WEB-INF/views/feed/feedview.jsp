<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FEED VIEW</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<link rel="stylesheet" href="<c:url value='/css/default/default.css'/>">
<link rel="stylesheet" href="<c:url value='/css/feed/feedView.css'/>">
<style>
.show {
	display: block;
}
.hide {
	display: none;
}
</style>
</head>
<body>

<!-- 09.24. 221, 264 -->

	<!-- header -->
	<%@ include file="/WEB-INF/frame/default/header.jsp"%>



	<!-- 전체 영역 시작 -->
	<div class="background">

		<!-- 뒤로가기 (피드메인 or 유저피드) -->
		<div class="pageBack">
			<button id="pageBack">
				<img alt="pageBack"
					src="<c:url value="/images/feed/feedw/feedButton.png"/>">
			</button>
		</div>
		<!-- 뒤로가기 끝 -->

		<!-- 상세보기 영역 -->
		<section class="container_view">

			<!-- 왼쪽 사진 영역 -->
			<section class="v_leftbox">

				<!-- 피드 이미지 -->
				<img src="<c:url value="/images/feed/feedw/uploadfile/${selectFeedView.boardPhoto}"/>" alt="feed-img">
				
				<!-- 해시태그 -->
						<div class="hashTag">
							<!-- 해시태그 리스트 -->
						</div>

				<!-- 태그 버튼 -->
				<button>
					<img id="tag" src="<c:url value="/images/feed/feedw/icon-05.png"/>">
					<div class="tagList hide">
						<!-- 태그 리스트 -->
					</div>
				</button>

			</section>
			<!-- 왼쪽 사진 영역 끝 -->
			
			

			<!-- 오른쪽 컨텐츠 영역 -->
			<section class="v_rightbox">

				<!-- 게시자 프로필 영역 -->
				<div class="v_profile">

					<!-- 피드 수정/삭제 버튼 (내 피드일때만) -->
					<c:if test="${sessionScope.memberVo.memberIdx eq selectFeedView.memberIdx}">
						<!-- 수정 버튼 -->
						<div class="edit_div">
							<button class="v_edit feedview_btn"
								onclick="feedEdit(${selectFeedView.memberIdx}, ${selectFeedView.boardIdx})">수정</button>
						</div>
						<!-- 삭제 버튼 -->
						<div class="delete_div">
							<button class="v_delete feedview_btn">삭제</button>
						</div>
					</c:if>
					<!-- 피드 수정/삭제 버튼 끝 -->

					<!-- 게시자 프로필 사진 -->
					<div class="v_photo">
						<button onclick="location.href = '<c:url value="/feed/userfeed/${selectFeedView.memberIdx}"/>'">	<!-- 수정 (09.17.우리) -->
							<img src="<c:url value="/images/member/profile/${selectFeedView.memberProfile}"/>" alt="profile-img">	<!-- 수정 (09.17.우리) -->
						</button>
					</div>

					<!-- 게시자 닉네임 -->
					<a href="<c:url value="/feed/userfeed/${selectFeedView.memberIdx}"/>" class="v_nickname">${selectFeedView.memberNickname}</a>	<!-- 수정(09.17.우리) -->

					<!-- 게시 내용 -->
					<div class="contents">
						<!-- 게시글 -->
						<textarea readonly>${selectFeedView.boardDiscription}</textarea>

					</div>

				</div>
				<!-- 게시자 프로필 영역 끝 -->



				<!-- 댓글 영역 시작 -->
				<section class="commentbox">
					<div id="cmt">
						<!-- 댓글 리스트(ajax) -->
					</div>
				</section>
				<!-- 댓글 영역 끝 -->



				<!-- 댓글 입력 영역 시작 -->
				<section class="commentingbox">

					<!-- 댓글창 네비 시작 -->
					<div class="buttonline">
						<div>
							<!-- 좋아요 버튼 -->
							<button class="like" id="likeButton">

								<!-- 현재: 좋아요 한 상태, 누르면: 좋아요 취소 -->
								<c:if test="${likeStatus>0}">
									<img id="current-like" name="delete"
										src="<c:url value="/images/feed/feedw/like.png"/>"
										onclick="clickLike(this.name)">
								</c:if>

								<!-- 현재: 좋아요 안한 상태 , 누르면: 좋아요 하기 -->
								<c:if test="${likeStatus==0}">
									<img id="current-dislike" name="insert"
										src="<c:url value="/images/feed/feedw/nolike.png"/>"
										onclick="clickLike(this.name)">
								</c:if>

							</button>
							<!-- 좋아요 버튼 끝 -->

							<!-- 카톡 공유하기 -->
							<a id="kakao-link-btn" class="share"
								href="javascript:sendLink(${selectFeedView.memberIdx},${selectFeedView.boardIdx},${totalLikeCount})">
								<img
								src="https://developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png" />
							</a>
							<!-- 카톡 공유하기 끝 -->
						</div>

						<!-- 좋아요 갯수 영역 -->
						<div class="likeline">
							<p>
								좋아요 <span id="totaLikeCount">${totalLikeCount}</span>개
							</p>
						</div>
						<!-- 좋아요 갯수 영역 끝-->

					</div>
					<!-- 댓글창 네비 끝 -->

					<!-- 댓글 입력 영역 시작 -->
					<form method="post" enctype="multipart/form-data">
						<div class="commentingline">

							<!-- 입력창 -->
							<div class="textbox">
								<input type="text" placeholder="댓글달기" name="comment"
									id="comment" autofocus autocomplete="off">
							</div>

							<!-- 게시 버튼 -->
							<div class="submitbox">
								<input type="submit" id="comment_submit" value="게시">	<!-- 수정 (09.17.우리) -->
							</div>

						</div>
					</form>
					<!-- 댓글 입력 영역 끝 -->

				</section>
				<!-- 댓글 입력 영역 끝 -->

			</section>
			<!-- 오른쪽 컨텐츠 영역 끝 -->

		</section>
		<!-- 상세보기 영역 끝 -->

	</div>
	<!-- 전체 영역 끝 -->



	<!-- footer -->
	<%@ include file="/WEB-INF/frame/default/footer.jsp"%>





	<script>
	
	/* 부트 서버 */
	const bootUrl = 'http://3.36.48.110:8083';
	/* 태그 */
	const tag = '${selectFeedView.tag}';
	/* 해시태그 */
	const hashTag = '${selectFeedView.hashtag}';
    /* boardMemberIdx */
	let boardMemberIdx = '${boardMemberIdx}';

	/* 09.24.추가 */
	/* 해시태그 search submit */
	function setParamTag(tag){
        $("#mySearch").val(tag);
        console.log(tag);
        $("#formSearch").submit();
    }
	
	/* document ready START */
    $(document).ready(function(){
    	
		/* 태그 리스트 */
 		if(tag == null) {
			return;
		} else {
			
			var str = [];
			var html = "";
			const tagArr = tag;
			
			str = tagArr.split(",");
			
			for(var idx=1; idx<str.length; idx++) {
				
				$.ajax({
					url: bootUrl+'/feed/feedview/memberIdxCheck',
					type: 'get',
					async: false,
					data: {
						memberNickname : str[idx]
					},
					success: function(data) {
						html += '<a class="tag-item" href="<c:url value="/feed/userfeed/'+ data +'"/>">@'
								+ str[idx] + '</a>';
					}
				});
				
			}
			$('.tagList').html(html);
		};
		
		
    	
		/* 09.24.수정 */
		/* 해시태그 리스트 */
		if(hashTag == null) {
			return;
		} else {
			
			var str = [];
			const hashTagArr = hashTag;
			
			str = hashTagArr.split(",");
			
			var html = "";
			
			html += '<form id="formSearch" action="${pageContext.request.contextPath}/feed/feedSearch" method="POST">';
			
			for(var idx=1; idx<str.length; idx++) {
				html += '<h1 onclick="setParamTag(this.title)" class="hashtag-item" title="'+str[idx]+'">#' + str[idx] + '</h1> ';
			}
            
            html += '<input name="mySearch" id="mySearch" type="hidden" value="">';
            html += '</form>';
			
			$('.hashTag').html(html);
		};
		

		

        /* 댓글 리스트 (ajax) */
        $.ajax({
            url: bootUrl+'/feed/feedview/selectcomment',
            type: 'get',
            data: {
                boardIdx: '${selectFeedView.boardIdx}'
            },
            success: function(data) {
            	
                var memberIdx = '${sessionScope.memberVo.memberIdx}';
                showList(data,memberIdx);
                
            }
        });
  
    });
    /* document ready END */
    
    
    
	/* 뒤로 가기 (피드메인 or 유저 피드) */
	$('#pageBack').click(function(){
		location.href = '<c:url value="/feed/feedmain"/>';
	});
    
    
    
	/* 태그 리스트 (토글) */
	$('#tag').click(function(){
			
		var list = $('#tagList');
			
		$('.tagList').fadeToggle(
			function() {
				list.addClass('show');
			}
		);
	});
	
	
	
	/* 피드 수정 페이지 이동 */
	function feedEdit(memberIdx, boardIdx){
        	
		var myIdx = '${sessionScope.memberVo.memberIdx}';
		var memberIdx = memberIdx;
		var boardIdx = boardIdx;
    								
		if(!myIdx) {
			alert('로그인 후 이용 가능합니다');
			location.href='<c:url value="/member/login"/>';
		} else {
			location.href='<c:url value="/feed/feededit/'+memberIdx+'&'+boardIdx+'"/>';
		}
        	
	}
    
    
    
    /* 피드 삭제 (ajax) */
    $('.v_delete').click(function(){
        $.ajax({
            url : bootUrl+'/feed/feedview/deletefeed/${selectFeedView.memberIdx}&${selectFeedView.boardIdx}',
            type:'POST',
            success : function(data) {
                if(data==1) {
                    alert('피드가 삭제되었습니다');
                    location.href = '<c:url value="/feed/feedmain"/>';
                }
            }
        });
    });
    
    
    
	/* 댓글 삭제 (ajax) */
	function commentDelete(boardCommentIdx, boardIdx){
        	
		var board = boardIdx;
		var idx = boardCommentIdx;

		$.ajax({
			url: bootUrl+'/feed/feedview/deletecomment/'+idx+'&'+board,
			type: 'GET',
			success: function(data){
                
				var memberIdx = '${sessionScope.memberVo.memberIdx}';
				alert('댓글이 삭제되었습니다');
                showList(data,memberIdx);
                    
			}
		});
	};
    
    
    
    /* 댓글 리스트 */
    function showList(list, memberIdx){
        
		var html = '';
		var idx = memberIdx;
            
        $.each(list, function(index, item){

			html += '<div class="comments">';
			html += '      <div class="cmt-profile">';
			html += '         <button onclick="showUserFeed('+item.memberIdx+')">';
			html += '            <img src="<c:url value="/images/member/profile/'+item.memberProfile+'"/>" alt="cmt-profile-img">';
			html += '         </button>';
			html += '      </div>';
			html += '      <div class="comment">';
			html += '         <a href="<c:url value="/feed/userfeed/'+item.memberIdx+'"/>" class="v_nickname">'+item.memberNickname+'</a>';	/* 수정 (09.17.우리) */
			html += '         <p>'+item.comment+'</p>';
			html += '      </div>';
			html += '		<div class="cmt-space"></div>';
				
			//피드 삭제 (내 댓글이거나 내 피드일때 삭제 가능)
			if (idx == item.memberIdx || idx == boardMemberIdx){
				html += '   <a class="comment_delete" onclick="commentDelete('+item.boardCommentIdx+',${boardIdx})">';
				html += '   	<img src="<c:url value="/images/feed/feedw/delete_icon.png"/>" class="delete_icon" alt="feedview_deleteIcon">';
				html += '   </a>';
			}
			html += '</div>';
		})
		$('#cmt').html(html);
	}
    
    
    
    /* 댓글 게시자 프로필 사진으로 계정 이동 */
 	function showUserFeed(memberIdx) {
		location.href='<c:url value="/feed/userfeed/'+memberIdx+'"/>';	/* 수정 (09.17.우리) */
	}

 
	
	/* 댓글 빈값 체크 */
    $('#comment_submit').click(function(){
    	
    	var comment = $('#comment').val();
    	
    	if(!comment){
    		alert('댓글 내용을 입력해주세요');
    		return false;
    	} alert('게시되었습니다');
    	
    });
        
        
        
</script>

   <!-- 좋아요 이벤트 -->
   <script>
      function clickLike(click){
         
         console.log(click);
         
         if(click == 'insert'){
            //비동기 통신 시작
            
            // myIdx 파라미터로 추가0918, url 수정
            // url경로 boot 로 수정
            $.ajax({
               url: bootUrl+'/feed/likeButtonClick',
               type:'POST',
               data:{
                  likeChange:'1',
                  boardIdx:'${selectFeedView.boardIdx}',
                  myIdx:'${sessionScope.memberVo.memberIdx}'
               },
               success:function(data){
                  //좋아요 누르기 성공
                  if(data ==1){
                     
                     console.log('insert성공');
                     
                     
                      var html  ='<img id="current-like" name="delete" src="<c:url value="/images/feed/feedw/like.png"/>"  onclick="clickLike(this.name)">';
                      
                     $('#likeButton').html(html);
                     
                     // 비동기 통신으로 좋아요 개수 +1 시키기
                     var currentLikeCount = parseInt($('#totaLikeCount').text());
                     
                     var newLikeCount = currentLikeCount+1;
                     
                     $('#totaLikeCount').text(newLikeCount);
                     
                     
                     // 피드로 돌아가면 좋아요 정렬 다시 업데이트 하기
                     
                  }/*if 끝  */
                  
               }/* success 끝 */
               
            });/* ajax 끝*/
         }else{
            // click == 'delete'
            // 내 idx 파라미터로 추가
            $.ajax({
               url: bootUrl+'/feed/likeButtonClick',
               type:'POST',
               data:{
                  likeChange:'-1',
                  boardIdx:'${selectFeedView.boardIdx}',
                  myIdx:'${sessionScope.memberVo.memberIdx}'
               },
               success:function(data){
                  //좋아요 취소하기 성공
                  if(data == 1){
                     
                     console.log('좋아요 취소하기 성공');
                     
                         var html  ='<img id="current-dislike" name="insert" src="<c:url value="/images/feed/feedw/nolike.png"/>" onclick="clickLike(this.name)">';
                     
                     $('#likeButton').html(html);
                     
                     // 비동기 통신으로 좋아요 개수 -1시키기
                     // 피드로 돌아가면 좋아요 정렬 다시 업데이트 하기 or 닫기 버튼 누르면 그전 페이지로 요청 주기 /feed/userFeed/{memberIdx}
                     var currentLikeCount = parseInt($('#totaLikeCount').text());
                     
                     var newLikeCount = currentLikeCount-1;
                     
                     $('#totaLikeCount').text(newLikeCount);
                     
                     
                  }/*if 끝  */
                  
               }/* success 끝 */
            });/* ajax 끝 */
         }
      };
   
   </script>




   <!--  카카오톡으로 공유하기   ㅡ0914추가-->
   <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
   <script type="text/javascript">
     function sendLink(memberIdx,boardIdx,totalLikeCount) {
        /* hashtag도 파라미터로 받기 */
        
      Kakao.init("daeecdc3ce37abac4a9a3f8ad3e05b0a");
      
       Kakao.Link.sendDefault({
         objectType: 'feed',
         content: {
           title: '오를래 사진을 공유합니다.',
           description: '오를래',
           imageUrl:'https://ifh.cc/g/Mtgj7e.jpg',
           link: {
             mobileWebUrl:'http://54.180.143.122:8080/orl/feed/feedview/'+memberIdx+'&'+boardIdx,
             webUrl: 'http://54.180.143.122:8080/orl/feed/feedview/'+memberIdx+'&'+boardIdx,
           },
         },
         social: {
           likeCount:totalLikeCount,
           /* commentCount: 45,
           sharedCount: 845, */
         },
         buttons: [
           {
             title: '웹으로 보기',
             link: {
               mobileWebUrl: 'http://54.180.143.122:8080/orl/feed/feedview/'+memberIdx+'&'+boardIdx,
               webUrl: 'http://54.180.143.122:8080/orl/feed/feedview/'+memberIdx+'&'+boardIdx,
             },
           }
         ],
       })
     }
   </script>


	


</body>
</html>