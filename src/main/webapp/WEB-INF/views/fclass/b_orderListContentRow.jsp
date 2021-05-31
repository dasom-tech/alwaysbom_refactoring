<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<li id="o${order.idx}" class="d-flex border p-3 small">
    <!-- 클래스 사진 -->
    <div class="col-2 d-flex justify-content-center align-items-center">
        <div class="overflow-hidden" style="width: 90px; height: 90px">
            <a href="/fclass/classList/${order.fclassIdx}">
                <img src="${order.fclassImage}" alt="사진" width="90px">
            </a>
        </div>
    </div>

    <!-- 입금상태에 따른 안내문구 -->
    <div class="d-flex flex-column justify-content-center align-items-baseline col-6">
        <a href="/fclass/classList/${order.fclassIdx}" class="link-dark fs-6 text-decoration-none">${order.fclassName}</a>
        <div class="d-flex border-bottom border-1 border-warning col-12">
            <span class="pe-2"><fmt:formatNumber value="${order.discountTotalPrice}" pattern="#,### 원"/></span>
            <span class="text-secondary">${order.status}</span>
        </div>
        <span>주문자ID : ${order.memberId}</span>
        <span>등록인원 : ${order.regCount} 명</span>
        <span>클래스 횟수 : ${order.fclassCount} 회</span>
    </div>

    <!-- 지점 및 수업일시 -->
    <div class="col-3 d-flex justify-content-center">
        <div class="d-flex flex-column">
            <span>지점 | ${order.branchName}</span>
            <span>수강시작일</span>
            <span>${order.scheduleDate}</span>
            <span>수업시간</span>
            <span>${order.scheduleStartTime} ~ ${order.scheduleEndTime}</span>
        </div>
    </div>

    <!-- 입금확인 처리 -->
    <div class="col-1 d-flex flex-column justify-content-center align-items-center">
        <c:if test="${order.status eq '입금대기'}">
        <button type="button"
                class="btn btn-sm btn-light px-3 py-2 mb-2"
                data-order-idx="${order.idx}"
                onclick="updateStatus(this)">입금확인</button>
        <button type="button"
                class="btn btn-sm btn-danger px-3 py-2"
                data-order-idx="${order.idx}"
                onclick="deleteRow(this)">주문취소</button>
        </c:if>
    </div>
</li>
