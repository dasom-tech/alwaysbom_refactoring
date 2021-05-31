<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
    <c:if test="${empty subsVo}">
        <title>정기구독 상품 등록</title>
    </c:if>
    <c:if test="${not empty subsVo}">
        <title>정기구독 상품 수정</title>
    </c:if>
    <%@ include file="../main/b_import.jspf"%>
    <link rel="stylesheet" href="/static/css/item/b_addForm.css">
    <script src="/static/ckeditor5-build-classic/ckeditor.js"></script>
</head>
<body>
<%@ include file="../main/b_header.jspf"%>
<div id="container" class="mx-auto">
<form method="post" enctype="multipart/form-data">

    <!-- 브레드크럼 (유저 이동경로) -->
    <nav id="bread-nav" style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
        <ol class="breadcrumb mb-xxl-5">
            <li class="breadcrumb-item" onclick="location.href='/admin/main'">관리자 홈</li>
            <li class="breadcrumb-item" onclick="location.href='/admin/subs'">정기구독 관리</li>
            <c:if test="${empty subsVo}">
                <li class="breadcrumb-item active" aria-current="page">정기구독 등록</li>
            </c:if>
            <c:if test="${not empty subsVo}">
                <li class="breadcrumb-item" onclick="location.href='/admin/subsList'">정기구독 조회</li>
                <li class="breadcrumb-item" disabled>${subsVo.name}</li>
                <li class="breadcrumb-item active" aria-current="page">상품 수정</li>
            </c:if>
        </ol>
    </nav>

    <!-- 1. 상품 이미지 등록 (이미지 3개 파일 업로드) -->
    <div class="fs-5 p-1 my-5 d-block border-bottom border-secondary">
        1. 상품 이미지 등록
        <span class="description text-danger ms-2">
            * 상품 사진은 가능하다면 고화질의 정방형 이미지로 올려주십시오.
        </span>
    </div>
    <div class="imgs d-flex justify-content-center">
        <div class="card overflow-hidden img-card" onclick="this.children.file.click()">
            <a href="#" class="w-100 h-100 btn btn-outline-dark
                               d-flex flex-column align-items-center justify-content-center">
                <i class="fa fa-plus h1"></i>
                <div>대표 이미지(필수)</div>
            </a>
            <input type="file" name="file" class="d-none" id="file1" onchange="preview(this, 'img1')">
            <c:if test="${empty subsVo}">
                <img src="" alt="사진" class="m-0 p-0 card-img-overlay d-none" id="img1">
            </c:if>
            <c:if test="${not empty subsVo}">
                <img src="${subsVo.image1}" alt="사진" class="m-0 p-0 card-img-overlay" id="img1">
                <input type="hidden" name="image1" value="${subsVo.image1}">
            </c:if>
        </div>
        <div class="card overflow-hidden img-card" onclick="this.children.file.click()">
            <a href="#" class="w-100 h-100 btn btn-outline-dark
                               d-flex flex-column align-items-center justify-content-center">
                <i class="fa fa-plus h1"></i>
                <div>서브 이미지(선택)</div>
            </a>
            <input type="file" name="file" class="d-none" id="file2" onchange="preview(this, 'img2')">
            <c:if test="${empty subsVo}">
                <img src="" alt="사진" class="m-0 p-0 card-img-overlay d-none" id="img2">
            </c:if>
            <c:if test="${not empty subsVo}">
                <c:if test="${not empty subsVo.image2}">
                <img src="${subsVo.image2}" alt="사진" class="m-0 p-0 card-img-overlay" id="img2">
                <input type="hidden" name="image2" value="${subsVo.image2}">
                </c:if>
                <c:if test="${empty subsVo.image2}">
                <img src="" alt="사진" class="m-0 p-0 card-img-overlay d-none" id="img2">
                </c:if>
            </c:if>
        </div>
        <div class="card overflow-hidden img-card" onclick="this.children.file.click()">
            <a href="#" class="w-100 h-100 btn btn-outline-dark
                               d-flex flex-column align-items-center justify-content-center">
                <i class="fa fa-plus h1"></i>
                <div>서브 이미지(선택)</div>
            </a>
            <input type="file" name="file" class="d-none" id="file3" onchange="preview(this, 'img3')">
            <c:if test="${empty subsVo}">
                <img src="" alt="사진" class="m-0 p-0 card-img-overlay d-none" id="img3">
            </c:if>
            <c:if test="${not empty subsVo}">
                <c:if test="${not empty subsVo.image3}">
                <img src="${subsVo.image3}" alt="사진" class="m-0 p-0 card-img-overlay" id="img3">
                <input type="hidden" name="image3" value="${subsVo.image3}">
                </c:if>
                <c:if test="${empty subsVo.image3}">
                <img src="" alt="사진" class="m-0 p-0 card-img-overlay d-none" id="img3">
                </c:if>
            </c:if>
        </div>
    </div>

    <!-- 2. 주요 정보 기입용 input 태그들 -->
    <div class="fs-5 p-1 my-5 d-block border-bottom border-secondary">2. 주요 정보</div>
    <div class="inputs-wrap mx-auto">
        <div class="row g-2">
            <!-- 상품명 입력 -->
            <div class="col-md">
                <div class="form-floating my-2">
                    <c:if test="${empty subsVo}">
                    <input type="text" name="name" class="form-control" id="itemName" placeholder="상품명 입력" autocomplete="off">
                    </c:if>
                    <c:if test="${not empty subsVo}">
                    <input type="text" name="name" class="form-control" id="itemName" placeholder="상품명 입력"
                           value="${subsVo.name}" autocomplete="off">
                    </c:if>
                    <label for="itemName">상품명 (한글 50자 미만)</label>
                </div>
            </div>
        </div>
        <div class="row g-2">
            <!-- 상품 가격 -->
            <div class="col-md">
                <div class="form-floating my-2">
                    <c:if test="${empty subsVo}">
                        <input type="text" name="price" class="form-control text-end"
                               id="itemPrice" placeholder="가격" onchange="calculate()" autocomplete="off">
                    </c:if>
                    <c:if test="${not empty subsVo}">
                        <input type="text" name="price" class="form-control text-end" value="${subsVo.price}"
                               id="itemPrice" placeholder="가격" onchange="calculate()" autocomplete="off">
                    </c:if>
                    <label for="itemPrice">상품 가격</label>
                </div>
            </div>
            <!-- 꽃 사이즈 선택 S/M/L/XL -->
            <div class="col-md">
                <div class="form-floating my-2">
                    <c:if test="${empty subsVo}">
                    <select name="fsize" id="selectFsize" class="form-select p-2 ps-3" aria-label="form-select example">
                        <option>정기구독 꽃 사이즈 선택</option>
                        <option value="S">S</option>
                        <option value="M">M</option>
                        <option value="L">L</option>
                        <option value="XL">XL</option>
                    </select>
                    </c:if>
                    <c:if test="${not empty subsVo}">
                        <select name="fsize" id="selectFsize" class="form-select p-2 ps-3" aria-label="form-select example">
                            <option value="${subsVo.fsize}">${subsVo.fsize}</option>
                            <option value="S">S</option>
                            <option value="M">M</option>
                            <option value="L">L</option>
                            <option value="XL">XL</option>
                        </select>
                    </c:if>
                </div>
            </div>
        </div>
            <!-- 서브헤더 입력 -->
        <div class="row g-2">
            <div class="col-md">
                <div class="form-floating my-2">
                    <c:if test="${empty subsVo}">
                    <input type="text" name="subheader" class="form-control" id="itemSubheader" placeholder="한줄 설명" autocomplete="off">
                    </c:if>
                    <c:if test="${not empty subsVo}">
                    <input type="text" name="subheader" class="form-control" id="itemSubheader" placeholder="한줄 설명"
                           value="${subsVo.subheader}" autocomplete="off">
                    </c:if>
                    <label for="itemSubheader">한줄 설명 (한글 100자 미만)</label>
                </div>
            </div>
        </div>
            <!-- summary -->
            <div class="row g-2">
                <div class="col-md-12">
                    <div class="form-floating my-2">
                        <c:if test="${empty subsVo.summary}">
                        <textarea class="form-control" name="summary" placeholder="상품 개요(500자 미만)" id="floatingTextarea2" style="height: 120px"></textarea>
                        <label for="itemSubheader">상품 개요 (한글 500자 미만)</label>
                        </c:if>
                        <c:if test="${not empty subsVo.summary}">
                        <textarea class="form-control" name="summary" placeholder="상품 개요(500자 미만)" id="floatingTextarea2" style="height: 120px">${subsVo.summary}</textarea>
                        <label for="itemSubheader">상품 개요 (한글 500자 미만)</label>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

    <!-- inputs-wrap 닫기 -->


    <!-- 3. 상품 상세페이지 등록 (텍스트 에디터) -->
    <div class="fs-5 p-1 my-5 d-block border-bottom border-secondary">
        3. 상세 정보
    </div>
    <div class="text-editor-wrap d-flex justify-content-center mx-auto">
        <div class="col-12">
            <label class="form-label description text-danger" for="content">
                * 고객의 이해를 돕기 위해 상품 상세정보와 이미지를 함께 등록해주세요
            </label>
            <c:if test="${empty subsVo}">
            <textarea name="content" id="content"></textarea>
            </c:if>
            <c:if test="${not empty subsVo}">
            <textarea name="content" id="content">${subsVo.content}</textarea>
            </c:if>
        </div>
    </div>

    <div class="d-flex justify-content-center my-lg-5">
        <c:if test="${empty subsVo}">
        <input type="button" value="등록하기" class="btn btn-lg btn-dark py-lg-3 px-lg-5"
               onclick="goInsert(this.form)">
        </c:if>
        <c:if test="${not empty subsVo}">
        <input type="button" value="수정하기" class="btn btn-lg btn-dark py-lg-3 px-lg-5"
               onclick="goUpdate(this.form)">
        <input type="hidden" name="idx" value="${subsVo.idx}">
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

    /* 할인율에 따라 최종가격 정하는 함수. (아직 수정단계입니다) */
    function calculate() {
        let priceVal = document.querySelector("#itemPrice").value;
        let discountRateVal = document.querySelector("#discountRate").value;
        let finalPrice = document.querySelector("#finalPrice");
        let finalPriceVal;

        if (!discountRateVal) {
            finalPriceVal = "";
        } else {
            if (priceVal == null || priceVal.trim() === "") {
                finalPriceVal = "상품 가격을 입력해주세요";
                finalPrice.classList.add("text-danger", "description");
            }
            /*-- 추후 price 칸에 숫자만 입력할 수 있도록 조건 처리해야 함 --*/
            else {
                finalPrice.classList.remove("text-danger", "description");
                finalPriceVal =
                    Math.floor((100 - Number(discountRateVal)) * 0.01 * Number(priceVal)) + " 원";
                console.log("finalPriceVal : " + finalPriceVal);
            }
        }
        finalPrice.value = finalPriceVal;
    }

    /* 할인적용 체크박스 누르면 할인율 입력가능하게 변경 */
    function enableDiscountRateInput(chkBox) {
        let discountRate = document.querySelector("#discountRate");
        let finalPrice = document.querySelector("#finalPrice");

        if (chkBox.checked) {
            discountRate.toggleAttribute("disabled", false);
            finalPrice.toggleAttribute("disabled", false);
        } else {
            discountRate.toggleAttribute("disabled", true);
            finalPrice.toggleAttribute("disabled", true);
            discountRate.value = null;
            finalPrice.value = null;
            calculate();
        }
    }

    /* 체크박스 체크시 네모박스 bg 컬러 변경 */
    function changeBg(chkBox) {
        if (chkBox.checked) {
            chkBox.classList.add("bg-dark");
        } else {
            chkBox.classList.remove("bg-dark");
        }
    }

    /* 폼데이터 전송후 창 이동 */
    function goInsert(frm) {
        frm.action = "/admin/addSubs";
        frm.submit();
    }
    function goUpdate(frm) {
        frm.action = "/admin/updateSubs/";
        frm.submit();
    }
</script>
<script src="/static/js/imageUploader.js"></script>
</body>
</html>
