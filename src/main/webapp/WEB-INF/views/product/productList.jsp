<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>소품샵</title>
    <%@ include file="../main/import.jspf"%>
    <link rel="stylesheet" href="/static/css/item/list.css">
</head>
<body>
<%@ include file="../main/header.jspf" %>

<!-- 배너 이미지와 글귀 -->
<div class="banner-wrap d-flex align-items-center justify-content-center">
    <div class="w-1280 mx-auto">
        <img src="${bannerVo.image}" alt="꽃다발배너" class="col-12">
    </div>
    <div class="banner-text w-1280 position-absolute mx-auto">
        <div class="banner-title fw-500 mb-4 ms-2 ls-narrower">${bannerVo.title}</div>
        <div class="banner-summary fw-light ms-2 ls-narrower">
            ${bannerVo.content}
        </div>
    </div>
</div>

<!-- 컨테이너 -->
<div id="container" class="mx-auto">

    <!-- Best 소품 6개 (인기순) -->
    <div class="p-subtitle fs-4 d-flex align-items-center">
        지금 가장 사랑받는 소품들이에요!
    </div>
    <div class="row row-cols-4">
        <c:forEach var="productVo" items="${all}">
        <c:if test="${not empty productVo}">
            <div class="col mb-8em">
                <div class="overflow-hidden mb-3">
                    <a href="/product/${productVo.idx}">
                        <img src="${productVo.image1}" class="col-12 scale-up" alt="소품샵 썸네일">
                    </a>
                </div>
                <div class="ps-1">
                    <div class="item-name">
                        <a href="/product/${productVo.idx}">${productVo.name}</a></div>
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
    </div>

    <!-- 화병 썸네일 -->
    <div class="p-subtitle fs-4 d-flex align-items-center">
        꽃을 더 아름답게 즐길 수 있는, 화병
    </div>
    <div class="row row-cols-4">
        <c:forEach var="productVo" items="${vase}">
        <c:if test="${not empty productVo}">
        <div class="col mb-8em">
            <div class="overflow-hidden mb-3">
                <a href="/product/${productVo.idx}">
                    <img src="${productVo.image1}" class="col-12 scale-up" alt="소품샵 썸네일">
                </a>
            </div>
            <div class="ps-1">
                <div class="item-name">
                    <a href="/product/${productVo.idx}">${productVo.name}</a></div>
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
            <div class="overflow-hidden mb-3">
                <a href="/product/${productVo.idx}">
                    <img src="${productVo.image1}" class="col-12 scale-up" alt="소품샵 썸네일">
                </a>
            </div>
            <div class="ps-1">
                <div class="item-name">
                    <a href="/product/${productVo.idx}">${productVo.name}</a></div>
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
</div> <!-- #container 닫음 -->

<%@ include file="../main/footer.jspf" %>

</body>
</html>