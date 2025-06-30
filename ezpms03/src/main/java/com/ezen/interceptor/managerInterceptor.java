package com.ezen.interceptor;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.vo.userVO;

public class managerInterceptor implements HandlerInterceptor 
{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception 
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		if( login == null || !login.getLevel().equals("M") )
		{
			String contextPath = request.getContextPath();
			try {
				response.sendRedirect(contextPath + "/login/login.do");
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			// 인터셉트에 걸림. 작동 안함.
			return false;
		}
		
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

}
