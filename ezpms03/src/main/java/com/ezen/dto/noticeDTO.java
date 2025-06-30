package com.ezen.dto;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ezen.vo.noticeVO;
import com.ezen.vo.searchVO;

@Repository
public class noticeDTO
{
	@Autowired
	private SqlSession session;
	
	private final static String namespace = "com.ezen.notice";
	
	//C:공지사항을 등록한다.
	//매개변수 : vo - 등록할 게시물 정보
	//리턴값 : true - 등록 성공, false - 등록 실패	
	public boolean Insert(noticeVO vo)
	{
		session.insert(namespace + ".insert",vo);
		return true;
	}
	
	
	//R:공지사항 정보를 조회한다.
	//매개변수 : nno - 조회할 게시물 번호, 
	//리턴값 : noticeVO - 게시물 정보, null - 게시물 없음		
	public noticeVO View(String nno)
	{
		noticeVO vo = session.selectOne(namespace + ".view",nno);

		return vo;
	}
	
	//U:공지사항을 업데이트한다
	public boolean Update(noticeVO vo)
	{
		session.update(namespace + ".update",vo);
		return true;
	}
	
	public void Delete(String nno)
	{	
		session.delete(namespace + ".delete", nno);
	}
	
	
	//R:공지사항 전체 갯수를 얻는다.
	//리턴값 : 전체 게시물 갯수
	public int GetTotal(searchVO vo)
	{
		int total = session.selectOne(namespace + ".total",vo);
		
		return total;
	}	
	
	
	//R:공지사항 목록을 조회한다.
	//리턴값 : 게시물 목록 List
	public List<noticeVO> List(searchVO vo)
	{
		List<noticeVO> list = session.selectList(namespace + ".list",vo);
		return list;
	}
	
}
