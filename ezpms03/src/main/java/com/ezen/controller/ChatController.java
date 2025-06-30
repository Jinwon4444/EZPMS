package com.ezen.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ezen.dto.learnDTO;
import com.ezen.vo.qnaVO;
import com.ezen.vo.userVO;

@Controller
public class ChatController 
{
	@Autowired
	learnDTO learndto;
	
	//메시지 목록 조회
	@RequestMapping(value = "/chat/getmsg.do",produces = "application/xml; charset=utf8")
	@ResponseBody
	public String GetMsg(@RequestParam("no")String no, qnaVO vo, HttpServletRequest request)
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		
		vo.setQno(no);
		String xml = learndto.QnaList(vo);
		
		return xml;
	}
	
	//메시지 등록
	@RequestMapping(value = "/chat/sendmsg.do",method = RequestMethod.POST)
	@ResponseBody
	public String SendMsg(@RequestParam("msg")String msg, HttpServletRequest request, qnaVO vo)
	{
		userVO login = (userVO)request.getSession().getAttribute("login");

		vo.setUserid(login.getUserid());
		vo.setQnote(msg);
		String state = learndto.QnaInsert(vo);
		
		return state;
	}
}
