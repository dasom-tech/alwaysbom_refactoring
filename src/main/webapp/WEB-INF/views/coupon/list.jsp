<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="UTF-8">
    <title>새늘봄 / 쿠폰</title>
    <%@ include file="../main/b_import.jspf"%>
    <style>
        #listArea li:last-child div {
            border-bottom: 2px solid #dee2e6 !important;
            box-shadow: 0 3px #E0E0E0;
        }
    </style>
</head>
<body>
<%@ include file="../main/b_header.jspf"%>
<div id="container" class="d-flex flex-column align-items-center mx-auto bg-white">
    <!-- 메뉴 영역 -->
    <!-- 메뉴 영역 -->
    <div class="col-12 d-flex justify-content-between align-items-center p-3">
        <!-- 라디오 버튼(전체/사용/미사용) -->
        <div id="statusRadio" class="col-3 d-flex btn-group" role="group">
            <label class="col-4">
                <input type="radio" name="status" class="d-none btn-check" value onchange="searchCoupon()" checked>
                <span class="d-block text-center p-2 btn btn-outline-secondary">전체</span>
            </label>
            <label class="col-4">
                <input type="radio" name="status" class="d-none btn-check" value="1" onchange="searchCoupon(1)">
                <span class="d-block text-center p-2 btn btn-outline-secondary">사용</span>
            </label>
            <label class="col-4">
                <input type="radio" name="status" class="d-none btn-check" value="0" onchange="searchCoupon(0)">
                <span class="d-block text-center p-2 btn btn-outline-secondary">미사용</span>
            </label>
        </div>

        <!-- 아이디 검색 -->
        <div class="col-3 d-flex align-items-center">
            <input type="text" class="rounded-3 border-1 p-2" aria-label="searchId"
                   name="searchId" id="searchId" placeholder="아이디로 검색"
                   onkeypress="if(event.keyCode === 13) searchCoupon(null, this.value)" autocomplete="off">
            <button class="border-1 rounded-3 btn btn-secondary p-2 flex-grow-1 shadow-none"
                    onclick="searchCoupon()">
                <i class="fa fa-search"></i>
            </button>
        </div>
    </div>

    <!-- 리스트 영역 -->
    <div class="col-12 p-3 d-flex flex-column">
        <!-- 리스트 내용 -->
        <ul id="listArea" class="col-12 d-flex flex-column text-center list-unstyled m-0 p-0">
        </ul>
    </div>

    <!-- 버튼 영역 -->
    <div class="col-12 p-3 d-flex justify-content-end">
        <button class="col-2 p-3 btn btn-dark" onclick="showPopup('#mergePopup')">추가</button>
    </div>
</div>

<!-- 추가 팝업 -->
<div class="modal fade" id="mergePopup" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <form class="modal-content">
            <div class="modal-header bg-warning">
                <h5 class="modal-title">쿠폰 추가 화면입니다</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body d-flex flex-column">

                <div class="form-floating mb-3">
                    <input class="form-control" type="text" name="name" id="name" placeholder="Name" autocomplete="off">
                    <label for="name">Name</label>
                </div>

                <div class="form-floating mb-3">
                    <input class="form-control" type="text" name="memberId" id="memberId" placeholder="Member Id" autocomplete="off">
                    <label for="memberId">Member Id</label>
                </div>

                <div class="form-floating">
                    <input class="form-control" type="number" name="point" id="point" placeholder="Point" autocomplete="off">
                    <label for="point">Point</label>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button id="mergeBtn" type="button" class="btn btn-dark" data-bs-dismiss="modal" onclick="mergeCouponCaller(this.form)">추가</button>
            </div>
        </form>
    </div>
</div>

<!-- 삭제팝업 -->
<div class="modal fade" id="deletePopup" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">정말 삭제하시겠습니까?</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button id="deleteBtn" type="button" class="btn btn-danger" data-bs-dismiss="modal"
                        onclick="deleteCouponCaller(this)">삭제
                </button>
            </div>
        </div>
    </div>
</div>

