<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>결제완료 페이지</title>
    <%@ include file="../main/import.jspf"%>
</head>
<body>
<%@ include file="../main/header.jspf" %>
<div id="container" class="mx-auto bg-warning d-flex flex-column pt-5">
    <div class="mt-5 mb-3 text-center">
        <h3 class="fw-bold my-4"><span>${member.name}</span>님의 클래스 예약 내역입니다.</h3>
        <span>새늘봄 클래스에서 봄을 만끽하세요!</span>
    </div>
    <form action="/admin/fclass/completePayment" method="post" id="contents" class="d-flex flex-column align-items-center">
        <div class="d-flex flex-column col-4 justify-content-center text-center">
            <div class="bg-light border px-2 py-3 mb-4" style="border-radius: 20px">
                ${member.name}님의 예약 정보
            </div>
            <div class="d-flex flex-column bg-light border rounded-3 p-4 mb-4">
                <c:if test="${order.payType eq '무통장입금'}">
                <div class="flex flex-column text-start mb-3">
                    <span class="d-block">입금계좌 안내</span>
                    <span>다음 계좌로 입금해주시면 예약이 완료됩니다.</span>
                </div>
                <div class="d-flex small fw-bold">
                    <div class="d-flex flex-column pe-3 text-start">
                        <span>계좌번호</span>
                        <span>예금주</span>
                        <span>입금금액</span>
                        <span>입금기한</span>
                    </div>
                    <div class="d-flex flex-column text-start">
                        <span>새늘봄은행 274-072066-01-041</span>
                        <span>(주)새늘봄</span>
                        <span><fmt:formatNumber value="${order.discountTotalPrice}" pattern="#,###원"/></span>
                        <span>주문일 기준 다음날 오전 9시까지</span>
                    </div>
                </div>
                </c:if>
                <c:if test="${order.payType ne '무통장입금'}">
                <div class="d-flex flex-column text-start mb-3">
                    <span>예약 안내</span>
                    <span>예약이 완료되었습니다!</span>
                </div>
                <div class="d-flex small fw-bold">
                    <div class="d-flex flex-column pe-3 text-start">
                        <span>클래스이름</span>
                        <span>지점명</span>
                        <span>입금금액</span>
                        <span>예약날짜</span>
                        <span>예약시간</span>
                    </div>
                    <div class="d-flex flex-column text-start">
                        <span>${order.fclassName}</span>
                        <span>${order.branchName}</span>
                        <span><fmt:formatNumber value="${order.discountTotalPrice}" pattern="#,###원"/></span>
                        <span>${order.scheduleDate}</span>
                        <span>${order.scheduleStartTime} ~ ${order.scheduleEndTime}</>
                    </div>
                </div>
                </c:if>
            </div>

        </div>

    </form>
    <div class="mt-2 text-center">
        <span>상세내역은 주문내역조회에서 확인하실 수 있습니다. </span>
    </div>
    <div class="pt-5 d-flex flex-column">
        <div class="d-flex justify-content-center">
            <div class="btns">
                <a href="/fclass/classList" class="btn btn-outline-dark">쇼핑 계속하기</a>
            </div>
            <div class="btns">
                <a href="/myPage" class="btn btn-outline-dark">클래스예약 조회</a>
            </div>
        </div>
    </div>
</div>
<%@ include file="../main/footer.jspf"%>

</body>
<style>
    .btns {
        width: 150px;
        cursor: pointer;
    }
    .btns:hover {
        color: whitesmoke;
    }
</style>
</html>
