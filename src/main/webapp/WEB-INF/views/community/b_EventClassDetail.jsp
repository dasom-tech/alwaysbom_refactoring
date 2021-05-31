<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<html>
<head>
    <title>이벤트 추가</title>
    <%@ include file="../main/b_import.jspf"%>
    <script src="/static/ckeditor5-build-classic/ckeditor.js"></script>
    <link rel="stylesheet" href="/static/bootstrap-datepicker/bootstrap-datepicker.css">
    <script src="/static/bootstrap-datepicker/bootstrap-datepicker.js"></script>
</head>
<body>
    <%@ include file="../main/b_header.jspf"%>
    <form id="container" class="mx-auto p-5" action="/admin/community/UpdateEvent" method="post" enctype="multipart/form-data">
        <input type="hidden" name="idx" value="${eventVo.idx}">
        <div class="d-flex justify-content-between mb-4">
            <div class="h5 text-secondary">이벤트 수정 및 상세입력</div>
            <button class="btn btn-danger" type="button" data-bs-toggle="modal" data-bs-target="#myModal">이벤트 삭제</button>
            <!-- 삭제 팝업 -->
            <div class="modal fade" id="myModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modalTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalTitle">이벤트를 삭제하시겠습니까?</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            삭제버튼을 누르시면 이벤트 복구가 불가합니다.
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
            <div class="col-4 pe-5 d-flex flex-column justify-content-center">
                <div class="form-floating mb-4 text-secondary">
                    <input type="text" name="name" class="form-control text-secondary" id="name" placeholder="name" value="${eventVo.name}" autocomplete="off">
                    <label for="name">Event name</label>
                </div>

                <div>
                    <label for="startDate">startDate</label>
                    <input type="text" placeholder="시작일을 정해주세요" id="startDate" name="startDate" class="form-control datepicker form-floating p-2 mb-4 text-secondary dataForm2" required="required" aria-label="시작일" value="${eventVo.startDate}"/>
                </div>

                <div>
                    <label for="endDate">endDate</label>
                    <input type="text" placeholder="종료일을 정해주세요" id="endDate" name="endDate" class="form-control datepicker form-floating p-2 mb-4 text-secondary dataForm2" required="required" aria-label="종료일" value="${eventVo.endDate}"/>
                </div>
            </div>
            <!-- 파일 -->
            <div class="col-8 d-flex">
                <div class="card col-4">
                    <div class="card-header mb-3">
                        <label for="file1">섬네일이미지</label>
                        <input type="file" name="file" class="form-control" id="file1" onchange="preview(this, 'img1')">
                        <input type="hidden" name="thumb" value="${eventVo.thumb}">
                    </div>
                    <img src="${eventVo.thumb}" alt="사진" class="card-img-bottom" id="img1">
                </div>
                <div class="card col-4">
                    <div class="card-header mb-3">
                        <label for="file2">메인이미지</label>
                        <input type="file" name="file" class="form-control" id="file2" onchange="preview(this, 'img2')">
                        <input type="hidden" name="image1" value="${eventVo.image1}">
                    </div>
                    <img src="${eventVo.image1}" alt="사진" class="card-img-bottom" id="img2">
                </div>
                <div class="card col-4">
                    <div class="card-header mb-3">
                        <label for="file3">추가이미지</label>
                        <input type="file" name="file" class="form-control" id="file3" onchange="preview(this, 'img3')">
                        <input type="hidden" name="image2" value="${eventVo.image2}">
                    </div>
                    <c:if test="${not empty eventVo.image2}">
                    <img src="${eventVo.image2}" alt="사진" class="card-img-bottom" id="img3">
                    </c:if>
                </div>
            </div>
        </div>

        <div class="col-12 mb-4">
            <label class="form-label" for="content">내용</label>
            <textarea class="form-control" name="content" id="content">${eventVo.content}</textarea>
        </div>

        <div class="col-12 mb-4 text-center">
            <button type="button" class="btn btn-danger btn-lg col-4" onclick="history.back()">취소</button>
            <button type="submit" class="btn btn-dark btn-lg col-4">수정</button>
        </div>
    </form>
    <%@ include file="../main/b_footer.jspf"%>
<script>
    function preview(file, id) {
        let img = document.querySelector("#" + id);

        let reader = new FileReader();
        reader.onload = function(e) {
            img.setAttribute("src", e.target.result.toString());
            img.classList.remove("d-none");
        }
        reader.readAsDataURL(file.files[0]);
    }
</script>
<script>
      $(function (){
        $('.datepicker').datepicker({
            autoclose: true,
            format: 'yyyy-mm-dd',
            showOtherMonths: false,
            startDate: 'noBefore',
            setDate: 'today',
            todayHighlight: true,
            title: '"등록하실 이벤트 일정을 선택해주세요"',
            language: 'ko'
        });
      });

      function deleteClass(form) {
          form.action = "/admin/community/eventDelete";
          form.submit();
      }

</script>
<script src="/static/js/imageUploader.js"></script>
</body>
<style>
    .dataForm2 {
        text-align: center;
    }
</style>
</html>
