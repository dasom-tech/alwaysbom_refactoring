<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
    <title>새늘봄 - checkout</title>
    <%@ include file="../main/import.jspf"%>
    <link rel="stylesheet" href="/static/css/order/orderstyle.css">
    <!-- jQuery -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
    <script>
        //결제 -> 결제완료
        function payment(frm) {

            let totalPrice = document.querySelector("#finalPrice").value;

            if (document.frm.payType.value === "간편결제") {
                alert("간편결제" + "<c:out value='${orderPrice.finalPrice}'/>" + "원" );
                alert("포트폴리오 용 사이트이니 결제하지 마십시오.");

                IMP.init('imp49204009');

                IMP.request_pay({ // param
                    pg: "inicis",
                    pay_method: "card",
                    merchant_uid: "merchant_" + new Date().getTime(),
                    name: "(주)Alwaysbom 결제",
                    //amount: "<c:out value='${orderPrice.finalPrice}'/>",
                    amount: 1,
                    buyer_email: "<c:out value='${sessionScope.member.id}'/>",
                    buyer_name: "<c:out value='${sessionScope.member.name}'/>",
                    buyer_tel: "<c:out value='${sessionScope.member.phone}'/>"

                }, function (rsp) { // callback
                    if (rsp.success) {
                        // 결제 성공 시 로직,
                        alert("결제가 완료되었습니다.");
                        document.frm.submit();

                        jQuery.ajax({
                            url: "http://www.myservice.com/payments/complete",
                            method: "POST",
                            headers: {"Content-Type": "application/json"},
                            data: {
                                imp_uid: rsp.imp_uid,
                                merchant_uid: rsp.merchant_uid
                            }
                        }).done(function(data){
                            //성공
                        })
                    } else {
                        // 결제 실패 시 로직,
                        alert("결제가 실패하였습니다." + rsp.error_msg);
                        return false;
                    }
                });
            } else {
                document.frm.submit();
            }
        }
    </script>
</head>

