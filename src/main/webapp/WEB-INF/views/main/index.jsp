<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>새늘봄 | 언제나 새롭게 꽃과 만나요</title>
    <%@ include file="import.jspf"%>
    <link rel="stylesheet" href="/static/css/item/list.css">
    <link rel="stylesheet" href="/static/css/main.css">
</head>
<body>
<%@ include file="header.jspf"%>
<!-- 메인 슬라이드 이미지 -->
<div id="mainSlide" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-indicators">
    <c:set var="index" value="0"/>
    <c:forEach var="images" items="${mainVo.images}" varStatus="status">
    <c:if test="${not empty images.path}">
        <button type="button" data-bs-target="#mainSlide" data-bs-slide-to="${index}" class=${index == 0 ? "active" : ""}
                aria-current=${index == 0 ? "true" : ""} aria-label="Slide ${index + 1}"></button>
        <c:set var="index" value="${index + 1}"/>
    </c:if>
    </c:forEach>
    </div>
    <div class="carousel-inner">
        <c:set var="index" value="0"/>
        <c:forEach var="images" items="${mainVo.images}" varStatus="status">
        <c:if test="${not empty images.path}">
        <div class="carousel-item ${index == 0 ? "active" : ""}">
            <a href="${images.link}"><img src="${images.path}" class="d-block w-100 main-img" alt="메인배너"></a>
        </div>
        <c:set var="index" value="${index + 1}"/>
        </c:if>
        </c:forEach>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#mainSlide" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#mainSlide" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </button>
</div>

<!-- 새늘봄 꽃 정기구독 -->
<div class="w-1280 mx-auto mt-100 mb-5 d-flex justify-content-between pt-4">
    <div class="col-4 d-flex flex-column pt-2 ps-4">
        <span class="fs-3 ls-narrower ps-3">2주에 한번, 나를 위한 행복</span>
        <span class="fs-3 fw-bolder ls-narrower ps-3">새늘봄 꽃 정기구독</span>
        <span class="mt-3 mb-3 fs-19 fw-light ls-narrower ps-3">
            이 계절 가장 이쁜 꽃으로 구성된 구독 꽃이예요!
        </span>
        <!-- size 표시 -->
        <div class="my-2 ps-3 d-flex">
            <span class="me-1 badge rounded-pill bg-warning size-unit">S</span>
            <span class="item-size me-3">size</span>
            <span class="me-1 badge rounded-pill bg-warning size-unit">M</span>
            <span class="item-size me-3">size</span>
            <span class="me-1 badge rounded-pill bg-warning size-unit">L</span>
            <span class="item-size me-3">size</span>
            <span class="me-1 badge rounded-pill bg-warning size-unit">XL</span>
            <span class="item-size me-3">size</span>
        </div>
        <!-- 정기구독 더 알아보기 버튼 -->
        <button type="button" class="mt-4 py-3 subs-btn col-8" onclick="location.href='/subs'">정기구독 더 알아보기</button>
    </div>
    <!-- 정기구독 상품 썸네일 2개 + 2개 -->
    <div class="col-6 border-1 border-danger">
        <div class="slide-wrapper">
            <ul class="slides">
                <c:forEach var="subsVo" items="${subsList}" varStatus="status">
                <c:if test="${not empty subsVo}">
                <li class="${status.index > 2 ? "" : "me-15"}">
                    <a href="/subs/${subsVo.idx}"><img src="${subsVo.image1}" alt="subs" class="mb-2"></a>
                    <div class="d-flex flex-column">
                        <span class="subheader">${subsVo.subheader}</span>
                        <span class="item-name"><a href="/subs/${subsVo.idx}">${subsVo.name}</a></span>
                        <div class="price-wrap">
                            <span class="discount-rate">1회 기준</span>
                            <span class="final-price">
                                <fmt:formatNumber value="${subsVo.price}" pattern="#,###원~"/>
                            </span>
                        </div>
                    </div>
                </li>
                </c:if>
                </c:forEach>
            </ul>
        </div>
    </div>
    <!-- 화살표 -->
    <div class="col-1 d-flex align-items-center justify-content-center">
        <i class="fas fa-chevron-right fs-1 next-btn"></i>
    </div>
</div> <!-- 정기구독 끝 -->

