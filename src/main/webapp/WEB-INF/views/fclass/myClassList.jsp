<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>새늘봄 - 상품 주문내역 조회</title>
    <%@ include file="../main/import.jspf" %>
    <link rel="stylesheet" href="/static/css/order/orderstyle_back.css">
</head>
<body>
<%@ include file="../main/header.jspf" %>
<div id="container" class="mx-auto d-flex flex-column user-select-none">
    <%@ include file="../member/mypage_header.jspf" %>
    <div class="h-85 d-flex">
        <%@ include file="../member/mypage_menu.jspf" %>
        <div id="classOrderBox" class="col-10 h-100 d-flex flex-column user-select-auto">
            <!-- 검색 영역 -->
            <div class="d-flex justify-content-between py-3">
                <!-- 입금상태(status)로 검색하기 -->
                <div class="d-flex m-0 p-0" role="group">
                    <label>
                        <input type="radio" class="btn-check" name="status" value="전체" onchange="searchByStatus(this.value)" checked>
                        <span class="btn btn-outline-warning btn-sm text-dark">전체</span>
                    </label>
                    <label class="mx-1">
                        <input type="radio" class="btn-check" name="status" value="입금대기" onchange="searchByStatus(this.value)">
                        <span class="btn btn-outline-warning btn-sm text-dark">입금대기</span>
                    </label>
                    <label>
                        <input type="radio" class="btn-check" name="status" value="결제완료" onchange="searchByStatus(this.value)">
                        <span class="btn btn-outline-warning btn-sm text-dark">결제완료</span>
                    </label>
                </div>
                <!-- 클래스명으로 검색하기 -->
                <div class="input-group mb-3" style="width: 300px;">
                    <input type="text" class="form-control className" name="className" id="className" onkeyup="if(event.keyCode === 13) searchByOption();" onfocus="this.value='';" autocomplete="off">
                    <button class="btn btn-outline-secondary" type="button" onclick="searchByOption()">
                        <span>검색</span>
                    </button>
                </div>
            </div>

            <!-- 내용 영역 --> <!--document.querySelector("#classUl").innerHTML = await response.text(); 이거 때문에 ul태그만 필요하고 나머지는 필요없어짐. -->
            <ul id="classUl" class="d-flex flex-column list-unstyled m-0 p-0 overflow-auto">
            </ul>
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

    searchByStatus("전체");

    async function searchByStatus(status) {
        let response = await fetch("/api/fclass/orders?status=" + status);
        document.querySelector("#classUl").innerHTML = await response.text();
    }

    async function searchByOption() {
        // 파라미터가 없는 대신, 직접 가져와야 한다. (className, status 둘다)
        const status = document.querySelector("#classOrderBox input[name=status]:checked").value;
        const $className = document.querySelector("#classOrderBox input[name=className]");

        const params = {
            status: status,
            className: $className.value
        };

        const queryString = new URLSearchParams(params).toString();
        const response = await fetch("/api/fclass/orders?" + queryString);
        document.querySelector("#classUl").innerHTML = await response.text();
        /*$className.value = '';*/
    }


</script>
<%@ include file="../main/footer.jspf" %>
</body>
</html>