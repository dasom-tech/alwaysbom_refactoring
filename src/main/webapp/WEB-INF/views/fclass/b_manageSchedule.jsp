<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<html>
<head>
    <title>클래스 일정 관리</title>
    <%@ include file="../main/b_import.jspf" %>
    <link rel="stylesheet" href="/static/bootstrap-datepicker/bootstrap-datepicker.css">
    <script src="/static/bootstrap-datepicker/bootstrap-datepicker.js"></script>
    <style>
        .bgColor {
            background-color: #f3f2f2;
        }
        .grayBoard {
            border-right: 3px solid #f3f2f2;
        }
    </style>
</head>
<body>
<%@ include file="../main/b_header.jspf" %>
<div id="container" class="mx-auto d-flex p-4 pt-5">
    <div class="col-8 d-flex flex-column px-4 grayBoard"> <%--border-warning border-end--%>
        <div class="w-100 d-flex justify-content-center align-items-center p-3 position-relative">
            <div class="position-absolute top-0 start-0 bg-light text-secondary rounded-3 px-3">
                <span>${fclass.category}</span> /
                <span>${fclass.name}</span> /
                <span>${branch.name}</span>
            </div>
            <span class="fs-2 fw-bold pt-5">클래스 조회</span>
        </div>
        <div class="w-100 d-flex flex-column align-items-center">
            <div>
            <label class="form-label">
                <input type="text" placeholder="조회하실 클래스의 날짜를 선택해주세요" id="dataForm" class="bgColor select-datepicker form-floating p-4" onclick="checkValidDate()" required="required" autocomplete="off"/>
            </label>
            <button type="button" class="btn btn-dark" id="searchBtn" onclick="searchSchedule()">검색</button>
            </div>
            <table class="table table-hover" id="scheduleTable" style="font-size: 0.9rem;">
                <thead class="table-dark" id="scheduleThead"></thead>
                <tbody id="scheduleTbody" class="overflow-auto"></tbody>
            </table>
        </div>
    </div>
    <div class="col-4 d-flex flex-column px-4">
        <div class="w-100 d-flex justify-content-center align-items-center p-3">
            <span class="fs-2 fw-bold pt-5">수강등록</span>
        </div>
        <div class="w-100 d-flex flex-column align-items-center">
            <div><input type="text" placeholder="등록할 수강일을 선택해주세요" id="classDate" class="bgColor register-datepicker form-floating p-2 mb-2 dataForm2" required="required" aria-label="수강일"/></div>
            <div class="mb-2"><input type="time" id="startTime" class="bgColor dataForm2 form-floating p-2" placeholder="시작시간" value="10:00" required="required" aria-label="시작시간"/></div>
            <div class="mb-2"><input type="time" id="endTime" class="bgColor dataForm2 form-floating p-2" placeholder="종료시간" value="20:00" required="required" aria-label="종료시간"/></div>
            <div class="mb-2"><input type="text" id="capacity" class="bgColor dataForm2 form-floating p-2" placeholder="수강정원" pattern="[0-9]+" onkeyup="this.reportValidity()" required="required" aria-label="수강정원" autocomplete="off"/></div>
            <div class="d-flex justify-content-between pb-5">
                <button type="button" class="btn btn-dark w-100 m-2 px-5" onclick="addSchedule()">추가</button>
            </div>
        </div>
            <div class="d-flex justify-content-end pb-5">
                <button type="button" class="btn btn-secondary w-40 m-2 px-5" onclick="goToList()">나가기</button>
            </div>
    </div>
</div>
<div class="modal fade" aria-hidden="true" id="modal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">경고!</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>정말 삭제하시겠습니까?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" id="removeBtn" data-bs-dismiss="modal" onclick="removeSchedule(this)">삭제</button>
            </div>
        </div>
    </div>
