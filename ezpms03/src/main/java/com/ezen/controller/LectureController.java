/*
 * 모듈명 : 강의 관련 웹 어플리케이션 처리를 위한 control class
 * 작성일 : 2025.04.18
 * 작성자 : 조효준
 */
package com.ezen.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ezen.dto.checkDTO;
import com.ezen.dto.fileDTO;
import com.ezen.dto.lectureDTO;
import com.ezen.util.WebUtil;
import com.ezen.vo.fileVO;
import com.ezen.vo.lectureVO;
import com.ezen.vo.searchVO;
import com.ezen.vo.userVO;
;

@Controller
public class LectureController {
	@Autowired
	lectureDTO lecturedto;
	
	@Autowired
	fileDTO filedto;
	
	@Autowired
	checkDTO checkdto;
	
	final static String uploadPath = "D:\\upload\\"; 
	
	//글쓰기
	@RequestMapping(value = "/lecture/write.do", method = RequestMethod.GET)
	public String Write(HttpServletRequest request, Model model, String lno) 
	{
		model.addAttribute("lno", lno);
		return "lecture/write";
	}
	
	//글쓰기 완료
	@RequestMapping(value = "/lecture/writeok.do", method = RequestMethod.POST)
	public void WriteOK(lectureVO vo, @RequestParam("files")MultipartFile[] files, Model model,
			HttpServletRequest request,HttpServletResponse response) throws IOException 
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		model.addAttribute("login", login );
		
		//공지사항 글쓰기
		vo.setUserid(login.getUserid());
		lecturedto.Insert(vo);  //dto 확인
		