<body>
<%@ include file="../main/header.jspf" %>
<div id=“container” class=“mx-auto”>
    <!-- 헤더 -->
    <div class="checkout_wrap">
        <div class="navi" tabindex="-1">
            <ol class="process">
                <li class="step"><span class="order"><b>1</b><span class="desc">편지 추가</span></span></li>
                <li class="step"><span class="order"><b>2</b><span class="desc">주소 입력</span></span></li>
                <li class="step current"><span class="order"><b>3</b><span class="desc">결제</span></span></li>
            </ol>
        </div>

    <div class="checkout_content">
        <div class="process">
            <div class="step" id="okCheckout">
                <!-- 폼 시작-->
                <form action="/order/complete" method="post" name="frm">
                    <input type="hidden" name="orderIdx" value="">
                <div class="information_box">
                    <div class="checkout_finals">
                        <div class="check_row"><span class="label">마지막으로 다시 한 번 주문내역을 확인해보세요.</span></div>
                        <!-- 주문내역 -->
                        <div class="checkout_cartlist">
                            <div class="head">
                                <span class="delivery">수령일</span>
                                <span class="product">상품명</span>
                                <span class="price">가격</span>
                            </div>
                            <div class="cartlist_wrap">
                                <div id="cartlist_wrapper_final">
                                    <div id="cartlist_wrapper" class="cartlist_wrap">
                                            <!-- 담은 수만큼 생성 -->
                                            <c:forEach var="oitem" items="${oitemList}">
                                            <div class="item">
                                                <h4 class="delivery_date">
                                                    <span class="label">수령일</span>
                                                        <c:if test="${oitem.category eq '정기구독'}">
                                                            <span class="val">첫번째 수령일</span>
                                                            <span class="val">${oitem.osubsList.get(0).deliveryDate}</span>
                                                            <br>
                                                            <span class="val">[${oitem.osubsList.get(0).month}개월 구독]</span>

                                                        </c:if>
                                                        <c:if test="${oitem.category ne '정기구독'}">
                                                            <span class="val">${oitem.requestDate}</span>
                                                        </c:if>
                                                </h4>
                                                <h5 class="delivery_title">
                                                    <span class="label">상품명</span>
                                                </h5>
                                                <div class="delivery_goods">
                                                    <div class="row">
                                                        <div class="list_good_checkout">
                                                            <div class="good">
                                                                <div class="photo">
                                                                    <a href="#" class="img" title="">
                                                                        <img src="${oitem.image}" class="image_size">
                                                                    </a>
                                                                </div>
                                                                <div class="detail">
                                                                    <span class="content_category">[${oitem.category}]</span>
                                                                    <span class="name">${oitem.name}</span>
                                                                    <div class="option">
                                                                        <span class="l"><span class="label"><i>수량 : ${oitem.quantity}</i></span></span>
                                                                    </div>
                                                                    <div class="option">
                                                                        <c:if test="${oitem.hasLetter eq true}">
                                                                        <span class="l"><span class="label"><i></i>편지 추가</span></span>
                                                                        </c:if>
                                                                    </div>
                                                                    <div class="option">
                                                                        <span class="l">
                                                                            <span class="label"><i>옵션 :</i>
                                                                                <span>
                                                                                    <c:forTokens items="${oitem.options}" delims="," var="option">
                                                                                    ${option}<br/>
                                                                                    </c:forTokens>
                                                                                </span>
                                                                            </span>
                                                                        </span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="list_good_price">
                                                            <span class="price">
                                                                <fmt:formatNumber value="${oitem.price}" pattern="#,### 원"/>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>

    <!---------------------------------------------- 주소입력부분 ------------------------------------------------------->

                        <div class="check_row under"><span class="label">배송 주소</span></div>
                        <table class="address_input_table in_s4 w450">
                            <tbody>
                            <tr>
                                <td><span class="detail"><span class="th">수령인 이름</span><span class="td">
                                    <input readonly type="text" value="${ordersVo.receiverName}"></span></span></td>
                                </tr>
                            <tr>
                                <td><span class="detail"><span class="th">수령인 연락처</span><span class="td">
                                    <input readonly type="text" value="${ordersVo.receiverPhone}"></span></span></td>
                                </tr>
                            </tbody>
                        </table>

                        <div class="check_unknow">
                            <span class="label">익명처리여부</span>
                            <c:if test="${empty ordersVo.senderName}">
                                <span class="val">익명배송</span>
                            </c:if>
                            <c:if test="${not empty ordersVo.senderName}">
                                <span class="val">실명배송</span>
                            </c:if>
                        </div>

                        <!-- 쿠폰, 적립금 -->
                        <table class="address_input_table in_s4 w450">
                            <tbody>
                            <tr>
                                <td><span class="detail"><span class="th">적립금</span>
                                    <span class="td_savings">
                                        <input type="number" min="0" onkeyup="compareWithPoint(this)" onchange="compareWithPoint(this)"
                                               name="point" id="input_my_point" value="0" autocomplete="off">
                                        <button type="button" class="btns add" onclick="Point()" onchange="Point()">사용</button>
                                        <span class="text">* 사용 가능 포인트:
                                            <fmt:formatNumber value="${member.point}" pattern="#,###"/>원</span>
                                        <input type="hidden" id="available_point" value="${member.point}"/>
                                    </span>
                                    </span>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <div class="check_row_table">
                            <ul class="list-group">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    상품<span><fmt:formatNumber value="${orderPrice.totalPrice}" pattern="+ #,### 원"/></span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    배송비<span>${orderPrice.deliveryString}</span>
                                    <input type="hidden" name="payDelivery" value="${orderPrice.deliveryFee}">
                                </li>
                                <li id="discountPoint" class="list-group-item d-flex justify-content-between align-items-center">
                                    포인트할인<span id="pointHere">-0 원</span>
                                    <input type="hidden" name="discountPoint" value="0">
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    등급할인<span><fmt:formatNumber value="${orderPrice.discountGradePrice}" pattern="- #,###원"/></span>
                                    <input type="hidden" name="discountGrade" value="${orderPrice.discountGradePrice}">
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center"
                                    id="total_color">
                                    <strong class="total_color">총 결제금액</strong>
                                    <input type="text" name="finalPrice" id="finalPrice" readonly
                                            class="total_color bg-transparent border-0 text-end"
                                            data-original-price="${orderPrice.finalPrice}"
                                           value="<fmt:formatNumber value='${orderPrice.finalPrice}' pattern='#,###원'/>">
                                    <!-- db저장용 -->
                                    <input type="hidden" name="payTotal" value="${orderPrice.finalPrice}">
                                </li>
                            </ul>
                        </div>

                        <!-- 결제수단 선택 라디오 버튼 -->
                        <div class="check_row_method" id="check_row_method">
                            <div class="row"><span class="label">결제 수단 선택</span><span class="val">
                                <b class="total"></b></span></div>
                            <div class="row" style="width: 1280px;">
                                <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
                                    <input type="radio" class="btn-check" name="payType" id="btnradio1" value="간편결제"
                                           autocomplete="off" checked>
                                    <label class="btn btn-outline-primary" for="btnradio1" onclick="creditCard()">간편결제</label>

                                    <input type="radio" class="btn-check" name="payType" id="btnradio2" value="신용카드"
                                           autocomplete="off">
                                    <label class="btn btn-outline-primary" for="btnradio2" onclick="creditCardInput()">신용카드</label>

                                    <input type="radio" class="btn-check" name="payType" id="btnradio3" value="무통장입금"
                                           autocomplete="off">
                                    <label class="btn btn-outline-primary" for="btnradio3" onclick="mootong()">무통장입금</label>
                                </div>
                            </div>

                            <!-- 결제 정보 입력창 -->

                            <!-- 신용카드 -->
                            <div class="checkout_method_card" id="credit_card_input">
                                <div class="more">* 신용카드 정보를 직접 입력하여 간편하게 결제하실 수 있습니다. <br>* 새늘봄에서는 절대 카드 정보를 직접 저장하지
                                    않습니다. <br>* 나이스 정보통신의 결제 기능을 사용합니다. <br>* 기명 법인카드의 경우, 소유하신 분의 주민등록번호 앞자리를
                                    입력해주세요. <br>* 무기명 법인카드의 경우, 사업자 등록번호를 입력해 주세요.</div>
                                <table class="address_input_table in_s4 w450">
                                    <caption class="blind"></caption>
                                    <tbody>
                                    <tr>
                                        <td><span class="detail add_200721"><span class="th">카드 번호</span>
                                            <span class="td_card">
                                                <div class="card_number" style="width: 24%;">
                                                    <input maxlength="4" name="card_num_1" id="card_num_1"
                                                        type="text" data-type="card_number" data-index="0"
                                                        autocomplete="off" value="">
                                                </div><span class="d" style="width: 2%;">-</span>
                                                <div class="card_number" style="width: 23%;">
                                                    <input maxlength="4" name="card_num_2" id="card_num_2"
                                                        data-type="card_number" data-index="1"
                                                        type="password"
                                                        class="ui-keyboard-input ui-widget-content ui-corner-all ui-keyboard-lockedinput"
                                                        aria-haspopup="true" role="textbox"
                                                        autocomplete="off">
                                                </div><span class="d" style="width: 2%;">-</span>
                                                <div class="card_number" style="width: 23%;">
                                                    <input maxlength="4" name="card_num_3" id="card_num_3"
                                                        data-type="card_number" data-index="2"
                                                        type="password"
                                                        class="ui-keyboard-input ui-widget-content ui-corner-all ui-keyboard-lockedinput"
                                                        aria-haspopup="true" role="textbox"
                                                        autocomplete="off">
                                                </div><span class="d" style="width: 2%;">-</span>
                                                <div class="card_number" style="width: 24%;">
                                                    <input maxlength="4" name="card_num_4" id="card_num_4"
                                                        data-type="card_number" data-index="3" type="text"
                                                        class="form-control form-control-small"
                                                        autocomplete="off" value="">
                                                </div>
                                            </span></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><span class="detail add_200721"><span class="th">
                                            유효 기간 (년/월)</span><span class="td_phone">
                                            <select class="form-control form-control-small" name="card_exp_year" id="card_exp_year"
                                                data-type="card_valid" data-index="0" style="width: 48%;">

                                                    <c:forEach var="year" begin="2021" end="2035">
                                                    <option value="${year}">${year}</option>
                                                    </c:forEach>
                                            </select><span class="d" style="width: 4%;">-</span>
                                            <select class="form-control form-control-small"
                                                name="card_exp_month" id="card_exp_month" data-type="card_valid" data-index="1" style="width: 48%;">
                                                    <c:forEach var="month" begin="01" end="12">
                                                        <option value="${month}">${month}</option>
                                                    </c:forEach>
                                            </select>
                                        </span></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><span class="detail add_200721"><span class="th">주민등록번호 앞자리</span><span class="td" style="width: 48%;">
                                            <input autocomplete="off"
                                                class="form-control form-control-small" maxlength="10"
                                                name="card_id" id="card_id" type="text" data-type="card_id" data-index="1"
                                                value="">
                                        </span></span></td>
                                    </tr>
                                    <tr>
                                        <td><span class="detail add_200721"><span class="th">비밀번호 앞 두자리</span><span class="td" style="width: 48%;">
                                            <input autocomplete="off" class="form-control form-control-small ui-keyboard-input ui-widget-content ui-corner-all ui-keyboard-lockedinput"
                                                   id="card_password" maxlength="2" name="card_password"
                                                   type="password" aria-haspopup="true" role="textbox"
                                                   data-type="card_password" data-index="0">
                                        </span></span></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>


                            <!-- 무통장 입금 -->
                            <div id="mootong" class="checkout_method_more">
                                <div class="more">입금자명 <input type="text" name="mootongName"
                                                              id="pre-mootong-name" value=""> 미기재시 주문자명으로 자동 반영</div>
                                <div class="noti">* 주문 후 72시간동안 미 입금시 자동 주문 취소됩니다.</div>
                                <div class="recept_money">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1">
                                        <label class="form-check-label" for="inlineRadio1">개인소득공제용</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2">
                                        <label class="form-check-label" for="inlineRadio2">사업자증빙용</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio3" value="option3" checked>
                                        <label class="form-check-label" for="inlineRadio3">미신청</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="complete">
                        <button type="button" class="info_btn next" id="purchase_submit" onclick="payment(this.form)">결제 하기</button>
                        <button type="button" class="info_btn back" onclick="history.back()">이전 단계로</button>
                    </div>
                </div>
                </form>
            </div>
        </div>
    </div>
