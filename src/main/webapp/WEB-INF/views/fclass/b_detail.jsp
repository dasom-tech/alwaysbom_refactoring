<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>클래스 수정 및 상세입력</title>
    <%@ include file="../main/b_import.jspf" %>
    <script src="/static/ckeditor5-build-classic/ckeditor.js"></script>
</head>
<body>
<%@ include file="../main/b_header.jspf" %>
<form id="container" class="mx-auto p-5" action="/admin/fclass/updateClass" method="post" enctype="multipart/form-data">
    <input type="hidden" name="idx" value="${classInfo.idx}">
    <div class="d-flex justify-content-between mb-4">
        <div class="h5 text-secondary">클래스 수정 및 상세입력</div>
        <button class="btn btn-danger" type="button" data-bs-toggle="modal" data-bs-target="#myModal">클래스 삭제</button>
        <!-- 삭제 팝업 -->
        <div class="modal fade" id="myModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modalTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalTitle">클래스를 삭제하시겠습니까?</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        삭제버튼을 누르시면 클래스 복구가 불가합니다.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-primary" onclick="deleteClass(this.form)">삭제</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="d-flex mb-4">
        <div class="col-4 pe-5 d-flex flex-column justify-content-between">
            <div class="btn-group mb-4" role="group" aria-label="Basic radio toggle button group">
                <input type="radio" class="btn-check" name="category" value="원데이클래스" id="btnradio1"
                       autocomplete="off" ${classInfo.category eq '원데이클래스' ? 'checked' : ''}>
                <label class="btn btn-outline-primary" for="btnradio1">원데이클래스</label>
                <input type="radio" class="btn-check" name="category" value="플로리스트" id="btnradio2"
                       autocomplete="off" ${classInfo.category ne '원데이클래스' ? 'checked' : ''}>
                <label class="btn btn-outline-primary" for="btnradio2">플로리스트</label>
            </div>

                <c:forEach var="branch" items="${branchList}" varStatus="status">
                    <div class="form-check d-flex">
                        <input class="form-check-input" type="checkbox" value="${branch.idx}"
                               name="branches" id="cb${status.index}" ${classInfo.branchList.contains(branch) ? 'checked' : ''}>
                        <label class="form-check-label" for="cb${status.index}">${branch.name}</label>
                    </div>
                </c:forEach>

            <div class="form-floating mb-4">
                <input type="text" name="name" class="form-control" id="name" placeholder="name"
                       value="${classInfo.name}" autocomplete="off">
                <label for="name">class name</label>
            </div>
            <div class="form-floating mb-4">
                <input type="text" name="subheader" class="form-control" id="subheader" placeholder="subheader"
                       value="${classInfo.subheader}" autocomplete="off">
                <label for="subheader">class subheader</label>
            </div>
            <div class="form-floating mb-4">
                <input type="text" name="price" class="form-control" id="price" placeholder="price"
                       value="${classInfo.price}" autocomplete="off">
                <label for="price">price</label>
            </div>
            <div class="form-floating mb-4">
                <input type="text" name="discountRate" class="form-control" id="discountRate"
                       placeholder="discountRate" value="${classInfo.discountRate}" autocomplete="off">
                <label for="discountRate">discountRate</label>
            </div>
            <div class="form-floating">
                <input type="text" name="count" class="form-control" id="count"
                       placeholder="count" value="${classInfo.count}" autocomplete="off">
                <label for="count">class count</label>
            </div>
        </div>
        <!-- 파일 -->
        <div class="col-8 d-flex">
            <div class="card col-4">
                <div class="card-header mb-3">
                    <input type="file" name="file" class="form-control" id="file1" onchange="preview(this, 'img1')">
                    <%--                        <label class="input-group-text" for="file1">File 1</label>--%>
                    <input type="hidden" name="image1" value="${classInfo.image1}">
                </div>
                <img src="${classInfo.image1}" alt="사진" class="card-img-bottom" id="img1">
            </div>
            <div class="card col-4">
                <div class="card-header mb-3">
                    <input type="file" name="file" class="form-control" id="file2" onchange="preview(this, 'img2')">
                    <%--                        <label class="input-group-text" for="file2">File 2</label>--%>
                    <input type="hidden" name="image2" value="${classInfo.image2}">
                </div>
                <img src="${classInfo.image2}" alt="사진" class="card-img-bottom ${empty classInfo.image2 ? 'd-none' : ''}" id="img2">
            </div>
            <div class="card col-4">
                <div class="card-header mb-3">
                    <input type="file" name="file" class="form-control" id="file3" onchange="preview(this, 'img3')">
                    <%--                        <label class="input-group-text" for="file3">File 3</label>--%>
                    <input type="hidden" name="image3" value="${classInfo.image3}">
                </div>
                <img src="${classInfo.image3}" alt="사진" class="card-img-bottom ${empty classInfo.image2 ? 'd-none' : ''}" id="img3">
            </div>
        </div>
    </div>

    <div class="col-12 mb-4">
        <label class="form-label" for="content">내용</label>
        <textarea name="content" id="content">${classInfo.content}</textarea>
    </div>

    <div class="col-12 mb-4 text-center">
        <button type="button" class="btn btn-danger btn-lg col-4" onclick="history.back()">취소</button>
        <button type="submit" class="btn btn-info btn-lg col-4">수정</button>
    </div>
</form>


<%@ include file="../main/b_footer.jspf" %>
<script>
    function preview(file, id) {
        let img = document.querySelector("#" + id);

        let reader = new FileReader();
        reader.onload = function (e) {
            img.setAttribute("src", e.target.result.toString());
            img.classList.remove("d-none");
        }
        reader.readAsDataURL(file.files[0]);
    }

    function deleteClass(form) {
        form.action = "/admin/fclass/deleteClass";
        form.submit();
    }
</script>
<script src="/static/js/imageUploader.js"></script>
</body>
</html>
