<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>꽃다발</title>
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
<%--            계절을 가득 담은 꽃다발로<br>당신의 일상을 특별한 날로 만들어보세요.--%>
        </div>
    </div>
</div>

<!-- 컨테이너 -->
<div id="container" class="mx-auto">
    <!-- 정렬 순서 (추후 매출통계와 연계) -->
    <div class="align-by pe-2 d-flex justify-content-end align-items-center">
        추천순 <i class="fas fa-chevron-down p-3"></i>
    </div>

    <!-- 상품 썸네일 리스트 -->
    <div class="row row-cols-4">
        <c:forEach var="flowerVo" items="${list}">
        <c:if test="${not empty flowerVo}">
        <div class="col mb-8em">
            <div class="overflow-hidden">
                <a href="/flower/${flowerVo.idx}">
                    <img src="${flowerVo.image1}" class="col-12 scale-up" alt="꽃다발 썸네일">
                </a>
            </div>
            <div class="ps-1">
                <div class="subheader">${flowerVo.subheader}</div>
                <div class="item-name">
                    <a href="/flower/${flowerVo.idx}">${flowerVo.name}</a>
                </div>
                <div class="price-wrap">
                    <c:if test="${not empty flowerVo.discountRate && flowerVo.discountRate > 0}">
                    <span class="discount-rate">${flowerVo.discountRate}%</span>
                    <span class="original-price">
                        <fmt:formatNumber value="${flowerVo.price}" pattern="#,###원 >"/>
                    </span>
                    </c:if>
                    <span class="final-price">
                        <fmt:formatNumber value="${flowerVo.finalPrice}" pattern="#,###원"/>
                    </span>
                </div>
                <div class="size-delivery">
                    <span class="badge rounded-pill bg-warning size-unit">${flowerVo.fsize}</span>
                    <span class="item-size">size</span>
                    <span class="badge rounded-pill bg-secondary delivery-unit">${flowerVo.freeDeliveryMessage}</span>
                </div>
            </div>
        </div>
        </c:if>
        </c:forEach>
    </div>
</div>

<%@ include file="../main/footer.jspf" %>

</body>
</html>
