package com.ezen.dto;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ezen.vo.searchVO;
import com.ezen.vo.userVO;

@Repository
public class memberDTO 
{
	@Autowired
	private SqlSession session;
	
	private final static String NAMESPACE = "com.ezen.member";
	
	//기능 : 검색된 회원 인원수를 얻는다
	//매개변수 : searchVO vo - 검색된 vo
	//리턴값 : 회원 총 숫자
	public int GetTotal(searchVO vo)
	{
		int total = session.selectOne(NAMESPACE + ".total", vo);
		
		return total;
	}	
	
	//기능 : 검색된 회원 목록 조회
	//매개변수 : searchVO vo - 검색된 vo
	//리턴값 : 회원목록 List
	public List<userVO> List(searchVO vo)
	{
		List<userVO> list = session.selectList(NAMESPACE + ".list", vo);
		return list;
	}
	
	//기능 : 검색된 회원 목록 조회
	//매개변수 : searchVO vo - 검색된 vo
	//리턴값 : 회원목록 List
	public boolean modify(userVO vo)
	{
		session.update(NAMESPACE + ".modify", vo);
		return true;
	}

	//기능 : 선택한 회원 목록 삭제
	//매개변수 : userid - 선택한 아이디들
	public boolean delete(String userid)
	{	
		session.delete(NAMESPACE + ".delete", userid);
		return true;
	}
	
	// 회원 복구
	// 매개변수 : userid - 복구할 아이디
	public boolean restore(String userid) 
	{
		session.update(NAMESPACE + ".restore", userid);
		return true;
	}
}