<%@ include file="../main/b_footer.jspf"%>
<script>
    class Coupon {
        constructor() {
            if (typeof arguments[0] === "object") {
                this.idx = arguments[0].idx;
                this.name = arguments[0].name;
                this.memberId = arguments[0].memberId;
                this.status = arguments[0].status;
                this.point = arguments[0].point;
                this.cdate = new Date(arguments[0].cdate);
            } else {
                this.name = arguments[0];
                this.memberId = arguments[1];
                this.status = 0;
                this.point = arguments[2];
            }
        }
        static $area = document.querySelector("#listArea");

        static appendHeader(length) {
            if (length === 0) {
                Coupon.appendNoListMessage();
                return false;
            } else {
                Coupon.appendListHeader();
                return true;
            }
        }

        static appendListHeader() {
            this.$area.innerHTML =
                '<li class="col-12 d-flex text-center bg-secondary text-white">' +
                '   <div class="col-1 p-2 py-3 border">쿠폰번호</div>' +
                '   <div class="col-2 p-2 py-3 border">이름</div>' +
                '   <div class="col-3 p-2 py-3 border">유저</div>' +
                '   <div class="col-1 p-2 py-3 border">사용여부</div>' +
                '   <div class="col-2 p-2 py-3 border">발행일</div>' +
                '   <div class="col-1 p-2 py-3 border">포인트</div>' +
                '   <div class="col-2 p-2 py-3 border">기능</div>' +
                '</li>';
        }

        static appendNoListMessage() {
            this.$area.innerHTML =
                '<div class="text-center">데이터가 존재하지 않습니다</div>';
        }

        static async list(status, memberId) {
            const params = {
                status: status,
                memberId: memberId
            }

            const queryString = new URLSearchParams(params).toString();

            let response = await fetch("/api/coupons?" + queryString);
            let result = await response.json();
            if (Coupon.appendHeader(result.length)) {
                Coupon.coupons = result.map(res => {
                    return new Coupon(res);
                });
                return Coupon.coupons;
            }
        }

        makeListItem() {
            let self = this;
            this.$li = document.createElement("li");
            this.$li.className = "col-12 d-flex text-center";

            this.$rowNum = document.createElement("div");
            this.$rowNum.className = "col-1 p-2 border border-start-0";
            this.$rowNum.innerText = this.idx;

            this.$name = document.createElement("div");
            this.$name.className = "col-2 p-2 border";
            this.$name.innerText = this.name;

            this.$memberId = document.createElement("div");
            this.$memberId.className = "col-3 p-2 border";
            this.$memberId.innerText = this.memberId;

            this.$isUsed = document.createElement("div");
            this.$isUsed.className = "col-1 p-2 border";
            this.$isUsed.innerText = this.status > 0 ? "사용" : "미사용";

            this.$cdate = document.createElement("div");
            this.$cdate.className = "col-2 p-2 border";
            this.$cdate.innerText = this.cdate.toLocaleDateString();

            this.$point = document.createElement("div");
            this.$point.className = "col-1 p-2 border";
            this.$point.innerText = parseInt(this.point).toLocaleString("ko-KR");

            this.$btnArea = document.createElement("div");
            this.$btnArea.className = "col-2 p-2 border border-end-0 d-flex justify-content-around";

            this.$deleteBtn = document.createElement("button");
            this.$deleteBtn.className = "btn btn-danger";
            this.$deleteBtn.innerText = "삭제";
            this.$deleteBtn.onclick = () => deletePopup(self);

            this.$updateBtn = document.createElement("button");
            this.$updateBtn.className = "btn btn-secondary";
            this.$updateBtn.innerText = "수정";
            this.$updateBtn.onclick = () => showPopup("#mergePopup", self);

            this.$btnArea.append(this.$deleteBtn, this.$updateBtn);
            this.$li.append(this.$rowNum, this.$name, this.$memberId, this.$isUsed, this.$cdate, this.$point, this.$btnArea);
        }

        appendListItem() {
            this.makeListItem();
            Coupon.$area.appendChild(this.$li);
        }

        prependListItem() {
            this.makeListItem();
            Coupon.$area.children.item(0).insertAdjacentElement("afterend", this.$li);
        }

        async mergeCoupon() {
            const option = {
                method: this.idx ? "put" : "post",
                body: JSON.stringify(this),
                headers: {
                    "Content-Type": "application/json;charset=utf-8"
                }
            }

            const queryString = this.idx ? "/" + this.idx : "";

            const response = await fetch("/api/coupons" + queryString, option)
            const result = await response.json();

            if (this.idx) {
                this.$name.innerText = this.name;
                this.$memberId.innerText = this.memberId;
                this.$point.innerText = parseInt(this.point).toLocaleString('ko-KR');
            } else {
                this.idx = result.idx;
                this.cdate = new Date(result.cdate);
                this.prependListItem();
            }
        }

        async deleteCoupon() {
            const option = {
                method: 'delete',
                headers: {
                    "Content-Type": "application/json;charset=utf-8"
                }
            };

            const response = await fetch("/api/coupons/" + this.idx, option);
            const result = await response.json();
            if (result) {
                this.$li.remove();
            }
        }
    }

    searchCoupon();

    function searchCoupon(type, memberId) {
        if (!type) {
            type = document.querySelector("#statusRadio input[type=radio]:checked").value;
        }
        if (!memberId) {
            memberId = document.querySelector("#searchId").value;
        }

        Coupon.list(type, memberId).then(list => {
            list.forEach(coupon => coupon.appendListItem());
        })
    }

    function mergeCouponCaller(form) {
        const name = form.name.value;
        const memberId = form.memberId.value;
        const point = form.point.value;

        let coupon;

        let couponIdx = form.dataset.couponIdx;
        console.log(couponIdx);

        if (couponIdx) {
            coupon = Coupon.coupons.filter(coupon => coupon.idx === parseInt(couponIdx))[0];
            console.log(coupon);
            coupon.name = name;
            coupon.memberId = memberId;
            coupon.point = point;
        } else {
             coupon = new Coupon(name, memberId, point);
        }
        console.log(coupon);
        coupon.mergeCoupon();
    }

    function showPopup(target, coupon) {
        const modalTitle = document.querySelector(target + " .modal-title");
        const form = document.querySelector(target + " .modal-content");
        const mergeBtn = document.querySelector("#mergeBtn");

        form.dataset.couponIdx = coupon ? coupon.idx : "";

        modalTitle.innerText = coupon ? "쿠폰 수정" : "쿠폰 추가";
        form.name.value = coupon ? coupon.name : "";
        form.memberId.value = coupon ? coupon.memberId : "";
        form.point.value = coupon ? coupon.point : "";
        mergeBtn.innerText = coupon ? "수정" : "추가";

        const modal = new bootstrap.Modal(document.querySelector(target));
        modal.toggle();
    }

    function deleteCouponCaller(btn) {
        const couponIdx = btn.dataset.couponIdx;
        const coupon = Coupon.coupons.filter(coupon => coupon.idx === parseInt(couponIdx))[0];
        coupon.deleteCoupon();
    }

    function deletePopup(coupon) {
        console.log(coupon);
        document.querySelector("#deleteBtn").dataset.couponIdx = coupon.idx;
        const modal = new bootstrap.Modal(document.querySelector("#deletePopup"));
        modal.toggle();
    }
</script>
</body>
</html>