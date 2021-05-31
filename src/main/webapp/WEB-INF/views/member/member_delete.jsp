<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<title>회원탈퇴</title>
<%@ include file="../main/import.jspf" %>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<%@ include file="../main/header.jspf" %>
<div id="container" class="mx-auto d-flex flex-column user-select-none">
    <%@ include file="../member/mypage_header.jspf" %>
    <div class="h-85 d-flex">
        <%@ include file="../member/mypage_menu.jspf" %>
        <div class="col-10 border-info d-flex justify-content-center p-4">
            <div class="col-12" id="contentPane">
                <div class="col-12 border-info d-flex justify-content-center p-4">
                    <div class="col-12">
                        <form action="/member_delete" method="post" id="delForm" onSubmit="return checkVal(this.form)">
                            <input type="hidden" name="id" value="${sessionScope.member.id}">
                            <div class="d-flex text-secondary">
                                <span class="h5">회원 탈퇴 안내</span>
                            </div>
                            <hr class="hr1"/>
                            ${sessionScope.member.name} 고객님,
                            <br>
                            탈퇴를 원하신다니 마음이 아프네요.
                            <hr>
                            지금 탈퇴하시면 고객님의 ${sessionScope.member.point}포인트는 자동 소멸됨을 알려드립니다.
                            <div class="mt-5">
                                <span class="h5">비밀번호 확인(필수)</span>
                                <input type="password" name="pw" maxlength="255" class="form-control form-control-sm mt-3" required id="pw"/>
                            </div>
                            <div class="text-center col-12 mt-5">
                                <button type="submit" id="submit" class="btn btn-danger col-3">탈퇴하기</button>
                                <button type="button" class="btn btn-secondary col-3" onclick="location.href='/'">취소하기</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>

    function checkVal() {

        let pwd = document.querySelector("#pw");

        if (pwd.value === "") {
            alert("비밀번호를 입력해주세요.");
            return false;
        }
        if (pwd.value !== "${sessionScope.member.pw}") {
            alert("비밀번호가 일치하지 않습니다. 확인해주세요.");
            return false;
        }
        if (pwd.value === "${sessionScope.member.pw}") {
            alert("탈퇴가 완료되었습니다. 감사합니다.");
        }
    }
</script>
</body>
<%@ include file="../main/footer.jspf"%>
</html>