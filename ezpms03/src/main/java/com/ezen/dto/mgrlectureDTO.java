package com.ezen.dto;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ezen.vo.lectureVO;
import com.ezen.vo.searchVO;

@Repository
public class mgrlectureDTO 
{
	@Autowired
	private SqlSession session;
	
	private final static String NAMESPACE = "com.ezen.mgrlecture";
	
	//R:공지사항 전체 갯수를 얻는다.
	//리턴값 : 전체 게시물 갯수
	public int GetTotal(searchVO vo)
	{
		int total = session.selectOne(NAMESPACE + ".total", vo);
		
		return total;
	}	
	
	//R:공지사항 목록을 조회한다.
	//리턴값 : 게시물 목록 List
	public List<lectureVO> List(searchVO vo)
	{
		List<lectureVO> list = session.selectList(NAMESPACE + ".list", vo);
		return list;
	}
	
	//기능 : 선택한 강의 삭제
	//매개변수 : 
	public boolean delete(String no)
	{
		session.delete(NAMESPACE + ".delete", no);
		return true;
	}

	// 강의 수강생 취소
	public boolean learnDelete(String userid) 
	{
		session.delete(NAMESPACE+ ".learndelete", userid);
		return true;
	}

	// 강의 수정
	public void update(lectureVO vo) {
		// TODO Auto-generated method stub
		
	}
}
