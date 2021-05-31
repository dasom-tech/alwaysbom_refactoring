<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Managing branch</title>
    <%@ include file="../main/b_import.jspf"%>
    <style>
        /*#container {*/
        /*    margin: 0 auto;*/
        /*}*/

        /*.branchList-wrap {*/
        /*    flex : auto;*/
        /*    flex-direction: row;*/
        /*    flex-wrap: wrap;*/
        /*    display: flex;*/
        /*    justify-content: center;*/
        /*    width: 1280px;*/
        /*    border: 1px solid black;*/
        /*}*/

        .file-wrap {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .btn-secondary, .btn-outline-danger {
            margin: 15px 0;
        }
        .imageBox {
            margin-bottom: 5px;
        }
        a {
            color: white;
            text-decoration: none;
        }
        .btn-dark:hover {
            color: white;
            background-color: gray;
            text-decoration: none;

        }
        .invisible {
            display: none;
        }

        .colorpicker > button {
            width: 6.25%;
        }
    </style>
</head>
<body>
<%@ include file="../main/b_header.jspf"%>
<div id="container" class="mx-auto p-3">
    <div class="px-3">
        <button type="button" class="btn btn-dark"><a href="/admin/fclass/classList">이전페이지</a></button>
        <h2>지점 리스트</h2>
    </div>
<%--    <div class="branchList-wrap">--%>
    <div class="d-flex flex-wrap justify-content-start">
        <c:forEach var="branch" items="${list}">
            <form enctype="multipart/form-data" class="col-4 px-3">
                <div class="card w-100" style="height: 39rem;">
                    <div class="card-body">
                        <div class="mb-3">
                            <label for="formGroupExampleInput" class="form-label">지점명</label>
                            <input type="text" name="name" value="${branch.name}" class="form-control"
                                   id="formGroupExampleInput" placeholder="Example input placeholder" required autocomplete="off">
                        </div>
                        <div class="mb-3">
                            <label for="formGroupExampleInput2" class="form-label">지점컬러</label>
                            <input type="text" name="color" value="${branch.color}" class="form-control" onchange="changeBg(this)"
                                   id="formGroupExampleInput2" placeholder="Another input placeholder"  style="background-color: ${branch.color}" required autocomplete="off">
                        </div>
                        <div class="mb-3">
                            <label for="formGroupExampleInput3" class="form-label">지점위치</label>
                            <input type="text" name="addr" value="${branch.addr}" class="form-control"
                                   id="formGroupExampleInput3" placeholder="Another input placeholder" required autocomplete="off">
                        </div>
                    </div>
                    <div class="file-wrap">
                        <div class="overflow-hidden" style="height: 200px">
                            <img src="${branch.mapImage}" width="300px" class="imageBox">
                        </div>
                        <input type="hidden" name="mapImage" value="${branch.mapImage}">
                        <input type="file" name="file" class="bmap" onchange="preview(this)" required/>
                        <div>
                            <button type="button" class="btn btn-secondary"
                                    onclick="goUpdate(this.form, ${branch.idx})">수정
                            </button>
                            <button type="button" class="btn btn-outline-danger"
                                    onclick="goDelete(this.form, ${branch.idx})">삭제
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </c:forEach>
    </div>

    <form enctype="multipart/form-data" class="col-4 p-3">
        <h2>지점추가</h2>
        <div class="card branchList-wrap w-100" style="height: 39rem;">
            <div class="card-body">
                <div class="mb-3">
                    <label for="name" class="form-label">지점명</label>
                    <input type="text" name="name"  class="form-control"
                           id="name" placeholder="추가할 지점명을 입력하세요" required autocomplete="off">
                </div>
                <div class="mb-3">
                    <label for="demo" class="form-label">지점컬러</label>
                    <input id="demo" type="text" name="color" class="form-control mb-1" placeholder="지점컬러" onchange="changeBg(this)" required autocomplete="off">
                    <div class="colorpicker d-flex" style="height: 15px"></div>
                </div>
                <div class="mb-3">
                    <label for="addr" class="form-label">지점위치</label>
                    <input type="text" name="addr"  class="form-control"
                           id="addr" placeholder="추가할 지점주소를 입력하세요" required autocomplete="off">
                </div>
                <div class="file-wrap">
                    <div class="overflow-hidden" style="height:200px">
                        <img id="preImg" src="" width="300px" class="imageBox invisible">
                    </div>
                    <input type="file" name="file" class="bmap" onchange="preview(this)" required/>
                    <button type="button" class="btn btn-secondary" onclick="branchUpload(this.form)">추가합니다</button>
                </div>
            </div>

        </div>
    </form>
</div>
<%@ include file="../main/b_footer.jspf"%>
<script>
    // let colorArray = [ '#000000', '#fe0000', '#ff7900', '#ffb900', '#ffde00', '#fcff00', '#d2ff00', '#05c000', '#00c0a7', '#0600ff', '#6700bf', '#9500c0', '#bf0199', '#ffffff' ]
    let colorArray = ['#8DD7BF', '#FF96C5', '#FF5768', '#FFBF65', '#FC6238', '#FFD872', '#6C88C4', '#C05780', '#FF828B', '#0065A2', '#00CDAC', '#FF6F68', '#CFF800', '#4DD091', '#FFEC59', '#FFA23A']
    let colorPicker = document.querySelector(".colorpicker");
    let demo = document.querySelector("#demo");
    for(let value of colorArray) {
        let button = document.createElement("button");
        button.className = "border-0";
        button.style = "background-color : " + value;
        button.type = "button";
        button.onclick = function () {
            demo.value = value;
            demo.style = "background-color : " + value;
        }
        colorPicker.appendChild(button);
    }

    function changeBg(tag) {
        tag.style = "background-color : " + tag.value;
    }

    async function branchUpload(branch) {
        let formData = new FormData(branch);
        let option = {
            method: "post",
            body: formData
        };
        let response = await fetch("/admin/fclass/api/addBranch", option);
        response.json().then(() => {
            alert("추가되었습니다")
            location.href = "/admin/fclass/branch";
        }).catch(() => alert("클래스 추가 실패했습니다"));
    }

    async function goUpdate(form, idx) {
        let formData = new FormData(form);
        formData.append("idx", idx);

        let option = {
            method: "post",
            body: formData
        }
        let response = await fetch("/admin/fclass/api/updateBranch", option);
        let result = await response.json();
        console.log(result);
        alert("수정되었습니다");
        location.href = "/admin/fclass/branch";
    }

    async function goDelete(form, idx) {
        let formData = new FormData(form);
        formData.append("idx", idx);

        let option = {
            method: "post",
            body: formData
        }
        let response = await fetch("/admin/fclass/api/deleteBranch", option);
        let result = await response.json();
        console.log(result);
        alert("삭제되었습니다");
        form.remove();
        location.href = "/admin/fclass/branch";
    }

    function preview(file) {
        let img = file.form.querySelector(".imageBox");

        let reader = new FileReader();
        reader.onload = function(e) {
            img.setAttribute("src", e.target.result.toString());
            img.classList.remove("invisible");
        }
        reader.readAsDataURL(file.files[0]);
    }
</script>
</body>
</html>
