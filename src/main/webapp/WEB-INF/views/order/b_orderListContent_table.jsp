<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 테이블 -->
<div class="order-lists">
    <span id="order-name">${searchOption.status} 목록</span>
</div>

<!-- 담은 수만큼 생성 -->
<c:forEach var="order" items="${ordersList}" varStatus="status">
    <table id="o${order.idx}" class="table">
        <thead>
        <tr>
            <th scope="col">
                주문번호 : ${order.idx}
                <c:if test="${order.status eq '입금대기'}">
                <button data-order-idx="${order.idx}" type="button" class="btn btn-dark btn-sm" id="order-button" onclick="payConfirm(this)">입금확인</button>
                </c:if>
                <c:if test="${order.status eq '주문취소'}">
                    <button data-order-idx="${order.idx}" type="button" class="btn btn-dark btn-sm" id="order-button" onclick="payCancel(this)">주문취소 승인</button>
                </c:if>
                <c:if test="${order.status eq '결제완료'}">
                    <button data-order-idx="${order.idx}" type="button" class="btn btn-dark btn-sm" id="order-button" onclick="departDelivery(this)">배송출발</button>
                </c:if>
            </th>
            <th scope="col">
                <span class="badge bg-secondary" id="order-date">주문일 : ${order.odate}</span>
            </th>
        </tr>
        </thead>

        <c:forEach var="oitem" items="${ordersList.get(status.index).olist}">
            <tbody>
            <tr>
                <td style="background-color: white" class="col-7">
                    <div class="photo">
                        <a href="#" class="img" title="폴인로즈 에디션">
                            <!-- <img src="images/0_1.png" class="rounded float-start" alt="..."> -->
                            <img src="${oitem.image}" class="image_size">
                        </a>
                    </div>
                    <div class="detail">
                        <span class="content_category"></span>
                        <span class="name">[${oitem.category}] ${oitem.name}</span>

                        <div class="option">
                            <span class="l"><span class="label"><i>수량 : </i>${oitem.quantity}</span></span>
                        </div>
                        <c:if test="${not empty oitem.letterContent}">
                            <div class="option">
                                <span class="l"><span class="label"><i></i>편지 추가</span></span>
                            </div>
                        </c:if>
                        <c:if test="${empty oitem.letterContent}">
                            <div class="option">
                                <span class="l"><span class="label"><i></i>편지 없음</span></span>
                            </div>
                        </c:if>
                        <div class="option">
                        <span class="l"><span class="label"><i>옵션 : </i><span>
                            <c:forTokens items="${oitem.options}" delims="," var="option">
                                ${option}<br/>
                            </c:forTokens>
                        </span></span></span>
                        </div>
                        <span class="price">
                            <span class="label">가격</span>
                            <span class="val">
                                <fmt:formatNumber value="${oitem.price}" pattern="#,### 원"/>
                            </span>
                    </span>
                    </div>
                </td>
                <td style="background-color: white" class="col-5">
                    <div class="detail2">
                        <span class="content_category"></span>
                        <span class="name">수령인 이름 : ${order.senderName}</span>

                        <div class="option">
                            <span class="label"><i>수령인 연락처 : ${order.receiverPhone}</i></span>
                        </div>
                        <div class="option">
                            <span class="label">[수령 요청일] : ${oitem.requestDate}</span>
                        </div>
                        <div class="option">
                            <span class="label">결제방법 : ${order.payType}</span>
                        </div>
                        <div class="option">
                            <span class="label"><strong>주문상태 : ${order.status}</strong></span>
                        </div>
                    </div>
                </td>
            </tr>
            </tbody>
        </c:forEach>
    </table>
</c:forEach>