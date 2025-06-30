/*
 * 모듈명 : 공지사항 관련 웹 어플리케이션 처리를 위한 control class
 * 작성일 : 2025.04.14
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
import org.springframework.web.multipart.MultipartFile;

import com.ezen.dto.checkDTO;
import com.ezen.dto.fileDTO;
import com.ezen.dto.noticeDTO;
import com.ezen.util.WebUtil;
import com.ezen.vo.fileVO;
import com.ezen.vo.noticeVO;
import com.ezen.vo.searchVO;
import com.ezen.vo.userVO;

@Controller
public class NoticeController 
{
	@Autowired
	noticeDTO noticedto;
	
	@Autowired
	fileDTO filedto;
	
	@Autowired
	checkDTO checkdto;
	
	final static String uploadPath = "D:\\upload\\"; 
	
	//글쓰기
	@RequestMapping(value = "/notice/write.do", method = RequestMethod.GET)
	public String Write(HttpServletRequest request) 
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		if( login == null || login.getLevel().equals("S"))
		{
			//로그인하지 않음.
			return "redirect:/login/login.do";
		}	
		
		return "notice/write";
	}
	
	
	//servlet-context.xml 에서 
	//multipartResolver 설정을 확인해야 함. 
	@RequestMapping(value = "/notice/writeok.do", method = RequestMethod.POST)
	public void WriteOK(noticeVO vo, @RequestParam("files")MultipartFile[] files, Model model,
			HttpServletRequest request,HttpServletResponse response) throws IOException 
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		if( login == null || login.getLevel().equals("S"))
		{
			//로그인하지 않음.
			response.sendRedirect("login/login.do");
			return;
		}	
		model.addAttribute("login", login );
		
		//공지사항 글쓰기
		vo.setUserid(login.getUserid());
		noticedto.Insert(vo);
		
		// 파일 업로드
		fileVO fvo = new fileVO();
		WebUtil.fileName(files, fvo, "nno", vo.getNno());
				
		response.sendRedirect("view.do?nno=" + vo.getNno());	
	}
	
	//글보기
	@RequestMapping(value = "/notice/view.do", method = RequestMethod.GET)
	public String View(@RequestParam(required = true, defaultValue="0") String nno, HttpServletRequest request, Model model) 
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		if( login == null)
		{
			//로그인하지 않음.
			return "redirect:/login/login.do";
		}
		
		noticeVO vo = noticedto.View(nno);
		
		vo.setNnote(WebUtil.Text2HTML(vo.getNnote()));
		vo.setNtitle(WebUtil.Text2HTML(vo.getNtitle()));
		
		fileVO fvo = new fileVO();
		fvo.setNo(vo.getNno());
		fvo.setNs("nno");
		
		List<fileVO> files = filedto.List(fvo);
		
		model.addAttribute("item", vo );	
		model.addAttribute("files", files );
		model.addAttribute("login", login );
		return "notice/view";
	}
	
	//공지사항 첨부파일 다운로드
	@RequestMapping(value = "/notice/down.do")
	public void Down(@RequestParam("name")String orgName, @RequestParam("file")String saveName,
			HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		if( login == null )
		{
			String contextPath = request.getContextPath();
			response.sendRedirect(contextPath + "/login/login.do");
		}
		
		// 파일 다운로드
		WebUtil.fileDown(orgName, saveName, response);
	}
	
	//글수정
	@RequestMapping(value = "/notice/modify.do", method = RequestMethod.GET)
	public String Modify(HttpServletRequest request, HttpServletResponse response, @RequestParam(required = true, defaultValue="0") String nno, Model model) 
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		check("notice", "nno", nno, login, request, response);
		
		noticeVO vo = noticedto.View(nno);
		vo.setNnote(WebUtil.Text2HTML(vo.getNnote()));
		vo.setNtitle(WebUtil.Text2HTML(vo.getNtitle()));
		
		fileVO fvo = new fileVO();
		fvo.setNo(vo.getNno());
		fvo.setNs("nno");
		
		List<fileVO> files = filedto.List(fvo);
		
		model.addAttribute("item", vo );	
		model.addAttribute("files", files );
		return "notice/modify";
	}
	
	//글 수정 완료
	@RequestMapping(value = "/notice/modifyok.do", method = RequestMethod.POST)
	public void ModifyOK(noticeVO vo, @RequestParam("files")MultipartFile[] files,
			HttpServletRequest request,HttpServletResponse response) throws IOException 
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		check("notice", "nno", vo.getNno(), login, request, response);

		//공지사항 글쓰기
		vo.setUserid(login.getUserid());
		noticedto.Update(vo);
		
		//기존 파일 삭제
		fileVO fvo = new fileVO();
		fvo.setNo(vo.getNno());
		fvo.setNs("nno");
		filedto.Delete(fvo);
		
		// 파일 업로드
		WebUtil.fileName(files, fvo, "nno", vo.getNno());
		
		response.sendRedirect("view.do?nno=" + vo.getNno());	
	}
	
	//글삭제
	@RequestMapping(value = "/notice/delete.do", method = RequestMethod.GET)
	public void Delete(HttpServletRequest request, @RequestParam(required = true, defaultValue="0") String nno, HttpServletResponse response) throws IOException 
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		check("notice", "nno", nno, login, request, response);
		
		String[] nno_list = nno.split(","); 
		for(String no : nno_list)
		{
			fileVO fvo = new fileVO();
			fvo.setNo(no);
			fvo.setNs("nno");
			
			filedto.Delete(fvo);
			noticedto.Delete(no);
		}
		
		response.sendRedirect("list.do");
	}
	
	
	//메인화면(목록)
	@RequestMapping(value = "/notice/list.do", method = RequestMethod.GET)
	public String List(HttpServletRequest request, @RequestParam(defaultValue = "1")int page,Model model,String index, String keyword) 
	{
		userVO loginVO = (userVO)request.getSession().getAttribute("login");
		if( loginVO == null)
		{
			//로그인하지 않음.
			return "redirect:/login/login.do";
		}
		
		String level = loginVO.getLevel();
		searchVO vo = new searchVO();
		vo.setPageno(page);		
		vo.setKeyword(keyword);
		vo.setIndex(index);
		
		//전체 갯수 
		int total = noticedto.GetTotal(vo);
		
		//최대 페이징
		int maxpage = total / 10;
		if( total % 10 != 0) maxpage++;
		
		//목록 조회
		List<noticeVO> list = noticedto.List(vo);
		for(noticeVO obj : list)
		{
			obj.setNtitle(WebUtil.Text2HTML(obj.getNtitle()));
		}

		
		//시작 블럭
		int startbk = (page - 1)  - (( page - 1) % 10) + 1;
		int endbk   = startbk + 10 - 1;
		if( endbk > maxpage ) endbk = maxpage;
		
		model.addAttribute("total", total);
		model.addAttribute("maxpage", maxpage);	
		model.addAttribute("startbk", startbk);
		model.addAttribute("endbk", endbk);
		model.addAttribute("search", vo);
		model.addAttribute("list", list);
		model.addAttribute("level", level);
		
		return "notice/list";
	}
	
	// notice 조정 권한
	private void check(String checktable, String checkno, String no, userVO vo, HttpServletRequest request, HttpServletResponse response)
	{
		if( vo == null || vo.getLevel().equals("S") || checkdto.check(checktable, checkno, no , vo.getUserid()) == 0)
		{
			if(vo.getLevel().equals("M"))
			{
				return;
			}
			//로그인하지 않음.
			System.out.println("비정상적인 접근입니다.");
			String contextPath = request.getContextPath();
			try {
				response.sendRedirect(contextPath + "/login/login.do");
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			return;
		}
	}
}
