<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>검색결과보기</title>
    <link rel="stylesheet" href="<c:url value='/css/mountain/search.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/default/default.css'/>">
  <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script></head>


</head>


<body>
<%@ include file="/WEB-INF/frame/default/header.jsp" %>

<div id="container">
    <div id="contents">
        <div class="titleArea">
            <h2>SEARCH</h2>
        </div>
        <form id="frm" method="post">
            <div class="boxContainer">
                <table class="elementsContainer">
                    <tr>
                        <td>
                            <input type="text" autocomplete="off" placeholder="검색하실 내용을 입력해주세요. " class="search" name="mysearch" required>
                        </td>
                        <td>
                            <label for="button">
                                <i id="submit" class="fas fa-search"></i>
                            </label>
                            <input type="submit" id="button" style="display:none">
                        </td>
                    </tr>
                </table>

            </div>
        </form>

        <c:if test="${not empty mountainListByName}">
            <h3 class="selectArea">해당 산의 검색결과</h3>
        </c:if>
        <form id="formLoc" action="${pageContext.request.contextPath}/mountain/mountainDetailInfo" method="POST">
            <div id="selectList">
                <c:forEach items="${mountainListByName}" var="list">
                    <div class="item">
                        <img onclick="setParamLoc(this.title)" class="img"
                             src="https://www.forest.go.kr/images/data/down/mountain/${list.img}" alt=""
                             title="${list.mountainName}"
                             width="200px" height="200px">
                        <span>#${list.mountainName}</span>
                    </div>
                </c:forEach>
            </div>

            <c:if test="${not empty mountainListByLoc}">
                <h3 class="selectArea">해당 지역의 검색결과</h3>
            </c:if>
            <div id="selectList">
                <c:forEach items="${mountainListByLoc}" var="list">
                    <div class="item">
                        <img onclick="setParamLoc(this.title)" class="img"
                             src="https://www.forest.go.kr/images/data/down/mountain/${list.img}" alt=""
                             title="${list.mountainName}"
                             width="200px" height="200px">
                        <span>#${list.mountainName}</span>
                    </div>
                </c:forEach>
            </div>
            <input name="mountainName" id="mountainName" type="hidden" value="">
        </form>

        <script>
            function setParamLoc(loc) {
                $("#mountainName").val(loc);
                $("#formLoc").submit();
            }
        </script>

    </div>
</div>
<!--  </div>
-->


<%@ include file="/WEB-INF/frame/default/footer.jsp" %>


</body>
</html>