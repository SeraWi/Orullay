<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>USER FEED</title>
    <!-- 스와이퍼 css -->
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.css" />

    <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">

    <!-- 제이쿼리 -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>


    <!-- 제이쿼리 다음에 스와이퍼, 스와이퍼js min버전 -->
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

    <!-- bootstrap js -->
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj" crossorigin="anonymous"></script>
   
   <link rel="stylesheet" href="<c:url value='/css/default/default.css'/>">
   <link rel="stylesheet" href="<c:url value='/css/feed/userFeed.css'/>">
   <link rel="stylesheet" href="<c:url value='/css/feed/follow.css'/>">
   <link rel="stylesheet" href="<c:url value='/css/feed/feedMain.css'/>">
   
   <style>
      .display_none{
         display:none;
      }
   </style>
   

</head>
<body>
   <!-- 헤더영역 -->
   <%@ include file="/WEB-INF/frame/default/header.jsp"%>
   
   
   <!-- modal_createfeed 우리언니 0908 추가  -->
   <div class="modal_createfeed">
      <div class="modal_content_create">
         <section class="container_create">
            <%@ include file="/WEB-INF/views/feed/createfeed.jsp"%>
         </section>
      </div>
   </div>


    <!-- 메인 피드 영역  시작-->
    <div class="container1">

        <!-- 프로필 영역 -->
        <section class="bio">
            <!-- 사진 영역 -->
            <a href="<c:url value="/feed/userfeed/${member.memberIdx}"/>">
               <div class="profile-photo">
                   <img src="<c:url value="/images/member/profile/${member.memberProfile}"/>" alt="profile-photo">
               </div>
            </a>

            <!-- 사용자 정보 영역: username, follow-infos, user-post,buttons -->
            <div class="profile-info">

                <!-- 사용자 id -->
                <div class="username">
                    <a href="<c:url value="/feed/userfeed/${member.memberIdx}"/>">${member.memberNickname}</a>
                </div>


                <ul class="follow-infos">
                    <li>게시물 ${feedCount}</li>
                    
                    <li class="follows" id="follower">
                       <a>팔로워 <span id="followerCount"> ${followerCount}</span></a>
                    </li>
                    
                    <li class="follows" id="following">
                       <a>팔로잉 <span id="followingCount">${followingCount}</span></a>
                    </li>
                </ul>

                <!-- 버튼 영역 팔로우하기, 팔로우 끊기, 내정보 수정하기, 피드 올리기  -->
                <div class="buttons" >
                   <c:choose>
                      <c:when test="${sessionScope.memberVo.memberIdx ne member.memberIdx}">
                         <div id="follow-button-div">
                            <input type="button" id="follow-button" class="${followRelation==0? 'buttons-area-yellow':'buttons-area-gray'}" value="${followRelation==0? '팔로우 시작하기': '팔로우 그만하기'}">
                         </div>
                      </c:when>

                  <c:otherwise>
                          <div><a class="buttons-area-yellow" href="<c:url value="/member/mypage"/>">내 정보 수정</a></div>
                          <div><a class="buttons-area-yellow modalbtn_createfeed">피드 올리기</a></div>               
                  </c:otherwise>
                   </c:choose>
               </div>
            </div>


        </section>
        <!--프로필 영역 끝  -->
        
        <!-- 팔로우 시작하기, 팔로우 그만하기 버튼 js -->
        <script>
           // 비동기 통신으로 팔로우 시작하기, 팔로우 그만하기 버튼을 눌렀을 때 팔로우 그민하기와 팔로우 시작하기 버튼으로 바꿔주기
           
           $('#follow-button-div').click(function(){
              //클릭하면 비동기 통신 시작
              
              var followStatus = $('#follow-button').val(); // 팔로우 시작하기 혹은 그만하기 인지 확인
              console.log(followStatus);
              
      
              if(followStatus == '팔로우 그만하기'){
                 //팔로우 그만하기
                 //followStatus = -1
                 
                 // data 파라미터 추가 0918 수정
                 $.ajax({
                     url:'<c:url value="/feed/followButtonClick"/>',
                     //url:'http://localhost:8083/feed/followButtonClick',
                     type:'POST',
                     data:{
                        followStatus : '-1',
                        yourIdx : '${member.memberIdx}',
                        myIdx:'${sessionScope.memberVo.memberIdx}'
                     },
                     success: function(data){
                        //data == 1 또는 0
                        if(data==1){
                           // 결과 데이터 1 : 리턴값 1 == 팔로우 그만하기 성공
                           // 1) 팔로우 그만하기 성공 ->글자 시작하기로 바꾸기
                            $('#follow-button').val('팔로우 시작하기');
                           
                           // 2) 배경색 노란색으로 바꿔주기 
                            $('#follow-button').css('background','#fdef7b');
                           
                           // 3) 팔로워 수 갱신 시키기 -> 남 피드 팔로워 수 -1시키기
                           
                           //int로 변환해줘야 더하면 값이 int
                           var followerCount = parseInt($('#followerCount').text());
                            var newFollowerCount = followerCount -1;
                            
                            // 캐스팅하고 값을 바꿔주기ㄴ
                            $('#followerCount').text(newFollowerCount);
                            console.log(newFollowerCount);
                           
                           
                        }else{
                           //팔로우 그만하기 실패
                        }
                     }
                     
                  });  
                 
                 
              }else{
                 //팔로우 시작하기: followStatus ==1
                 
                 $.ajax({
                     url:'<c:url value="/feed/followButtonClick"/>',
                     //url:'http://localhost:8083/feed/followButtonClick',
                     type:'POST',
                     data:{
                        followStatus :'1',
                        yourIdx : '${member.memberIdx}',
                        myIdx:'${sessionScope.memberVo.memberIdx}'
                     },
                     success:function(data){
                        if(data ==1){
                           // 결과 데이터 1 : 리턴값 1 == 팔로우 시작하기 성공
                           
                           // 1) 팔로우 시작하기 성공 -> 글자 그만하기로 바꾸기
                           $('#follow-button').val('팔로우 그만하기');
                           
                           // 2) 배경색 회색으로 바꾸기
                           $('#follow-button').css('background','#f8f8f8');
                           
                           // 3) 팔로워 수 갱신 시키기 ->남 피드 팔로워 수 +1시키기
                           
                           // int로 바꾸기 (text로 받으면 type이 String->String +1 =String)
                           var followerCount = parseInt($('#followerCount').text());
                           var newFollowerCount = followerCount +1;
                           
                           $('#followerCount').text(newFollowerCount);
                           console.log(newFollowerCount);
                           
                        }
                     }
                    
                 });
              }
              
           });
           
           
        </script>
   <!-- 팔로우 시작하기, 팔로우 그만하기 버튼 js 끝-->
        

      <!-- 내크루 가기 영역  swiper 사용 -->
        <div class="swiper mySwiper">
            <div class="swiper-wrapper">
             
                <!--  내가 가입한 크루 리스트-->
                 <c:forEach var ="myCrewList" items="${myCrewList}">
                     <div class="swiper-slide">
                        <a href="<c:url value="/crew/detail?crewIdx=${myCrewList.crewIdx}"/>" class="crew">
                          <img src="<c:url value="/images/crew/${myCrewList.crewPhoto}"/>">
                          <div>${myCrewList.crewName}</div>
                       </a>
                    </div>
                 </c:forEach>
                 <!--  내가 가입한 크루 리스트 끝-->
              
              <!-- 크루 더 보기 -->
              <div class="swiper-slide">
                <a href="<c:url value="/crew/list"/>" class="crew">
                    <img src="<c:url value="/images/feed/feeds/more.png"/>" alt="">
                    <div>MORE</div>
                </a>
              </div> 
              <!-- 크루 더 보기 끝 -->   

            </div>
            <!-- swiper-wrapper 끝 -->
            
            
            <!-- 옆으로 가기 버튼 영역 시작  -->
            <div class="swiper-button-next"></div>
            <div class="swiper-button-prev"></div>
            <div class="swiper-pagination"></div>
            <!-- 버튼 영역 끝 -->
           
          </div> 
          <!-- 크루 가기 영역(swiper mySwiper) 끝 -->
      
      
          <!-- 크루가기Swiper JS -->
          <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
      
          <!-- Initialize Swiper -->
          <script>
            var swiper = new Swiper(".mySwiper", {
              slidesPerView: 6,
              spaceBetween: -40,
              slidesPerGroup: 6,
              loop: true,
              loopFillGroupWithBlank: true,
              pagination: {
                el: ".swiper-pagination",
                clickable: true
              },
              navigation: {
                nextEl: ".swiper-button-next",
                prevEl: ".swiper-button-prev"
              }
            });
          </script>
         <!--크루 영역 JS 끝 --> 
          

        <!-- 갤러리 네비게이션 영역 : 피드보기랑 좋아요 보기 -->
        <div class="gallery-nav">
           <!-- 기본정렬 -->
            <div class="feed-icon" id="default-sort-Click"><input type="image" src="<c:url value="/images/feed/feeds/feedicon.png"/>"></div>
           <!-- 좋아요 정렬 -->
           <div class="heart-icon" id="like-sort-Click" ><input type="image" src="<c:url value="/images/feed/feeds/redheart.png"/>"></div>
        </div>
        <!--갤러리 네비게이션 영역 끝 -->

        <!-- 갤러리영역 : 기본정렬 -->
        <section class="gallery" id="default-sort-gallery">
             <c:forEach var ="feedGallery" items="${feedGallery}">
                 <a class="item">
                     <img onclick="location.href='${pageContext.request.contextPath}/feed/feedview/${member.memberIdx}&${feedGallery.boardIdx}'" src="<c:url value="/images/feed/feedw/uploadfile/${feedGallery.boardPhoto}"/>" alt="기본">
                 </a>
              </c:forEach>
          </section> 
      
        <!-- 갤러리 영역: 좋아요 영역 display_none으로 안보이는 상태-->
        <section class="gallery display_none" id="like-sort-gallery">
             <c:forEach var="feedLikeGallery" items="${feedLikeGallery}">
              <a class="item" >
                 <img onclick="location.href='${pageContext.request.contextPath}/feed/feedview/${feedLikeGallery.memberIdx}&${feedLikeGallery.boardIdx}'"  src="<c:url value="/images/feed/feedw/uploadfile/${feedLikeGallery.boardPhoto}"/>"alt="좋아요"> 
              </a>
             </c:forEach>
        </section>
        
        <!-- 갤러리 정렬  JS 시작-->
       <script>
        
         // 좋아요 아이콘 클릭하면 좋아요 정렬로 보여주기
          $('#like-sort-Click').click(function(){
                // 좋아요 정렬 : display_none 없애기
                // 기본 정렬: display_none 설정
                $('#default-sort-gallery').addClass('display_none');
                $('#like-sort-gallery').removeClass('display_none');
             });
           
           
        // 다시 기본 정렬 클릭하면 기본정렬로 보여주기
           $('#default-sort-Click').click(function(){
              // 좋아요 정렬 :display_none 설정
              // 기본 정렬 : 보이도록 설정
              $('#like-sort-gallery').addClass('display_none');
              $('#default-sort-gallery').removeClass('display_none');
           }); 
        
        </script>
        <!-- 갤러리 정렬  JS 끝-->

    </div>