<!-- 새늘봄 꽃다발 -->
<div class="mt-100 flower-wrap">
    <div class="w-1280 mx-auto">
        <div class="px-4 me-3 mb-5 d-flex justify-content-between align-items-end">
            <div>
                <span class="fs-3 ls-narrower ps-3">꽃이 필요한 순간,</span>
                <span class="fs-3 fw-bolder ls-narrower ps-3">새늘봄 꽃다발</span>
            </div>
            <span class="cursor-pointer see-more" onclick="location.href='/flower'">더보기</span>
        </div>
        <!------- 꽃다발 썸네일 4개 ------->
        <div class="px-4 mx-2 row row-cols-4">
            <c:forEach var="flowerVo" items="${flowerList}">
            <c:if test="${not empty flowerVo}">
            <div class="col mb-5">
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
        <!----------------------------------------->
    </div>
</div> <!-- 꽃다발 끝 -->

<!-- 새늘봄 플라워클래스 -->
<div class="fclass-wrap">
    <div class="w-1280 mx-auto">
        <div class="px-4 me-3 mb-4 d-flex justify-content-between align-items-end">
            <div>
                <span class="fs-3 ls-narrower ps-3">꽃과 함께 하는 일상,</span>
                <span class="fs-3 fw-bolder ls-narrower ps-3">플라워클래스</span>
            </div>
            <span class="cursor-pointer see-more" onclick="location.href='/fclass/classList'">더보기</span>
        </div>

        <!-- 상품 썸네일 리스트 -->
        <!----------------------------------------->
        <div class="px-4 mx-2">
            <div class="mb-5 d-flex justify-content-start">
                <div class="col-6 pe-2 position-relative overflow-hidden height-400px d-flex justify-content-start
                            align-items-end">
                    <div class="position-absolute p-4 d-flex flex-column cursor-pointer"
                         onclick="location.href='/fclass/classList/${fclassBig.idx}'">
                        <span class="fs-5 fw-light text-white">2021년에도 새늘봄 클래스와 함께</span>
                        <span class="fs-3 fw-bolder text-white">${fclassBig.name} > </span>
                    </div>
                    <a href="/fclass/classList/${fclassBig.idx}">
                        <img src="${fclassBig.image1}" alt="썸네일" class="w-100">
                    </a>
                </div>
                <div class="col-6 ps-3 d-flex justify-content-start">
                    <div class="col-6">
                        <a href="/fclass/classList/${fclassSmall.idx}">
                            <img src="${fclassSmall.image1}" alt="썸네일" class="w-100">
                        </a>
                    </div>
                    <div class="col-5 ps-3 d-flex flex-column">
                        <span class="item-name cursor-pointer" onclick="location.href='/fclass/classList/${fclassSmall.idx}'">
                            ${fclassSmall.name}
                        </span>
                        <div class="price-wrap">
                            <c:if test="${not empty fclassSmall.discountRate && fclassSmall.discountRate > 0}">
                                <span class="discount-rate">${fclassSmall.discountRate}%</span>
                                <span class="original-price">
                                    <fmt:formatNumber value="${fclassSmall.price}" pattern="#,###원"/>
                                </span>
                            </c:if>
                            <div class="final-price mt-1 mb-3">
                                <fmt:formatNumber value="${fclassSmall.finalPrice}" pattern="#,###원"/>
                            </div>
                            <ul class="border-0 d-flex m-0 p-0">
                                <c:forEach var="bvo" items="${fclassSmall.branchList}">
                                    <li class="branch-box list-unstyled p-1 me-1 fw-bold"  style="color: ${bvo.color}; border: 2px solid ${bvo.color}; border-radius: 12px; font-size: 0.75rem; width: 60px; text-align: center;">${bvo.name}</li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!----------------------------------------->


    </div>
</div>
<!-- 새늘봄 소품샵 -->



<%@ include file="footer.jspf"%>
<script>
    /* 슬라이드 이미지 */
    let slides = document.querySelector(".slides"),
        currentIdx = 0,
        slideCount = 2,
        slideWidth = 710,
        slideMargin = 0,
        btn = document.querySelector(".next-btn");

    slides.style.width = (slideWidth * slideCount) +
                            slideMargin * (slideCount - 1) + "px";

    function moveSlide(num) {
        slides.style.left = (-num * 710) + "px";
        currentIdx = num;
    }
    btn.addEventListener("click", function(){
        if (currentIdx === 0) {
            moveSlide(1);
        } else {
            moveSlide(0);
        }
    });
</script>
</body>
</html>
