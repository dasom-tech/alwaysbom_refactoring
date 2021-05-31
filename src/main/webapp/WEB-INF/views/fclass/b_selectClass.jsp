<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<html>
<head>
    <title>클래스 수업 지점 선택</title>
    <%@ include file="../main/b_import.jspf"%>
</head>
<body>
<%@ include file="../main/b_header.jspf"%>
<form id="container" class="mx-auto pt-5" method="get" action="/admin/fclass/manageSchedule">
        <div class="d-flex justify-content-center align-items-center py-5">
            <span class="fs-2 fw-bold">관리할 클래스 선택</span>
        </div>
    <div class="d-flex justify-content-between">
        <div class="col-4 d-flex justify-content-center align-items-center p-5">
            <select class="form-select form-select-lg lh-lg" aria-label="select"
                    id="category" name="category" onchange="findByCategory(this.value)">
                <option selected disabled>카테고리를 선택해주세요</option>
                <option value="원데이클래스">원데이클래스</option>
                <option value="플로리스트">플로리스트</option>
            </select>
        </div>
        <div class="col-4 d-flex justify-content-center align-items-center p-5">
            <select class="form-select form-select-lg lh-lg" aria-label="select" disabled
                    id="classIdx" name="classIdx" onchange="findByClassIdx(this.value)">
                <option selected>클래스를 선택해주세요</option>
                <option value="원데이클래스">원데이클래스</option>
                <option value="플로리스트">플로리스트</option>
            </select>
        </div>
        <div class="col-4 d-flex justify-content-center align-items-center p-5">
            <select class="form-select form-select-lg lh-lg" aria-label="select" disabled
                    id="branchIdx" name="branchIdx" onchange="enableNextBtn()">
                <option selected>지점을 선택해주세요</option>
                <option value="원데이클래스">원데이클래스</option>
                <option value="플로리스트">플로리스트</option>

            </select>
        </div>
    </div>
    <div class="d-flex justify-content-center pt-5">
        <div class="col-4 d-flex justify-content-center align-items-baseline p-5">
            <button id="nextBtn" type="submit" class="btn btn-dark btn-lg px-5" disabled>다음으로</button>
        </div>
    </div>
</form>
<%@ include file="../main/b_footer.jspf"%>
<script>
    async function findByCategory(category) {
        let response = await fetch("/admin/fclass/api/findClassByCategory?category=" + category);
        let result = await response.json();
        console.log(result);

        let selectElement = document.querySelector("#classIdx");
        let branch = document.querySelector("#branchIdx");
        let nextBtn = document.querySelector("#nextBtn");

        selectElement.innerHTML = "";selectElement.innerHTML = "";
        let defaultOption = document.createElement("option");
        defaultOption.setAttribute("selected", "true");
        defaultOption.setAttribute("disabled", "true");
        defaultOption.innerText = "클래스를 선택해주세요";
        selectElement.appendChild(defaultOption);

        branch.setAttribute("selected", "false");
        branch.setAttribute("disabled", "false");
        branch.innerHTML = "<option selected disabled>지점을 선택해주세요</option>";
        nextBtn.setAttribute("disabled", "false");

        for (fclass of result) {
            if (fclass.branchList.length > 0) { //branchList가 빈 배열이 아니면
                let option = document.createElement("option");
                option.value = fclass.idx;
                option.innerText = fclass.name;
                selectElement.appendChild(option);
            }
        }
        selectElement.removeAttribute("disabled");
    }
    async function findByClassIdx(classIdx) {

        let response = await fetch("/admin/fclass/api/findBranchByClassIdx?classIdx=" + classIdx);
        let result = await response.json();
        console.log(result);

        let selectElement = document.querySelector("#branchIdx");

        selectElement.innerHTML = "<option selected disabled>지점을 선택해주세요</option>";

        for (branch of result) {
            let option = document.createElement("option");
            option.value = branch.idx;
            option.innerText = branch.name;
            selectElement.appendChild(option);
        }
        selectElement.removeAttribute("disabled");
    }

    function enableNextBtn() {
        let nextBtn = document.querySelector("#nextBtn");
        nextBtn.removeAttribute("disabled");
    }
</script>
</body>
</html>
