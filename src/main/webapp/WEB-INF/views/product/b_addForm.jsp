<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
    <c:if test="${empty productVo}">
    <title>소품샵 상품 등록</title>
    </c:if>
    <c:if test="${not empty productVo}">
    <title>소품샵 상품 수정</title>
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
            <li class="breadcrumb-item" onclick="location.href='/admin/product'">소품샵 관리</li>
            <c:if test="${empty productVo}">
            <li class="breadcrumb-item active" aria-current="page">상품 등록</li>
            </c:if>
            <c:if test="${not empty productVo}">
            <li class="breadcrumb-item" onclick="location.href='/admin/productList'">상품 조회</li>
            <li class="breadcrumb-item active" aria-current="page">${productVo.name}</li>
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
            <c:if test="${empty productVo}">
            <img src="" alt="사진" class="m-0 p-0 card-img-overlay d-none" id="img1">
            </c:if>
            <c:if test="${not empty productVo}">
                <img src="${productVo.image1}" alt="사진" class="m-0 p-0 card-img-overlay" id="img1">
                <input type="hidden" name="image1" value="${productVo.image1}">
            </c:if>
        </div>
        <div class="card overflow-hidden img-card" onclick="this.children.file.click()">
            <a href="#" class="w-100 h-100 btn btn-outline-dark
                               d-flex flex-column align-items-center justify-content-center">
                <i class="fa fa-plus h1"></i>
                <div>서브 이미지(선택)</div>
            </a>
            <input type="file" name="file" class="d-none" id="file2" onchange="preview(this, 'img2')">
            <c:if test="${empty productVo}">
            <img src="" alt="사진" class="m-0 p-0 card-img-overlay d-none" id="img2">
            </c:if>
            <c:if test="${not empty productVo}">
                <c:if test="${not empty productVo.image2}">
                <img src="${productVo.image2}" alt="사진" class="m-0 p-0 card-img-overlay" id="img2">
                <input type="hidden" name="image2" value="${productVo.image2}">
                </c:if>
                <c:if test="${empty productVo.image2}">
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
            <c:if test="${empty productVo}">
            <img src="" alt="사진" class="m-0 p-0 card-img-overlay d-none" id="img3">
            </c:if>
            <c:if test="${not empty productVo}">
                <c:if test="${not empty productVo.image3}">
                <img src="${productVo.image3}" alt="사진" class="m-0 p-0 card-img-overlay" id="img3">
                <input type="hidden" name="image3" value="${productVo.image3}">
                </c:if>
                <c:if test="${empty productVo.image3}">
                <img src="" alt="사진" class="m-0 p-0 card-img-overlay d-none" id="img3">
                </c:if>
            </c:if>
        </div>
    </div>

    <!-- 2. 주요 정보 기입용 input 태그들 -->
    <div class="fs-5 p-1 my-5 d-block border-bottom border-secondary">
        2. 주요 정보
    </div>
    <div class="inputs-wrap mx-auto">
        <div class="row g-2">
            <!-- 상품명 입력 -->
            <div class="col-md">
                <div class="form-floating my-2">
                    <c:if test="${empty productVo}">
                    <input type="text" name="name" class="form-control" id="itemName" placeholder="상품명 입력" autocomplete="off">
                    </c:if>
                    <c:if test="${not empty productVo}">
                    <input type="text" name="name" class="form-control" id="itemName" placeholder="상품명 입력"
                           value="${productVo.name}" autocomplete="off">
                    </c:if>
                    <label for="itemName">상품명 (한글 50자 미만)</label>
                </div>
            </div>
            <!-- 서브헤더 입력 -->
            <div class="col-md">
                <div class="form-floating my-2">
                    <c:if test="${empty productVo}">
                    <input type="text" name="subheader" class="form-control" id="itemSubheader" placeholder="한줄 설명" autocomplete="off">
                    </c:if>
                    <c:if test="${not empty productVo}">
                    <input type="text" name="subheader" class="form-control" id="itemSubheader" placeholder="한줄 설명"
                           value="${productVo.subheader}" autocomplete="off">
                    </c:if>
                    <label for="itemSubheader">한줄 설명 (한글 100자 미만)</label>
                </div>
            </div>
        </div>
        <div class="row g-2">
            <div class="col-md d-flex justify-content-between align-items-center">
                <!-- 화병/굿즈 라디오버튼 -->
                <div class="col-2 d-flex flex-column justify-content-center options-label">
                    <c:if test="${empty productVo}">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category"
                               id="cateVase1" value="vase" onclick="enableFsizeSelectBox(true)">
                        <label class="form-check-label" for="cateVase1">화병</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category"
                               id="cateGoods1" value="goods" onclick="enableFsizeSelectBox(false)">
                        <label class="form-check-label" for="cateGoods1">굿즈</label>
                    </div>
                    </c:if>
                    <c:if test="${not empty productVo}">
                        <c:if test="${productVo.category eq 'vase'}">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="category" checked
                                   id="cateVase2" value="vase" onclick="enableFsizeSelectBox(true)">
                            <label class="form-check-label" for="cateVase2">화병</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="category"
                                   id="cateGoods2" value="goods" onclick="enableFsizeSelectBox(false)">
                            <label class="form-check-label" for="cateGoods2">굿즈</label>
                        </div>
                        </c:if>
                        <c:if test="${productVo.category eq 'goods'}">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="category"
                                       id="cateVase3" value="vase" onclick="enableFsizeSelectBox(true)">
                                <label class="form-check-label" for="cateVase3">화병</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="category" checked
                                       id="cateGoods3" value="goods" onclick="enableFsizeSelectBox(false)">
                                <label class="form-check-label" for="cateGoods3">굿즈</label>
                            </div>
                        </c:if>
                    </c:if>
                </div>
                <!-- 화병일 경우 어울리는 꽃다발 사이즈 선택 (셀렉트 박스) -->
                <div class="form-floating my-2 col-10">
                    <c:if test="${empty productVo}">
                    <select name="fsize" class="form-select" id="itemSize" aria-label="itemSize" disabled>
                        <option>화병인 경우만 선택</option>
                        <option value="S">S</option>
                        <option value="M">M</option>
                        <option value="L">L</option>
                        <option value="XL">XL</option>
                    </select>
                    </c:if>
                    <c:if test="${not empty productVo}">
                        <c:if test="${empty productVo.fsize}">
                            <select name="fsize" class="form-select" id="itemSize" aria-label="itemSize" disabled>
                                <option>화병인 경우만 선택</option>
                                <option value="S">S</option>
                                <option value="M">M</option>
                                <option value="L">L</option>
                                <option value="XL">XL</option>
                            </select>
                        </c:if>
                        <c:if test="${not empty productVo.fsize}">
                        <select name="fsize" class="form-select" id="itemSize" aria-label="itemSize">
                            <c:if test="${productVo.fsize eq 'S'}">
                                <option>화병인 경우만 선택</option>
                                <option value="S" selected>S</option>
                                <option value="M">M</option>
                                <option value="L">L</option>
                                <option value="XL">XL</option>
                            </c:if>
                            <c:if test="${productVo.fsize eq 'M'}">
                                <option>화병인 경우만 선택</option>
                                <option value="S">S</option>
                                <option value="M" selected>M</option>
                                <option value="L">L</option>
                                <option value="XL">XL</option>
                            </c:if>
                            <c:if test="${productVo.fsize eq 'L'}">
                                <option>화병인 경우만 선택</option>
                                <option value="S">S</option>
                                <option value="M">M</option>
                                <option value="L" selected>L</option>
                                <option value="XL">XL</option>
                            </c:if>
                            <c:if test="${productVo.fsize eq 'XL'}">
                                <option>화병인 경우만 선택</option>
                                <option value="S">S</option>
                                <option value="M">M</option>
                                <option value="L">L</option>
                                <option value="XL" selected>XL</option>
                            </c:if>
                        </select>
                        </c:if>
                    </c:if>
                    <label for="itemSize">어울리는 꽃다발 사이즈</label>
                </div>
            </div>
            <!-- 상품 가격 -->
            <div class="col-md">
                <div class="form-floating my-2">
                    <c:if test="${empty productVo}">
                    <input type="text" name="price" class="form-control text-end"
                           id="itemPrice" placeholder="가격" onchange="calculate()">
                    </c:if>
                    <c:if test="${not empty productVo}">
                    <input type="text" name="price" class="form-control text-end" value="${productVo.price}"
                           id="itemPrice" placeholder="가격" onchange="calculate()" autocomplete="off">
                    </c:if>
                    <label for="itemPrice">상품 가격</label>
                </div>
            </div>
        </div>

        <div class="row g-3">
            <div class="options-label col-md-2 d-flex flex-column justify-content-center">
                <!-- 할인율 적용 라디오버튼 -->
                <div class="form-check form-check-inline">
                    <c:if test="${empty productVo}">
                    <input class="form-check-input" type="checkbox" id="discount"
                           onclick="enableDiscountRateInput(this); changeBg(this)">
                    </c:if>
                    <c:if test="${not empty productVo}">
                        <c:if test="${not empty productVo.discountRate && productVo.discountRate > 0}">
                        <input class="form-check-input" type="checkbox" id="discount" checked
                               onclick="enableDiscountRateInput(this); changeBg(this)">
                        </c:if>
                        <c:if test="${empty productVo.discountRate || productVo.discountRate <= 0}">
                        <input class="form-check-input" type="checkbox" id="discount"
                               onclick="enableDiscountRateInput(this); changeBg(this)">
                        </c:if>
                    </c:if>
                    <label class="form-check-label" for="discount">할인 적용하기</label>
                </div>
            </div>

            <!-- 할인율 입력 -->
            <div class="col-md-4">
                <div class="form-floating my-2">
                    <c:if test="${empty productVo}">
                    <input type="number" max="50" class="form-control" name="discountRate"
                           id="discountRate" placeholder="할인율" onchange="calculate()" disabled autocomplete="off">
                    </c:if>
                    <c:if test="${not empty productVo}">
                        <c:if test="${not empty productVo.discountRate && productVo.discountRate > 0}">
                        <input type="number" max="50" class="form-control" name="discountRate" placeholder="할인율"
                               value="${productVo.discountRate}" id="discountRate" onchange="calculate()" autocomplete="off">
                        </c:if>
                        <c:if test="${empty productVo.discountRate || productVo.discountRate <= 0}">
                        <input type="number" max="50" class="form-control" name="discountRate"
                               id="discountRate" placeholder="할인율" onchange="calculate()" disabled autocomplete="off">
                        </c:if>
                    </c:if>
                    <label for="discountRate">할인율 (숫자만 입력)</label>
                </div>
            </div>

            <!-- 할인 적용가 -->
            <div class="col-md-6">
                <div class="form-floating my-2">
                    <c:if test="${empty productVo}">
                    <input type="text" class="form-control text-end"
                           id="finalPrice" placeholder="할인 적용가" disabled readonly>
                    </c:if>
                    <c:if test="${not empty productVo}">
                        <c:if test="${not empty productVo.discountRate && productVo.discountRate > 0}">
                        <input type="text" class="form-control text-end" value="${productVo.finalPrice}"
                               id="finalPrice" placeholder="할인 적용가" readonly>
                        </c:if>
                        <c:if test="${empty productVo.discountRate || productVo.discountRate <= 0}">
                        <input type="text" class="form-control text-end"
                               id="finalPrice" placeholder="할인 적용가" disabled readonly>
                        </c:if>
                    </c:if>
                    <label for="finalPrice">할인 적용가</label>
                </div>
            </div>
        </div>
    </div> <!-- inputs-wrap 닫기 -->


    <!-- 3. 상품 상세페이지 등록 (텍스트 에디터) -->
    <div class="fs-5 p-1 my-5 d-block border-bottom border-secondary">
        3. 상세 정보
    </div>
    <div class="text-editor-wrap d-flex justify-content-center mx-auto">
        <div class="col-12">
            <label class="form-label description text-danger" for="content">
                * 고객의 이해를 돕기 위해 상품 상세정보와 이미지를 함께 등록해주세요
            </label>
            <c:if test="${empty productVo}">
            <textarea name="content" id="content"></textarea>
            </c:if>
            <c:if test="${not empty productVo}">
            <textarea name="content" id="content">${productVo.content}</textarea>
            </c:if>
        </div>
    </div>

    <div class="d-flex justify-content-center my-lg-5">
        <c:if test="${empty productVo}">
        <input type="button" value="등록하기" class="btn btn-lg btn-dark py-lg-3 px-lg-5"
               onclick="goInsert(this.form)">
        </c:if>
        <c:if test="${not empty productVo}">
        <input type="button" value="수정하기" class="btn btn-lg btn-dark py-lg-3 px-lg-5"
           onclick="goUpdate(this.form)">
        <input type="hidden" name="idx" value="${productVo.idx}">
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

    /* 카테고리 화병을 선택하면 어울리는 꽃 사이즈 셀렉트박스 선택할 수 있게 */
    function enableFsizeSelectBox(isVase) {
        let fsizeSelectBoxEl = document.querySelector("#itemSize");
        if (isVase) {
            fsizeSelectBoxEl.toggleAttribute("disabled", false);
        } else {
            fsizeSelectBoxEl.toggleAttribute("disabled", true);
        }
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
            else if (!parseInt(priceVal)) {
                finalPriceVal = "상품 가격에 숫자만 입력해주세요";
                finalPrice.classList.add("text-danger", "description");
            }
            else {
                finalPrice.classList.remove("text-danger", "description");
                finalPriceVal =
                    Math.floor((100 - Number(discountRateVal)) * 0.01 * Number(priceVal)).toLocaleString('ko-KR') + " 원";
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

    /* 유효성 검사 */
    function checkValidation(isInsert) {
        const $inputs = document.getElementsByTagName("input");
        const $options = document.querySelector('#itemSize').options;
        let isCategoryChecked = false;
        let isFsizeSelected = false;
        let cateVase = document.querySelectorAll(".form-check-input")[0];
        let cateGoods = document.querySelectorAll(".form-check-input")[1];

        if (cateVase.checked || cateGoods.checked) {
            isCategoryChecked = true;
        }

        if (cateVase.checked) {
            for (let i = 0; i < $options.length; i++) {
                if (i > 0 && $options[i].selected) {
                    isFsizeSelected = true;
                    break;
                }
            }
        } else if (cateGoods.checked) {
            isFsizeSelected = true;
        }

        let isValidate = true;
        if (isInsert) {
            if (!document.getElementById('file1').value) {
                alert("대표 이미지 하나는 필수로 업로드하셔야합니다.");
                isValidate = false;
            }
        }
        if (!$inputs.name.value) {
            alert("상품명을 입력해주세요.");
            isValidate = false;
        }
        else if (!$inputs.subheader.value) {
            alert("한줄 설명을 작성해주세요.");
            isValidate = false;
        }
        else if (!isCategoryChecked) {
            alert("카테고리를 지정해주세요.");
            isValidate = false;
        }
        else if (!isFsizeSelected) {
            alert("꽃다발의 사이즈를 선택해주세요.");
            isValidate = false;
        }
        else if (!$inputs.price.value) {
            alert("상품의 가격을 입력해주세요.");
            isValidate = false;
        }
        else if (!parseInt($inputs.price.value)) {
            alert("가격에 숫자가 아닌 문자열이 섞여 있습니다.");
            isValidate = false;
        }
        else if (!myEditor.getData()) {
            alert("상품을 상세설명을 입력해주세요.");
            isValidate = false;
        }
        return isValidate;
    }

    /* 폼데이터 전송후 창 이동 */
    function goInsert(frm) {
        if (checkValidation(true)) {
            frm.action = "/admin/addProduct";
            frm.submit();
        } else {
            return;
        }
    }
    function goUpdate(frm) {
        if (checkValidation(false)) {
            frm.action = "/admin/updateProduct";
            frm.submit();
        } else {
            return;
        }
    }

</script>
<script src="/static/js/imageUploader.js"></script>
</body>
</html>
