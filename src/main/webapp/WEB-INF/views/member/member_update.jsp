<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원 정보 관리</title>
    <%@ include file="../main/import.jspf" %>
</head>
<body>
<%@ include file="../main/header.jspf" %>
<div id="container" class="mx-auto d-flex flex-column h-100 user-select-none">
    <%@ include file="../member/mypage_header.jspf" %>
    <div class="h-85 d-flex">
        <%@ include file="../member/mypage_menu.jspf" %>
            <div class="col-10 border-info d-flex justify-content-center p-4">
                <div class="col-12" id="contentPane">
                    <div class="col-12 border-info d-flex justify-content-center p-4">
                        <div class="col-12">
                            <div class="d-flex flex-column text-secondary">
                            <span class="h5">회원 정보 관리</span>
                            <hr class="hr1"/>
                        </div>
                        <form role="form" action="/member_update" method="post" onsubmit="confirm();">
                            <fieldset>
                                <p>
                                    <label class="txt">이름</label>
                                    <input type="text" name="name" value="${sessionScope.member.name}" maxlength="255" class="form-control form-control-sm" required id="id_name" autocomplete="off" />
                                </p>
                                <p>
                                    <label class="txt">비밀번호</label>
                                    <input type="password" name="pw" value="${sessionScope.member.pw}" maxlength="255" class="form-control form-control-sm" required id="id_pw" autocomplete="off" />
                                </p>
                                <p>
                                    <label class="txt">비밀번호 확인</label>
                                    <input type="password" name="pwCfm" maxlength="255" class="form-control form-control-sm" required id="id_pwCfm" autocomplete="off"/>
                                </p>
                                <p>
                                    <label class="txt">아이디(이메일)</label>
                                    <input type="text" name="id" value="${sessionScope.member.id}" readonly="readonly" class="form-control form-control-sm" maxlength="255" autocomplete="off"/>
                                </p>
                                <p>
                                    <label class="txt">휴대폰 번호</label>
                                    <input type="text" name="phone" id="phone" value="${sessionScope.member.phone}" class="form-control form-control-sm" maxlength="15" minlength="9" autocomplete="off"/>
                                </p>
                                <p>
                                    <label class="txt">생년월일</label>
                                    <input type="date" name="birth" id="birth" value="${sessionScope.member.birth}" class="form-control form-control-sm" autocomplete="off" />
                                </p>
                                    <label class="txt">성별</label>
                                    <div class="d-grid gap-2 d-flex col-12 gender-area">
                                        <label class="col-6">
                                            <input type="radio" name="gender" value="female" ${sessionScope.member.gender eq 'female' ? "checked" : ""}
                                                   class="d-none" ${empty sessionScope.member.gender ? "" : "disabled"} />
                                            <span class="col-12 d-block p-3 btn btn-gender">여성</span>
                                        </label>
                                        <label class="col-6">
                                            <input type="radio" name="gender" value="male" ${sessionScope.member.gender eq 'male' ? "checked" : ""}
                                                   class="d-none" ${empty sessionScope.member.gender ? "" : "disabled"}>
                                            <span class="col-12 d-block p-3 btn btn-gender">남성</span>
                                        </label>
                                    </div>
                                <div class="d-grid col-3 mx-auto">
                                    <input type="submit" class="btn btn-lg m-4 btn-outline-danger" value="정보수정" />
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function confirm(){
        alert('정보 수정이 완료되었습니다:-)');
    }
</script>
</body>
<%@ include file="../main/footer.jspf"%>
</html>
<style>
    .btn-gender,
    .gender-area input[type=radio]:not([checked])[disabled] + .btn-gender:hover {
        background-color: darkgrey;
        color: white;
    }

    .gender-area input[type=radio] + .btn-gender:hover {
        background-color: grey;
        color: white;
    }

    .gender-area input[type=radio]:checked + .btn-gender,
    .gender-area input[type=radio][checked] + .btn-gender {
        background-color: grey;
        color: white;
    }
</style>