</div>
</div>
<%@ include file="../main/footer.jspf"%>
<script>
    window.onload = function () {
        creditCard();
    }
    //간편결제
    function creditCard() {
        document.querySelector('#credit_card_input').style.display = 'none';
        document.querySelector('#mootong').style.display = 'none';
    }
    //신용카드 직접입력
    function creditCardInput() {
        document.getElementById('credit_card_input').style.display = 'block';
        document.getElementById('mootong').style.display = 'none';
    }
    //무통장입금
    function mootong() {
        document.getElementById('credit_card_input').style.display = 'none';
        document.getElementById('mootong').style.display = 'block';
    }

    function Point() {
        let inputPoint = document.querySelector('#input_my_point');
        let usePoint = document.querySelector('#pointHere');
        let $discountPoint = document.querySelector("#pointHere + input");
        let finalPrice = document.querySelector('#finalPrice');
        let originalPrice = finalPrice.getAttribute('data-original-price');
        let discountPoint;

        if (inputPoint.value !== '' || inputPoint.value.length > 0) {
            discountPoint = inputPoint.value;
        } else {
            discountPoint = 0;
        }
        usePoint.textContent = '- ' + discountPoint.toLocaleString('ko-KR') + '원';
        $discountPoint.value = discountPoint;
        let finalAmount = originalPrice - discountPoint;
        finalPrice.value = finalAmount.toLocaleString('ko-KR') + "원";
    }
    function compareWithPoint(point) {
        //사용자가 입력한 포인트가 현재 포인트보다 크면?..
        if (point.value < 0) {
            alert("포인트는 0원 이상부터 사용 가능합니다.");
            point.value="";
        }
        if (point.value > ${member.point}) {
            alert("${member.name} 회원님께서 사용 가능한 포인트는 <fmt:formatNumber value="${member.point}" pattern="#,###"/> 입니다.");
            point.value="";
        }
    }
</script>
</body>
</html>