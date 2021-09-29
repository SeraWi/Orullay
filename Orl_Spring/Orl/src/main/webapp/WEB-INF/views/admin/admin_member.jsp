<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>회원관리</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="<c:url value='/css/default/default.css'/>">
  <link rel="stylesheet" href="<c:url value='/css/admin/member.css'/>">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script src="https://kit.fontawesome.com/cccee664d4.js" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>
<script>
	/*부트서버*/
	const url = 'http://13.125.199.218:8087';
	/*뷰 서버*/	
	const url2 = '${pageContext.request.contextPath}';

	const adminIdx = '${sessionScope.memberVo.memberIdx}';

	$(document).ready(function () {
		
		if(adminIdx != 92){
			alert('해당 페이지에 접근할 권한이 없습니다.');
			window.location.href = url2 + '/';
		}
		
		$.ajax({
			url:url+'/admin/member/getAllInfo',
			type:'get',
			success:function(data){
				let html = '';
				$.each(data.list, function(index,item){
					
					html +=  '<tr>'
					html +=  '<td>'+item.memberIdx+'</td>'
					html +=   ' <td style="max-width:150px;overflow:auto">'+item.memberId+'</td>'
					html +=  '  <td><img src="'+url2+'/images/member/profile/'+item.memberProfile+'" style="width:80px; height:80px;border-radius: 50%;"></td>'
					html +=   ' <td>'+item.memberName+'</td>'
					html +=    '<td>'+item.memberEmail+'</td>'
					html +=   ' <td>'+item.memberNickname+'</td>'
					html +=   ' <td>'+item.memberRegdate+'</td>'
					html +=    '<td>'+item.memberBirth+'</td>'
					html +=    '<td>'
					html +=     '   <a id = "deleteId" onclick="javascript:isDelete('+item.memberIdx+')" >삭제</a>'
					html +=    '</td>'
					html +=    '<td>'
				        	
				//<!-- Trigger the modal with a button -->
				html +='<button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal'+item.memberIdx+'" style="width:100px; height:40px; font-size:15px; font-weight:bold; background-color:cadetblue;">피드보기</button>'

				//<!-- Modal -->
				html +='<div id="myModal'+item.memberIdx+'" class="modal fade" role="dialog">'
				html +='<div class="modal-dialog">'

				   // <!-- Modal content-->
				    html +=    '<div class="modal-content">'
				    html +=  '<div class="modal-header">'
				    html +=    '<button type="button" class="close" data-dismiss="modal">&times;</button>'
				    html +=    '<h4 class="modal-title">피드 보기</h4>'
				    html += ' </div>'
				    html +=  '<div class="modal-body selectList">'
				    
				    $.each(data.feedList,function(index, item2){
				    	if(item.memberIdx == item2.memberIdx){
				    		html += '<div class="item">'
						    html +=    '<img alt="" class="img" src="'+url2+'/images/feed/feedw/uploadfile/'+item2.boardPhoto+'"  width="80px" height="80px">'
						    html +=    '<span># '+item2.boardIdx+'</span>'
						    html +=    '</div>'
				    	}
				    })
				    html +=  '</div>'
				    html += ' <div class="modal-footer">'
				    html +=  '  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>'
				    html +=  '</div></div></div></div></td></tr>'
				})
				$('#myTable').html(html);	
			}
		})
	})
	
	
</script>

<body>
<%@ include file="/WEB-INF/frame/admin/header.jsp" %>


<div class="container">
  <h2>회원관리</h2>
  <p>검색창 안에 회원을 검색해보세요! </p>  
  <input class="form-control" id="myInput" type="text" placeholder="Search..">
  <br>
  <table class="table table-bordered table-striped table-hover">
    <thead>
      <tr>
        <th>IDX</th>
        <th>아이디</th>
        <th>프로필사진</th>
        <th>이름</th>
        <th>Email</th>
        <th>닉네임</th>
        <th>가입일</th>
        <th>생일</th>
        <th>관리</th>
        <th>피드</th>
      </tr>
    </thead>
    <tbody id="myTable">
   
    </tbody>
  </table>

</div>





<script>
$(document).ready(function(){
  $("#myInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });
});
function isDelete(memberIdx){
	if(confirm("삭제하시겠습니까?")) {
		$.ajax({
			url: url+'/admin/member/deleteMember',
		 	data: {memberIdx : memberIdx},
		 	type: 'get',
	        success: function (data) {
	        	if(data!=0){
	        		alert('삭제했습니다.');
	        		history.go(0);
	        	} else {
	        		alert('삭제에 실패했습니다.');
	        	}
	        }
		 });
		
	} else{
		return false;
	}
}
</script>

</body>
</html>
