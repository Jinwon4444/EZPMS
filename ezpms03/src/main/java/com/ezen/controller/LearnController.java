package com.ezen.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import com.ezen.dto.learnDTO;
import com.ezen.util.WebUtil;
import com.ezen.vo.fileVO;
import com.ezen.vo.learnlistVO;
import com.ezen.vo.lectureVO;
import com.ezen.vo.searchVO;
import com.ezen.vo.subtaskVO;
import com.ezen.vo.taskVO;
import com.ezen.vo.userVO;

@Controller
public class LearnController {
	@Autowired
	learnDTO learndto;
	
	@Autowired
	fileDTO filedto;
	
	@Autowired
	checkDTO checkdto;
	
	//수강신청 목록조회
	@RequestMapping(value = "/learn/signlist.do", method = RequestMethod.GET)
	public String Learnlist(HttpServletRequest request, @RequestParam(defaultValue = "1")int page,Model model,String index, String day,String keyword) 
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		
		String level = login.getLevel();
		searchVO vo = new searchVO();
		vo.setPageno(page);		
		vo.setKeyword(keyword);
		vo.setIndex(index);
		vo.setDay(day);
		
		
		//전체 갯수 
		int total = learndto.GetTotal(vo);
		
		//최대 페이징
		int maxpage = total / 10;
		if( total % 10 != 0) maxpage++;
		
		//목록 조회
		List<lectureVO> lecturelist = learndto.LectureList(vo);
		
		for(lectureVO obj : lecturelist)
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
		model.addAttribute("list", lecturelist);
		model.addAttribute("level", level);
		
