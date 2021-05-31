<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
    <title>배너 등록/수정</title>
    <%@ include file="../main/b_import.jspf"%>
    <link rel="stylesheet" href="/static/css/item/b_addForm.css">
</head>
<body>
<%@ include file="../main/b_header.jspf"%>
<div id="container" class="mx-auto">
<form method="post" enctype="multipart/form-data">

    <!-- 브레드크럼 (유저 이동경로) -->
    <nav id="bread-nav" style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
        <ol class="breadcrumb mb-xxl-5">
            <li class="breadcrumb-item" onclick="location.href='/admin/main'">관리자 홈</li>
            <c:if test="${category eq 'subs'}">
                <li class="breadcrumb-item" onclick="location.href='/admin/subs'">정기구독 관리</li>
            </c:if>
            <c:if test="${category eq 'flower'}">
                <li class="breadcrumb-item" onclick="location.href='/admin/flower'">꽃다발 관리</li>
            </c:if>
            <c:if test="${category eq 'product'}">
                <li class="breadcrumb-item" onclick="location.href='/admin/product'">소품샵 관리</li>
            </c:if>
            <li class="breadcrumb-item active" aria-current="page">배너 등록/수정</li>
        </ol>
    </nav>

    <!-- 1. 배너 이미지 등록 -->
    <div class="fs-5 p-1 my-5 d-block border-bottom border-secondary">
        1. 배너 이미지 등록
        <span class="description text-danger ms-2">
            * 배너 이미지의 크기를 1280 * 300 픽셀로 반드시 지켜주세요.
        </span>
    </div>
    <div class="imgs d-flex justify-content-center">
        <div class="card overflow-hidden img-card" onclick="this.children.file.click()"
             style="width: 1090px; height: 255px;">
            <a href="#" class="w-100 h-100 btn btn-outline-dark
                               d-flex flex-column align-items-center justify-content-center">
                <i class="fa fa-plus h1"></i>
                <div>배너 이미지 (1280 * 300 px)</div>
            </a>
            <input type="file" name="file" class="d-none" id="file1" onchange="preview(this, 'img1')">
            <c:if test="${empty bannerVo}">
                <img src="" alt="사진" class="m-0 p-0 w-100 card-img-overlay d-none" id="img1">
            </c:if>
            <c:if test="${not empty bannerVo}">
                <img src="${bannerVo.image}" alt="사진" class="m-0 p-0 w-100 card-img-overlay" id="img1">
                <input type="hidden" name="image" value="${bannerVo.image}">
            </c:if>
        </div>
    </div>

    <!-- 2. 배너에 들어갈 텍스트 -->
    <div class="fs-5 p-1 my-5 d-block border-bottom border-secondary">
        2. 배너 텍스트
    </div>
    <div class="inputs-wrap mx-auto">
        <!-- 배너 제목 입력 -->
        <div class="row">
            <div class="col-md">
                <div class="form-floating my-2">
                    <c:if test="${not empty bannerVo}">
                    <input type="text" name="title" class="form-control" id="bannerTitle" placeholder="상품명 입력"
                           value="${bannerVo.title}" autocomplete="off">
                    </c:if>
                    <c:if test="${empty bannerVo}">
                    <input type="text" name="title" class="form-control" id="bannerTitle" placeholder="상품명 입력" autocomplete="off">
                    </c:if>
                    <label for="bannerTitle">배너 제목 (한글 25자 미만)</label>
                </div>
            </div>
        </div>

        <!-- 배너 내용 입력 -->
        <div class="row">
            <div class="col-md">
                <div class="form-floating my-2">
                    <c:if test="${not empty bannerVo}">
                    <input type="text" name="content" class="form-control" id="bannerContent" placeholder="한줄 설명"
                           value="${bannerVo.content}" autocomplete="off">
                    </c:if>
                    <c:if test="${empty bannerVo}">
                    <input type="text" name="content" class="form-control" id="bannerContent" placeholder="한줄 설명"
                           value="" autocomplete="off">
                    </c:if>
                    <label for="bannerContent">배너 제목에 상응하는 설명 텍스트 (한글 50자 미만)</label>
                </div>
            </div>
        </div>
        <!-- 배너 카테고리 -->
        <c:if test="${category eq 'subs'}">
            <input type="hidden" name="category" value="subs">
        </c:if>
        <c:if test="${category eq 'flower'}">
            <input type="hidden" name="category" value="flower">
        </c:if>
        <c:if test="${category eq 'product'}">
            <input type="hidden" name="category" value="product">
        </c:if>
    </div> <!-- inputs-wrap 닫기 -->

    <div class="d-flex justify-content-center my-lg-5">
        <c:if test="${not empty bannerVo}">
        <input type="button" value="등록/수정하기" class="btn btn-lg btn-dark py-lg-3 px-lg-5"
               onclick="updateBanner(this.form)">
        </c:if>
        <c:if test="${empty bannerVo}">
        <input type="button" value="등록/수정하기" class="btn btn-lg btn-dark py-lg-3 px-lg-5"
               onclick="addBanner(this.form)">
        </c:if>
        <input type="button" value="이전으로" class="btn btn-lg btn-secondary py-lg-3 px-lg-5 ms-3"
               onclick="history.back()">
    </div>
</form>
</div>  <!-- container 닫기 -->
<%@ include file="../main/b_footer.jspf"%>

<script>
    /* 업로드한 이미지 미리보기 */
    function preview(file, id) {
        let img = document.querySelector("#" + id);

        let reader = new FileReader();
        reader.onload = function(e) {
            img.setAttribute("src", e.target.result.toString());
            img.classList.remove("d-none");
        }
        reader.readAsDataURL(file.files[0]);
    }

    /* 폼데이터 전송후 창 이동 */
    function addBanner(frm) {
        frm.action = "/admin/addBanner";
        frm.submit();
    }
    function updateBanner(frm) {
        frm.action = "/admin/updateBanner";
        frm.submit();
    }
</script>
</body>
</html>
