<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>꽃다발 상품 조회</title>
    <%@ include file="../main/b_import.jspf"%>
    <link rel="stylesheet" href="/static/css/item/b_addForm.css">
    <link rel="stylesheet" href="/static/css/item/list.css">
</head>
<body>
<%@ include file="../main/b_header.jspf"%>
<div id="container" class="mx-auto">
    <form>
        <!-- 브레드크럼 (유저 이동 경로) -->
        <nav id="bread-nav" style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
            <ol class="breadcrumb mb-8em">
                <li class="breadcrumb-item" onclick="location.href='/admin/main'">관리자 홈</li>
                <li class="breadcrumb-item" onclick="location.href='/admin/flower'">꽃다발 관리</li>
                <li class="breadcrumb-item active" aria-current="page">상품 조회</li>
            </ol>
        </nav>

        <!-- 상품 썸네일 -->
        <div class="row row-cols-4">
            <c:forEach var="flowerVo" items="${list}">
            <c:if test="${not empty flowerVo}">
            <div class="col mb-8em">
                <div class="thumbnails-wrap position-relative d-flex flex-column justify-content-start align-items-end">
                    <button type="button" class="btn-close-style" onclick="showDeleteModal(${flowerVo.idx})">삭제</button>
                    <div class="overflow-hidden thumbnails">
                        <a href="/admin/flowerUpdateForm/${flowerVo.idx}">
                            <img src="${flowerVo.image1}" class="col-12" alt="꽃다발 썸네일">
                        </a>
                    </div>
                </div>
                <div class="ps-1">
                    <div class="subheader">${flowerVo.subheader}</div>
                    <div class="item-name">
                        <a href="/admin/flowerUpdateForm/${flowerVo.idx}">${flowerVo.name}</a></div>
                    <div>
                        <c:if test="${not empty flowerVo.discountRate && flowerVo.discountRate > 0}">
                        <span class="discount-rate">${flowerVo.discountRate}%</span>
                        <span class="original-price">${flowerVo.price}원 ></span>
                        </c:if>
                        <span class="final-price">${flowerVo.finalPrice}원</span>
                    </div>
                    <div class="size-delivery">
                        <span class="badge rounded-pill bg-warning size-unit">${flowerVo.fsize}</span>
                        <span class="item-size">size</span>
                        <c:if test="${flowerVo.freeDelivery > 0}">
                        <span class="badge rounded-pill bg-secondary delivery-unit">${flowerVo.freeDeliveryMessage}</span>
                        </c:if>
                    </div>
                </div>
            </div>
            </c:if>
            </c:forEach>
        </div>
    </form>
</div>

<!-- Modal -->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">정말 삭제하시겠습니까?</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                게시물 삭제를 원하시면 '삭제' 버튼을 눌러주세요.
            </div>
            <form class="modal-footer">
                <input type="hidden" name="idx" id="idx">
                <button type="button" class="btn btn-danger" onclick="deleteItem(this.form)">삭제</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
            </form>
        </div>
    </div>
</div> <!-- Modal 끝 -->


<%@ include file="../main/b_footer.jspf"%>
<script>

    function showDeleteModal(idx) {
        document.querySelector("#idx").value = idx;
        new bootstrap.Modal(document.querySelector("#staticBackdrop")).show();
    }

    function deleteItem(frm) {
        frm.action = "/admin/deleteFlower";
        frm.submit();
    }
</script>
</body>
</html>
