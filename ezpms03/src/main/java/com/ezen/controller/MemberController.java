/*
 * 모듈명 : 관리자 멤버관리 관련 웹 어플리케이션 처리를 위한 control class
 * 작성일 : 2025.04.18
 * 작성자 : 서진원
 */
package com.ezen.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ezen.dto.memberDTO;
import com.ezen.dto.userDTO;
import com.ezen.util.WebUtil;
import com.ezen.vo.searchVO;
import com.ezen.vo.userVO;

@Controller
public class MemberController 
{
	@Autowired
	userDTO userdto;
	
	@Autowired
	memberDTO memberdto;
	
	/*** 
	 * 회원목록 페이지로 이동
	 * @return 회원목록 페이지
	 */
	@RequestMapping(value = "/mgrmember/list.do", method = RequestMethod.GET)
	public String List(HttpServletRequest request, HttpServletResponse response, @RequestParam(defaultValue = "1")int page, Model model, userVO vo, String sort) 
	{
		// 화면 출력 시 권한 검색 용
		userVO loginVO = (userVO)request.getSession().getAttribute("login");
		
		// 최초 검색 시 null값을 검색 가능하게 적용
		if(vo.getName() == null) vo.setName("");
		if(vo.getState() == null) vo.setState("");
		if(vo.getGender() == null) vo.setGender("");
		if(vo.getLevel() == null) vo.setLevel("");
		if(sort == null) sort = "name";
		
		// 페이지에 검색값 유지
		model.addAttribute("s_state", vo.getState());
		model.addAttribute("s_gender", vo.getGender());
		model.addAttribute("s_level", vo.getLevel());
		
		// 조건별 전체 검색 구문
		if(vo.getState() == "") vo.setState("Y', 'N");
		if(vo.getGender() == "") vo.setGender("M', 'F");
		if(vo.getLevel() == "") vo.setLevel("T', 'S");
		
		// where 조건절 인덱스 처리
		String index = "state in ('" + vo.getState() + "') and gender in ('" + vo.getGender() + "') and level in ('" + vo.getLevel() + "') ";
		// System.out.println(index);
		
		searchVO svo = new searchVO();
		svo.setPageno(page);		
		svo.setKeyword(vo.getName().trim());
		svo.setIndex(index);
		svo.setSort(sort);
		
		//전체 갯수 
		int total = memberdto.GetTotal(svo);
		
		//최대 페이징
		int maxpage = total / 10;
		if( total % 10 != 0) maxpage++;
		
		//목록 조회
		List<userVO> list = memberdto.List(svo);

		
		for(userVO item : list)
		{
			System.out.println("name :" + item.getName());
		}
		
		//시작 블럭
		int startbk = (page - 1)  - (( page - 1) % 10) + 1;
		int endbk   = startbk + 10 - 1;
		if( endbk > maxpage ) endbk = maxpage;
		
		model.addAttribute("total", total);
		model.addAttribute("maxpage", maxpage);	
		model.addAttribute("startbk", startbk);
		model.addAttribute("endbk", endbk);
		model.addAttribute("search", svo);
		model.addAttribute("list", list);
		model.addAttribute("level", loginVO.getLevel());
		
		return "mgrmember/list";
	}
	
	/*** 
	 * 회원수정 페이지로 이동
	 * @return 회원수정 페이지
	 */
	@RequestMapping(value="/mgrmember/modify.do", method = RequestMethod.GET)
	public String modify(HttpServletRequest request, HttpServletResponse response, String userid, Model model)
	{
		userVO vo = userdto.mypage(userid);
		vo.setUserid(userid);
		vo.setEmail(WebUtil.Text2HTML(vo.getEmail()));
		model.addAttribute("data", vo);
		
		return "mgrmember/modify";
	}
	
	/*** 
	 * 회원수정 작업
	 * @return 회원수정 완료 후 이동
	 */
	@RequestMapping(value="/mgrmember/modify.do", method = RequestMethod.POST)
	public String modify(HttpServletRequest request, HttpServletResponse response, userVO vo)
	{
		memberdto.modify(vo);
		
		return "redirect:/mgrmember/list.do";
	}
	
	/*** 
	 * 교수등록 페이지로 이동
	 * @return 교수등록 페이지
	 */
	@RequestMapping(value="/mgrmember/regist.do", method = RequestMethod.GET)
	public String regist(HttpServletRequest request, HttpServletResponse response)
	{
		return "mgrmember/regist";
	}
	
	/*** 
	 * 교수등록 완료
	 * @return 교수 등록 후 이동
	 */
	@RequestMapping(value = "/mgrmember/registok.do", method = RequestMethod.POST)
	public String registOK(HttpServletRequest request, HttpServletResponse response, userVO vo)
	{
		userdto.join(vo);
		return "mgrmember/list";
	}
	
	//회원 삭제
	@RequestMapping(value = "/mgrmember/delete.do", method = RequestMethod.GET)
	public void Delete(HttpServletRequest request, @RequestParam(required = true, defaultValue="0") String id, HttpServletResponse response) throws IOException 
	{
		String[] id_list = id.split(",");
		for(String userid : id_list)
		{
			memberdto.delete(userid);
		}
		response.sendRedirect("list.do");
	}
	
	// 회원 복구
	@RequestMapping(value = "/mgrmember/restore.do", method = RequestMethod.GET)
	public String restore(HttpServletRequest request, HttpServletResponse response, String userid)
	{
		memberdto.restore(userid);
		return "redirect:/mgrmember/list.do";
	}

}
