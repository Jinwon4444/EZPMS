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
import org.springframework.web.multipart.MultipartFile;

import com.ezen.dto.fileDTO;
import com.ezen.dto.lectureDTO;
import com.ezen.dto.mgrlectureDTO;
import com.ezen.util.WebUtil;
import com.ezen.vo.fileVO;
import com.ezen.vo.lectureVO;
import com.ezen.vo.noticeVO;
import com.ezen.vo.searchVO;
import com.ezen.vo.userVO;

@Controller
public class MgrlectureController 
{
	@Autowired
	lectureDTO lecturedto;
	
	@Autowired
	mgrlectureDTO mgrlecturedto;
	
	@Autowired
	fileDTO filedto;
	
	final static String uploadPath = "D:\\upload\\";
	
	//메인화면(목록)
	@RequestMapping(value = "/mgrlecture/list.do", method = RequestMethod.GET)
	public String List(HttpServletRequest request, HttpServletResponse response, @RequestParam(defaultValue = "1")int page, Model model, String title, String name, String state, String sort) 
	{
		levelCheck(request, response);
		
		// 최초 검색 시 null값 검색 가능하게 변경
		if(title == null) title = "";
		if(name == null) name = "";
		if(state == null) state = "";
		if(sort == null) sort = "";
		
		model.addAttribute("state", state);
		
		userVO loginVO = (userVO) request.getSession().getAttribute("login");
		String level = loginVO.getLevel();
		searchVO vo = new searchVO();
		vo.setPageno(page);		
		vo.setKeyword(title.trim());
		vo.setKeyword2(name.trim());
		vo.setIndex(state);
		vo.setSort(sort);
		vo.setUserid(loginVO.getUserid());
		
		//전체 갯수 
		int total = mgrlecturedto.GetTotal(vo);
		// System.out.println(total);
		
		//최대 페이징
		int maxpage = total / 10;
		if( total % 10 != 0) maxpage++;
		
		//목록 조회
		List<lectureVO> list = mgrlecturedto.List(vo);
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
		
		return "mgrlecture/list";
	}
	
	// 선택 삭제
	@RequestMapping(value = "/mgrlecture/delete.do", method = RequestMethod.GET)
	public void Delete(HttpServletRequest request, @RequestParam(required = true, defaultValue="0") String lno, HttpServletResponse response) throws IOException 
	{
		levelCheck(request, response);
		
		String[] lno_list = lno.split(","); 
		for(String no : lno_list)
		{
			mgrlecturedto.delete(no);
		}
		response.sendRedirect("list.do");
	}
	
	// 관리자 강의 수정
	@RequestMapping(value = "/mgrlecture/modify.do", method = RequestMethod.GET)
	public String Modify(HttpServletRequest request, HttpServletResponse response, @RequestParam(required = true, defaultValue="0") String lno, Model model) 
	{
		levelCheck(request, response);
		
		lectureVO vo = lecturedto.View(lno);
		
		List<userVO> learnlist = lecturedto.Learnlist(lno);
		
		fileVO fvo = new fileVO();
		fvo.setNo(vo.getLno());
		fvo.setNs("lno");
		
		List<fileVO> files = filedto.List(fvo);
		
		model.addAttribute("item", vo );	
		model.addAttribute("files", files);
		model.addAttribute("list", learnlist);
		return "mgrlecture/modify";
	}
	
	// 관리자 강의 수정 완료
	@RequestMapping(value = "/mgrlecture/modifyok.do", method = RequestMethod.POST)
	public String ModifyOK(lectureVO vo, @RequestParam("files")MultipartFile[] files,
			HttpServletRequest request,HttpServletResponse response) throws IOException 
	{
		levelCheck(request, response);

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
		
		return "redirect:/lecture/view.do?lno=" + vo.getLno();
	}
	
	// 관리자 수강생 취소
	@RequestMapping(value = "/mgrlecture/learndelete.do", method = RequestMethod.GET)
	public String learnDelete(HttpServletRequest request, HttpServletResponse response, String userid, String lno) throws IOException
	{
		levelCheck(request, response);
		
		mgrlecturedto.learnDelete(userid);
		return "redirect:/lecture/view.do?lno=" + lno;
	}
	
	/*** 
	 * 관리자 권한 검사
	 * @return 관리자인지 검사하는 메소드
	 */
	private void levelCheck(HttpServletRequest request, HttpServletResponse response)
	{
		userVO vo = (userVO) request.getSession().getAttribute("login");
		if( vo == null || !vo.getLevel().equals("M"))
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
