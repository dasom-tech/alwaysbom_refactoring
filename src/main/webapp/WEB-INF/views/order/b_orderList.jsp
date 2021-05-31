<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>새늘봄 백오피스 - 주문내역 조회</title>
    <%@ include file="../main/b_import.jspf"%>
    <link rel="stylesheet" href="/static/css/order/orderstyle_back.css">
</head>
<body>
<%@ include file="../main/b_header.jspf"%>
<div id="container">
    <div class="col-12 pt-5 d-flex flex-column">
        <div id="btnGroup" class="btn-group" role="group" aria-label="Basic radio toggle button group">
            <input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" checked value="입금대기">
            <label class="btn btn-outline-primary" for="btnradio1">입금 대기
                <span class="badge">${statusCount.wait}</span>
            </label>

            <input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off" value="주문취소">
            <label class="btn btn-outline-primary" for="btnradio2">주문 취소
                <span class="badge">${statusCount.cancel}</span>
            </label>

            <input type="radio" class="btn-check" name="btnradio" id="btnradio3" autocomplete="off" value="취소완료">
            <label class="btn btn-outline-primary" for="btnradio3">취소 완료
                <span class="badge">${statusCount.cancelComplete}</span>
            </label>

            <input type="radio" class="btn-check" name="btnradio" id="btnradio4" autocomplete="off" value="결제완료">
            <label class="btn btn-outline-primary" for="btnradio4">결제 완료
                <span class="badge">${statusCount.orderComplete}</span>
            </label>

            <input type="radio" class="btn-check" name="btnradio" id="btnradio5" autocomplete="off" value="배송중">
            <label class="btn btn-outline-primary" for="btnradio5">배송중
                <span class="badge">${statusCount.delivery}</span>
            </label>

            <input type="radio" class="btn-check" name="btnradio" id="btnradio6" autocomplete="off" value="배송완료">
            <label class="btn btn-outline-primary" for="btnradio6">배송 완료
                <span class="badge">${statusCount.deliveryComplete}</span>
            </label>
        </div>
    </div>
    <div id="ordersListContent">
        <%@ include file="b_orderListContent.jsp"%>
    </div>
</div>
<%@ include file="../main/b_footer.jspf"%>
<script>
    //주문 불러오기
    document.querySelectorAll("#btnGroup input[type=radio]").forEach(function (input) {
        input.addEventListener("change", function () {
            // 해당 라디오버튼에 대한 상태값을 파라미터 status값으로 넘겨준다.
            fetch("/admin/api/orders?status=" + this.value).then(response => {
                console.log(response);
                //받은 값을 .text로 변환 후 출력해보고, #ordersListContent에 뿌려준다.
                response.text().then(result => {
                    console.log(result);
                    document.querySelector("#ordersListContent").innerHTML = result;
                });
            });
        });
    });

    //입금대기 -> 결제완료
    function payConfirm(btn, index) {
        const idx = btn.dataset.orderIdx;

        const option = {
            method: 'put',
            body: '결제완료',
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
                    alert("변경되었습니다.");
                    //화면 변경 처리 (일단 원래있던 테이블 삭제)
                    const $ul = document.querySelector("ul#o" + idx);
                    $ul.remove();
                    // 입금확인 버튼 누를시, 입금확인 -1 결제완료 +1
                    const complete = document.querySelector("#btnGroup input[value=결제완료] + label > span");
                    complete.innerHTML = (parseInt(complete.innerHTML) + 1).toString();
                    const wait = document.querySelector("#btnGroup input[value=입금대기] + label > span");
                    wait.innerHTML = (parseInt(wait.innerHTML) - 1).toString();

                    document.querySelector("#status[data-index='" + index + "']").innerText = '결제완료';
                    document.querySelector("#order-button[data-index='" + index + "']").innerText = '배송출발';
                } else {
                    alert("실패입니다");
                }
            });
        });
    }

    // 주문취소 -> 주문취소 완료
    function payCancel(btn) {
        const idx = btn.dataset.orderIdx;

        let option = {
            method: 'put',
            body: '취소완료',
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
                    alert("변경되었습니다.");
                    const $ul = document.querySelector("ul#o" + idx);
                    $ul.remove();
                    const complete = document.querySelector("#btnGroup input[value=취소완료] + label > span");
                    complete.innerHTML = (parseInt(complete.innerHTML) + 1).toString();
                    const wait = document.querySelector("#btnGroup input[value=주문취소] + label > span");
                    wait.innerHTML = (parseInt(wait.innerHTML) - 1).toString();

                } else {
                    alert("실패입니다");
                }
            });
        });
    }

    // 결제완료 -> 배송중 으로 변경
    function departDelivery(btn) {
        const idx = btn.dataset.orderIdx;

        let option = {
            method: 'put',
            body: '배송중',
            headers : {
                "Content-Type": "application/json;charset=utf-8"
            }
        }

        fetch("/admin/api/orders/" + idx + "/status", option).then(response => {
            console.log(response);
            response.json().then(result => {
                console.log(result);
                if (result) {
                    alert("변경되었습니다.");
                    const $ul = document.querySelector("ul#o" + idx);
                    $ul.remove();
                    const complete = document.querySelector("#btnGroup input[value=배송중] + label > span");
                    complete.innerHTML = (parseInt(complete.innerHTML) + 1).toString();
                    const wait = document.querySelector("#btnGroup input[value=결제완료] + label > span");
                    wait.innerHTML = (parseInt(wait.innerHTML) - 1).toString();

                } else {
                    alert("실패입니다");
                }
            });
        });
    }

</script>
</body>
</html>
