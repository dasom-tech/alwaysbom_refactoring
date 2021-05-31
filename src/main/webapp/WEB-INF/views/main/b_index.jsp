<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>백 오피스 메인</title>
    <%@ include file="b_import.jspf"%>
    <style>
        .square {
            position: relative;
        }

        .square.wide::after {
            content: "";
            display: block;
            padding-bottom: 40%;
        }

        .square .inner {
            position: absolute;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
    </style>
</head>
<body>
<%@ include file="b_header.jspf" %>
<div id="container" class="mx-auto bg-white d-flex flex-column p-3">
    <div class="pb-3">
        <h2 class="m-0 p-0">메인 페이지 관리</h2>
    </div>
    <form enctype="multipart/form-data" class="d-flex flex-column border border-secondary col-12">
        <div class="d-flex">
            <div class="col-2 border-bottom border-end border-secondary bg-warning p-3">메인 이미지 등록</div>
            <ul class="col-10 list-unstyled m-0 p-0 d-flex flex-wrap border-bottom border-secondary">
                <c:forEach var="image" items="${mainConfig.images}" varStatus="status">
                <li class="col-6 p-3 image-box">
                    <input type="file" name="image" class="visually-hidden"
                           onchange="changeImage(this, ${status.index})">
                    <div class="position-relative col-12 square wide">
                        <button type="button" onclick="clickFileButton(${status.index})"
                                class="inner empty btn btn-outline-warning ${not empty image.path ? "d-none" : ""}">
                            등록
                        </button>
                        <div class="inner exist ${empty image.path ? "d-none" : ""}">
                            <img src="${not empty image.path ? image.path : ""}" alt="" class="inner">
                            <div class="position-absolute end-0 top-0">
                                <div class="d-flex p-3">
                                    <select name="link" class="me-2" ${empty image.path ? "disabled" : ""}>
                                        <option value="/subs" ${image.link eq "/subs" ? "selected" : ""}>정기구독</option>
                                        <option value="/flower" ${image.link eq "/flower" ? "selected" : ""}>꽃다발</option>
                                        <option value="/product" ${image.link eq "/product" ? "selected" : ""}>소품샵</option>
                                        <option value="/fclass/classList" ${image.link eq "/fclass/classList" ? "selected" : ""}>클래스</option>
                                        <option value="/community/event/eventlist" ${image.link eq "/community/event/eventlist" ? "selected" : ""}>커뮤니티</option>
                                    </select>
                                    <button type="button" class="btn btn-warning btn-sm me-2"
                                            onclick="clickFileButton(${status.index})">수정</button>
                                    <button type="button" class="btn btn-danger btn-sm"
                                            onclick="showDeleteModal(${status.index})">삭제</button>
                                    <input type="hidden" name="deleted" value="false">
                                </div>
                            </div>
                        </div>
                    </div>

                </li>
                </c:forEach>
            </ul>
        </div>
        <div class="d-flex border-bottom border-secondary">
            <div class="col-2 p-3 border-secondary border-end bg-warning">
                <div>플라워 클래스</div>
            </div>
            <div class="col-10 p-3 d-flex">
                <div class="col-3 d-flex flex-column me-3">
                    <label for="fclassIdxBig">썸네일 대형</label>
                    <select class="form-select" id="fclassIdxBig">
                        <c:forEach var="fclass" items="${classes}">
                            <option value="${fclass.idx}" ${fclass.idx == mainConfig.fclassIdxBig ? "selected" : ""}>${fclass.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-3 d-flex flex-column">
                    <label for="fclassIdxSmall">썸네일 소형</label>
                    <select class="form-select" id="fclassIdxSmall">
                        <c:forEach var="fclass" items="${classes}">
                            <option value="${fclass.idx}" ${fclass.idx == mainConfig.fclassIdxSmall ? "selected" : ""}>${fclass.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>
        <div class="p-3 d-flex flex-column align-items-center bg-secondary">
            <button type="button" class="btn btn-dark col-4"
                    onclick="saveConfig(this.form)">변경사항 저장
            </button>
        </div>
    </form>
</div>
<%@ include file="b_footer.jspf"%>

<!-- 삭제 팝업 -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">삭제하시겠습니까?</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button id="deleteConfirm" type="button" class="btn btn-danger" data-bs-dismiss="modal">삭제</button>
            </div>
        </div>
    </div>
</div>

<!-- 저장 완료 팝업 -->
<div class="modal fade" id="saveModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">변경사항이 저장되었습니다</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>


<script>
    function clickFileButton(index) {
        let box = document.querySelectorAll(".image-box")[index];
        let file = box.querySelector("input[type=file]");

        file.click();
    }

    function showDeleteModal(index) {
        const $deleteModal = document.querySelector("#deleteModal")
        const $modal = new bootstrap.Modal($deleteModal);
        const $deleteConfirm = document.querySelector("#deleteConfirm");
        $deleteConfirm.onclick = function () {
            deleteImage(index);
        }
        $modal.show();
    }

    function deleteImage(index) {
        let box = document.querySelectorAll(".image-box")[index];
        let file = box.querySelector("input[type=file]");
        file.value = "";

        let img = box.querySelector("img");
        img.removeAttribute("src");

        let exist = box.querySelector(".exist");
        exist.classList.add("d-none");

        let empty = box.querySelector(".empty");
        empty.classList.remove("d-none");
        box.querySelector("select").setAttribute("disabled", "true");
        let deleted = box.querySelector("[name=deleted]");
        deleted.value = "true";
    }

    function changeImage(file, index) {
        let fileReader = new FileReader();
        let box = document.querySelectorAll(".image-box")[index];

        fileReader.onload = function (e) {
            let img = box.querySelector("img");
            img.setAttribute("src", e.target.result.toString());

            let exist = box.querySelector(".exist");
            exist.classList.remove("d-none");

            let empty = box.querySelector(".empty");
            empty.classList.add("d-none");
        }

        fileReader.readAsDataURL(file.files[0])

        if (file.files[0]) {
            box.querySelector("select").removeAttribute("disabled");
        }
    }

    function saveConfig(form) {
        let formData = new FormData();
        // let file = document.querySelector("[type=file]").files[0];
        let files = document.querySelectorAll("[type=file]");
        files.forEach((file, index) => {
            formData.append("image", file.files[0] || new Blob());
            formData.append("link", form.link[index].value);
            formData.append("deleted", form.deleted[index].value);
        });
        formData.append("fclassIdxBig", document.querySelector("#fclassIdxBig").value);
        formData.append("fclassIdxSmall", document.querySelector("#fclassIdxSmall").value);

        const option = {
            method: "POST",
            body: formData,
        };

        fetch("/api/admin/configs", option).then(response => {
            response.json().then(result => {
                console.log(result);
                new bootstrap.Modal(document.querySelector("#saveModal")).show();
            })
        }).catch(err => {
            console.log(err);
        })
    }
</script>
</body>
</html>
