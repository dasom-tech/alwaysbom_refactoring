<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>소품샵 상세페이지</title>
    <%@ include file="../main/import.jspf"%>
    <link rel="stylesheet" href="/static/css/item/detail.css">
    <link rel="stylesheet" href="/static/bootstrap-datepicker/bootstrap-datepicker.css">
    <script src="/static/bootstrap-datepicker/bootstrap-datepicker.js"></script>
</head>
<body>
<%@ include file="../main/header.jspf"%>

<!-- 맨위로 가는 버튼 -->
<button type="button" id="moveToTop" onclick="moveToTop()">
    <i class="far fa-arrow-alt-circle-up"></i>
</button>

<!-- 메인 컨테이너 -->
<div id="container" class="mx-auto">
    <form method="post">

        <!-- 메뉴 경로 표시 -->
        <nav id="bread-nav" style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
            <ol class="breadcrumb mb-3">
                <li class="breadcrumb-item"><a href="/">HOME</a></li>
                <li class="breadcrumb-item"><a href="/product">소품샵</a></li>
                <li class="breadcrumb-item active" aria-current="page">${productVo.name}</li>
            </ol>
        </nav>

        <!-- 상품 썸네일과 주문 정보 -->
        <div class="d-flex justify-content-between mb-5em">
            <!-- 사진 썸네일 -->
            <div class="w-45 d-flex flex-column justify-content-start">
                <div id="item-thumbnails" class="carousel slide mb-4" data-bs-interval="0" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src="${productVo.image1}" class="d-block w-100" alt="대표 썸네일">
                        </div>
                        <c:if test="${not empty productVo.image2}">
                            <div class="carousel-item">
                                <img src="${productVo.image2}" class="d-block w-100" alt="대표 썸네일">
                            </div>
                        </c:if>
                        <c:if test="${not empty productVo.image3}">
                            <div class="carousel-item">
                                <img src="${productVo.image3}" class="d-block w-100" alt="대표 썸네일">
                            </div>
                        </c:if>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#item-thumbnails" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#item-thumbnails" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div> <!-- id="item-thumbnails" 닫기 -->

                <!-- 3개 한 줄에 일렬로 나오는 썸네일 -->
                <div class="d-flex">
                    <button type="button" data-bs-target="#item-thumbnails" data-bs-slide-to="0"
                            class="active col-4 p-0 pe-3 border-0 bg-transparent m-0" aria-current="true" aria-label="Slide 1">
                        <img src="${productVo.image1}" alt="썸네일1" class="w-100">
                    </button>
                    <c:if test="${not empty productVo.image2}">
                        <button type="button" data-bs-target="#item-thumbnails" data-bs-slide-to="1"
                                class="col-4 p-0 ps-2 pe-2 border-0 bg-transparent m-0" aria-label="Slide 2">
                            <img src="${productVo.image2}" alt="썸네일2" class="w-100">
                        </button>
                    </c:if>
                    <c:if test="${not empty productVo.image3}">
                        <button type="button" data-bs-target="#item-thumbnails" data-bs-slide-to="2"
                                class="col-4 p-0 ps-3 border-0 bg-transparent m-0" aria-label="Slide 3">
                            <img src="${productVo.image3}" alt="썸네일3" class="w-100">
                        </button>
                    </c:if>
                </div>
            </div> <!-- 사진 썸네일 닫기 -->

            <!-- 주문 정보 -->
            <div class="w-46 d-flex flex-column">
                <span class="subheader">${productVo.subheader}</span>
                <span class="item-name">${productVo.name}</span>

                <!-- 가격 정보 -->
                <div class="d-flex justify-content-start align-items-center">
                    <c:if test="${not empty productVo.discountRate && productVo.discountRate > 0}">
                        <span class="discount-rate text-danger pe-2">${productVo.discountRate}%</span>
                        <span class="original-price text-decoration-line-through pe-2">
                        <fmt:formatNumber value="${productVo.price}" pattern="#,###원 >"/>
                </span>
                    </c:if>
                    <span class="fs-3 fw-500" data-product-finalPrice>
                    <fmt:formatNumber value="${productVo.finalPrice}" pattern="#,###원"/>
                </span>
                </div>

                <!-- 무료배송 알림 -->
                <div class="fd-announcement d-flex justify-content-start py-3 my-4">
                    3만원 이상 구매시, <span class="green-color fw-500 ps-1">무료배송!</span>
                </div>

                <!-- 구매옵션 -->
                <div class="fs-19 mb-4">
                    <!-- 수령일 선택 옵션 -->
                    <div class="row mb-4">
                        <label for="requestDate" class="col-3 fw-500 pt-1">수령일</label>
                        <div class="col-9">
                            <input type="text" name="requestDate" id="requestDate" placeholder="수령일을 선택해주세요."
                                   class="datepicker col-12 p-2 ps-3 fs-6" autocomplete="off"/>
                        </div>
                    </div>

                    <!-- 수량 선택 옵션 -->
                    <div class="row mb-4">
                        <div class="col-3 fw-500">수량</div>
                        <div class="col-9 count d-flex justify-content-start align-items-center">
                            <button type="button" class="border-0 bg-transparent" onclick="adjustQuantity(false)">
                                <i class="fas fa-minus-circle"></i>
                            </button>
                            <span class="quantity col-2 text-center" data-product-quantity>1</span>
                            <button type="button" class="border-0 bg-transparent" onclick="adjustQuantity(true)">
                                <i class="fas fa-plus-circle"></i>
                            </button>
                        </div>
                    </div>

                    <!-- 편지 추가 옵션 -->
                    <div class="row mb-4 d-flex align-items-baseline">
                        <div class="col-3 fw-500">편지 추가</div>
                        <div class="col-9">
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="letterOptions"
                                       id="withLetter" value="1" checked onclick="checkRadioBtn(true)">
                                <label class="form-check-label text-dark fw-500" for="withLetter">추가할게요.(+2,500원)</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="letterOptions"
                                       id="withoutLetter" value="0" onclick="checkRadioBtn(false)">
                                <label class="form-check-label" for="withoutLetter">추가하지 않을게요.</label>
                            </div>
                        </div>
                    </div>
                </div> <!-- 구매옵션 닫기 -->

                <!-- price box 그룹 -->
                <div class="price-box-wrap">
                    <!-- 상품가격 price box -->
                    <div class="d-flex justify-content-between p-4 mx-2 mb-3 price-box">
                        <span class="fw-500">상품가격</span>
                        <span class="fw-500">
                        <fmt:formatNumber value="${productVo.finalPrice}" pattern="#,###원"/>
                    </span>
                    </div>

                    <!-- 편지추가 price box -->
                    <div id="addLetter" class="p-4 mx-2 mb-3 price-box">
                        <div class="d-flex justify-content-between pb-1">
                            <span class="fw-500">추가상품 : 편지추가</span>
                            <button type="button" class="btn-close btn-close-style" onclick="closeLetter(this)"></button>
                        </div>
                        <div class="d-flex justify-content-end">
                        <span class="fw-500" data-letter-price>
                            <fmt:formatNumber value="${productVo.letterPrice}" pattern="#,###원"/>
                        </span>
                        </div>
                    </div>
                </div> <!-- price-box-wrap 닫기 -->

                <!-- 무료배송일때만 붙는 badge -->
                <div class="d-flex justify-content-end mb-1 mt-3 me-2">
                    <c:if test="${not empty productVo.freeDeliveryMessage}">
                    <span class="badge rounded-pill price-box text-dark fw-500">
                        ${productVo.freeDeliveryMessage}
                    </span>
                    </c:if>
                </div>

                <!-- 총 주문금액 -->
                <div class="d-flex justify-content-end align-items-baseline me-2 mb-4">
                    <span class="me-3">총 주문금액</span>
                    <span id="totalPrice" class="fw-bold fs-3">
                    <fmt:formatNumber value="${productVo.finalPrice + productVo.letterPrice}" pattern="#,###원"/>
                </span>
                </div>

                <!-- 장바구니/바로구매 버튼 -->
                <div class="d-flex justify-content-center mt-5">
                    <!-- 로그인 세션이 없을 때 장바구니를 클릭하면 -->
                    <c:if test="${empty sessionScope.member}">
                        <button type="button" class="btn sub-button fw-bold py-3 me-2"
                                data-bs-toggle="modal" data-bs-target="#loginModal">장바구니</button>
                        <!-- Modal -->
                        <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel2" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="loginModalLabel2">새늘봄의 회원이신가요?</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body fs-19 p-3 mb-5">
                                        로그인 이후 이용 가능한 서비스입니다.<br>로그인 화면으로 이동하시려면 '이동'을 눌러주세요.
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-dark fs-19" onclick="location.href='/login'">이동</button>
                                        <button type="button" class="btn btn-secondary fs-19" data-bs-dismiss="modal">닫기</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <!-- 로그인 세션이 있을 때 장바구니를 클릭하면 -->
                    <c:if test="${not empty sessionScope.member}">
                    <button type="button" class="btn sub-button fw-bold py-3 me-2" onclick="addCart()">장바구니</button>
                    </c:if>

                <%--memberId, category, productIdx, image, fsize 임의로 넣어주기--%>
                    <c:if test="${not empty sessionScope.member}">
                        <input type="hidden" name="memberId" value="${sessionScope.member.id}">
                    </c:if>
                    <c:if test="${empty sessionScope.member}">
                        <input type="hidden" name="memberId" value="">
                    </c:if>
                    <input type="hidden" name="category" value="소품샵">
                    <input type="hidden" name="productIdx" value="${productVo.idx}" id="productIdx">
                    <input type="hidden" name="image" value="${productVo.image1}">
                    <input type="hidden" id="fsize" name="fsize" value="${productVo.fsize}">
                <%----------------------------------------------------------------%>

                    <!-- 로그인 세션이 없을 때 바로구매를 클릭하면 -->
                    <c:if test="${empty sessionScope.member}">
                        <button type="button" class="btn main-button fw-bold py-3" data-bs-toggle="modal"
                                data-bs-target="#loginModal">바로구매</button>
                        <!-- Modal -->
                        <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel3" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="loginModalLabel3">새늘봄의 회원이신가요?</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body fs-19 p-3 mb-5">
                                        로그인 이후 이용 가능한 서비스입니다.<br>로그인 화면으로 이동하시려면 '이동'을 눌러주세요.
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-dark fs-19" onclick="location.href='/login'">이동</button>
                                        <button type="button" class="btn btn-secondary fs-19" data-bs-dismiss="modal">닫기</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <!-- 로그인 세션이 있을 때 바로구매를 클릭하면 -->
                    <c:if test="${not empty sessionScope.member}">
                    <button type="button" class="btn main-button fw-bold py-3" onclick="goPay(this.form)">바로구매</button>
                    </c:if>

                    <!-- 수령일 미선택시 뜨는 Modal -->
                    <div>
                        <button type="button" class="visually-hidden btn main-button fw-bold py-3" data-bs-toggle="modal"
                                data-bs-target="#chkModal" id="chkModalBtn"></button>
                        <!-- Modal -->
                        <div class="modal fade" id="chkModal" tabindex="-1" aria-labelledby="chkModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="chkModalLabel">수령일을 선택해주세요.</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body fs-19 p-3 mb-5">
                                        희망하는 수령일을 선택해주세요.<br>선택 후 결제 페이지로 이동할 수 있습니다.
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary fs-19" data-bs-dismiss="modal">닫기</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

            </div> <!-- 주문 정보 닫기 -->
        </div> <!-- 상품 썸네일 & 주문 정보 닫기 -->

        <!-- 상품설명/리뷰/배송안내 Tabs -->
        <div class="d-flex showType-wrap">
            <label class="col-4">
                <input type="radio" name="showType" class="d-none" id="showTypeContent" checked="">
                <span class="d-block text-center p-3 btn-show" onclick="animateScroll('#detail-area')">상품설명</span>
            </label>
            <label class="col-4">
                <input type="radio" name="showType" class="d-none">
                <span class="d-block text-center p-3 btn-show" onclick="animateScroll('#review-area')">리뷰</span>
            </label>
            <label class="col-4">
                <input type="radio" name="showType" class="d-none">
                <span class="d-block text-center p-3 btn-show" onclick="animateScroll('#delivery-area')">배송안내</span>
            </label>
        </div>

        <!-- 상품설명 -->
        <div id="detail-area" class="overflow-auto d-flex justify-content-center mb-5">
            <div class="mx-auto text-center">${productVo.content}</div>
        </div>

        <!-- 리뷰게시판 -->
        <div id="review-area" class="p-3">
            <!-- 리뷰게시판 타이틀 -->
            <div class="d-flex justify-content-between align-items-end">
                <div class="d-flex align-items-baseline">
                    <span class="fs-2 fw-500 py-3 pe-5">리뷰</span>
                    <span class="fs-5 c-666">리뷰 작성 시 200P 적립 (사진 등록 시 300P)</span>
                </div>
                <!-- 리뷰작성이 가능한 케이스 -->
                <c:if test="${not empty oitemList}">
                <c:forEach var="oitemVo" items="${oitemList}" varStatus="status">
                <c:if test="${status.index == 0}">
                <input type="hidden" name="oitemIdx" value="${oitemVo.idx}" id="oitemIdx">
                <span class="fs-17"><a class="fw-500" data-bs-toggle="modal" href="#reviewPossible" role="button">리뷰 쓰기</a></span>
                    <div class="modal fade" id="reviewPossible" aria-hidden="true" aria-labelledby="..." tabindex="-1">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="fs-19 p-5 mb-5">
                                    ${sessionScope.member.name} 고객님께서는 이미 해당 상품을<br>
                                    구매하신 이력이 있습니다.<br><br>
                                    상품이 마음에 드셨나요?<br><br>
                                    리뷰를 작성해주시면 200포인트를 적립해드려요.<br>
                                    (사진 첨부시 +100P!)
                                </div>
                                <div class="modal-footer">
                                    <!-- Toggle to second dialog -->
                                    <button class="btn btn-dark fs-19" data-bs-target="#writingReview" data-bs-toggle="modal"
                                            data-bs-dismiss="modal">리뷰 쓰기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Second modal dialog (리뷰 쓰기 창) -->
                    <div class="modal fade " id="writingReview" tabindex="-1" aria-labelledby="writingReviewLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered ">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="writingReviewLabel">리뷰 쓰기</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form>
                                        <!-- 리뷰 제목-->
                                        <div class="mb-3">
                                            <label for="review-title" class="col-form-label">리뷰 제목</label>
                                            <input type="text" class="form-control" id="review-title" autocomplete="off">
                                        </div>
                                        <!-- 사진 첨부 -->
                                        <div class="mb-3">
                                            <label for="review-file" class="col-form-label">사진 첨부</label>
                                            <input type="file" class="form-control text-secondary" id="review-file" aria-describedby="inputGroupFileAddon04" aria-label="Upload">
                                        </div>
                                        <!-- 리뷰 내용 -->
                                        <div class="mb-3">
                                            <label for="review-content" class="col-form-label">내용</label>
                                            <textarea class="form-control" id="review-content" rows="5"></textarea>
                                        </div>
                                        <!-- 별점 선택하기 -->
                                        <div class="mb-3">
                                            <label for="review-star" class="col-form-label">별점</label>
                                            <div class="d-flex btn-group text-warning fs-2 ps-3 pb-1" role="group" id="review-star">
                                                <label class="btn-radio">
                                                    <input type="radio" class="btn-check" name="starPoint" value="1" autocomplete="off">
                                                    <i class="fas fa-star"></i>
                                                </label>
                                                <label class="btn-radio">
                                                    <input type="radio" class="btn-check" name="starPoint" value="2" autocomplete="off">
                                                    <i class="fas fa-star"></i>
                                                </label>
                                                <label class="btn-radio">
                                                    <input type="radio" class="btn-check" name="starPoint" value="3" autocomplete="off">
                                                    <i class="fas fa-star"></i>
                                                </label>
                                                <label class="btn-radio">
                                                    <input type="radio" class="btn-check" name="starPoint" value="4" autocomplete="off">
                                                    <i class="fas fa-star"></i>
                                                </label>
                                                <label class="btn-radio">
                                                    <input type="radio" class="btn-check" name="starPoint" value="5" autocomplete="off" checked>
                                                    <i class="fas fa-star"></i>
                                                </label>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-dark fs-19" onclick="addReview()">리뷰 등록하기</button>
                                    <button type="button" class="btn btn-secondary fs-19" data-bs-dismiss="modal">닫기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
                </c:forEach>
                </c:if>
                <!-- 구매이력이 없어 리뷰 작성 불가 -->
                <c:if test="${empty oitemList && not empty sessionScope.member}">
                    <span class="fs-17"><a href="#" class="fw-500" data-bs-toggle="modal" data-bs-target="#reviewImpossible">리뷰 쓰기</a></span>
                    <!-- Modal -->
                    <div class="modal fade" id="reviewImpossible" tabindex="-1" aria-labelledby="reviewImpossibleLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="reviewImpossibleLabel">리뷰 작성 불가</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body fs-19 p-3 mb-5">
                                    상품 구매가 확정된 후 이용가능한 서비스입니다.<br>
                                    구매 후 리뷰를 작성해주시면 포인트를 드립니다.
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-dark fs-19" data-bs-dismiss="modal">계속 쇼핑</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
                <!-- 로그인 세션이 없어 리뷰 작성 불가 -->
                <c:if test="${empty sessionScope.member}">
                    <span class="fs-17"><a href="#" class="fw-500" data-bs-toggle="modal" data-bs-target="#loginModal">리뷰 쓰기</a></span>
                    <!-- Modal -->
                    <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="loginModalLabel">새늘봄의 회원이신가요?</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body fs-19 p-3 mb-5">
                                    로그인 이후 이용 가능한 서비스입니다.<br>로그인 화면으로 이동하시려면 '이동'을 눌러주세요.
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-dark fs-19" onclick="location.href='/login'">이동</button>
                                    <button type="button" class="btn btn-secondary fs-19" data-bs-dismiss="modal">닫기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>

            <!-- 리뷰 카테고리 -->
            <div class="d-flex align-items-baseline review-category col-12">
                <label>
                    <input type="radio" name="reviewCategory" class="d-none" checked="" onclick="switchCategory('#thisReview', '#bestReview')">
                    <span class="d-block text-center py-3 px-4 btn-rev">소품샵 베스트 리뷰</span>
                </label>
                <label>
                    <input type="radio" name="reviewCategory" class="d-none" onclick="switchCategory('#bestReview', '#thisReview')" id="thisReviewRadio">
                    <span class="d-block text-center py-3 px-4 btn-rev">이 상품의 리뷰</span>
                </label>
            </div>

            <!-- 소품샵 베스트 리뷰 게시판 -->
            <div id="bestReview">
                <c:forEach var="bestReviewVo" items="${bestReviewList}">
                    <c:if test="${not empty bestReviewVo}">
                        <div class="review-item">
                            <div class="accordion-header" id="best${bestReviewVo.idx}">
                                <div class="collapsed d-flex justify-content-between p-4 bb-1 review-row"
                                     data-bs-toggle="collapse" data-bs-target="#bestContent${bestReviewVo.idx}"
                                     aria-expanded="false" aria-controls="bestContent${bestReviewVo.idx}">
                        <span class="col-2 fs-17 c-star ls-narrower">
                            <c:forEach begin="1" end="5" var="count">
                                <c:set var="halfStar" value="${true}"/>
                                <c:if test="${bestReviewVo.star >= count}">
                                    <c:set var="faClassName" value="fas fa-star"/>
                                </c:if>
                                <c:if test="${bestReviewVo.star < count}">
                                    <c:set var="faClassName" value="far fa-star"/>
                                    <c:if test="${bestReviewVo.star + 1 > count and bestReviewVo.star % 1 > 0 and halfStar}">
                                        <c:set var="halfStar" value="${false}"/>
                                        <c:set var="faClassName" value="fas fa-star-half-alt"/>
                                    </c:if>
                                </c:if>
                                <i class="${faClassName} fs-6"></i>
                            </c:forEach>
                        </span>
                                    <span class="col-5 fs-17">
                            ${bestReviewVo.name}
                            <c:if test="${not empty bestReviewVo.image}">
                                <span class="c-bbb ms-2"><i class="fas fa-images"></i></span>
                            </c:if>
                        </span>
                                    <span class="col-2 text-center c-666 fw-light">${bestReviewVo.memberId.substring(0,4)}***님</span>
                                    <span class="col-2 text-center c-666 fw-light">${bestReviewVo.regDate.substring(0,10)}</span>
                                </div>
                            </div>
                            <div id="bestContent${bestReviewVo.idx}" class="accordion-collapse collapse border-0" aria-labelledby="best${bestReviewVo.idx}"
                                 data-bs-parent="#bestReview">
                                <div class="accordion-body bb-1">
                                    <div class="col-5 d-flex flex-column ms-13">
                                        <c:if test="${not empty bestReviewVo.image}">
                                            <img src="${bestReviewVo.image}" alt="image" class="col-9">
                                        </c:if>
                                        <div class="my-4">
                                                ${bestReviewVo.content}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div> <!-- #bestReview 닫기 -->

            <!-- 이 상품의 리뷰 게시판 -->
            <div id="thisReview" class="d-none">
                <div id="thisReviewBox">
                    <c:forEach var="thisReviewVo" items="${thisReviewList}">
                        <c:if test="${not empty thisReviewVo}">
                            <div class="review-item">
                                <div class="accordion-header" id="this${thisReviewVo.idx}">
                                    <div class="collapsed d-flex justify-content-between p-4 bb-1 review-row"
                                         data-bs-toggle="collapse" data-bs-target="#thisContent${thisReviewVo.idx}"
                                         aria-expanded="false" aria-controls="thisContent${thisReviewVo.idx}">
                            <span class="col-2 fs-17 c-star ls-narrower">
                                <c:forEach begin="1" end="5" var="count">
                                    <c:set var="halfStar" value="${true}"/>
                                    <c:if test="${thisReviewVo.star >= count}">
                                        <c:set var="faClassName" value="fas fa-star"/>
                                    </c:if>
                                    <c:if test="${thisReviewVo.star < count}">
                                        <c:set var="faClassName" value="far fa-star"/>
                                        <c:if test="${thisReviewVo.star + 1 > count and thisReviewVo.star % 1 > 0 and halfStar}">
                                            <c:set var="halfStar" value="${false}"/>
                                            <c:set var="faClassName" value="fas fa-star-half-alt"/>
                                        </c:if>
                                    </c:if>
                                    <i class="${faClassName} fs-6"></i>
                                </c:forEach>
                            </span>
                                        <span class="col-5 fs-17">
                                ${thisReviewVo.name}
                                <c:if test="${not empty thisReviewVo.image}">
                                    <span class="c-bbb ms-2"><i class="fas fa-images"></i></span>
                                </c:if>
                            </span>
                                        <span class="col-2 text-center c-666 fw-light">${thisReviewVo.memberId.substring(0,4)}***님</span>
                                        <span class="col-2 text-center c-666 fw-light">${thisReviewVo.regDate.substring(0,10)}</span>
                                    </div>
                                </div>
                                <div id="thisContent${thisReviewVo.idx}" class="accordion-collapse collapse border-0" aria-labelledby="this${thisReviewVo.idx}"
                                     data-bs-parent="#thisReview">
                                    <div class="accordion-body bb-1">
                                        <div class="col-5 d-flex flex-column ms-13">
                                            <c:if test="${not empty thisReviewVo.image}">
                                                <img src="${thisReviewVo.image}" alt="image" class="col-9">
                                            </c:if>
                                            <div class="my-4">
                                                    ${thisReviewVo.content}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div> <!-- #thisReview 닫기 -->

        </div> <!-- 리뷰게시판 닫기 -->

        <!-- 배송안내 -->
        <div id="delivery-area" class="ps-3 my-4">
            <div class="fs-2 fw-500 py-3">배송안내</div>
            <div class="c-666 d-flex flex-column">
                <hr>
                <div class="fs-5 fw-500 mt-3">1. 배송 정보<br>1-1. 배송비 정책</div>
                <p>
                    [공통] 구매 금액 합산 30,000원 이상일 경우 배송비는 무료입니다.<br>
                    [유의사항] 정기구독 상품 및 일부 3만원 미만의 배송비 무료 상품은 구매금액 합산에 포함되지 않습니다.
                </p>

                <span class="fs-5 fw-500">1-2. 일반배송 (택배배송)</span>
                <p>
                    [배송일] 선택하신 수령일 전날 발송되어 해당 일에 수령합니다.<br>
                    [배송방법] 우체국 택배를 통해서 배송되며, 카카오톡 알림톡을 통해 주문하신 분께 송장 번호를 개별적으로 공지합니다.<br>
                    [배송지역]  전국 모든 지역에 배송이 가능합니다. (제주도 및 도서 산간 지역은 1~2일 늦어질 수 있습니다.)<br>
                    [배송시간] 택배로 배송 당일 정확한 배송 시간 안내는 어려운 점 양해 부탁드려요.<br>
                    해당 주소지에 평소 우체국택배 집배원님이 배송 가시는 시간에 받아보실 수 있습니다.
                </p>

                <span class="fs-5 fw-500">1-3. 새벽배송</span>
                <p>
                    [배송지역] 서울/경기 일부지역에만 제공되며, 섬/공단/학교/학교기숙사/병원/관공서는 배송이 불가합니다.<br>
                    [배송방법] 새벽배송 가능지역은 오전 7시 이전까지 작성하신 배송지로 배송되며, 그 외 지역은 일반배송 (택배배송)으로 발송됩니다.<br>
                    [배송시간] 오후 2시 이전 주문완료건에 대하여 다음날 오전 7시 이전까지 배송받을 수 있습니다.<br>
                    [배송비 정책] 새벽배송 가능지역일 경우, 추가비용없이 배송됩니다.<br>
                    [유의사항]<br>
                    - 새벽배송은 저온의 온도를 유지하기 위해 단열재 없이 배송됩니다.<br>
                    - 결제시, 공동현관 비밀번호 기입이 필수이며, 미기입시 1층 현관에 배송됩니다.
                </p>

                <span class="fs-5 fw-500">▶ 새벽배송 가능지역 ◀</span>
                <p>
                    1) 전지역 가능<br>
                    서울, 안양시, 부천시, 구리시, 성남시, 수원시, 광명시, 의정부시, 안산시, 시흥시 (안산/시흥 공단지역 제외)<br>
                    <br>
                    2) 일부지역가능<br>
                    <u>광주시</u>  오포읍<br>
                    <br>
                    <u>고양시</u><br>
                    덕양구 – 성사동(성사1~2동), 화정동(화정1~2동), 행신동(행신1~3동), 주교동, 토당동, 도내동, 삼송동, 원흥동, 흥도동, 능곡동, 행주동<br>
                    일산동구 – 장항동(장항1~2동), 마두동(마두1~2동), 백석동(백석1~2동), 식사동, 풍동, 중산동, 정발산동, 풍산동<br>
                    일산서구 – 일산동(일산1~3동), 주엽동(주엽1~2동), 가좌동, 덕이동, 대화동, 탄현동, 송산동, 송포동<br>
                    <br>
                    <u>과천시</u>   관문동 제외 전지역<br>
                    <br>
                    <u>용인시</u>   수지구 고기동, 처인구 제외 전지역<br>
                    <br>
                    <u>인천광역시</u>   계양구, 부평구, 남동구, 연수구, 미추홀구, 서구<br>
                    <br>
                    <u>하남시</u><br>
                    미사동(미사1~2동), 신장동(신장1~2동), 덕풍동(덕풍1~3동), 망월동, 선동, 풍산동, 창우동, 천현동, 학암동, 위례동<br>
                    <br>
                    <u>파주시</u><br>
                    금촌동(금촌1~3동), 운정1~3동, 야동동, 다율동, 와동동, 목동동, 동패동, 문발동, 야당동, 교하동<br>
                    <br>
                    <u>화성시</u><br>
                    병점동(병점1~2동), 동탄1~6동, 진안동, 반월동, 기산동, 능동, 반송동, 석우동, 영천동, 청계동, 오산동, 목동, 산척동<br>
                    <br>
                    <u>의왕시</u>   내손동(내손1~2동), 포일동, 오전동, 고천동<br>
                    <br>
                    <u>군포시</u>   군포1~2동, 산본동(산본1~2동), 금정동, 당동, 당정동, 부곡동, 광정동, 궁내동, 수리동, 재궁동, 오금동<br>
                    <br>
                    <u>김포시</u>   양촌읍, 고촌읍, 운양동, 장기동, 구래동, 마산동, 걸포동, 감정동, 사우동, 북변동, 풍무동<br>
                    <br>
                    <u>남양주시</u><br>
                    진전읍, 진건읍, 와부읍, 별내면, 퇴계원면, 다산동(다산1~2동), 별내동, 평내동, 호평동, 금곡동, 이패동, 도농동, 지금동
                </p>

                <span class="fs-5 fw-500">2. 교환 및 환불 정책</span>
                <p>
                    [결제 완료] 상태라면 언제든지 홈페이지 및 고객센터를 통해 해지 가능합니다. (마이페이지 > 주문내역)<br>
                    [발송 준비] 단계에서는 주문 내역 변경 및 주문 취소가 불가합니다.<br>
                    [배송 완료] 배송 이후에는 원칙적으로 환불이 불가하며, 100% happiness program에 따라<br>
                    꽃 신선도, 배송 상태(꽃 부러짐) 등 문제가 있는 경우에는 동일 꽃 혹은 동일 크기의 꽃으로 다시 보내드립니다.<br>
                    [기타] 무통장 결제의 환불은 주문취소요청이 확인된 날짜 기준으로 다음날(휴일 제외)에 일괄적으로 이루어집니다.
                </p>
            </div>
        </div> <!-- 배송안내 닫기 -->
    </form>
