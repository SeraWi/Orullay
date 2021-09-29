<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
/*부트서버*/
const url = 'http://52.79.178.223:8081';
/*뷰 서버*/	
const url2 = '${pageContext.request.contextPath}';
/*s3 경로*/
const crewFileUrl = 'https://minju-aws-bucket.s3.ap-northeast-2.amazonaws.com//fileupload/crew';

const adminIdx = '${sessionScope.memberVo.memberIdx}';

$(document).ready(function () {
	
	if(adminIdx != 92){
		alert('해당 페이지에 접근할 권한이 없습니다.');
		window.location.href = url2 + '/';
	}
	
    $.ajax({
    	url: url + '/admin/crew/getAllInfo',
        type: 'get',
        success: function (data) {
        	let html = '';
        	$.each(data.crewList, function(index, item){
				html += '<tr>';
				html += '<td>'+item.crewIdx+'</td>';
				html += '<td>'+item.crewName+'</td>';
				html += '<td><img src="'+crewFileUrl+item.crewPhoto+'"';
				html += 'style="width: 100px; height: 100px"></td>';
				html += '<td style="max-width: 350px; overflow: auto">'+item.crewDiscription+'</td>';
				html += '<td style="max-width: 100px">'+item.crewCreatedate+'</td>';
				html += '<td style="max-width: 200px">'+item.crewTag+'</td>';
				html += '<td><p class="text-center">'+item.memberNickName+'</p></td>';
				html += '<td style="width: 50px">';
				html += '<a id="deleteId" href="#"';
				html += 'onclick="javascript:isDelete('+item.crewIdx+')">삭제</a></td>';
				html += '<td>';
				
				// Trigger the modal with a button
				html += '<button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal'+item.crewIdx+'"';
				html += 'style="width: 110px; height: 40px; font-size: 15px; font-weight: bold; background-color: cadetblue;">';
				html += '크루원 목록</button>';
				
				// Modal
				html += '<div id="myModal'+item.crewIdx+'" class="modal fade" role="dialog">';
				html += '<div class="modal-dialog">';
				// Modal content
				html += '<div class="modal-content">';
				html += '<div class="modal-header">';
				html += '<button type="button" class="close" data-dismiss="modal">&times;</button>';
				html += '<h4 class="modal-title">크루원 보기</h4>';
				html += '</div>';
				html += '<div class="modal-body selectList">';
	
				$.each(data.crewRegList, function(index, item2){
	        		if(item.crewIdx == item2.crewIdx) {
	        			html += '<div class="item">';
						html += '<img alt="" class="img" src="'+url2+'/images/member/profile/'+item2.memberProfile+'"';
						html += 'width="80px" height="80px" style="border-radius: 50%">';
						html += '<span># '+item2.memberNickName+'</span>';
						html += '</div>';
	        		}
	        	});
				
				html += '</div>';
				html += '<div class="modal-footer">';
				html += '<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>';
				html += '</div></div></div></div></td></tr>';
        	});
			$('#myTable').html(html);				
        }//success end
				
   	}); //ajax end
    
   		
    $("#myInput").on("keyup", function() {
	    var value = $(this).val().toLowerCase();
	    $("#myTable tr").filter(function() {
	      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
	    });
	});
    
}); //document ready end
function isDelete(crewIdx){
	if(confirm("삭제하시겠습니까?")) {
		 $.ajax({
			url: url+'/admin/crew/deleteCrew',
		 	data: {crewIdx : crewIdx},
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
<body>
	<%@ include file="/WEB-INF/frame/admin/header.jsp"%>

	<div class="container">
		<h2>크루 관리</h2>
		<p>크루를 검색해보세요 !</p>
		<input class="form-control" id="myInput" type="text"
			placeholder="Search.."> <br>
		<table class="table table-bordered table-striped table-hover">
			<thead>
				<tr>
					<th>IDX</th>
					<th>이름</th>
					<th>사진</th>
					<th>설명</th>
					<th>생성일</th>
					<th>해시태그</th>
					<th>크루장</th>
					<th>관리</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody id="myTable">
			</tbody>
		</table>
	</div>
</body>
</html>