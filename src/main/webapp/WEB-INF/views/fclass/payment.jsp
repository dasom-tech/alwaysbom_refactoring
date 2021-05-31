<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:choose>
    <c:when test="${memberVo.grade eq '데이지'}">
        <fmt:parseNumber var="discountPrice" integerOnly="true" value="0"/>
<%--        <c:set var="discountPrice" value="0"/>--%>
    </c:when>
    <c:when test="${memberVo.grade ne '데이지'}">
        <fmt:parseNumber var="discountPrice" integerOnly="true" value="${fclassVo.finalPrice * regCount * 0.02}"/>
<%--        <c:set var="discountPrice" value="${fclassVo.finalPrice * regCount * 0.02}"/>--%>
    </c:when>
</c:choose>
<fmt:parseNumber var="totalPrice" integerOnly="true" value="${fclassVo.finalPrice * regCount - discountPrice}"/>
<%--<c:set var="totalPrice" value="${fclassVo.finalPrice * regCount - discountPrice}"/>--%>

<html>
<head>
    <title>플라워클래스 결제</title>
    <%@ include file="../main/import.jspf"%>
    <style>
        .ps-hana {
            padding-left: 7rem;
            padding-right: 7rem;
        }
    </style>
</head>
<script>
    function usePoint() {
        const inputPointEl = document.querySelector("#input_my_point");
        const discountPointEl = document.querySelector("#pointHere");
        const finalPriceEl = document.querySelector("#finalPrice");
        const discountPointHiddenEl = document.querySelector("#discountPointHidden");
        const discountGradeEl = document.querySelector("#discountGradeHidden");
        const discountTotalPriceEl = document.querySelector("#discountTotalPriceHidden");

        /*let originalPrice = finalPriceEl.getAttribute("data-original-price");*/
        let originalPrice = finalPriceEl.dataset.originalPrice;
        let discountPoint;

        if (inputPointEl.value !== "" || inputPointEl.value.length > 0) {
            discountPoint = inputPointEl.value;
        } else {
            discountPoint = 0;
        }
        discountPointEl.textContent = '-' + discountPoint + ' 원';

        discountPointHiddenEl.value = discountPoint;
        discountGradeEl.value = ${discountPrice};
        let finalPrice = originalPrice - discountPoint;
        //discountPoint.setAttribute("discountPoint");
       // grade.setAttribute("discountGrade");
        finalPriceEl.textContent = finalPrice.toLocaleString('ko-KR') + " 원";
        discountTotalPriceEl.value= finalPrice;
    }

    function compareWithPoint(point) {
        if (point.value < 0) {
            alert("포인트는 0원 이상부터 사용 가능합니다.");
            point.value="";
        }
        if (point.value > ${memberVo.point}) {
            alert("${memberVo.name}님께서 사용 가능한 포인트는 <fmt:formatNumber value="${memberVo.point}" pattern="#,###"/> 입니다.")
            point.value="";
        }
    }
</script>
<body>
<%@ include file="../main/header.jspf" %>
<form action="/fclass/completePayment" method="post" id="container" class="d-flex flex-column align-items-center mx-auto bg-white p-2">

    <!-- 결제 단계 아이콘 -->
    <div class="rounded-circle h6 d-flex flex-column align-items-center justify-content-center"
         style="height: 130px; width: 130px; color: #6e6e6e; background-color: #e8e8e8">
        <span class="h5">1</span>
        <span class="fw-light">결제</span>
    </div>

    <!-- 상품 헤더 -->
    <div class="col-12 py-2 border-top border-2 border-dark d-flex text-center">
        <div class="col-3">수강일</div>
        <div class="col-6">클래스</div>
        <div class="col-3">수강료</div>
    </div>

    <!-- 상품 -->
    <div class="col-12 d-flex border-1 border-top ps-hana" style="height: 170px">
        <!-- 수강일 -->
        <div class="col-3 d-flex align-items-center text-start">
            <span>${scheduleVo.sdate}</span>
        </div>

        <!-- 클래스 내용 -->
        <div class="col-6 d-flex align-items-center">
            <div class="overflow-hidden" style="height:150px">
                <img src="${fclassVo.image1}" alt="이미지" width="160px;">
            </div>
            <div class="d-flex flex-column ps-2">
                <span>[ ${branchVo.name} ] ${fclassVo.category}_${fclassVo.name}</span>
                <span>수강인원 : ${regCount}</span>
                <span>수강시간 : ${scheduleVo.startTime} ~ ${scheduleVo.endTime}</span>
            </div>
        </div>

        <!-- 수강료 -->
        <div class="col-3 d-flex align-items-center justify-content-end">
            <span class="text-secondary"><fmt:formatNumber value="${fclassVo.finalPrice}" pattern="#,###"/> 원</span>
        </div>
    </div>

    <!-- 적립금 -->
    <div class="col-12 py-4 ps-hana d-flex align-items-center border-1 border-secondary border-top border-bottom">
        <span class="fw-bold me-1">적립금</span>
        <input type="number" id="input_my_point" autocomplete="off" class="mx-1 ps-3 border border-secondary btn-outline-white rounded-3" onkeyup="compareWithPoint(this)" onchange="compareWithPoint(this)" autocomplete="off">
        <button type="button" class="btn btn-sm btn-warning mx-1" onclick="usePoint()">적용</button>
        <span class="mx-1">* 사용 가능 포인트: <fmt:formatNumber value="${memberVo.point}" pattern="#,###"/></span>
    </div>

    <!-- 결제 금액 -->
    <div class="col-12 py-4 ps-hana d-flex flex-column border-1 border-secondary border-bottom">
        <div class="d-flex py-2">
            <span class="col-9">포인트할인</span>
            <input type="hidden" name="discountPoint" id="discountPointHidden" value="0">
            <span class="col-3 d-flex justify-content-end align-items-center" id="pointHere">
                <fmt:formatNumber value="0" pattern="-#,### 원"/>
            </span>
        </div>
        <div class="d-flex py-2">
            <span class="col-9">등급할인</span>
<%--            <span id="gradeDiscount" name="discountGrade">-<fmt:formatNumber value="0" pattern="#,###"/> 원</span>--%>
            <input type="hidden" name="discountGrade" id="discountGradeHidden" value="0">
            <span class="col-3 d-flex justify-content-end align-items-center" id="gradeDiscount">
                <fmt:formatNumber value="${discountPrice}" pattern="-#,### 원"/>
            </span>
        </div>
        <div class="d-flex py-2 h4 text-warning m-0">
            <span class="col-9">총 결제금액</span>
            <input type="hidden" name="discountTotalPrice" id="discountTotalPriceHidden" value="${totalPrice}">
            <span class="col-3 d-flex justify-content-end align-items-center" id="finalPrice" data-original-price="${totalPrice}">
                <fmt:formatNumber value="${totalPrice}" pattern="#,### 원"/>
            </span>
        </div>
    </div>

    <!-- 결제 수단 -->
    <div class="col-12 py-4 ps-hana d-flex flex-column border-1 border-bottom border-dark">
        <span>결제 수단 선택</span>
        <div class="d-flex pay-button-group">
            <label class="col-3">
                <input class="d-none" type="radio" name="payType" value="신용카드" autocomplete="off" checked>
                <span class="d-block btn-pay py-3 text-center">신용카드</span>
            </label>
            <label class="col-3">
                <input class="d-none" type="radio" name="payType" value="신용카드(직접입력)" autocomplete="off">
                <span class="d-block btn-pay py-3 text-center">신용카드(직접입력)</span>
            </label>
            <label class="col-3">
                <input class="d-none" type="radio" name="payType" value="무통장입금" autocomplete="off">
                <span class="d-block btn-pay py-3 text-center">무통장입금</span>
            </label>
            <label class="col-3">
                <input class="d-none" type="radio" name="payType" value="카카오페이" autocomplete="off">
                <span class="d-block btn-pay py-3 text-center">카카오페이</span>
            </label>
        </div>
        <!-- 결제 수단별 내용 영역 -->
        <div>
            <!-- 신용카드 내용 -->
            <div class="pay-content active p-4">
            </div>

            <!-- 신용카드(직접입력) 내용 -->
            <div class="pay-content">
                <div class="d-flex flex-column border-1 border-bottom border-secondary p-4">
                    <span>* 신용카드 정보를 직접 입력하여 간편하게 결제하실 수 있습니다.</span>
                    <span>* 꾸까에서는 절대 카드 정보를 직접 저장하지 않습니다.</span>
                    <span>* 나이스 정보통신의 결제 기능을 사용합니다.</span>
                    <span>* 기명 법인카드의 경우, 소유하신 분의 주민등록번호 앞자리를 입력해주세요.</span>
                    <span>* 무기명 법인카드의 경우, 사업자 등록번호를 입력해 주세요.</span>
                </div>
                <div class="d-flex flex-column p-4">
                    <div class="col-6">
                        <div>카드 번호</div>
                        <div class="d-flex align-items-center text-center">
                            <input type="text" style="width:23.875%">
                            <span style="width:1.5%">-</span>
                            <input type="text" style="width:23.875%">
                            <span style="width:1.5%">-</span>
                            <input type="text" style="width:23.875%">
                            <span style="width:1.5%">-</span>
                            <input type="text" style="width:23.875%">
                        </div>
                    </div>
                    <div class="col-6">
                        <div>유효 기간 (년/월)</div>
                        <div class="d-flex align-items-center text-center">
                            <select name="year" style="width:49.25%">
                            <c:forEach var="year" begin="2021" end="2035">
                                <option value="${year}">${year}</option>
                            </c:forEach>
                            </select>
                            <span style="width:1.5%">-</span>
                            <select name="month" style="width:49.25%">
                            <c:forEach var="month" begin="01" end="12">
                                <option value="${month}">${month}</option>
                            </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="col-6">
                        <div>주민등록번호 앞자리</div>
                        <div class="d-flex align-items-center text-center">
                            <input type="text" style="width:49.25%">
                        </div>
                    </div>
                    <div class="col-6">
                        <div>비밀번호 앞 두자리</div>
                        <div class="d-flex align-items-center text-center">
                            <input type="text" style="width:49.25%">
                        </div>
                    </div>
                </div>
            </div>

            <!-- 무통장입금 내용 -->
            <div class="pay-content p-4">
                <div class="d-flex flex-column">
                    <div class="col-6 d-flex align-items-center">
                        <span>입금자명</span>
                        <input type="text" class="mx-2" style="width:80px" aria-label="name" autocomplete="off">
                        <span>미기재시 주문자명으로 자동 반영</span>
                    </div>
                    <div class="py-4">
                        <span>* 주문 후 72시간동안 미 입금시 자동 주문 취소됩니다.</span>
                    </div>
                    <div>
                        <label>
                            <input type="radio" name="cashReceipt" value="individual">
                            <span>개인소득공제용</span>
                        </label>
                        <label class="mx-2">
                            <input type="radio" name="cashReceipt" value="business">
                            <span>사업자증빙용</span>
                        </label>
                        <label>
                            <input type="radio" name="cashReceipt" value="noApply" checked>
                            <span>미신청</span>
                        </label>
                    </div>
                </div>
            </div>

            <!-- 카카오페이 내용 -->
            <div class="pay-content p-4">
            </div>
        </div>
    </div>

    <!-- 버튼 영역 -->
    <div class="col-12 py-4 ps-hana d-flex flex-column">
        <input type="hidden" name="scheduleIdx" value="${scheduleVo.idx}">
        <input type="hidden" name="regCount" value="${regCount}">
        <input type="hidden" name="memberId" value="${memberVo.id}">
        <input type="hidden" name="payTotal" value="${fclassVo.price * regCount}">
       <%-- <input type="hidden" name="discountGrade" value="${discountPrice}">--%>
        <button type="button" class="col-3 align-self-end btn-pay bg-pay py-3" onclick="completePayment(this.form)">결제 하기</button>
    </div>
</form>
<%@ include file="../main/footer.jspf"%>
<script>
    let $payTypeList = document.querySelectorAll('.pay-button-group input[type="radio"]');
    let $payButtonContentList = document.querySelectorAll('.pay-content');

    async function completePayment(form) {
        //regCount가 scheduleVo에 있는 total - regcount 의 값보다 클 때 alert띄우고 다시입력하게 하기
        let scheduleIdx = form.scheduleIdx.value;
        let response = await fetch("/api/fclass/schedules/" + scheduleIdx);
        let result = await response.json();

        console.log(result);

        if (result.totalCount - result.regCount < form.regCount.value) {
            alert("수강등록 가능한 인원수를 초과하였습니다.");
        } else {
            form.submit();
        }

        //regCount가 scheduleVo에 있는 total - regcount 의 값보다 작을 때 결제완료 페이지로 넘기기
    }

    function getPayTypeIndex($payTypeList) {
        let result = -1;
        $payTypeList.forEach(function ($payType, payTypeIndex) {
            if ($payType.checked) {
                result = payTypeIndex;
            }
        });
        return result;
    }

    $payTypeList.forEach(function ($payType, payTypeIndex) {
        $payType.addEventListener("change", function () {
            $payButtonContentList.forEach(function ($payButtonContent, payButtonContentIndex) {
                if ($payButtonContent.classList.contains("active")) {
                    $payButtonContent.classList.remove("active");
                }

                if (payTypeIndex === payButtonContentIndex) {
                    $payButtonContent.classList.add("active");
                }
            });
        });
    });
</script>
</body>
</html>
<style>
    .btn-pay {
        background-color: white;
        border: 1px solid #dfdfdf;
        text-align: center;
        cursor: pointer;
    }

    :checked + .btn-pay {
        background-color: #3A3A3A;
        color: #FFFFFF;
    }

    .btn-pay:hover {
        background-color: #5A5A5A;
        color: #FFFFFF;
    }

    .pay-content {
        display: none;
    }

    .pay-content.active {
        display: flex;
        flex-direction: column;
    }

    .bg-pay {
        background-color: #3A3A3A;
        color: #FFFFFF;
    }
</style>