package com.flo.alwaysbom.util.interceptor;

import com.flo.alwaysbom.main.vo.AdminVo;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AdminInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();

        AdminVo admin = (AdminVo) session.getAttribute("admin");

        if (admin == null) {
            response.sendRedirect("/admin/login");
            return false;
        }

        return true;
    }
}