</div>
<!--수정하기 모달 -->
<div class="modal fade" aria-hidden="true" id="modal2" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <form id="updateForm" class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">클래스일정 수정</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div>
                    <input type="text" placeholder="수정할 수강일을 선택해주세요" class="update-datepicker form-floating p-2 mb-2 dataForm2" name="sdate" required="required" aria-label="수강일"/>
                </div>
                <div class="mb-2">
                    <input type="time" placeholder="시작시간" class="dataForm2 form-floating p-2" name="startTime" required="required" aria-label="시작시간"/>
                </div>
                <div class="mb-2">
                    <input type="time" placeholder="종료시간" class="dataForm2 form-floating p-2" name="endTime" required="required" aria-label="종료시간"/>
                </div>
                <div class="mb-2">
                    <input type="text" placeholder="수강정원" class="dataForm2 form-floating p-2" name="totalCount" pattern="[0-9]+" onkeyup="this.reportValidity()" required="required" aria-label="수강정원" autocomplete="off"/>
                </div>
            </div>
            <div class="modal-footer">
                <input type="hidden" name="idx">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal" onclick="updateSchedule(this.form)">수정</button>
            </div>
        </form>
    </div>
</div>
<%@ include file="../main/b_footer.jspf" %>
<script type="text/javascript">
    let modal = document.querySelector("#modal");
    let removeBtn = document.querySelector("#removeBtn");

    modal.addEventListener("show.bs.modal", function (e) {
        let idx = e.relatedTarget.getAttribute("data-idx");
        removeBtn.setAttribute("data-idx", idx);
    });

    async function removeSchedule(btn) {
        let idxArray;

        if (btn) { // btn 이 있으면(undefined가 아니면) btn의 idx를 1개짜리 배열로 만들어서 ajax 처리
            idxArray = [btn.getAttribute("data-idx")];

        } else { // btn 이 없으면(undefined) 체크된 리스트의 idx를 배열로 만들어서 ajax 처리
            let arr = [...document.querySelectorAll(".each-check:checked")];
            idxArray = arr.map(function (tag) {
                return tag.parentElement.parentElement.getAttribute("data-idx");
            });
        }

        let option = {
            method: 'post',
            body: JSON.stringify(idxArray),
            headers: {
                'Content-Type': 'application/json;charset=UTF-8'
            }
        };

        let response = await fetch("/admin/fclass/api/deleteScheduleByIdx", option);
        let result = await response.json();
        if(result) {
            for (let idx of idxArray) {
                let tr = document.querySelector("tr[data-idx='" + idx + "']");
                tr.remove();
            }
            let numList = document.querySelectorAll("#scheduleTbody tr td span");
            numList.forEach(function (num, index) {
                num.textContent = (index + 1).toString();
            });
            alert("일정이 삭제되었습니다.");
        } else {
            alert("일정 삭제에 실패했습니다");
        }
    }

    async function updateSchedule(form) {
        let formData = new FormData(form);

        let option = {
            method: "post",
            body: formData
        }
        let response = await fetch("/admin/fclass/api/updateSchedule", option);
        let result = await response.json();

        //기존의 tr에 있던 태그를 가져왔다
        let tr = document.querySelector("#scheduleTbody tr[data-idx='" + form.idx.value + "']"); // #scheduleTbody 의 자식 중에 tr[data-idx="1"]
        let sdate = tr.querySelector('[data-hana="sdate"]');
        let startTime = tr.querySelector('[data-hana="startTime"]');
        let endTime = tr.querySelector('[data-hana="endTime"]');
        let totalCount = tr.querySelector('[data-hana="totalCount"]');

        //기존의 tr에 있던 태그의 값을 result의 값으로 수정(덮어쓰기)
        sdate.textContent = result.smonth + "월 " + result.sday + "일";
        startTime.textContent = result.startTime;
        endTime.textContent = result.endTime;
        totalCount.textContent = result.totalCount;
    }

    async function searchSchedule() {
        let sdate = document.querySelector("#dataForm");
        let data = {
            fclassIdx: ${fclass.idx},
            branchIdx: ${branch.idx},
            sdate: sdate.value
        };

        console.log(data);

        let option = {
            method: "post",
            body: JSON.stringify(data),
            headers: {
                "Content-Type": "application/json;charset=UTF-8"
            }
        };

        let response = await fetch("/fclass/api/searchSchedule", option);
        let result = await response.json();
        console.log(result);

        let scheduleThead = document.querySelector("#scheduleThead");
        scheduleThead.innerHTML = '<tr>'
                                // + '<th scope="col" class="col-1 p-0">'
                                //   + '<div class="d-flex justify-content-end align-items-center position-relative">'
                                //     + '<input class="form-check-input position-absolute" style="left: 8px;" type="checkbox" id="checkAll" onclick="checkAll()">'
                                //     + '<button class="btn text-white">삭제</button>'
                                //   + '</div>'
                                // + '</th>'

                                + '<th scope="col" style="flex: 0 0 auto; width: 4.16667%; vertical-align: middle">'
                                    + '<input class="form-check-input" type="checkbox" id="checkAll" onclick="checkAll(this)">'
                                + '</th>'
                                + '<th scope="col" class="bg-danger" style="flex: 0 0 auto; width: 6.33333%; padding: 0; vertical-align:middle;">'
                                    + '<button class="btn btn-danger text-white p-1 fw-bold" style="font-size:14.3333px" onclick="removeSchedule()">삭제</button>'
                                + '</th>'
                                + '<th scope="col" style="width: 14.5%;">클래스 수강일</th>'
                                + '<th scope="col" class="col-2">시작시간</th>'
                                + '<th scope="col" class="col-2">종료시간</th>'
                                + '<th scope="col" class="col-2">수강정원</th>'
                                + '<th scope="col" class="col-2">등록인원</th>'
                                + '<th class="col-1"></th>'
                                + '</tr>'

        let tbody = document.querySelector("#scheduleTbody");
        tbody.innerHTML = "";

        let form = document.querySelector("#updateForm");
        result.forEach(function (schedule, index) {
            let tr = document.createElement("tr");
            tr.setAttribute("role", "button");
            tr.setAttribute("data-idx", schedule.idx);
            // 체크박스의 event.stopPropagation()을 사용하기 위해서 자동으로 뜨는걸 막고, onclick 이벤트에서 toggle함.
            // tr.setAttribute("data-bs-toggle", "modal");
            tr.setAttribute("data-bs-target", "#modal2");
            tr.onclick = function () {
                $('.update-datepicker').datepicker("setDate", new Date(schedule.sdate));
                form.sdate.value = dateToString(schedule.sdate);
                form.startTime.value = schedule.startTime;
                form.endTime.value = schedule.endTime;
                form.totalCount.value = schedule.totalCount;
                form.idx.value = schedule.idx;

                let myModal = new bootstrap.Modal(document.querySelector("#modal2"), {
                    keyboard: false
                });
                myModal.toggle();
            }

            tr.innerHTML = '<th class="border-end bg-light" style="flex: 0 0 auto; width: 4.16667%; vertical-align: middle">'
                            + '<input class="form-check-input each-check" type="checkbox" id="check">'
                         + '</th>'
                         + '<td style="flex: 0 0 auto; width: 6.33333%; padding: 0; vertical-align:middle;">'
                            + '<span>'+ (index + 1) +'</span>'
                         + '</td>'
            // tr.innerHTML += '<td>' + new Date(schedule.sdate).toLocaleDateString() + '</td>'
            tr.innerHTML += '<td class="fw-bold" data-hana="sdate" style="width: 14.5%;">' + schedule.smonth + '월 ' + schedule.sday + '일' + '</td>'
            tr.innerHTML += '<td class="fw-bold" data-hana="startTime">' + schedule.startTime + '</td>'
            tr.innerHTML += '<td class="fw-bold" data-hana="endTime">' + schedule.endTime + '</td>'
            tr.innerHTML += '<td class="fw-bold" data-hana="totalCount">' + schedule.totalCount + '</td>'
            tr.innerHTML += '<td class="fw-bold" data-hana="regCount">' + schedule.regCount + '</td>'
            tr.innerHTML += '<td><button data-idx="' + schedule.idx + '" class="btn btn-danger p-0 px-2" data-bs-toggle="modal" data-bs-target="#modal">삭제</button></td>';
            tr.querySelector("th input[type='checkbox']").addEventListener("click", checkStatus);
            tr.querySelector("th").addEventListener("click", function (event) {
                tr.querySelector("th input[type='checkbox']").click();
                event.stopPropagation();
            });
            tr.querySelector("td button[data-bs-toggle='modal']").addEventListener("click", function (event) {
                event.stopPropagation();
            });
            tbody.appendChild(tr);
        })
    }

    function goToList() {
        location.href="/admin/fclass/classList";
    }

    function checkAll(allBtn) {
        let checkList = document.querySelectorAll(".each-check");
        for (let checkBox of checkList) {
            checkBox.checked = allBtn.checked;
        }
    }

    function checkStatus(event) {
        event.stopPropagation();

        let allBtn = document.querySelector("#checkAll");

        let status = true;
        let checkList = document.querySelectorAll(".each-check");
        for (let checkBox of checkList) {
            status = status && checkBox.checked;
        }
        allBtn.checked = status;
    }

    async function addSchedule() {
        let classDate = document.querySelector("#classDate");
        let startTime = document.querySelector("#startTime");
        let endTime = document.querySelector("#endTime");
        let capacity = document.querySelector("#capacity");
        let data = {
            branchIdx: ${branch.idx},
            fclassIdx: ${fclass.idx},
            sdate: classDate.value,
            startTime: startTime.value,
            endTime: endTime.value,
            totalCount: capacity.value
        };

        let option = {
            method: "post",
            body: JSON.stringify(data),
            headers: {
                "Content-Type": "application/json;charset=UTF-8"
            }
        };

        let response = await fetch("/admin/fclass/api/addSchedule", option);
        response.json().then((result) => {
            alert("클래스 일정이 추가되었습니다")
            document.getElementById('searchBtn').click();
            // location.href = "/admin/fclass/manageSchedule?classIdx=" + result.fclassIdx + "&branchIdx=" + result.branchIdx;
        }).catch(() => alert("클래스 일정 추가에 실패했습니다"));
    }

    function dateToString(dateString) {
        let date = new Date(dateString);
        let year = date.getFullYear();
        let month = date.getMonth() + 1;
        let day = date.getDate();
        month = month < 10 ? '0' + month : month;
        day = day < 10 ? '0' + day : day;

        return year + "-" + month + "-" + day;
    }

    async function checkValidDate() {
        let disabledArrayInit = [];

        let today = new Date().getTime();
        for(let i = 0; i < 60; i++) {
            // let date = new Date(today + 1000 * 60 * 60 * 24 * i);
            let dateString = dateToString(today + 1000 * 60 * 60 * 24 * i);
            disabledArrayInit.push(dateString);
        }

        let data = {
            branchIdx: ${branch.idx},
            fclassIdx: ${fclass.idx}
        };

        let option = {
            method: "post",
            body: JSON.stringify(data),
            headers: {
                "Content-Type": "application/json;charset=UTF-8"
            }
        };

        let response = await fetch("/fclass/api/searchSchedule", option);
        let result = await response.json();
        console.log(result);

        for (let scheduleVo of result) {
            // let sdate = new Date(scheduleVo.sdate);
            let sdateString = dateToString(scheduleVo.sdate);

            let number = disabledArrayInit.indexOf(sdateString);
            disabledArrayInit.splice(number, 1);
        }

        $('.select-datepicker').datepicker("setDatesDisabled",disabledArrayInit);

    }

    $(function () {
        $('.select-datepicker').datepicker({
            format: 'yyyy-mm-dd',
            showOtherMonths: false,
            startDate: 'noBefore',
            endDate: '+60d',
            setDate: 'today',
            todayHighlight: true,
            title: '"조회하실 클래스 날짜를 선택해주세요"',
            language: 'ko'
        });

        $('.register-datepicker').datepicker({
            format: 'yyyy-mm-dd',
            showOtherMonths: false,
            startDate: 'noBefore',
            endDate: '+60d',
            setDate: 'today',
            todayHighlight: true,
            title: '"등록하실 새늘봄 클래스 일정을 선택해주세요"',
            language: 'ko'
        });

        $('.update-datepicker').datepicker({
            format: 'yyyy-mm-dd',
            showOtherMonths: false,
            startDate: 'noBefore',
            endDate: '+60d',
            setDate: 'today',
            todayHighlight: true,
            title: '"변경하실 클래스 일정을 선택해주세요"',
            language: 'ko'
        });
    });

</script>
</body>
</html>

<style>

    #dataForm {
        border: none;
        border-radius: 2rem;
        width: 385px;
        text-align: center;
        font-size: large;
        font-weight: bold;
    }
    .dataForm2 {
        border: none;
        border-radius: 1rem;
        text-align: center;
        width: 230px;
    }
    table {
        text-align: center;
    }

</style>