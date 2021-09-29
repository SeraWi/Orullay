<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>크루 관리</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="<c:url value='/css/default/default.css'/>">
  <link rel="stylesheet" href="<c:url value='/css/admin/crew.css'/>">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script src="https://kit.fontawesome.com/cccee664d4.js" crossorigin="anonymous"></script>
</head>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
/*부트서버*/
const url = 'http://3.36.48.110:8083';
/*뷰 서버*/	
const url2 = '${pageContext.request.contextPath}';

const adminIdx = '${sessionScope.memberVo.memberIdx}';


$(document).ready(function () {
	
	if(adminIdx != 92){
		alert('해당 페이지에 접근할 권한이 없습니다.');
		window.location.href = url2 + '/';
	}
		$.ajax({
			url:url+'/admin/feed/getAllInfo',
			type:'get',
			success:function(data){
				let html= '';
				$.each(data, function(index,item){
					html+=	   '<tr>'
					html+= '<td>'+item.boardIdx+'</td>'
					html+='<td><img src="'+url2+'/images/feed/feedw/uploadfile/'+item.boardPhoto+'" width="100px" height="100px" ></td>'
					html+='<td style="max-width:100px">'+item.memberNickname+'</td>'
					html+='<td><img src="'+url2+'/images/member/profile/'+item.memberProfile+'" style="width:80px; height:80px;border-radius: 50%;"></td>'
					html+='<td style="max-width:400px">'+item.boardDiscription+'</td>'
					html+='<td style="max-width:300px">'+item.hashtag+'</td>'
					html+='<td>'
					html+=    ' <a id = "deleteId" onclick="javascript:isDelete('+item.boardIdx+')" >삭제</a>'
					html+='</td>'
					html+='</tr>'
				})
				
				$('#myTable').html(html);	
			}
		})
	})
	
	
</script>
<body>
<%@ include file="/WEB-INF/frame/admin/header.jsp" %>


<div class="container">
  <h2>피드 관리</h2>
  <p> 찾을 내용을 입력해주세요!</p>  
  <input class="form-control" id="myInput" type="text" placeholder="Search..">
  <br>
  <table class="table table-bordered table-striped table-hover">
    <thead>
      <tr>
        <th>IDX</th>
        <th>사진</th>
        <th>멤버닉네임</th>
        <th>멤버프로필</th>
        <th>설명</th>
        <th>해시태그</th>
        <th>관리</th>
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
function isDelete(boardIdx){
	if(confirm("삭제하시겠습니까?")) {
		 $.ajax({
				url: url+'/admin/crew/deleteFeed',
			 	data: {boardIdx : boardIdx},
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