<!-- 메인 피드 영역  끝-->


<!-- footer영역 -->
<%@ include file="/WEB-INF/frame/default/footer.jsp"%>
<!-- footer 영역 끝 -->

<!-- 비동기 통신으로 보여지는 영역 시작 -->

   <!--팔로워 리스트 영역 -->
    <div class="container-follow display_none" id="container-follower">

        <div class="title">
            <div>팔로워</div>
            <button><img src="<c:url value="/images/feed/feeds/formdelete.png"/>" class="form-close"></button>
        </div>

        <div class="follower-members" id="follower-members">
            <div class="member">
             <!-- 비동기 통신으로 추가되는 영역 --> 
                <img src="<c:url value="/images/feed/feeds/defaultPhoto.jpg"/>">
                <a href="#">사용자아이디</a>
                <input type="submit" value="팔로우하기">
                
            </div>
        </div>
    </div>
    <!-- 팔로워 리스트 영역 끝  -->
   
   <!-- 팔로워 리스트 비동기통신 영역 시작-->
   <script>
   
   // 1) 팔로워 글자 클릭하면 팔로워 리스트 보여주기
   $('#follower').click(function(){
	  
	  followerList();
   });
   
   // 2) 닫기 버튼 눌렀을 때 다시 팔로워 숨기기
   $('.form-close').click(function(){
      $('#container-follower').addClass('display_none');
      
   });
   
   
   // 3) 팔로워 리스트 함수
   function followerList(){
	 	  //팔로워 보여주기
	      $('#container-follower').removeClass('display_none');
	      
	      //팔로워 명단 초기화 시키기
	      $('#follower-members').html('');
	      
	      
	      //비동기 통신
	      $.ajax({
	         url:'<c:url value="/feed/followerList"/>',
	         type:'GET',
	         data:{
	            yourIdx:'${member.memberIdx}',
	            myIdx:'${sessionScope.memberVo.memberIdx}'
	         },
	         success: function(data){
	          $.each(data,function(index,item){
	        	   // 가져오는 정보
	        	   // memberIdx(팔로워들의 idx), memberNickname, memberProfile, followStatus(내가 팔로우 하는지, 하지 않으면 null)
	        	  
	        	   //나의 Idx(세션에 저장된 정보)
	        	   var myIdx = '${sessionScope.memberVo.memberIdx}';
	        	   //console.log(index,item);
	        	  
	               
	               var html ='<div class="member">';
	               html += '   <a href="<c:url value="/feed/userfeed/'+item.memberIdx+'"/>">';
	               html += '      <img src="<c:url value="/images/member/profile/'+item.memberProfile+'"/>"/>';
	               html += '   </a>';
	               html += '   <a class="nickname-area" href="<c:url value="/feed/userfeed/'+item.memberIdx+'"/>">'+item.memberNickname+'</a>';
	               //html += '   <input type="hidden" value="'+item.yourFollowerIdx+'">';
	               
	               
	               // 1)item.yourFollowerIdx 가 나의 Idx 일 경우 -> 버튼 안보여주기
	               // 2)item.followStatus가 null, 팔로우 안하는 상태->팔로우 시작하기 버튼
	               // 3)item.followStatus가 not null, 팔로우 하는 상태->팔로우 그만하기 버튼
	               // 팔로우 시작하기 혹은 그만하기 누르면 : yourFollowerIdx와 myIdx, 현재 팔로우 상태를 파라미터로 
	               
	               
	               // 1)item.memberIdx 가 나의 Idx 일 경우 -> 버튼 안보여주기
	               // 2)item.memberIdx2가 null, 팔로우 안하는 상태->팔로우 시작하기 버튼
	               // 3)item.memberIdx2가 not null, 팔로우 하는 상태->팔로우 그만하기 버튼
	               // 팔로우 시작하기 혹은 그만하기 누르면 : memberIdx와 myIdx, 현재 팔로우 상태(memberIdx2)를 파라미터로 
	               
	               if(myIdx == item.memberIdx){
	                 html +='';
	               }else if(item.followStatus == null){
	            	 html += '   <input type="button" class="button-yellow-inList" value="follow" name ="insert" onclick="followBtnClick('+item.memberIdx+',${sessionScope.memberVo.memberIdx},'+item.followStatus+',0)">'; 
	               }else if(item.followStatus != null){
	            	 html += '   <input type="button" class="button-gray-inList" value="unfollow" name ="delete" onclick="followBtnClick(+'+item.memberIdx+',${sessionScope.memberVo.memberIdx},'+item.followStatus+',0)">';     
	               }
	               html += '</div>';
	               
	               //div 추가해주기
	               $('#follower-members').append(html);
	            });  
	         }
	      });
   };
   
   // 팔로우 리스트 함수 끝
   </script>
   
   <script>
   
   // 리스트 안쪽 팔로우 시작하기 그만하기 버튼 처리 함수 (팔로워, 팔로잉 둘다 가능)
   function followBtnClick(yourIdx,myIdx,followStatus,current){
	   var yourIdx = yourIdx;// 팔로우 버튼 누른 사용자의 idx
	   var myIdx = myIdx; //나의 idx
	   var followStatus =followStatus; //현재 팔로우 하는 지 상태(내기준)
	   // current == 0: 팔로워 리스트 current == 1 팔로잉 리스트
	   var current = current;
	   
	   //팔로우 시작하기 (현재 상태== 팔로우 안하는 중 == null)
	   if(followStatus == null){
		   console.log('insert');
		   //비동기 통신 시작
		   $.ajax({
			   url:'<c:url value="/feed/followButtonClick"/>',
			   type:'POST',
			   data:{
				   followStatus:'1',
				   yourIdx:yourIdx,
				   myIdx:myIdx
			   },
			   success: function(data){
				   if(data==1){
					   
					   console.log('inser성공');
					   
					   //팔로워 리스트 갱신 혹은 팔로잉 리스트 갱신
					   if(current == 0){
						   followerList();
					   } else{
						   followingList();
					   }
					   
					   //팔로잉 수 +1(내 피드 일 때만 팔로잉 수 변동)
					   if(${member.memberIdx eq sessionScope.memberVo.memberIdx}){
			               var followingCount = parseInt($('#followingCount').text());
			               var newFollowingCount = followingCount +1;
			               $('#followingCount').text(newFollowingCount);  
					   }

					   
				   }/* success 안 if끝 */
			   }/* success 끝 */
			   
			   
		   });/*ajax끝 */
		   
		   
	   }else{
		   //팔로우 그만하기
		   console.log('delete');
		   //비동기 통신 시작
		   $.ajax({
			   url:'<c:url value="/feed/followButtonClick"/>',
			   type:'POST',
			   data:{
				   followStatus:'-1',
				   yourIdx:yourIdx,
				   myIdx:myIdx
			   }, 
			   success: function(data){
				   if(data==1){
					   
					   console.log('delete성공');
					   
					   //팔로워 리스트 혹은 팔로잉 리스트 갱신
					   if(current == 0){
						   followerList();
					   } else{
						   followingList();
					   }
					   
					   //팔로잉 수 -1 (내 피드일 때만 팔로잉 수 변동)
					   if(${member.memberIdx eq sessionScope.memberVo.memberIdx}){
			               var followingCount = parseInt($('#followingCount').text());
			               var newFollowingCount = followingCount -1;
			               $('#followingCount').text(newFollowingCount);  
					   }
					   
				   }/* success 안 if끝 */
			   }/* success 끝 */
			   
		   });/* ajax끝 */
		   
	   }
   };//함수 끝
   
   
   
   </script>
   <!--팔로워 리스트  영역 js 끝  -->
   
   <!--팔로잉  리스트 영역  -->
   <div class="container-follow display_none" id="container-following">

        <div class="title">
            <div>팔로잉</div>
            <button><img src="<c:url value="/images/feed/feeds/formdelete.png"/>" class="form-close"></button>
        </div>

        <div class="follower-members" id="following-members">
         <!-- 비동기 통신으로 추가되는 영역 -->            
        </div>
    </div>
    <!--팔로잉  리스트 영역  끝-->
    
    <!-- 팔로잉 리스트 영역 비동기 통신 영역 시작 -->
   <!-- 내피드에서 팔로잉 리스트에서 버튼, 남피드 팔로잉 리스트에서는 버튼 안보이게  -->
   <script>
	
   
   // 1) 팔로잉 글자 클릭 -> 리스트 가져오기
   $('#following').click(function(){
	   	// 팔로잉 리스트 창 보이도록
         $('#container-following').removeClass('display_none');
	   	
	   	// 비동기 통신으로 리스트 가져오기
         followingList();
            
      });/*click 이벤트 끝  */
      
      
   // 2) following list 가져오기 비동기 통신
   function followingList(){
	// 명단 초기화 
       $('#following-members').html('');
       
       // 팔로잉 버튼 눌렀을 때 명단 가져오기 ->비동기 통신으로
       // 파라미터 : 나의 idx, 피드 주인 idx
       $.ajax({
          url:'<c:url value="/feed/followingList"/>',
          //url:'http://localhost:8083/feed/followingList',
          type:'GET',
          data:{
             yourIdx:'${member.memberIdx}',
             myIdx:'${sessionScope.memberVo.memberIdx}'
          },
          success: function(data){
             //console.log(data); 
             
           $.each(data,function(index,item){
                //console.log(index,item);
                
                //나의 Idx(세션에 저장된 정보)
	        	var myIdx = '${sessionScope.memberVo.memberIdx}';
                
                //가져오는 데이터 
                //memberIdx2(팔로워 idx), memberNickname2(팔로워닉네임), memberProfile2(팔로워사진),followStatus(내기준 팔로우버튼상태)
                
                var html ='<div class="member">';
                html += '   <a href="<c:url value="/feed/userfeed/'+item.memberIdx2+'"/>">';
                html += '      <img src="<c:url value="/images/member/profile/'+item.memberProfile2+'"/>"/>';
                html += '   </a>';
                html += '   <a class="nickname-area" href="<c:url value="/feed/userfeed/'+item.memberIdx2+'"/>">'+item.memberNickname2+'</a>';
                
                //1)memberIdx2 = 나의 Idx랑 같다면 버튼 안보여주기
                //2)followStatus ==null 팔로우 안한 상태 ->팔로우 시작하기
                //3)followStatus !=null 팔로우 한 상태 ->팔로우 그만하기
                if(item.memberIdx2 == myIdx){
               	 html +='';
                }else if(item.followStatus ==null){
               	 html += '   <input type="button" class="button-yellow-inList" value="follow" name ="insert" onclick="followBtnClick('+item.memberIdx2+',${sessionScope.memberVo.memberIdx},'+item.followStatus+',1)">'; 
                }else if(item.followStatus !=null){
               	 html += '   <input type="button" class="button-gray-inList" value="unfollow" name ="delete" onclick="followBtnClick(+'+item.memberIdx2+',${sessionScope.memberVo.memberIdx},'+item.followStatus+',1)">';
                }
                
                html += '</div>';
                
                //div에 추가하기
                $('#following-members').append(html);
             });  
          }/* success 끝 */
       });/* ajax 끝 */
   } // 함수 끝
  
   
   // 3) 닫기 버튼 눌렀을 때 
   $('.form-close').click(function(){
	  // 모달창 보이지 않도록 처리
      $('#container-following').addClass('display_none');
      
   });/* 닫기끝 */
   
   </script>

</body>
</html>