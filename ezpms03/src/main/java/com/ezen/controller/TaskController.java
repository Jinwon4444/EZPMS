package com.ezen.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ezen.dto.checkDTO;
import com.ezen.dto.fileDTO;
import com.ezen.dto.learnDTO;
import com.ezen.dto.taskDTO;
import com.ezen.util.WebUtil;
import com.ezen.vo.fileVO;
import com.ezen.vo.lectureVO;
import com.ezen.vo.noticeVO;
import com.ezen.vo.qnaVO;
import com.ezen.vo.searchVO;
import com.ezen.vo.subtaskVO;
import com.ezen.vo.taskVO;
import com.ezen.vo.userVO;

@Controller
public class TaskController
{
	@Autowired
	taskDTO taskdto;
	
	@Autowired
	fileDTO filedto;
	
	@Autowired
	learnDTO learndto;
	
	@Autowired
	checkDTO checkdto;
	
	final static String uploadPath = "D:\\upload\\";
	
	// 과제 등록
	@RequestMapping(value = "/task/write.do", method = RequestMethod.GET)
	public String Write(HttpServletRequest request, HttpServletResponse response, Model model, String lno) 
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		check("lecture", "lno", lno, login, request, response);
		
		model.addAttribute("lno", lno);
		return "task/write";
	}
	
	// 과제 등록 완료
	@RequestMapping(value = "/task/writeok.do", method = RequestMethod.POST)
	public void WriteOK(taskVO vo, @RequestParam("files")MultipartFile[] files, Model model,
			HttpServletRequest request,HttpServletResponse response) throws IOException 
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		check("lecture", "lno", vo.getLno(), login, request, response);

		model.addAttribute("login", login );
		
		vo.setUserid(login.getUserid());
		taskdto.insert(vo);  
		
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
				fvo.setNo(vo.getTno());  //연결된 글 번호 nno, lno, sno, tno
				fvo.setNs("tno");
				filedto.Insert(fvo);
			}
		}
		
		System.out.println(vo.getTno());
		response.sendRedirect("view.do?tno="+ vo.getTno());		
	}
	
	// 과제 보기
	@RequestMapping(value = "/task/view.do", method = RequestMethod.GET)
	public String View(@RequestParam(required = true, defaultValue="0") String tno, HttpServletRequest request, Model model) 
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		if( login == null)
		{
			//로그인하지 않음.
			return "redirect:/login/login.do";
		}
		
		taskVO vo = taskdto.view(tno);
		List<userVO> learnlist = taskdto.Learnlist(tno);
		
		// 과제 제출했는지 확인
		int count = taskdto.learnCount(tno);
		
		vo.setTnote(WebUtil.Text2HTML(vo.getTnote())); //구분확인
		
		fileVO fvo = new fileVO();
		fvo.setNo(vo.getTno());  //구분확인
		fvo.setNs("tno");   //구분확인
		
		List<fileVO> files = filedto.List(fvo);
		
		model.addAttribute("item", vo );
		model.addAttribute("files", files );
		model.addAttribute("login", login );
		model.addAttribute("list", learnlist);
		model.addAttribute("count", count);
		return "task/view";
	}
	
	// 과제 수정
	@RequestMapping(value = "/task/modify.do", method = RequestMethod.GET)
	public String Modify(HttpServletRequest request, HttpServletResponse response, @RequestParam(required = true, defaultValue="0") String tno, Model model) 
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		check("task", "tno", tno, login, request, response);
		
		taskVO vo = taskdto.view(tno);

		fileVO fvo = new fileVO();
		fvo.setNo(vo.getTno());
		fvo.setNs("tno");
		
		List<fileVO> files = filedto.List(fvo);
		
		model.addAttribute("item", vo);	
		model.addAttribute("files", files);
		return "task/modify";
	}
	
	// 과제 수정 완료
	@RequestMapping(value = "/task/modifyok.do", method = RequestMethod.POST)
	public void ModifyOK(taskVO vo, @RequestParam("files")MultipartFile[] files,
			HttpServletRequest request,HttpServletResponse response) throws IOException 
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		check("task", "tno", vo.getTno(), login, request, response);

		vo.setUserid(login.getUserid());
		taskdto.update(vo);
		
		//기존 파일 삭제
		fileVO fvo = new fileVO();
		fvo.setNo(vo.getTno());
		fvo.setNs("tno");
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
		
		response.sendRedirect("view.do?tno=" + vo.getTno());	
	}
	
	// 과제 평가 뷰
	@RequestMapping(value = "/task/evaluate.do", method = RequestMethod.GET)
	public String Taskview(@RequestParam(required = true, defaultValue="0") String tno, String sno, HttpServletRequest request, HttpServletResponse response, Model model) 
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		System.out.println(login.getUserid());
		check("task", "tno", tno, login, request, response);

		//검색용 taskvo
		taskVO tvo = new taskVO();
		tvo.setTno(tno);
		tvo.setSno(sno);
		
		taskVO vo = learndto.TaskSub(tno);  
		
		subtaskVO svo = learndto.TaskView(tvo);

		vo.setTnote(WebUtil.Text2HTML(vo.getTnote())); 
		
		fileVO fvo = new fileVO();
		fvo.setNo(svo.getSno());  
		fvo.setNs("sno");
		
		List<fileVO> files = filedto.List(fvo);
		
		model.addAttribute("item", vo );
		model.addAttribute("subitem", svo);
		model.addAttribute("files", files);
		model.addAttribute("login", login);
		return "task/evaluate";
	}
	
	// 과제 채점
	@RequestMapping(value = "/task/evaluateok.do", method = RequestMethod.GET)
	public String evaluateOk(HttpServletRequest request, HttpServletResponse response, String score, String sno, String tno)
	{
		userVO login = (userVO)request.getSession().getAttribute("login");
		check("task", "tno", tno, login, request, response);
		
		subtaskVO vo = new subtaskVO();
		vo.setSno(sno);
		vo.setScore(score);
		taskdto.evaluateOk(vo);
		
		System.out.println(vo.getSno());
		System.out.println(vo.getScore());
		return "redirect:/task/evaluate.do?tno="+tno+"&sno="+sno;
	}
	
	//메인화면(목록)
	@RequestMapping(value = "/task/list.do", method = RequestMethod.GET)
	public String List(HttpServletRequest request, @RequestParam(defaultValue = "1")int page,Model model,String index, String keyword) 
	{
		userVO loginVO = (userVO)request.getSession().getAttribute("login");
		if( loginVO == null || loginVO.getLevel().equals("S"))
		{
			//로그인하지 않음.
			return "redirect:/login/login.do";
		}
		
		String level = loginVO.getLevel();
		searchVO vo = new searchVO();
		vo.setPagesize(5);
		vo.setPageno(page);
		vo.setKeyword(keyword);
		vo.setIndex(index);
		vo.setUserid(loginVO.getUserid());	
		
		//전체 갯수 
		int total = taskdto.GetTotal(vo);
		
		//최대 페이징
		int maxpage = total / 5;
		if( total % 5 != 0) maxpage++;
		
		//목록 조회
		List<lectureVO> list = taskdto.List(vo);
		for(lectureVO obj : list)
		{
			obj.setLtitle(WebUtil.Text2HTML(obj.getLtitle()));
		}
		
		//시작 블럭
		int startbk = (page - 1)  - (( page - 1) % 5) + 1;
		int endbk   = startbk + 5 - 1;
		if( endbk > maxpage ) endbk = maxpage;
		
		model.addAttribute("total", total);
		model.addAttribute("maxpage", maxpage);	
		model.addAttribute("startbk", startbk);
		model.addAttribute("endbk", endbk);
		model.addAttribute("search", vo);
		model.addAttribute("list", list);
		model.addAttribute("level", level);
		
		return "task/list";
	}
	
	// 강의 과제목록
	@RequestMapping(value = "/task/sublist.do", method = RequestMethod.GET)
	public String SubList(HttpServletRequest request, String lno, Model model)
	{
		userVO loginVO = (userVO)request.getSession().getAttribute("login");
		searchVO vo = new searchVO();
		vo.setUserid(loginVO.getUserid());
		vo.setNo(lno);
			
		//전체 갯수 
		int total = taskdto.GetTaskTotal(vo);
		
		//수강학생수 조회
		int student = taskdto.GenStuTotal(vo);
		
		//목록 조회
		List<taskVO> list = taskdto.TaskList(vo);
		
		model.addAttribute("total", total);
		model.addAttribute("student", student);
		model.addAttribute("search", vo);
		model.addAttribute("list", list);
		
		return "task/sublist";
	}
	
	// task 개인 권한
	private void check(String checktable, String checkno, String no, userVO vo, HttpServletRequest request, HttpServletResponse response)
	{
		if( checkdto.tcheck(checktable, checkno, no, vo.getUserid()) == 0 )
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
