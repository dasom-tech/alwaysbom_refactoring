package com.flo.alwaysbom.util.interceptor;

import com.flo.alwaysbom.member.vo.MemberVO;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        MemberVO member = (MemberVO) session.getAttribute("member");
        System.out.println("request.getRequestURL() = " + request.getRequestURL());
        System.out.println("member = " + member);

        if (member == null) {
            response.sendRedirect("/login");
            return false;
        }
        return true;
    }
}
