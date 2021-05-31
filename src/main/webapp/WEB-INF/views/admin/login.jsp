<%--
  Created by IntelliJ IDEA.
  User: minho
  Date: 2021-04-11
  Time: 오후 2:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>로그인</title>
    <%@ include file="../main/b_import.jspf"%>
</head>
<body class="d-flex flex-column align-items-center justify-content-center bg-secondary">
<div class="container d-flex flex-column justify-content-center align-items-center m-0 p-0 h-100">
    <div class="my-auto col-sm-12 col-md-6 col-lg-4 d-flex flex-column ">
        <div>관리자 페이지</div>
        <form class="border border-secondary bg-dark rounded-3 d-flex flex-column"
              action="/admin/login" method="post">
            <div class="p-3">
                <input type="text" class="form-control" autocomplete="off" name="id" placeholder="아이디">
            </div>
            <div class="p-3">
                <input type="password" id="password" class="form-control" autocomplete="off" name="password" placeholder="비밀번호">
            </div>
            <hr class="bg-light px-3 m-0">
            <div class="p-3">
                <button type="button" class="col-12 btn btn-primary" onclick="login(this.form)">로그인</button>
            </div>
        </form>
    </div>
</div>
<script>
    document.querySelector("#password").addEventListener("keyup", (ev) => {
        if(ev.keyCode === 13) {
            login(ev.target.form);
        }
    })

    function login(form) {
        fetch("/admin/login", {
            method: "post",
            body: new FormData(form)
        }).then(response => {
            response.json().then(result => {
                if (result) {
                    location.href="/admin/main";
                } else {
                    alert("아이디, 비밀번호를 확인해주세요");
                }
            })
        })
    }
</script>
</body>
</html>
