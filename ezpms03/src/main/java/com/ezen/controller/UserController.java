/*
 * 모듈명 : 유저 관련 웹 어플리케이션 처리를 위한 control class
 * 작성일 : 2025.04.11
 * 작성자 : 서진원
 */
package com.ezen.controller;

import java.awt.Color;
import java.io.IOException;
import java.io.OutputStream;
import java.security.MessageDigest;
import java.util.List;

import javax.imageio.ImageIO;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ezen.dto.userDTO;
import com.ezen.util.WebUtil;
import com.ezen.vo.taskVO;
import com.ezen.vo.userVO;

import nl.captcha.Captcha;
import nl.captcha.Captcha.Builder;
import nl.captcha.backgrounds.FlatColorBackgroundProducer;

@Controller
public class UserController 
{

	@Autowired
	userDTO userdto;
	
	/*** 
	 * 로그인 페이지로 이동
	 * @return 로그인 페이지
	 */
	@RequestMapping(value="/login/login.do", method = RequestMethod.GET)
	public String login(HttpServletRequest request)
	{
		request.getSession().setAttribute("login", null);
		return "login/login";
	}
	
	/*** 
	 * 로그인 처리
	 * @return 로그인 처리 결과 리턴
	 */
	@RequestMapping(value = "/login/loginok.do", method = RequestMethod.POST)
	@ResponseBody
	public String LoginOK(HttpServletRequest request,String userid,String userpw) 
	{
		userVO vo = userdto.login(userid, userpw);
		
		if(vo == null)
		{
			request.getSession().setAttribute("login", null);
			return "ERROR";
		} else if(vo.getState().equals("N"))
		{
			request.getSession().setAttribute("login", null);
			return "NOT";
		} else 
		{
			// 세션에 로그인정보를 저장한다.
			System.out.println(vo.getUserpw());
			System.out.println(vo.getLevel());
			request.getSession().setMaxInactiveInterval(120 * 60);
			request.getSession().setAttribute("login", vo);
			switch (vo.getLevel()) 
			{
				case "S":
					return "S";
				case "T":
					return "T";
				case "M":
					return "M";
			}
			return "";
		}
	}
	
	/*** 
	 * 로그아웃
	 * @return 로그인 페이지
	 */
	@RequestMapping(value = "/login/logout.do", method = RequestMethod.GET)
	public String Logout(HttpServletRequest request) 
	{
		request.getSession().setAttribute("login", null);	
		return "redirect:/login/login.do";
	}	
	
	/*** 
	 * 회원가입 페이지로 이동
	 * @return 회원가입 페이지
	 */
	@RequestMapping(value = "/login/join.do", method = RequestMethod.GET)
	public String join()
	{
		return "login/join";
	}
	
