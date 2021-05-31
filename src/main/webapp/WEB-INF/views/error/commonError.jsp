<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<html>
<head>
    <title>기본 에러</title>
    <%@ include file="../main/import.jspf"%>
    <script src="/static/ckeditor5-build-classic/ckeditor.js"></script>
    <link rel="stylesheet" href="/static/css/fclass/classDetail.css">
    <link rel="stylesheet" href="/static/bootstrap-datepicker/bootstrap-datepicker.css">
    <style>
        #errIcon {
            font-size: 120px !important;
        }

        @media screen and (max-width: 1280px) {
            #container {
                width: auto !important;
            }
        }

    </style>
</head>
<body>
<%@ include file="../main/header.jspf"%>
<div id="container" class="mx-auto d-flex flex-column justify-content-center">
<form method="get" action="/fclass/test">
    <div class="d-flex flex-column align-items-center pb-3">
        <span><i id="errIcon" class="fas fa-exclamation-triangle fs-1 text-warning"></i></span>
        <span class="fs-3 fw-bold text-secondary">404 Error</span>
        <span class="fs-3 fw-bold text-secondary">존재하지 않는 페이지입니다.</span>
    </div>
    <div>
        ${exception.message}
    </div>
    <div class="d-flex flex-column align-items-center text-secondary">
        <span class="fs-5">고객센터 1161-1031</span>
        <span>(운영시간: 10:00 ~ 13:00, 14:00 ~ 18:00</span>
    </div>
</form>
</div>
<%@ include file="../main/footer.jspf"%>
</body>
</html>
