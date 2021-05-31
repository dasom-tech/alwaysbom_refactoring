<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<title>회원가입</title>
<%@ include file="../main/import.jspf"%>
<script src="/static/bootstrap-datepicker/bootstrap-datepicker.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
    function joinform_check() {
        const joinPassword = document.querySelector("#joinPassword");
        var id = document.getElementById("id");
        var pw = document.getElementById("pw");
        var pwCfm = document.getElementById("pwCfm");
        var name = document.getElementById("name");
        var phone = document.getElementById("phone");

        if(!joinPassword.value) {
            alert("가입 승인비밀번호를 입력해주세요");
            joinPassword.focus();
            return false;
        }

        if(!document.join_form.id.value) {
            alert("아이디를 입력해주세요.");
            join_form.id.focus();
            return false;
        }
        var idCheck =/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-z]{2,3}$/;

        if(!idCheck.test(id.value)) {
            alert("아이디를 이메일 형식에 맞게 입력해주세요.");
            join_form.id.focus();
            return false;
        }
        if(!document.join_form.pw.value){
            alert("비밀번호를 입력해주세요.");
            return false;
        }
        if(!document.join_form.pwCfm.value){
            alert("비밀번호를 동일하게 다시 입력해주세요.");
            return false;
        }
        //비밀번호와 비밀번호 확인 입력값이 다를때
        if(document.join_form.pw.value != document.join_form.pwCfm.value){
            alert("비밀번호가 일치하지 않습니다. 확인해주세요.");
            return false;
        }
        //비밀번호 영문자+숫자+특수조합(8~25자리 입력) 정규식
        var pwdCheck = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/;

        if (!pwdCheck.test(pw.value)) {
            alert("비밀번호는 영문자+숫자+특수문자 조합으로 8~25자리 사용해야 합니다.");
            pw.focus();
            return false;
        }

        if(!document.join_form.name.value){
            alert("이름을 입력해주세요.");
            return false;
        }
        var reg = /[0,1,6,7,8,9]{3}[-]+[0-9]{4}[-]+[0-9]{4}/; //숫자만 입력하는 정규식

        if (!reg.test(phone.value)) {
            alert("전화번호는 숫자만 사용하여 010-1234-5678 형식으로 입력할 수 있습니다.");
            phone.focus();
            return false;
        }

        if(!document.join_form.phone.value){
            alert("휴대폰 번호를 입력해주세요.");
            return false;
        }
        if(!document.join_form.birth.value){
            alert("생년월일을 입력해주세요.");
            return false;
        }
        if(!document.join_form.gender.value){
            alert("성별을 선택해주세요.");
            return false;
        }
        //입력 값 전송
        document.join_form.submit();
    }

    $(function(){
        let timer;
        // 아이디 중복체크
        document.querySelector("#id").addEventListener("keyup", function() {
            let idString = this.value;
            let warning = this.nextElementSibling;

            clearTimeout(timer);
            timer = setTimeout(function() {
                $.ajax({
                    url: "/idCheck",
                    method: "get",
                    data: {
                        id: idString
                    },
                    dataType: "json",
                    success: function(hasId) {
                        if (hasId) {
                            // 중복
                            // 경고메시지 표시(classList.remove("hidden"))
                            warning.classList.remove("hidden");
                            document.querySelector("#id").classList.add("red-border");

                        } else {
                            // 중복없음
                            warning.classList.add("hidden");
                            document.querySelector("#id").classList.remove("red-border");
                        }
                    }
                });
            }, 300);
        });
    });