	//아이디 중복체크
	@RequestMapping(value = "/login/idcheck.do", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String IDCheck(@RequestParam("id")String userid)
	{
		if(userid == null)
		{
			return "X:아이디가 입력되지 않았습니다.";
		}
		if( userdto.isDupCheckID(userid) == true)
		{
			return "Y:중복된 아이디입니다.";
		}else
		{
			return "N:사용가능한 아이디입니다.";
		}
	}
	
	//이메일 중복체크
	@RequestMapping(value = "/login/emailcheck.do", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String emailCheck(String email)
	{
		if(email == null)
		{
			return "X:이메일이 입력되지 않았습니다.";
		}
		if( userdto.isValidEmail(email) == false)
		{
			return "F:이메일 형식이 아닙니다.";
		}
		if( userdto.isDupCheckEmail(email) == true)
		{
			return "Y:중복된 이메일입니다.";
		} else
		{
			return "N:사용가능한 이메일입니다.";
		}
	}
	
	/*** 
	 * 회원가입 완료
	 * @return 회원가입 완료 페이지
	 */
	@RequestMapping(value = "/login/joinok.do", method = RequestMethod.POST)
	public String joinOk(userVO vo)
	{
		if(vo == null)
		{
			System.out.println("비정상적인 접근입니다.");
			return "redirect:/login/login.do";
		}
		
		userdto.join(vo);
		return "login/joinok";
	}
	
	/*** 
	 * 아이디찾기 페이지로 이동
	 * @return 아이디찾기 페이지
	 */
	@RequestMapping(value = "/login/idfind.do", method = RequestMethod.GET)
	public String idFind(HttpServletRequest request)
	{
		return "login/idfind";
	}
	/*** 
	 * 아이디찾기 
	 * @return 아이디찾기 결과값 리턴
	 */
	@RequestMapping(value = "/login/idfind.do", method = RequestMethod.POST)
	@ResponseBody
	public String idFindok(String name, String email)
	{
		if(name == null || email == null)
		{
			System.out.println("비정상적인 접근입니다.");
			return "redirect:/login/login.do";
		}
		
		String userid = userdto.idFind(name, email);
		if(userid.equals(""))
		{
			return "X";
		} else 
		{
			return "Y:" + userid;
		}
	}
	
	/*** 
	 * 비밀번호찾기 페이지로 이동
	 * @return 비밀번호찾기 페이지
	 */
	@RequestMapping(value = "/login/pwdfind.do", method = RequestMethod.GET)
	public String pwdFind(HttpServletRequest request)
	{
		request.getSession().setAttribute("check", null);
		return "login/pwdfind";
	}
	// 비밀번호 찾기
	@RequestMapping(value = "/login/pwdfind.do", method = RequestMethod.POST)
	@ResponseBody
	public String pwdFindok(String userid, String email)
	{
		int count = userdto.pwdFind(userid, email);
		if(count == 0)
		{
			return "X";
		} else
		{
			return "Y";
		}
	}
	
	/*** 
	 * 비밀번호찾기 후 재발급
	 * @return 
	 */
	@RequestMapping(value = "/login/pwdnew.do", method = RequestMethod.POST)
	public String pwdFindOk(HttpServletRequest request, String userid, String email)
	{
		if(userid == null || email == null)
		{
			System.out.println("비정상적인 접근입니다.");
			return "redirect:/login/login.do";
		}
		String random = WebUtil.Random(10);
		userdto.pwdNew(userid, email, random);
		
		String code    = random;
		String msg     = "mail send ok...";
		String from    = "sjw242@naver.com";
		String to      = email;
		String title   = "EZPMS 임시 비밀번호입니다.";
		String content = "임시 비밀번호 : " + code;
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom(from);     // 보내는사람 생략하거나 하면 정상작동을 안함
			messageHelper.setTo(to);         // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(content);  // 메일 내용

			mailSender.send(message);
			
		} catch (Exception e) 
		{
			e.printStackTrace();
			msg = e.toString();
		}
		
		return "login/login";
	}
	
	// 비밀번호 수정 페이지
	@RequestMapping(value = "/login/pwdmodify.do", method = RequestMethod.GET)
	public String pwdModify(HttpServletRequest request, Model model, String userid)
	{
		userVO vo = (userVO) request.getSession().getAttribute("login");
		if( userid == null)
		{
			userid = "";
		}
		if( vo == null)
		{
			//로그인하지 않음.
			System.out.println("비정상적인 접근입니다.");
			return "redirect:/login/login.do";
		}
		
		model.addAttribute("data", vo);
		model.addAttribute("memberid", userid);
		return "login/pwdmodify";
	}
	// 비밀번호 수정
	@RequestMapping(value = "/login/pwdmodify.do", method = RequestMethod.POST)
	public String pwdModifyOk(HttpServletRequest request, String selectid, String userpw)
	{
		userVO vo = (userVO) request.getSession().getAttribute("login");
		if( vo == null)
		{
			//로그인하지 않음.
			System.out.println("비정상적인 접근입니다.");
			return "redirect:/login/login.do";
		}
		
		// 관리자가 회원 비밀번호 수정시
		if(selectid != null)
		{
			vo.setUserid(selectid);
		}
		vo.setUserpw(userpw);
		userdto.pwdModify(vo);
		
		if(vo.getLevel().equals("M"))
		{
			return "redirect:/mgrmember/list.do";
		} else
		{
			return "login/mypage";
		}
	}
	
	/*** 
	 * 내정보 페이지로 이동
	 * @return 내정보 페이지
	 */
	@RequestMapping(value = "/login/mypage.do", method = RequestMethod.GET)
	public String mypage(HttpServletRequest request, Model model)
	{
		userVO vo = (userVO) request.getSession().getAttribute("login");
		if( vo == null)
		{
			//로그인하지 않음.
			System.out.println("비정상적인 접근입니다.");
			return "redirect:/login/login.do";
		}
		
		int count = userdto.mypagetask(vo.getUserid());
		
		vo = userdto.mypage(vo.getUserid());
		vo.setEmail(WebUtil.Text2HTML(vo.getEmail()));
		
		model.addAttribute("data", vo);
		model.addAttribute("count", count);
		
		return "login/mypage";
	}
	
	// 회원탈퇴
	@RequestMapping(value = "/login/exit.do", method = RequestMethod.GET)
	public String delete(HttpServletRequest request, Model model)
	{
		userVO vo = (userVO) request.getSession().getAttribute("login");
		if( vo == null)
		{
			//로그인하지 않음.
			System.out.println("비정상적인 접근입니다.");
			return "redirect:/login/login.do";
		}
		
		userdto.exit(vo.getUserid());
		
		model.addAttribute("msg", "계정이 비활성화되었습니다.");
		model.addAttribute("url", "/login/login.do");
		return "include/alert";
	}
	
	//캡챠 이미지 출력
	@RequestMapping(value = "/login/sign.do")
	public void Sign(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		// 자동 등록 방지 코드를 생성할 객체들을 선언합니다
		Captcha mCaptcha;
		Builder mBuilder;
		String  mAnswer;

		// 자동 등록방지코드를 생성하고, 코드를 이미지로 변환, 이미지를 출력(반환)
		mBuilder = new Captcha.Builder(160,50);
		// 빌더에 문자열을 추가
		mBuilder.addText();
		// 빌더에 배경색을 추가
		mBuilder.addBackground(new FlatColorBackgroundProducer(Color.WHITE));
		// 선 추가
		mBuilder.addBorder();
		// 노이즈 추가
		mBuilder.addNoise();
		// 셋팅이된 내용으로 빌더에게 captcha를 생성 요청함
		mCaptcha = mBuilder.build();
		// captcha가 갖고있는 정답을 문자열로 저장해둡니다
		mAnswer  = mCaptcha.getAnswer();

		// captcha를 이미지로 반환합니다
		OutputStream mOut = response.getOutputStream();
		ImageIO.write(mCaptcha.getImage(), "jpg", mOut);
		mOut.close();

		// 세션에, 정답을 저장합니다
		request.getSession().setAttribute("sign",mAnswer);			
	}
	
	//캡챠 정답 조회
	@RequestMapping(value = "/login/getsign.do")
	@ResponseBody
	public String GetSign(HttpServletRequest request)
	{
		return (String)request.getSession().getAttribute("sign");
	}

	
	// 이메일 전송
	@Autowired
	private JavaMailSender mailSender;
	
	@RequestMapping(value = "/login/mailsend.do", method = RequestMethod.POST)
	@ResponseBody
	public String mailSend(HttpServletRequest request, String email)
	{
		try 
		{
			if( userdto.isValidEmail(email) == false)
			{
				return "F";
			} 
		} catch(Exception e)
		{
			return "F";
		}
		
		String code    = WebUtil.Random(5);
		String msg     = "mail send ok...";
		String from    = "sjw242@naver.com";
		String to      = email;
		String title   = "인증 정보입니다.";
		String content = "인증번호 : " + code;
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom(from);     // 보내는사람 생략하거나 하면 정상작동을 안함
			messageHelper.setTo(to);         // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(content);  // 메일 내용

			mailSender.send(message);
			request.getSession().setMaxInactiveInterval(3 * 60);
			request.getSession().setAttribute("check", code);
			// System.out.println(request.getSession().getAttribute("check"));
		} catch (Exception e) 
		{
			e.printStackTrace();
			msg = e.toString();
		}
		
		return "S";
	}
	
	// 인증번호 확인
	@RequestMapping(value = "/login/mailcheck.do", method = RequestMethod.POST)
	@ResponseBody
	public String mailCheck(HttpServletRequest request, String check)
	{
		if( check == null)
		{
			System.out.println("비정상적인 접근입니다.");
			return "redirect:/login/login.do";
		}
		System.out.println(request.getSession().getAttribute("check"));
		try 
		{
			if(request.getSession().getAttribute("check").equals(check))
			{
				return "S";
			} else
			{
				return "F";
			}
		} catch(Exception e)
		{
			return "F";
		}
	}
}