		return "learn/signlist";
	}
	
	
	//강의 내용보기
	@RequestMapping(value = "/learn/view.do", method = RequestMethod.GET)
	public String View(@RequestParam(required = true, defaultValue="0") String lno, String from, HttpServletRequest request, Model model) 
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		
		lectureVO vo = learndto.View(lno);  //번호확인
		
		vo.setLnote(WebUtil.Text2HTML(vo.getLnote())); //구분확인
		vo.setLtitle(WebUtil.Text2HTML(vo.getLtitle()));
		
		fileVO fvo = new fileVO();
		fvo.setNo(vo.getLno());  //구분확인
		fvo.setNs("lno");   //구분확인
		
		List<fileVO> files = filedto.List(fvo);
		
		model.addAttribute("item", vo );	
		model.addAttribute("files", files );
		model.addAttribute("login", login );
		model.addAttribute("from", from);
		return "learn/view";  //경로확인
	}
	
	//수강신청 완료
	@RequestMapping(value = "/learn/signok.do", method = RequestMethod.GET)
	public String Signok(String lno,  Model model,
			HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		
		model.addAttribute("login", login);
		
		learnlistVO vo = new learnlistVO();
		vo.setUserid(login.getUserid());
		vo.setLno(lno);
		
		//수강신청
		if (learndto.Sign(vo))
		{
	        // 실패 메시지 파라미터 추가
	        return "redirect:/learn/signlist.do?msg=duplicate";
	    }
		
	    return "redirect:/learn/signlist.do?msg=success";
	}

	
	//수강목록 조회
	@RequestMapping(value = "/learn/list.do", method = RequestMethod.GET)
	public String List(HttpServletRequest request, @RequestParam(defaultValue = "1")int page,Model model,String index,String keyword) 
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		
		String level = login.getLevel();
		searchVO vo = new searchVO();
		vo.setPageno(page);		
		vo.setKeyword(keyword);
		vo.setIndex(index);
		vo.setUserid(login.getUserid());
		
		//전체 갯수 
		int total = learndto.GetListTotal(vo);
		
		//최대 페이징
		int maxpage = total / 10;
		if( total % 10 != 0) maxpage++;
		
		//목록 조회
		List<lectureVO> list = learndto.List(vo);
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
		
		return "learn/list";
	}
	
	
	//수강포기
	@RequestMapping(value = "/learn/delete.do", method = RequestMethod.GET)
	public void Delete(HttpServletRequest request, @RequestParam(required = true, defaultValue="0") String lno, HttpServletResponse response) throws IOException 
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		check("learnlist", "lno", lno, login, request, response);
	
		learnlistVO vo = new learnlistVO();
		vo.setLno(lno);
		vo.setUserid(login.getUserid());
		learndto.Delete(vo);

		response.sendRedirect("list.do?msg=success");
	}
	
	//첨부파일 다운로드
	@RequestMapping(value = "/learn/down.do")
	public void Down(@RequestParam("name")String orgName, @RequestParam("file")String saveName,
			HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		
		// 파일 다운로드
		WebUtil.fileDown(orgName, saveName, response);
	}
	
	//과제목록 조회
	@RequestMapping(value = "/learn/tasklist.do", method = RequestMethod.GET)
	public String Tasklist(HttpServletRequest request, @RequestParam(defaultValue = "1")int page,Model model,String index,String keyword, String lno) 
	{
		userVO loginVO = (userVO)request.getSession().getAttribute("login");
		
		String level = loginVO.getLevel();
		searchVO vo = new searchVO();
		vo.setPageno(page);		
		vo.setKeyword(keyword);
		vo.setIndex(index);
		vo.setUserid(loginVO.getUserid());
		vo.setNo(lno);
		
		//목록 조회
		List<taskVO> list = learndto.TaskList(vo);
		for(taskVO obj : list)
		{
			obj.setTtitle(WebUtil.Text2HTML(obj.getTtitle()));
		}
		
		//전체 갯수 
		int total = learndto.GetTaskTotal(vo);
		
		//최대 페이징
		int maxpage = total / 10;
		if( total % 10 != 0) maxpage++;
		
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
		
		return "learn/tasklist";
	}
	
	//과제 제출
	@RequestMapping(value = "/learn/tasksub.do", method = RequestMethod.GET)
	public String Tasksub(@RequestParam(required = true, defaultValue="0") String tno, HttpServletRequest request, Model model) 
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		
		taskVO vo = learndto.TaskSub(tno);
		 
		vo.setTnote(WebUtil.Text2HTML(vo.getTnote()));
		vo.setTtitle(WebUtil.Text2HTML(vo.getTtitle()));
		
		fileVO fvo = new fileVO();
		fvo.setNo(vo.getTno()); 
		fvo.setNs("tno");  
		
		List<fileVO> files = filedto.List(fvo);
		
		model.addAttribute("item", vo );	
		model.addAttribute("files", files);
		model.addAttribute("login", login);
		return "learn/tasksub";
	}
	
	//과제 제출 처리
	@RequestMapping(value = "/learn/tasksubok.do", method = RequestMethod.POST)
	public void Tasksubok(subtaskVO vo, String tend, @RequestParam("files")MultipartFile[] files, Model model,
			HttpServletRequest request,HttpServletResponse response) throws IOException, ParseException 
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		
		model.addAttribute("login", login);
		
		// 시간 검색용
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date endday = formatter.parse(tend);
		Date today = new Date();
		
		vo.setUserid(login.getUserid());
		if(today.after(endday) || learndto.CheckTask(vo))  //제출조건에 부합하는 상태일때 실패
		{												   //제출 조건은 1.마감일보다 빠를것  2.수강중인 강의일것  3.제출하지 않은 과제일것(중복 x) 
			response.sendRedirect("tasksub.do?msg=fails&tno=" + vo.getTno());
			return;
		}
		
		learndto.Insert(vo);
		
		// 파일 업로드
		fileVO fvo = new fileVO();
		WebUtil.fileName(files, fvo, "sno", vo.getSno());

		response.sendRedirect("taskview.do?tno=" + vo.getTno() + "&sno=" + vo.getSno());	
	}
	
	// 과제 내용
	@RequestMapping(value = "/learn/taskview.do", method = RequestMethod.GET)
	public String Taskview(@RequestParam(required = true, defaultValue="0") String tno, String sno, HttpServletRequest request, HttpServletResponse response, Model model) 
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		check("subtask", "sno", sno, login, request, response);
		
		//검색용 taskvo
		taskVO tvo = new taskVO();
		tvo.setTno(tno);
		tvo.setSno(sno);
		
		//task 내용 저장용 vo
		taskVO vo = learndto.TaskSub(tno);  //번호확인
		
		subtaskVO svo = learndto.TaskView(tvo);

		vo.setTnote(WebUtil.Text2HTML(vo.getTnote())); //구분확인
		vo.setTtitle(WebUtil.Text2HTML(vo.getTtitle()));
		
		fileVO fvo = new fileVO();
		fvo.setNo(svo.getSno());  //구분확인
		fvo.setNs("sno");   //구분확인
		
		List<fileVO> files = filedto.List(fvo);
		
		model.addAttribute("item", vo );
		model.addAttribute("subitem", svo);
		model.addAttribute("files", files);
		model.addAttribute("login", login);
		return "learn/taskview";
	}
	
	// 과제제출 수정페이지
	@RequestMapping(value = "/learn/taskmodify.do", method = RequestMethod.GET)
	public String Taskmodify(@RequestParam(required = true, defaultValue="0") String tno, String sno, HttpServletRequest request, Model model,HttpServletResponse response) throws ParseException 
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		check("subtask", "sno", sno, login, request, response);
		
		//검색용 taskvo
		taskVO tvo = new taskVO();
		tvo.setTno(tno);
		tvo.setSno(sno);
		
		//task 내용 저장용 vo
		taskVO vo = learndto.TaskSub(tno);  //번호확인
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date endday = formatter.parse(vo.getTend());
		Date today = new Date();
		if(today.after(endday))  //마감일보다 늦은 상태일때 실패 
		{
			return "redirect:taskview.do?msg=fails&tno=" + tno;
		}

		subtaskVO svo = learndto.TaskView(tvo);
		
		vo.setTnote(WebUtil.Text2HTML(vo.getTnote()));
		vo.setTtitle(WebUtil.Text2HTML(vo.getTtitle()));//구분확인
		
		fileVO fvo = new fileVO();
		fvo.setNo(svo.getSno());  //구분확인
		fvo.setNs("sno");   //구분확인
		
		List<fileVO> files = filedto.List(fvo);
		
		model.addAttribute("item", vo );
		model.addAttribute("subitem", svo );
		model.addAttribute("files", files);
		model.addAttribute("login", login);
		return "learn/taskmodify";
	}
	
	// 과제제출 수정 완료
	@RequestMapping(value = "/learn/taskmodifyok.do", method = RequestMethod.POST)
	public void Taskmodifyok(subtaskVO vo, String tend, @RequestParam("files")MultipartFile[] files, Model model,
			HttpServletRequest request,HttpServletResponse response) throws IOException, ParseException 
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		check("subtask", "sno", vo.getSno(), login, request, response);
		
		model.addAttribute("login", login);
		
		vo.setUserid(login.getUserid());
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date endday = formatter.parse(tend);
		Date today = new Date();
		
		if(today.after(endday))  //제출조건에 부합하는 상태일때 실패
		{  
			response.sendRedirect("tasksub.do?msg=fails&tno=" + vo.getTno());
			return;
		}
		
		learndto.Update(vo);
		
		fileVO fvo = new fileVO();
		fvo.setNo(vo.getSno());
		fvo.setNs("sno");
		filedto.Delete(fvo);
		
		// 파일 업로드
		WebUtil.fileName(files, fvo, "sno", vo.getSno());
		
		response.sendRedirect("taskview.do?&tno=" + vo.getTno() + "&sno=" + vo.getSno());	
	}
	
	// 개인 권한
	private void check(String checktable, String checkno, String no, userVO vo, HttpServletRequest request, HttpServletResponse response)
	{
		if( checkdto.check(checktable, checkno, no, vo.getUserid()) == 0 )
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