		// 원본 파일 이름 알아오기				
		for(MultipartFile file : files)
		{
			if (!file.isEmpty()) 
			{
				//2. 원본 파일 이름 알아오기
				String originalFileName = file.getOriginalFilename();
				System.out.println("원래파일명 :" + originalFileName);
				
				//3. 파일이름이 중복되어 저장되지 않도록 파일이름 변경(UUID)
				UUID uuid = UUID.randomUUID();
				String savedFileName = uuid.toString();
				System.out.println("저장파일명 :" + savedFileName);
				
				//4. 파일객체 생성
				File newFile = new File(uploadPath + savedFileName);
				
				//5. 파일을 upload 디렉토리에 저장
				file.transferTo(newFile);
				
				fileVO fvo = new fileVO();
				fvo.setFname(originalFileName);
				fvo.setPname(savedFileName);
				fvo.setNo(vo.getLno());  //연결된 글 번호 nno, lno, sno, tno
				fvo.setNs("lno");
				filedto.Insert(fvo);
			}
		}
		response.sendRedirect("view.do?lno=" + vo.getLno());	//연결된 글 번호 nno, lno, sno, tno
	}
	
	//글보기
	@RequestMapping(value = "/lecture/view.do", method = RequestMethod.GET)
	public String View(@RequestParam(required = true, defaultValue="0") String lno, HttpServletRequest request, Model model) 
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		
		lectureVO vo = lecturedto.View(lno);  //번호확인
		List<userVO> learnlist = lecturedto.Learnlist(lno);
		
		vo.setLnote(WebUtil.Text2HTML(vo.getLnote())); //구분확인
		vo.setLtitle(WebUtil.Text2HTML(vo.getLtitle()));
		
		fileVO fvo = new fileVO();
		fvo.setNo(vo.getLno());  //구분확인
		fvo.setNs("lno");   //구분확인
		
		List<fileVO> files = filedto.List(fvo);
		
		model.addAttribute("item", vo );
		model.addAttribute("files", files );
		model.addAttribute("login", login );
		model.addAttribute("list", learnlist);
		return "lecture/view";  //경로확인
	}
	
	//첨부파일 다운로드
	@RequestMapping(value = "/lecture/down.do")
	public void Down(@RequestParam("name")String orgName, @RequestParam("file")String saveName,
			HttpServletResponse response) throws IOException
	{
		File file = new File(uploadPath,saveName);
		
		// 파일명 인코딩
		String encodedFileName = new String (orgName.getBytes("UTF-8"), "ISO-8859-1");
		
		// file 다운로드 설정
		response.setContentType("application/download");
		response.setContentLength((int)file.length());
		response.setHeader("Content-Disposition", "attatchment;filename=\"" + encodedFileName + "\"");
		
		// 다운로드 시 저장되는 이름은 Response Header의 "Content-Disposition"에 명시
		OutputStream os = response.getOutputStream();
		
		FileInputStream fis = new FileInputStream(file);
		FileCopyUtils.copy(fis, os);		
	}
	
	//글수정
	@RequestMapping(value = "/lecture/modify.do", method = RequestMethod.GET)
	public String Modify(HttpServletRequest request, HttpServletResponse response, @RequestParam(required = true, defaultValue="0") String lno, Model model) 
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		check("lecture", "lno", lno, login, request, response);
	
		lectureVO vo = lecturedto.View(lno);
		
		List<userVO> learnlist = lecturedto.Learnlist(lno);
		
		fileVO fvo = new fileVO();
		fvo.setNo(vo.getLno());
		fvo.setNs("lno");
		
		List<fileVO> files = filedto.List(fvo);
		
		model.addAttribute("item", vo );	
		model.addAttribute("files", files );
		model.addAttribute("list", learnlist);
		return "lecture/modify";
	}
	
	//글 수정 완료
	@RequestMapping(value = "/lecture/modifyok.do", method = RequestMethod.POST)
	public void ModifyOK(lectureVO vo, @RequestParam("files")MultipartFile[] files,
			HttpServletRequest request,HttpServletResponse response) throws IOException 
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		check("lecture", "lno", vo.getLno(), login, request, response);
			
		//공지사항 글쓰기
		vo.setUserid(login.getUserid());
		lecturedto.Update(vo);
		
		//기존 파일 삭제
		fileVO fvo = new fileVO();
		fvo.setNo(vo.getLno());
		fvo.setNs("lno");
		filedto.Delete(fvo);
		
		//원본 파일 이름 알아오기				
		for(MultipartFile file : files)
		{
			if (!file.isEmpty()) 
			{
				//2. 원본 파일 이름 알아오기
				String originalFileName = file.getOriginalFilename();
				System.out.println("원래파일명 :" + originalFileName);
				
				//3. 파일이름이 중복되어 저장되지 않도록 파일이름 변경(UUID)
				UUID uuid = UUID.randomUUID();
				String savedFileName = uuid.toString();
				System.out.println("저장파일명 :" + savedFileName);
				
				//4. 파일객체 생성
				File newFile = new File(uploadPath + savedFileName);
				
				//5. 파일을 upload 디렉토리에 저장
				file.transferTo(newFile);
				
				fvo.setFname(originalFileName);
				fvo.setPname(savedFileName);
				fvo.setNo(vo.getLno());
				fvo.setNs("lno");
				filedto.Insert(fvo);
			}
		}
		
		response.sendRedirect("view.do?lno=" + vo.getLno());	
	}
	
	//메인화면(목록)
	@RequestMapping(value = "/lecture/list.do", method = RequestMethod.GET)
	public String List(HttpServletRequest request, @RequestParam(defaultValue = "1")int page,Model model,String index, String keyword) 
	{
		userVO loginVO = (userVO)request.getSession().getAttribute("login");
		
		String level = loginVO.getLevel();
		searchVO vo = new searchVO();
		vo.setPageno(page);		
		vo.setKeyword(keyword);
		vo.setIndex(index);
		vo.setUserid(loginVO.getUserid());
		
		//전체 갯수 
		int total = lecturedto.GetTotal(vo);
		
		//최대 페이징
		int maxpage = total / 10;
		if( total % 10 != 0) maxpage++;
		
		//목록 조회
		List<lectureVO> list = lecturedto.List(vo);
		for(lectureVO obj : list)
		{
			obj.setLtitle(WebUtil.Text2HTML(obj.getLtitle()));
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
		
		return "lecture/list";
	}
	
	// 권한 검사
	private void check(String checktable, String checkno, String no, userVO vo, HttpServletRequest request, HttpServletResponse response)
	{
		if( checkdto.check(checktable, checkno, no , vo.getUserid()) == 0)
		{
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
