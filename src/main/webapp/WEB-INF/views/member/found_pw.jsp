<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>비밀번호 찾기 완료</title>
    <%@ include file="../main/import.jspf"%>
</head>
<body>
<%@ include file="../main/header.jspf" %>
<div id="container" class="mx-auto d-flex flex-column align-items-center">
    <form role="form" action="/login" method="post" class="col-5 d-flex flex-column">
        <h5 class="page_title text-center p-2 mt-5 text-secondary m-0 p-4 border-bottom border-secondary">비밀번호 찾기</h5>
        <div class="login_box">
            <div class="inner">
                <div class="login_user_input">
                    <p class="text-center text-secondary mb-4">
                        메일로 임시 비밀번호를 보내드렸습니다. 감사합니다:-)
                    </p>
                </div>
                <button type="button" class="login text-decoration-none text-center" onclick="location.href='/login'">로그인</button>
                <p class="login_under_noti">
                    - 유효 메일이 아니거나 휴면 상태일 경우 수신 어려움.
                    <br>
                    - 새늘봄 메일을 수신 차단시 수신 어려움.
                    <br>
                    - 확인되지 않을시 1:1 문의를 남겨주시기 바랍니다.
                    <br>
                    (평일 AM10시-PM6시에 빠른 답변 가능합니다.)
                </p>
            </div>
        </div>
    </form>
</div>
<%@ include file="../main/footer.jspf"%>
</body>
</html>
<style>
    .login_box {
        position: relative;
        padding-top: 50px;
        padding-bottom: 50px;
    }

    .row {
        display: block;
        margin: 0;
        padding-bottom: 30px;
    }
    .login_user_input {
        content: '';
        display: block;
        clear: both;
    }
    .col {
        margin: 0;
        padding: 0;
    }
    .login_user_input span.ipt {
        border: none;
        padding: 10px;
        text-align: center;
        font-size: 14px;
        line-height: 44px;
        font-weight: 300;
        letter-spacing: -.21px;
        color: #222;
    }
    .login {
        margin-top: 10px;
        outline: 0;
        cursor: pointer;
        display: block;
        width: 100%;
        border: #ffcd32 1px solid;
        border-radius: 5px;
        background: #ffcd32;
        text-align: center;
        height: 52px;
        font-size: 16px;
        line-height: 52px;
        font-weight: 300;
        letter-spacing: -.24px;
        color: #333;
    }
    .login_under_noti {
        margin-top: 22px;
        padding-top: 20px;
        font-size: 14px;
        line-height: 22px;
        font-weight: 100;
        letter-spacing: -.21px;
        color: #222;
        border-top: #ececec 1px solid;
        text-align: center;
    }

    .login_user_input .row .col {
        display: block;
        float: left;
    }
    .login_user_input .ipt {
        margin: 0px 0px 30px 0px;
        background: 0 0;
        outline: 0;
        display: block;
        width: 100%;
        padding: 10px 20px;
        border: #d3d3d3 1px solid;
        -webkit-border-radius: 5px;
        -moz-border-radius: 5px;
        border-radius: 5px;
        font-weight: 300;
        color: #222;
        height: 50px;
        font-size: 16px;
        line-height: 50px;
        letter-spacing: -.24px;
    }
    .login_id_find_results {
        padding: 20px;
        margin-top: 10px;
        border: #ffcd32 1px solid;
        border-radius: 5px;
    }
</style>


