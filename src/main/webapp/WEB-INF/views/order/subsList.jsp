<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>새늘봄 - 정기구독 내역조회</title>
    <%@ include file="../main/import.jspf" %>
    <link rel="stylesheet" href="/static/css/order/orderstyle_back.css">
</head>
<body>
<%@ include file="../main/header.jspf" %>
<div id="container" class="mx-auto d-flex flex-column user-select-none">
    <%@ include file="../member/mypage_header.jspf" %>
    <div class="h-85 d-flex">
        <%@ include file="../member/mypage_menu.jspf" %>
        <div class="col-10 border-info d-flex justify-content-center p-4">
            <div class="col-12 h-100" id="contentPane">
                <div class="h5 col-12 d-flex flex-column text-secondary">
                    <div class="d-flex">
                        <span class="fw-bold name-color">${sessionScope.member.name}</span>
                        <span>님의 정기구독 내역</span>
                        <hr>
                    </div>
                    <div id="ordersListContent" class="fs-6">
                        <!-- 담은 수만큼 생성 -->
                        <c:forEach var="order" items="${ordersList}" varStatus="status">
                            <ul id="o${order.idx}" class="d-flex flex-column list-unstyled m-0 p-0">
                                <li class="d-flex align-items-center border-bottom py-3 ps-4 bg-light">
                                    <div class="col-9 d-flex align-items-center">
                                        주문번호 : ${order.idx}
                                        <c:if test="${order.status eq '입금대기' || order.status eq '결제완료'}">
                                            <button data-order-idx="${order.idx}" type="button" class="btn btn-dark btn-sm" id="order-button" data-index="${status.index}" onclick="CancelOrder(this, ${status.index})">주문취소</button>
                                        </c:if>
                                        <c:if test="${order.status eq '주문취소'}">
                                            <button data-order-idx="${order.idx}" type="button" class="btn btn-dark btn-sm" id="order-button">취소요청중</button>
                                        </c:if>
                                        <c:if test="${order.status eq '배송중'}">
                                            <button data-order-idx="${order.idx}" type="button" class="btn btn-dark btn-sm" id="order-button" data-index="${status.index}" onclick="ConfirmOrder(this ,${status.index})">구매확정</button>
                                        </c:if>
                                    </div>
                                    <div class="col-3 d-flex justify-content-end pe-4">
                                        <span class="badge bg-secondary" id="order-date">주문일 : ${order.odate}</span>
                                    </div>
                                </li>
                                <c:forEach var="oitem" items="${ordersList.get(status.index).olist}" varStatus="nextStatus">
                                    <li class="d-flex border-bottom py-3 lh-base">
                                        <div style="background-color: white" class="col-7 d-flex lh-base">
                                            <div class="overflow-hidden">
                                                <a href="#" title="${oitem.name}">
                                                    <!-- <img src="images/0_1.png" class="rounded float-start" alt="..."> -->
                                                    <img src="${oitem.image}" class="image_size">
                                                </a>
                                            </div>
                                            <div class="d-flex flex-column ps-3">
                                                <span class="content_category"></span>
                                                <span class="name">[${oitem.category}] ${oitem.name}</span>
                                                <div>
                                                    <span class="fst-italic">수량 : </span>
                                                    <span>${oitem.quantity}</span>
                                                </div>
                                                <span>편지 ${empty oitem.letterContent ? "없음" : "추가"}</span>
                                                <div>
                                                    <span>옵션 : </span>
                                                    <c:forTokens items="${oitem.options}" delims="," var="option">
                                                        ${option}<br>
                                                    </c:forTokens>
                                                </div>
                                                <div>
                                                    <span>가격</span>
                                                    <span>
                                                        <fmt:formatNumber value="${oitem.price}" pattern="#,### 원"/>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div style="background-color: white" class="col-3 d-flex flex-column justify-content-end lh-base">
                                            <div>수령인 이름 : ${order.senderName}</div>
                                            <div class="fst-italic">수령인 연락처 : ${order.receiverPhone}</div>
                                            <br>
                                            <div>[수령 요청일] : ${oitem.requestDate}</div>
                                            <div>결제방법 : ${order.payType}</div>
                                            <br>
                                            <input type="hidden" id="orderStatus" value="${order.status}">
                                        </div>
                                        <div style="background-color: white" class="col-2 d-flex flex-column justify-content-center align-items-center lh-base">
                                            <div class="fw-bold" >
                                                <div>주문상태 <i class="fas fa-sort-down fs-2"></i></div>
                                                <span class="badge bg-warning text-dark ms-2 my-2" id="status" data-index="${status.index}">${order.status}</span>
                                            </div>
                                            <c:if test="${order.status eq '배송완료' and oitem.reviewCheck eq 0}">
                                                <div><button id="b${oitem.idx}" type="button" class="btn btn-secondary btn-sm" onclick="showReviewModal(this, '${oitem.category}', ${oitem.itemIdx}, ${oitem.idx})">리뷰작성</button></div>
                                            </c:if>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="../commons/reviewForm.jsp"%>
<script>
    //주문취소 -> 취소요청중
    function CancelOrder(btn, index) {
        const idx = btn.dataset.orderIdx;
        const option = {
            method: 'put',
            body: '주문취소',
            headers : {
                "Content-Type": "application/json;charset=utf-8"
            }
        }

        // 버튼 클릭시 -> 상태값(status)변경처리 + 숫자 변경
        fetch("/admin/api/orders/" + idx + "/status", option).then(response => {
            console.log(response);
            response.json().then(result => {
                console.log(result);
                if (result) {
                    alert("주문 취소 요청이 완료되었습니다. 관리자 승인 후 취소처리됩니다.");
                    document.querySelector("#status[data-index='" + index + "']").innerText = '주문취소';
                    document.querySelector("#order-button[data-index='" + index + "']").value = '취소요청중';
                    location.reload();
                    //document.querySelector("#status-text").innerText = '취소요청중';
                } else {
                    alert("실패입니다");
                }
            });
        });
    }

    //배송중 -> 배송완료
    function ConfirmOrder(btn, index) {
        const idx = btn.dataset.orderIdx;

        const option = {
            method: 'put',
            body: '배송완료',
            headers : {
                "Content-Type": "application/json;charset=utf-8"
            }
        }

        // 버튼 클릭시 -> 상태값(status)변경처리 + 숫자 변경
        fetch("/admin/api/orders/" + idx + "/status", option).then(response => {
            console.log(response);
            response.json().then(result => {
                console.log(result);
                if (result) {
                    alert("상품을 받으셨나요? 리뷰를 작성해주세요.");
                    document.querySelector("#status[data-index='" + index + "']").innerText = '배송완료';
                    document.querySelector("#order-button[data-index='" + index + "']").innerText = '배송완료';
                    location.reload();
                } else {
                    alert("실패입니다");
                }
            });
        });
    }
</script>
</body>
<%@ include file="../main/footer.jspf" %>
</html>