</div> <!-- #container 닫기 -->

<%@ include file="../main/footer.jspf"%>

<script>
    const letterOptionsEl = document.getElementsByName("letterOptions");
    const totalPriceEl = document.querySelector("#totalPrice");

    /* 별점 클릭하면 별 색깔 바뀌기 */
    let $stars = document.querySelectorAll("[name=starPoint]");
    let $starIcons = document.querySelectorAll("[name=starPoint] + i");
    for (const $star of $stars) {
        $star.onchange = function(){
            console.log(this.value);
            const starPoint = parseInt(this.value);
            $starIcons.forEach(($starIcon, index) => {
                let className = "fas fa-star";
                if (starPoint <= index) {
                    className = "far fa-star";
                }
                $starIcon.className = className;
            })
        }
    }

    /* template 만들기 */
    function htmlToElement(html) {
        const template = document.createElement("template");
        template.innerHTML = html.trim();
        return template.content.firstChild;
    }

    /* 편지 추가, 추가안함 */
    function checkRadioBtn(isAdded) {
        if (isAdded) { // 편지 추가 O
            letterOptionsEl[1].nextElementSibling.classList.remove("text-dark", "fw-500");
            letterOptionsEl[0].nextElementSibling.classList.add("text-dark", "fw-500");
            document.querySelector("#addLetter").classList.remove("d-none");
        } else { // 편지 추가 X
            letterOptionsEl[0].nextElementSibling.classList.remove("text-dark", "fw-500");
            letterOptionsEl[1].nextElementSibling.classList.add("text-dark", "fw-500");
            document.querySelector("#addLetter").classList.add("d-none");
        }
        configTotal();
    }

    /* 소품샵 상품 수량 증감 */
    function adjustQuantity(isUp) {
        const productQuantityEl = document.querySelector("[data-product-quantity]");
        let quantity = productQuantityEl.textContent;
        if (isUp) {
            quantity++;
        } else {
            if (quantity > 1) {
                quantity--;
            }
        }
        productQuantityEl.textContent = quantity;
        configTotal();
    }

    /* letterPriceBox 닫기 버튼 눌렀을 때 */
    function closeLetter() {
        document.querySelector("#addLetter").classList.add("d-none");
        document.querySelector("#withoutLetter").checked = true;
        checkRadioBtn(false);
    }

    /* 총 주문금액 계산하기 */
    function configTotal() {
        const $productFinalPrice = document.querySelector("[data-product-finalPrice]");
        const $productQuantity = document.querySelector("[data-product-quantity]");
        const $letterPrice = document.querySelector("[data-letter-price]");

        let productFinalPrice = $productFinalPrice.textContent.trim().replace("원", "").replaceAll(",", "");
        let productQuantity = $productQuantity.textContent;
        let letterPrice = $letterPrice.textContent.trim().replace("원", "").replaceAll(",", "");
        let totalPrice = productFinalPrice * productQuantity;

        if (letterOptionsEl[0].checked) {
            totalPrice += Number(letterPrice);
        }

        totalPriceEl.textContent = totalPrice.toLocaleString('ko-KR') + "원";
    }

    /* 수령일 선택 */
    $(function () {
        $('.datepicker').datepicker({
            autoclose: true,
            format: 'yyyy-mm-dd',
            showOtherMonths: false,
            startDate: 'noBefore',
            endDate: '+14d',
            setDate: 'today',
            todayHighlight: true,
            title: '원하시는 수령일을 설정해주세요.',
            language: 'ko'
        });
    })

    /* 장바구니 보내기 */
    async function addCart() {
        const $inputs = document.getElementsByTagName("input");
        const $productQuantity = document.querySelector("[data-product-quantity]");

        if ($inputs.requestDate.value == "") {
            document.getElementById("chkModalBtn").click();
            return;
        }

        const cartVo = {
            memberId: $inputs.memberId.value,
            category: $inputs.category.value,
            productIdx: $inputs.productIdx.value,
            quantity: $productQuantity.textContent,
            requestDate: $inputs.requestDate.value,
            letter: letterOptionsEl[0].checked ? 1 : 0,
        };

        const option = {
            method: 'post',
            body: JSON.stringify(cartVo),
            headers: {
                'Content-Type': 'application/json;charset=UTF-8'
            }
        }

        const response = await fetch("/api/carts", option);
        const result = await response.json();
        console.log(result);

        if (result) {
            location.href = "/cart/list";
        }
    }

    /* 바로구매 클릭 */
    function goPay(frm) {
        const $inputs = document.getElementsByTagName("input");

        if ($inputs.requestDate.value == "") {
            document.getElementById("chkModalBtn").click();
            return;
        }

        const oitemVoList = [
            {
                hasLetter: letterOptionsEl[0].checked,
                name: document.querySelector(".item-name").textContent,
                price: totalPriceEl.textContent.replace("원", "").replaceAll(",", ""),
                image: $inputs.image.value,
                requestDate: $inputs.requestDate.value,
                category: $inputs.category.value,
                quantity: document.querySelector("[data-product-quantity]").textContent,
                reviewCheck: 0,
                fsize: document.querySelector("#fsize").value,
                itemIdx: document.querySelector("#productIdx").value
            }
        ];

        let data = document.createElement("input");
        data.classList.add("visually-hidden");
        data.type = "text";
        data.name = "data";
        data.value = JSON.stringify(oitemVoList);

        // console.log("data.value: " + data.value);

        frm.appendChild(data);
        frm.action = "/order/letter";
        frm.submit();
    }

    /* 상품설명/리뷰/배송안내 탭 누르면 스크롤 이동 */
    function animateScroll(locationStr) {
        let headerHeight = document.querySelector("header").offsetHeight;
        let targetScrollVal = document.querySelector(locationStr).offsetTop;
        window.scrollTo({top:targetScrollVal - headerHeight, behavior:'smooth'});
    }

    /* 최상단으로 스크롤 이동 */
    function moveToTop() {
        window.scrollTo({
            top: 0,
            left: 0,
            behavior: 'smooth'
        });
        document.querySelector('#showTypeContent').checked = true;
    }

    /* 리뷰 카테고리(베스트리뷰/해당 상품리뷰) 탭으로 바꾸기 */
    function switchCategory(prev, next) {
        document.querySelector(prev).classList.add('d-none');
        document.querySelector(next).classList.remove('d-none');
        if (next === '#bestReview') {
            location.reload();
        }
    }

    /* 리뷰 쓰기 클릭했을 때 리뷰쓰기가 가능한지 체크 */
    async function chkAvailability() {
        const idx = ${productVo.idx};
        const option = {
            method: 'post',
            body: idx,
            headers: {
                'Content-Type': 'application/json;charset=UTF-8'
            }
        }
        const response = await fetch("/product/api/chkAvailability", option);
        const result = await response.json();
        console.log(result);

        if (result) {
            location.href = "/cart/list";
        }
    }

    /* 리뷰 등록하기 버튼 눌렀을 때 */
    async function addReview() {
        let star = document.querySelector("[name=starPoint]:checked").value;
        let name = document.querySelector("#review-title").value;
        let $image = document.querySelector("#review-file");
        let content = document.querySelector("#review-content").value;
        let productIdx = document.querySelector("#productIdx").value;
        let oitemIdx = document.querySelector("#oitemIdx").value;

        let formData = new FormData();

        formData.append('name', name);
        formData.append('productIdx', productIdx);
        formData.append('oitemIdx', oitemIdx);
        if ($image.files[0]) {
            formData.append('imageFile', $image.files[0]);
        }
        formData.append('content', content);
        formData.append('star', star);

        console.log(formData);

        let options = {
            method: 'post',
            body: formData
        };

        const $reviewModal = document.querySelector('#writingReview');
        let reviewModal = bootstrap.Modal.getInstance($reviewModal);

        fetch("/product/" + productIdx.toString() + "/reviews", options).then(response => {
            response.json().then(result => {
                console.log(result);
                const $newReview = makeReviewRow(result);
                const $thisReviewBox = document.querySelector("#thisReviewBox");
                $thisReviewBox.prepend($newReview);
                reviewModal.hide();
                animateScroll("#review-area");
                switchCategory('#bestReview', '#thisReview');
                document.getElementById('thisReviewRadio').checked = true;
            }).catch(err => {
                console.log(err);
            })
        }).catch(err => {
            console.log(err);
        })
    }

    /* 리뷰 등록한 뒤 리뷰 행 추가 */
    function makeReviewRow(rowObject) {
        const idx = rowObject.idx;
        const $accordionItem = htmlToElement("<div class='accordion-item'></div>");
        const $accordionHeader = htmlToElement("<div class='accordion-header' id='flush-heading" + idx + "' role='button'></div>");
        $accordionItem.appendChild($accordionHeader);

        // reviewList 영역에 들어갈 애들
        const $reviewList = htmlToElement('<div class="reviewList bb-1 review-row collapsed d-flex justify-content-between p-4 fs-5"' +
            ' data-bs-toggle="collapse" data-bs-target="#collapse' + idx + '"' +
            ' aria-expanded="false" aria-controls="collapse' + idx + '">');

        const $starSpan = htmlToElement('<span class="col-2 fs-17 c-star ls-narrower d-flex align-items-center"></span>')
        const star = rowObject.star;
        for (let i = 1; i <= 5; i++) {
            let className = "fas fa-star fs-6";
            if (star < i) {
                className = "far fa-star fs-6";
            }
            const $star = htmlToElement('<i class="' + className + ' pe-1"></i>')
            $starSpan.appendChild($star);
        }
        const $reviewImage = htmlToElement('<span class="col-5 fs-17">' + rowObject.name + '</span>')
        if (rowObject.image != null) {
            const $imageIcon = htmlToElement('<span class="c-bbb ms-2"><i class="fas fa-images"></i></span>')
            $reviewImage.appendChild($imageIcon);
        }
        const $memberId = htmlToElement('<span class="col-2 text-center fs-6 fw-light c-666">' + rowObject.memberId.substring(0, 4)+ '***님' + '</span>')
        const $regDate = htmlToElement('<span class="col-2 text-center fs-6 fw-light c-666">' + rowObject.regDate.substring(0, 10) + '</span>')

        $reviewList.append($starSpan, $reviewImage, $memberId, $regDate);
        $accordionHeader.appendChild($reviewList);
        // reviewList 끝

        let collapseHtml = '';
        collapseHtml += '<div id="collapse' + idx + '" class="accordion-collapse collapse border-0"' +
            '     aria-labelledby="flush-heading' + idx + '" data-bs-parent="#bestReview">';
        collapseHtml += '   <div class="accordion-body bb-1">';
        collapseHtml += '       <div class="col-5 d-flex flex-column ms-13">';
        if (rowObject.image) {
            collapseHtml += '       <img src="' + rowObject.image + '" alt="사진" class="col-9">';
        }
        collapseHtml += '           <div class="my-4">' + rowObject.content + '</div>';
        collapseHtml += '       </div>';
        collapseHtml += '   </div>';
        const $accordionCollapse = htmlToElement(collapseHtml);

        $accordionItem.appendChild($accordionCollapse);
        return $accordionItem;
    }


</script>
</body>
</html>
