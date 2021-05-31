<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
    <title>소품샵 상품 조회</title>
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
                <li class="breadcrumb-item" onclick="location.href='/admin/product'">소품샵 관리</li>
                <li class="breadcrumb-item active" aria-current="page">상품 조회</li>
            </ol>
        </nav>

        <!-- 화병 썸네일 -->
        <div class="p-subtitle fs-4 d-flex align-items-center">
            꽃을 더 아름답게 즐길 수 있는, 화병
        </div>
        <div class="row row-cols-4">
            <c:forEach var="productVo" items="${vase}">
            <c:if test="${not empty productVo}">
            <div class="col mb-8em">
                <div class="thumbnails-wrap position-relative d-flex flex-column justify-content-start align-items-end">
                    <button type="button" class="btn-close-style" onclick="showDeleteModal(${productVo.idx})">삭제</button>
                    <div class="overflow-hidden mb-3 thumbnails">
                        <a href="/admin/productUpdateForm/${productVo.idx}">
                            <img src="${productVo.image1}" class="col-12" alt="소품샵 썸네일">
                        </a>
                    </div>
                </div>
                <div class="ps-1">
                    <div class="item-name">
                        <a href="/admin/productUpdateForm/${productVo.idx}">${productVo.name}</a></div>
                    <div class="price-wrap">
                    <c:if test="${not empty productVo.discountRate && productVo.discountRate > 0}">
                    <span class="discount-rate">${productVo.discountRate}%</span>
                    <span class="original-price">
                        <fmt:formatNumber value="${productVo.price}" pattern="#,###원 >"/>
                    </span>
                    </c:if>
                    <span class="final-price">
                        <fmt:formatNumber value="${productVo.finalPrice}" pattern="#,###원"/>
                    </span>
                    </div>
                    <c:if test="${not empty productVo.fsize}">
                    <div class="fit-size">
                        <span class="badge rounded-pill bg-secondary size-unit">${productVo.fsize}</span>
                        <span class="item-size">size꽃과 잘어울려요!</span>
                    </div>
                    </c:if>
                </div>
            </div>
            </c:if>
            </c:forEach>
        </div>

        <!-- 굿즈 썸네일 -->
        <div class="p-subtitle fs-4 d-flex align-items-center">
            꽃과 함께하면 더 좋은, 굿즈
        </div>
        <div class="row row-cols-4">
            <c:forEach var="productVo" items="${goods}">
            <c:if test="${not empty productVo}">
            <div class="col mb-8em">
                <div class="thumbnails-wrap position-relative d-flex flex-column justify-content-start align-items-end">
                    <button type="button" class="btn-close-style" onclick="showDeleteModal(${productVo.idx})">삭제</button>
                    <div class="overflow-hidden mb-3 thumbnails">
                        <a href="/admin/productUpdateForm/${productVo.idx}">
                            <img src="${productVo.image1}" class="col-12" alt="소품샵 썸네일">
                        </a>
                    </div>
                </div>
                <div class="ps-1">
                    <div class="item-name">
                        <a href="/admin/productUpdateForm/${productVo.idx}">${productVo.name}</a></div>
                    <div class="price-wrap">
                    <c:if test="${not empty productVo.discountRate && productVo.discountRate > 0}">
                    <span class="discount-rate">${productVo.discountRate}%</span>
                    <span class="original-price">
                        <fmt:formatNumber value="${productVo.price}" pattern="#,###원 >"/>
                    </span>
                    </c:if>
                    <span class="final-price">
                        <fmt:formatNumber value="${productVo.finalPrice}" pattern="#,###원"/>
                    </span>
                    </div>
                </div>
            </div>
            </c:if>
            </c:forEach>
        </div> <!-- .row 닫음 -->
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
        frm.action = "/admin/deleteProduct";
        frm.submit();
    }
</script>
</body>
</html>
