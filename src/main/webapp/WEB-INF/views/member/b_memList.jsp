<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>회원 목록</title>
    <%@ include file="../main/b_import.jspf"%>
    <link rel="stylesheet" href="/static/css/item/b_itemManager.css">
</head>
<body>
<%@ include file="../main/b_header.jspf"%>
<div id="container" class="d-flex flex-column align-items-center mx-auto">
    <table id="b_memList" class="table table-striped text-center mt-4">
        <thead>
        <tr>
            <th>아이디</th>
            <th>이름</th>
            <th>생일</th>
            <th>성별</th>
            <th>휴대폰번호</th>
            <th>회원등급</th>
            <th>포인트</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="mem" items="${list}">
            <tr>
                <td>${mem.id }</td>
                <td>${mem.name }</td>
                <td>${mem.birth }</td>
                <td>${mem.gender }</td>
                <td>${mem.phone }</td>
                <td>${mem.grade }</td>
                <td>${mem.point }</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<%@ include file="../main/b_footer.jspf"%>
</body>
</html>
