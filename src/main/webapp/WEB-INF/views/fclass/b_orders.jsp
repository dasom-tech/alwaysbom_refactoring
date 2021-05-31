<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<html>
<head>
    <title>클래스 수강내역</title>
    <%@ include file="../main/b_import.jspf" %>
</head>
<body>
<%@ include file="../main/b_header.jspf" %>
<div id="container" class="mx-auto pt-5">
    <div class="d-flex justify-content-center align-items-center pt-5">
        <span class="fs-2 fw-bold">클래스 등록 조회</span>
    </div>
    <div class="d-flex row-cols-3 p-5">
        <div class="d-flex">
            <select id="branchSelect" class="form-select form-select-lg">
                <option value selected>전체지점</option>
                <c:forEach var="branchName" items="${branchList}">
                <option value="${branchName}">${branchName}</option>
                </c:forEach>
            </select>
        </div>
        <div class="px-2 d-flex">
            <select id="status" class="form-select form-select-lg">
                <option value="전체" selected>전체</option>
                <option value="입금대기">입금대기</option>
                <option value="결제완료">결제완료</option>
            </select>
        </div>
        <div class="d-flex">
            <div class="input-group">
                <input id="memberId" type="text" class="form-control"
                       onkeypress="if(event.keyCode === 13)searchBySearchOption()"
                       placeholder="회원 아이디로 검색" autocomplete="off">
                <button class="btn btn-outline-secondary" type="button"
                        onclick="searchBySearchOption()">검색
                </button>
            </div>
        </div>
    </div>

    <ul id="classUl" class="px-5">

    </ul>

</div>
<%@ include file="../main/b_footer.jspf" %>
<script>
    async function searchBySearchOption() {
        let branch = document.querySelector("#branchSelect").value;
        const status = document.querySelector("#status").value;

        let params = {
            branchName: branch,
            status: status,
            memberId: document.querySelector("#memberId").value
        }
        let queryString = new URLSearchParams(params);
        const response = await fetch("/admin/fclass/api/orders?" + queryString);
        document.querySelector("#classUl").innerHTML = await response.text();
    }

    async function updateStatus(btn) {
        const idx = btn.dataset.orderIdx;
        const data = '결제완료';

        const option = {
            method: 'put',
            body: data,
            headers: {
                "Content-Type": "application/json;charset=utf-8"
            }
        }

        //PUT요청(변경)
        let response = await fetch("/admin/fclass/api/orders/" + idx, option);
        // let result = await response.json();

        if (response.ok) {
            //GET요청(가져오기)
            response = await fetch("/admin/fclass/api/orders/" + idx);
            let result = await response.text();
            const oldLi = document.querySelector("#classUl #o" + idx);
            oldLi.outerHTML = result;
        }
    }
    async function deleteRow(btn) {
        const idx = btn.dataset.orderIdx;
        const option = {
            method: 'delete',
            headers: {
                "Content-Type": "application/json;charset=utf-8"
            }
        }
        let response = await fetch("/admin/fclass/api/orders/" + idx, option);
        //let result = await response.json();
        //console.log(result);
        if (response.ok) {
            let oldLi = document.querySelector("#classUl #o" + idx);
            oldLi.remove();
            alert("주문취소");
        } else {
            alert("주문취소 실패");
        }
    }
</script>
</body>
</html>
