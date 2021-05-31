<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<html>
<head>
    <title>Title</title>
    <%@ include file="../main/b_import.jspf"%>
</head>
<body>
<div class="d-flex flex-column w-25">
    <div id="hana" class="carousel slide carousel-fade" data-bs-interval="0" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="/static/image/flower/flower1.jpg" class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
                <img src="/static/image/flower/flower2.jpg" class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
                <img src="/static/image/flower/vase3-1.jpg" class="d-block w-100" alt="...">
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#hana" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#hana" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
    <div class="d-flex mt-3">
        <button type="button" data-bs-target="#hana" data-bs-slide-to="0" class="active col-4 border-0 bg-transparent m-0 p-0" aria-current="true"
                aria-label="Slide 1">
            <img src="/static/image/flower/flower1.jpg" alt="..." class="w-100">
        </button>
        <button type="button" data-bs-target="#hana" data-bs-slide-to="1" class="col-4 border-0 bg-transparent m-0 p-0" aria-label="Slide 2">
            <img src="/static/image/flower/flower2.jpg" alt="..." class="w-100">
        </button>
        <button type="button" data-bs-target="#hana" data-bs-slide-to="2" class="col-4 border-0 bg-transparent m-0 p-0" aria-label="Slide 3">
            <img src="/static/image/flower/vase3-1.jpg" alt="..." class="w-100">
        </button>
    </div>
</div>
</body>
<script>
</script>
</html>