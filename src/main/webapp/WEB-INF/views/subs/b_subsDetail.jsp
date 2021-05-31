<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>정기구독 상세페이지</title>
    <%@ include file="../main/b_import.jspf"%>
    <link rel="stylesheet" href="/static/css/item/b_detail.css">
</head>
<body>
<%@ include file="../main/b_header.jspf"%>
<div id="container" class="mx-auto">
    <form action="/admin/subsUpdateForm">
        <!-- 메뉴 이동 경로 -->
        <nav id="bread-nav" style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
            <ol class="breadcrumb mb-8em">
                <li class="breadcrumb-item"><a href="/admin/main">관리자 홈</a></li>
                <li class="breadcrumb-item"><a href="/admin/subs">꽃다발 관리</a></li>
                <li class="breadcrumb-item"><a href="/admin/subsList">상품 조회</a></li>
                <li class="breadcrumb-item active" aria-current="page">${subsVo.name}</li>
            </ol>
        </nav>

        <h1>꽃다발 상세페이지 백오피스</h1>
        <div>${subsVo.subheader}</div>
        <div>${subsVo.summary}</div>
        <div>${subsVo.name}</div>
        <div>${subsVo.price}</div>
        <!-- 상품 상세페이지에 들어갈 내용 -->
        <div>${subsVo.content}</div>

        <input type="submit" value="수정하기">
        <input type="hidden" value="${subsVo.idx}" name="idx">
        <input type="button" value="삭제" onclick="goDelete(this.form)">
    </form>
</div>
<%@ include file="../main/b_footer.jspf"%>

<script>
    function goDelete(frm) {
        // 정말 삭제하시겠냐 모달창 띄우고 예 누르면 삭제, 아니면 모달창 끄기
        frm.action="/admin/deleteSubs";
        frm.submit();
    }

</script>

</body>
</html>
