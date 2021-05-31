<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>정기구독 상품 조회</title>
    <%@ include file="../main/b_import.jspf"%>
    <link rel="stylesheet" href="/static/css/item/b_addForm.css">
    <link rel="stylesheet" href="/static/css/item/list.css">
</head>
<body>
<%@ include file="../main/b_header.jspf"%>
<div id="container" class="mx-auto">
    <form>
    <nav id="bread-nav" style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
        <ol class="breadcrumb mb-8em">
            <li class="breadcrumb-item" onclick="location.href='/admin/main'">관리자 홈</li>
            <li class="breadcrumb-item" onclick="location.href='/admin/subs'">정기구독 관리</li>
            <li class="breadcrumb-item active" aria-current="page">정기구독 상품 조회/수정/삭제</li>
        </ol>
    </nav>

        <div class="subs_list d-flex flex-column justify-content-center">
        <!-- 정기구독 상품 4개 리스트 -->
        <c:forEach var="subsVo" items="${subsList}" varStatus="status">
            <div class="d-flex py-4 border-bottom">
            <c:if test="${empty subsVo}">
                <h3>판매중인 정기구독 상품이 없습니다.</h3>
                </c:if>
                <c:if test="${not empty subsVo}">
                <div class="order-${status.index % 2} thumbnails-wrap col-6 position-relative d-flex justify-content-end">
                    <button type="button" class="btn-close-style" onclick="showDeleteModal(${subsVo.idx})">삭제</button>
                    <!-- Modal -->
                    <div class="overflow-hidden">
                        <div class="flex-row thumbnails d-flex justify-content-center scale-up">
                            <!-- 이미지 클릭시, 수정 페이지로 이동 -->
                            <a href="/admin/subsUpdateForm/${subsVo.idx}">
                                <img src="${subsVo.image1}" alt="${subsVo.name}" class="w-100" height="580px"/>
                            </a>
                        </div>
                    </div>
                </div>
                    <!-- 홀수index text-end pe-5 / 짝수index ps-5 -->
                <div class="${status.index % 2 == 1 ? "text-end pe-5" : "ps-5"} col-6 flex-row justify-content-start" id="subs_infos">
                    <h4 class="fw-normal text-secondary">${subsVo.subheader}</h4>
                    <h2 class="py-2">${subsVo.name}</h2>
                    <h2 class="py-3">
                        <fmt:formatNumber value="${subsVo.price}" pattern="#,###원"/> ~
                    </h2>
                    <div class="w-95">
                        <h5 class="py-3 fw-lighter lh-lg">${subsVo.summary}</h5>
                    </div>
                    <h5 class="py-3"><span class="badge rounded-pill bg-light text-dark">무료배송</span></h5>
                </div>
            </c:if>
            </div>
        </c:forEach>
    </div>
    </form>
</div>

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
        frm.action = "/admin/deleteSubs";
        frm.submit();
    }
</script>
</body>
</html>
