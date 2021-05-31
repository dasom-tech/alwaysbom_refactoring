<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:forEach var="order" items="${orders}">
    <li class="d-flex border p-3 small">
        <!-- 클래스 사진 -->
        <div class="col-2 d-flex justify-content-center align-items-center">
            <div class="overflow-hidden" style="width: 90px; height: 90px">
                <a href="/fclass/classList/${order.fclassIdx}">
                    <img src="${order.fclassImage}" alt="사진" width="90px">
                </a>
            </div>
        </div>

        <!-- 입금상태에 따른 안내문구 -->
        <div class="col-6 d-flex flex-column justify-content-center align-items-baseline">
            <a href="/fclass/classList/${order.fclassIdx}" class="link-dark fs-6 text-decoration-none">${order.fclassName}</a>
            <div class="d-flex border-bottom border-1 border-warning col-12">
                <span class="pe-2"><fmt:formatNumber value="${order.discountTotalPrice}" pattern="#,### 원"/></span>
                <span class="text-secondary">${order.status}</span>
            </div>
            <c:if test="${order.status eq '입금대기'}">
                <span class="pt-2">입금이 확인되면 예약이 완료됩니다. 감사합니다.</span>
            </c:if>
            <c:if test="${order.status eq '결제완료'}">
            <span class="pt-2">
                클래스에 대한 궁금한점이 있으시면
                <a href="#" class="link-danger">1:1 문의게시판</a>
                을 이용해주세요!
            </span>
            </c:if>
        </div>

        <!-- 지점 및 수업일시 -->
        <div class="d-flex justify-content-center" style="width: 23%;">
            <div class="d-flex flex-column">
                <span>지점 | ${order.branchName}</span>
                <span>수강시작일</span>
                <span>${order.scheduleDate}</span>
                <span>수업시간</span>
                <span>${order.scheduleStartTime} ~ ${order.scheduleEndTime}</span>
            </div>
        </div>

        <!-- 리뷰링크 -->
        <div id="o${order.idx}" class="d-flex justify-content-center align-items-center" style="width: 10.33333333%">
            <c:if test="${order.status eq '결제완료' and order.reviewCheck eq 0}" >
                <input type="hidden" value="${order.idx}" id="oclassIdx">
                <input type="hidden" value="${order.fclassIdx}" id="fclassIdx">
            <a id="b${order.idx}" class="btn btn-sm btn-light px-3 py-2" onclick="showReviewModal(this, '클래스', ${order.fclassIdx}, ${order.idx})">리뷰쓰기</a>
            </c:if>
        </div>
    </li>
</c:forEach>