</script>
</head>
<body>
<%@ include file="../main/header.jspf" %>
<div class="col-5 mx-auto">
<form role="form" action="/member_join" method="post" name="join_form" onsubmit="return joinform_check()">
    <div class="join-header py-3 mb-4">
        <h5 class="page_title text-center p-2 mt-5 text-secondary m-0">회원가입</h5>
    </div>

    <label class="my-2">가입 비밀번호</label>
    <div class="d-flex flex-column mb-4">
        <input type="password" id="joinPassword" name="joinPassword" value="" class="col-12 mb-4"
               title="테스트용 가입승인 비밀번호를 입력해주세요" maxlength="255" placeholder="가입 비밀번호 입력" autocomplete="off"/>
    </div>

    <label class="my-2">이메일 (아이디)</label>
    <div class="d-flex flex-column mb-4">
        <!--<input type="text" id="id" name="id" value="${kakao_id}" class="col-12 mr-3" maxlength="255" placeholder="6~30자 이메일 형식(특수문자 사용불가)" pattern="^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-z]{2,3}$" />-->
        <input type="text" id="id" name="id" value="${kakao_id}" class="col-12 mr-3" maxlength="255" placeholder="6~30자 이메일 형식(특수문자 사용불가)" autocomplete="off"/>
        <div class="hidden warning">※ 이미 사용중인 아이디입니다.</div>
    </div>

    <label class="my-2">비밀번호</label>
    <input type="password" name="pw" id="pw" class="col-12 mb-4" maxlength="255" placeholder="영문자+숫자+특수문자 조합으로 8~25자리" autocomplete="off"/>

    <label class="my-2">비밀번호 확인</label>
    <input type="password" name="pwCfm" class="col-12 mb-4" maxlength="255" placeholder="비밀번호를 동일하게 한 번 더 입력해주세요."
           autocomplete="off"/>

    <label class="my-2">이름</label>
    <input type="text" name="name" value="${kakao_name}" class="col-12 mb-4" maxlength="255" placeholder="이름을 입력해주세요."  autocomplete="off"/>

    <label class="my-2">휴대폰번호 입력</label>
    <div class="d-flex flex-column mb-4">
        <input type="text" name="phone" id="phone" class="col-12 mb-4" maxlength="15" minlength="9" placeholder="예) 010-1234-5678" title="전화번호를 입력하세요" autocomplete="off"/>
        <div class="hidden warning">※ 사용중인 휴대폰 번호가 있습니다.</div>
    </div>

    <label class="my-2">생년월일</label>
    <input type="date" name="birth" id="birth" class="col-12 mb-4" placeholder="달력에서 선택해주세요." autocomplete="off"/>

    <label class="my-2">성별</label>
    <div class="gap-2 d-flex col-12 btn-group" role="group">
        <label class="col-6 d-flex flex-column">
            <input type="radio" name="gender" value="female" ${kakao_gender eq 'female' ? "checked" : ""}
                   class="d-none btn-check ${empty kakao_gender ? "" : "disabled"}" ${empty kakao_gender ? "" : "onclick='return(false);'"} >
            <span class="btn btn-outline-secondary">여성</span>
        </label>
        <label class="col-6 d-flex flex-column">
            <input type="radio" name="gender" value="male" ${kakao_gender eq 'male' ? "checked" : ""}
                   class="d-none btn-check ${empty kakao_gender ? "" : "disabled"}" ${empty kakao_gender ? "" : "onclick='return(false);'"} >
            <span class="btn btn-outline-secondary">남성</span>
        </label>
    </div>
    <div class="d-grid col-3 mx-auto">
        <input type="submit" class="btn btn-lg m-4 btn-outline-danger" value="회원가입" />
    </div>
</form>
</div>
<%@ include file="../main/footer.jspf"%>
<script type="text/javascript">
    Kakao.init("a7ed8ce3bc2337bb4281fa9fc4d51ddd");
    Kakao.isInitialized();

    function kakaoLogin() {
        Kakao.Auth.login({
            scope:'profile, account_email, gender, birthday',
            success: function (authObj) {
                window.Kakao.API.request({
                    url:'/v2/user/me',
                    success: res => {
                        const kakao_account = res.kakao_account;
                        console.log(kakao_account);

                        var kakao_id = kakao_account.email;
                        var kakao_name = kakao_account.profile.nickname;
                        var kakao_gender = kakao_account.gender;
                    }
                });
            }
        });
    }
</script>
</body>
</html>
<style>
    .disabled + .btn:hover {
        background-color: white;
        color: #6c757d;
        cursor: not-allowed;
    }
    .red-border {
        border: 1px solid red;
    }
    .hidden {
        display: none;
    }
    .join-header {
        border-bottom: 1px solid #4D4D4D;
    }
</style>