/*
 * 모듈명 : userVO 클래스에 대해서 회원가입,로그인 처리 클래스
 * 작성일 : 2025.04.14
 * 작성자 : 서진원
 */
package com.ezen.dto;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ezen.vo.*;

@Repository
public class userDTO 
{
	@Autowired
	private SqlSession session;
	
	private final static String NAMESPACE = "com.ezen.user";
	
	// 기능 : 주어진 userVO 객체를 이용하여 회원가입
	// 매개변수 : vo - 사용자 정보 객체
	// 리턴값 : true - 회원가입 성공, false - 실패	
	public boolean join(userVO vo)
	{
		session.insert(NAMESPACE + ".join", vo);
		return true;
	}
	
	//기능 : 로그인 처리 기능
	//매개변수 : userid - 아이디, userpw - 비밀번호 
	//리턴값 : null - 로그인 실패, 객체 - 로그인 정보 객체
	public userVO login(String userid, String userpw)
	{
		userVO vo = new userVO();
		vo.setUserid(userid);
		vo.setUserpw(userpw);
		vo = session.selectOne(NAMESPACE + ".login", vo);
		if(vo != null)
		{
			vo.setUserpw("");
		}
		return vo;
	}
	
	//기능 : 회원정보 검색 기능
	//매개변수 : userid - 아이디 
	//리턴값 : null - 검색 실패, 객체 - 회원정보 객체
	public userVO mypage(String userid)
	{
		userVO vo = new userVO();
		vo.setUserid(userid);
		vo = session.selectOne(NAMESPACE + ".mypage", vo);
		
		return vo;
	}
	
	//기능 : 회원정보 과제 미제출 검색 기능
	//매개변수 : userid - 아이디 
	//리턴값 : null - 검색 실패, 객체 - 미제출 과제 리스트
	public int mypagetask(String userid) 
	{
		int count = session.selectOne(NAMESPACE + ".mypagetask", userid);
		return count;
	}
	
	//기능 : 주어진 userID를 이용하여 중복된 회원아이디인지 검사
	//매개변수 : userID - 사용자 아이디
	//리턴값 : true - 아이디 중복됨, false - 아이디 중복 안됨
	public boolean isDupCheckID(String userid)
	{	
		int total = session.selectOne(NAMESPACE + ".checkid", userid);
		if( total > 0 )
		{
			return true;
		}
		return false;
	}
	
	//기능 : 주어진 email를 이용하여 중복된 이메일인지 검사
	//매개변수 : email - 사용자 이메일
	//리턴값 : true - 이메일 중복됨, false - 이메일 중복 안됨
	public boolean isDupCheckEmail(String email)
	{	
		int total = session.selectOne(NAMESPACE + ".checkemail", email);
		if( total > 0 )
		{
			return true;
		}
		return false;
	}
	
	//기능 : 주어진 email을 이용하여 유효성 검사
	//매개변수 : email - 사용자 이메일
	//리턴값 : true - 형식 완성, false - 형식 실패
	public boolean isValidEmail(String email) 
	{
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        return email.matches(emailRegex);
    }
	
	//기능 : 주어진 이름과 email을 이용하여 아이디 찾기
	//매개변수 : name - 회원 이름, email - 회원 이메일
	//리턴값 : true - 아이디, false - 공백
	public String idFind(String name, String email)
	{
		userVO vo = new userVO();
		vo.setName(name);
		vo.setEmail(email);
		
		String idcheck = session.selectOne(NAMESPACE + ".findid", vo);
		if(idcheck == null || idcheck == "")
		{
			return "";
		}
		
		System.out.println(idcheck);
		return idcheck;
	}

	// 비밀번호 찾기
	public int pwdFind(String userid, String email) 
	{
		userVO vo = new userVO();
		vo.setUserid(userid);
		vo.setEmail(email);
		
		int count = session.selectOne(NAMESPACE + ".findpwd", vo);
		return count;
	}

	// 비밀번호 재발급
	public boolean pwdNew(String userid, String email, String random) 
	{
		userVO vo = new userVO();
		vo.setUserid(userid);
		vo.setEmail(email);
		vo.setUserpw(random);
		
		session.update(NAMESPACE + ".newpwd", vo);
		return true;
	}

	// 비밀번호 변경
	public boolean pwdModify(userVO vo) 
	{
		session.update(NAMESPACE + ".modifypwd", vo);
		return true;
	}

	// 회원 임시 탈퇴
	public boolean exit(String userid) 
	{
		session.update(NAMESPACE + ".exit", userid);
		return true;
	}

	
}
