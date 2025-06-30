package com.ezen.dto;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ezen.vo.lectureVO;
import com.ezen.vo.searchVO;
import com.ezen.vo.userVO;

@Repository
public class lectureDTO
{
	@Autowired
	private SqlSession session;
	
	private final static String namespace = "com.ezen.lecture";
	
	//C:강의를 등록한다.
	//매개변수 : vo - 등록할 게시물 정보
	//리턴값 : true - 등록 성공, false - 등록 실패	
	public boolean Insert(lectureVO vo)
	{
		session.insert(namespace + ".insert",vo);
		return true;
	}
	
	//R:강의 정보를 조회한다.
	public lectureVO View(String lno)
	{
		lectureVO vo = session.selectOne(namespace + ".view",lno);

		return vo;
	}
	//R:강의 목록을 조회한다.
	//리턴값 : 게시물 목록 List
	public List<userVO> Learnlist(String lno)
	{
		List<userVO> list = session.selectList(namespace + ".learnlist", lno);
		return list;
	}
	
	//R:강의 전체 갯수를 얻는다.
	//리턴값 : 전체 게시물 갯수
	public int GetTotal(searchVO vo)
	{
		int total = session.selectOne(namespace + ".total",vo);
		
		return total;
	}	
	
	
	//R:강의 목록을 조회한다.
	//리턴값 : 게시물 목록 List
	public List<lectureVO> List(searchVO vo)
	{
		List<lectureVO> list = session.selectList(namespace + ".list", vo);
		return list;
	}
	
	//U:강의 업데이트한다
	public boolean Update(lectureVO vo)
	{
		session.update(namespace + ".update",vo);
		return true;
	}

}
