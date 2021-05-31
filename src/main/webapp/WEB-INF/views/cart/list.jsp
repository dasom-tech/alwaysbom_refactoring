<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="UTF-8">
    <title>새늘봄 / 장바구니</title>
    <%@ include file="../main/import.jspf"%>
    <style>
        .height-100px {
            height: 100px;
        }

        .height-150px {
            height: 150px;
        }
    </style>
</head>
<body>
    <%@ include file="../main/header.jspf"%>

    <div id="container" class="mx-auto d-flex flex-column align-items-center py-4">
        <h1>장바구니</h1>
        <form action="/cart/order2" method="get" class="w-100 d-flex flex-column pt-4">
            <ul id="basket" class="list-group list-group-flush w-100">
                <li class="list-group-item bg-dark text-white d-flex text-center">
                    <div class="col-1">
                        <input type="checkbox" class="form-check-input p-3 rounded-circle bg-warning border-warning" aria-label="allCheck" id="allBtn" onchange="applyAll(this)" checked>
                    </div>
                    <div class="col-6 d-flex justify-content-center align-items-center"><span>상품정보</span></div>
                    <div class="col-3 d-flex justify-content-center align-items-center"><span>추가상품</span></div>
                    <div class="col-2 d-flex justify-content-center align-items-center"><span>합계 금액</span></div>
                </li>
                <c:set var="rowCount" value="-1"/>
                <c:forEach var="cart" items="${list}" varStatus="status">
                <c:choose>
                    <c:when test="${cart.category eq '꽃다발'}">
                        <c:set var="path" value="${cart.flowerVo.image1}"/>
                        <c:set var="link" value="/flower/${cart.flowerVo.idx}"/>
                        <c:set var="target" value="${cart.flowerVo}"/>
                    </c:when>
                    <c:when test="${cart.category eq '정기구독'}">
                        <c:set var="path" value="${cart.subsVo.image1}"/>
                        <c:set var="link" value="/subs/${cart.subsVo.idx}"/>
                        <c:set var="target" value="${cart.subsVo}"/>
                    </c:when>
                    <c:when test="${cart.category eq '소품샵'}">
                        <c:set var="path" value="${cart.productVo.image1}"/>
                        <c:set var="link" value="/product/${cart.productVo.idx}"/>
                        <c:set var="target" value="${cart.productVo}"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="path" value="default.jpg"/>
                        <c:remove var="target"/>
                    </c:otherwise>
                </c:choose>
                <c:if test="${not empty target}">
                <c:set var="rowCount" value="${rowCount + 1}"/>
                <li class="list-group-item bg-white d-flex text-center cart-item" data-cart-idx="${cart.idx}">
                    <!-- 체크박스 -->
                    <div class="col-1">
                        <input type="checkbox" class="form-check-input p-3 rounded-circle cart-check bg-warning border-warning" aria-label="checkbox" name="idx"
                               value="${cart.idx}" onchange="checkAll()" checked>
                    </div>

                    <!-- 상품정보 컬럼 -->
                    <div class="col-6 d-flex">
                        <!-- 이미지 -->
                        <div class="card-img w-25 overflow-hidden height-150px">
                            <a href="${link}">
                                <img src="${path}" alt="사진" class="h-100">
                            </a>
                        </div>
                        <!-- 상품내용 -->
                        <div class="bg-transparent w-75 d-flex flex-column align-items-baseline ps-3 text-start">
                            <span>${target.name}</span>
                            <div class="text-secondary">
                                <c:if test="${cart.category eq '정기구독'}">
                                <div>
                                    <span>첫 구독일 :</span>
                                    <span>${cart.subsStartDate}</span>
                                </div>
                                <div>
                                    <span>구독기간 :</span>
                                    <span>${cart.subsMonth}개월</span>
                                    <span>(${cart.subsMonth * 2}회)</span>
                                </div>
                                </c:if>
                                <c:if test="${cart.category ne '정기구독'}">
                                <div>
                                    <span>수령일 :</span>
                                    <span>${cart.requestDate}</span>
                                </div>
                                </c:if>
                            </div>
                            <div>
                                <c:if test="${target.discountRate ne 0}">
                                <span class="text-danger fw-bold">${target.discountRate}%</span>
                                <span class="text-decoration-line-through text-secondary pe-1" data-cart-original-price="${cart.itemOriginalPrice}"><fmt:formatNumber value="${cart.itemOriginalPrice * cart.quantity}" pattern="#,###원"/></span>
                                </c:if>
                                <span class="fw-bold" data-cart-final-price="${cart.itemFinalPrice}"><fmt:formatNumber value="${cart.itemFinalPrice * cart.quantity}" pattern="#,###원"/></span>
                            </div>
                            <div class="d-flex user-select-none align-items-center col-2 text-secondary">
                                <i class="fa fa-minus-circle col-3 text-start" role="button" onclick="adjustQuantity(false, this, ${rowCount})"></i>
                                <span class="cart-quantity p-2 col-6 text-center text-dark">${cart.quantity}</span>
                                <i class="fa fa-plus-circle col-3 text-end" role="button" onclick="adjustQuantity(true, this, ${rowCount})"></i>
                            </div>
                        </div>
                    </div>

                    <!-- 추가상품 -->
                    <div class="col-3 d-flex flex-column">
                    <c:if test="${cart.letter > 0}">
                        <span>편지추가(2,500원)</span>
                    </c:if>
                    <c:forEach var="choice" items="${cart.choices}">
                        <div>
                            <span>${choice.productVo.name} * ${choice.quantity}</span>
                            <span><fmt:formatNumber value="${choice.productVo.finalPrice}" pattern="(#,###원)"/></span>
                        </div>
                    </c:forEach>
                    </div>

                    <!-- 총 금액 -->
                    <div class="col-2" data-cart-total-price="${cart.totalPrice}">
                        <fmt:formatNumber value="${cart.totalPrice}" pattern="#,###원"/>
                    </div>

                    <!-- 삭제 버튼 -->
                    <div>
                        <i class="btn fa fa-window-close text-warning" data-cart-idx="${cart.idx}" onclick="showPopup(this)"></i>
                    </div>
                </li>
                </c:if>
                </c:forEach>
            </ul>

            <!-- 총 합계금액 표시 영역 -->
            <div class="col-12 d-flex justify-content-end py-4 border-1 border-top border-bottom" style="border-color: rgba(0, 0, 0, .25) !important">
                <div class="d-flex text-end fs-1 text-warning">
                    <span class="px-1">총 금액 : </span>
                    <span id="sumTotalPrice"><fmt:formatNumber value="${totalSum}" pattern="#,###원"/></span>
                </div>
            </div>

            <!-- 결제 버튼 영역 -->
            <div class="col-12 d-flex justify-content-end pt-4 border-1 border-top">
                <div class="col-3">
                    <button type="button" id="submitBtn" class="col-12 btn-pay bg-pay py-3" onclick="goPay()">결제</button>
                </div>
            </div>
        </form>
    </div>

    <div class="modal fade" id="popup" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    정말 삭제하시겠습니까?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal" id="removeCartBtn" onclick="removeCartItem()">삭제</button>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="../main/footer.jspf"%>

    <script>
        let lastRequest;

        function showPopup(button) {
            document.querySelector("#removeCartBtn").setAttribute("data-cart-idx", button.getAttribute("data-cart-idx"));
            new bootstrap.Modal(document.querySelector("#popup")).toggle();
        }

        function removeCartItem() {
            let idx = document.querySelector("#removeCartBtn").getAttribute("data-cart-idx");
            let option = {
                method: 'post',
                body: idx,
                headers: {
                    'Content-Type': 'application/json;charset=utf-8'
                }
            }

            fetch("/api/cart/removeByIdx", option)
                .then(response => {
                    response.json().then(result => {
                        if (result) {
                            const cartItem = document.querySelector(".cart-item[data-cart-idx='" + idx + "']");
                            cartItem.remove();
                            sumTotalPrice();
                        }
                    });
                })
                .catch(err => {
                    alert(err);
                });
        }

        function applyAll(allBtn) {
            let allCheck = document.querySelectorAll(".cart-check");
            for (let check of allCheck) {
                check.checked = allBtn.checked;
            }
            sumTotalPrice();
        }

        function checkAll() {
            let allCheck = document.querySelectorAll(".cart-check");
            let allBtn = document.querySelector("#allBtn");
            let checked = true;
            for (let check of allCheck) {
                checked &= check.checked;
                if (checked === false) {
                    break;
                }
            }
            allBtn.checked = checked;
            sumTotalPrice();
        }

        function sumTotalPrice() {
            let sumTotalPrice = [...document.querySelectorAll("li[data-cart-idx]")]
                .filter(el => el.querySelector("input[type=checkbox][name=idx]").checked)
                .map(el => parseInt(el.querySelector("[data-cart-total-price]").dataset.cartTotalPrice))
                .reduce((prev, curr) => prev + curr, 0);
            console.log(sumTotalPrice);

            let sumTotalPriceEl = document.querySelector("#sumTotalPrice");
            sumTotalPriceEl.innerHTML = sumTotalPrice.toLocaleString("ko-KR") + "원";
        }

        function adjustQuantity(isUp, adjustBtn, index) {
            let submitBtnEl = document.querySelector("#submitBtn");
            submitBtnEl.setAttribute("disabled", "true");

            const quantityEl = adjustBtn.parentElement.querySelector(".cart-quantity");
            let quantity = quantityEl.textContent;

            let cartItemList = document.querySelectorAll(".cart-item");
            let cartItemEl = cartItemList.item(index);

            let originalPriceEl = cartItemEl.querySelector("[data-cart-original-price]");
            let finalPriceEl = cartItemEl.querySelector("[data-cart-final-price]");
            let totalPriceEl = cartItemEl.querySelector("[data-cart-total-price]");

            let itemOriginalPrice;
            let itemFinalPrice;

            if (originalPriceEl) {
                itemOriginalPrice = parseInt(originalPriceEl.getAttribute("data-cart-original-price"));
            }

            if (finalPriceEl) {
                itemFinalPrice = parseInt(finalPriceEl.getAttribute("data-cart-final-price"));
            }

            let totalPrice = parseInt(totalPriceEl.getAttribute("data-cart-total-price"));

            if (isUp) {
                quantity++;
                totalPrice = totalPrice + itemFinalPrice;
            } else {
                if (quantity > 1) {
                    quantity--;
                    totalPrice = totalPrice - itemFinalPrice;
                }
            }

            if (originalPriceEl) {
                originalPriceEl.textContent = (itemOriginalPrice * quantity).toLocaleString('ko-KR') + "원";
            }
            if (finalPriceEl) {
                finalPriceEl.textContent = (itemFinalPrice * quantity).toLocaleString('ko-KR') + "원";
            }
            totalPriceEl.textContent = totalPrice.toLocaleString('ko-KR') + "원";
            totalPriceEl.setAttribute("data-cart-total-price", totalPrice.toString());

            sumTotalPrice();

            quantityEl.textContent = quantity;

            //ajax 처리 하고 합계금액 계산

            if (lastRequest) {
                clearTimeout(lastRequest);
                lastRequest = undefined;
            }

            lastRequest = setTimeout(function () {
                let cartItem = {
                    idx: cartItemEl.getAttribute("data-cart-idx"),
                    quantity: quantity
                };

                let option = {
                    method: 'post',
                    body: JSON.stringify(cartItem),
                    headers: {
                        'Content-Type': 'application/json;charset=UTF-8'
                    }
                }

                fetch("/api/cart/updateQuantity", option)
                    .then(response => {
                        response.json()
                            .then(result => {
                                console.log("수량이 변경되었습니다");
                                console.log(result);
                            })
                            .catch(err => console.log(err));
                    })
                    .catch(err => console.log(err));
                submitBtnEl.removeAttribute("disabled");
            }, 500);
        }

        function goPay() {
            let checkedList = document.querySelectorAll(".cart-check:checked");

            let queryString = new URLSearchParams();
            checkedList.forEach(el => {
                queryString.append("idx", el.value);
            })

            fetch("/api/cart/convertOitemList?" + queryString)
                .then(response => {
                    response.json()
                        .then(result => {
                            // console.log(result);
                            goOitem(result)
                        })
                        .catch(err => alert(err));
                })
                .catch(err => alert(err));
        }

        function goOitem(oitemList) {
            let form = document.createElement("form");
            form.action = "/order/letter";
            form.method = "post";

            let data = document.createElement("input");
            data.type = "text";
            data.name = "data";
            data.value = JSON.stringify(oitemList);
            form.appendChild(data);

            document.body.appendChild(form);
            form.submit();
        }
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