<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<html>
<head>
    <title>꽃다발 관리 인덱스</title>
    <%@ include file="../main/b_import.jspf"%>
    <link rel="stylesheet" href="/static/css/item/b_itemManager.css">
</head>
<body>
<%@ include file="../main/b_header.jspf"%>
<div id="container" class="mx-auto">
    <nav id="bread-nav" style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
        <ol class="breadcrumb mb-xxl-5">
            <li class="breadcrumb-item" onclick="location.href='/admin/main'">관리자 홈</li>
            <li class="breadcrumb-item active" aria-current="page">꽃다발 관리</li>
        </ol>
    </nav>
    <div class="mt-100 d-flex justify-content-center">
        <div class="btn-circle d-flex justify-content-center align-items-center"
             onclick="location.href='/admin/banner/flower'">
            배너 등록/수정
        </div>
        <div class="btn-circle d-flex justify-content-center align-items-center"
             onclick="location.href='/admin/flowerAddForm'">
            꽃다발 상품 등록
        </div>
        <div class="btn-circle d-flex justify-content-center align-items-center text-center"
             onclick="location.href='/admin/flowerList'">꽃다발 상품<br>조회/수정/삭제
        </div>
    </div>
</div>
<%@ include file="../main/b_footer.jspf"%>
</body>
</html>
