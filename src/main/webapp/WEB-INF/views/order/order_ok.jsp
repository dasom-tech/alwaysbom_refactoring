<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>새늘봄 - 주문완료</title>
    <%@ include file="../main/import.jspf"%>
    <link rel="stylesheet" href="/static/css/order/orderstyle.css">
</head>
<body>
<%@ include file="../main/header.jspf" %>
<%-- 오늘 날짜 구하기 --%>
<c:set var="today" value="<%=new java.util.Date()%>"/>
<c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd hh:mm:ss"/></c:set>
<section class="contents" id="contents" tabindex="0">

    <div id="root" data-app="payment">
        <div class="checkout_kukka_complete">
            <div class="inbox">
                <div class="checkout_note">
                    <h3 class="thank"><span class="name">${sessionScope.member.name}</span>님의 주문이 완료되었습니다.</h3>
                    <p class="desc fw-normal">새늘봄이 행복을 가득 담아 보내드릴게요!</p>
                    <p class="order_no fw-bold">${sessionScope.member.name} 님의 주문내역 입니다.</p>

                    <c:forEach var="oitem" items="${ordersList.get(status.index).olist}" varStatus="status">
                         <input type="hidden" id="category" value="${oitem.category}">
                    </c:forEach>

                    <c:if test="${ordersVo.payType == '무통장입금'}">
                    <!-- 계좌 입금시 -->
                    <dl class="bank_info">
                        <dt class="th">입금계좌 안내
                            <span>다음계좌로 입금해주시면 주문이 완료됩니다.</span>
                        </dt>
                        <dd class="td">
                             <span class="line"><b class="prop">주문번호</b>
                            <span class="val">#${ordersVo.idx}</span></span>
                            <span class="line"><b class="prop">계좌번호</b>
                            <span class="val">새늘은행 274-072066-01-041</span></span>
                            <span class="line">
                                <b class="prop">예금주</b><span class="val">(주)새늘봄</span></span>
                            <span class="line"><b class="prop">입금금액</b>
                                <span class="val"><fmt:formatNumber value="${ordersVo.payTotal}" pattern="#,###"/>원</span></span>
                            <span class="line"><b class="prop">보내시는분</b>
                                <span class="val">${ordersVo.mootongName}</span></span>
                            <span class="line"><b class="prop">입금기한</b>
                                <span class="val">다음날 오전 9시까지</span>
                            </span>
                        </dd>
                    </dl>
                    </c:if>

                    <!-- 카드 결제시 -->
                    <c:if test="${ordersVo.payType == '신용카드' || ordersVo.payType == '간편결제'}">
                        <dl class="bank_info">
                            <dt class="th">결제정보
                                <span>결제가 정상적으로 완료되었습니다.</span>
                            </dt>
                            <dd class="td">
                                <span class="line"><b class="prop">주문번호</b>
                                    <span class="val">#${ordersVo.idx}</span>
                                </span>
                                <span class="line"><b class="prop">결제타입</b>
                                    <span class="val">${ordersVo.payType}</span></span>
                                <span class="line"><b class="prop">결제금액</b>
                                    <span class="val"><fmt:formatNumber value="${ordersVo.payTotal}" pattern="#,###"/>원</span></span>
                                <span class="line"><b class="prop">결제날짜</b>
                                        <span class="val">${date}</span></span>
                            </dd>
                        </dl>
                    </c:if>
                    <p class="more fw-normal">상세내역은 아래 주문내역조회에서 확인하실 수 있습니다.</p>
                </div>
                <div class="checkout_next">
                    <div class="content_bottom_button">
                        <div class="bottom_row">
                            <div class="bottom_col">
                                <a href="/" class="bottom_button is_default">쇼핑 계속하기</a>
                            </div>
                            <div class="bottom_col">
                                <button type="button" class="bottom_button is_active" onclick="location.href='/orders/flowerList'">주문 내역 조회</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<%@ include file="../main/footer.jspf"%>
<script>
    // function orderList() {
    //     if (document.querySelector('#finalPayType').value == '') {
    //         location.href="/orders/subsList";
    //     }
    // }
</script>
</body>
</html>