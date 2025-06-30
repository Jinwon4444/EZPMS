package com.ezen.dto;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ezen.vo.lectureVO;
import com.ezen.vo.searchVO;
import com.ezen.vo.subtaskVO;
import com.ezen.vo.taskVO;
import com.ezen.vo.userVO;

@Repository
public class taskDTO
{
	@Autowired
	private SqlSession session;
	
	private final static String NAMESPACE = "com.ezen.task";

	// 과제 등록
	public boolean insert(taskVO vo) 
	{
		session.insert(NAMESPACE + ".insert", vo);
		return true;
	}

	// 과제 정보 조회
	public taskVO view(String tno) 
	{
		taskVO vo = session.selectOne(NAMESPACE + ".view", tno);
		return vo;
	}	
	
	// 해당과제 학생 리스트
	public List<userVO> Learnlist(String tno) 
	{
		List<userVO> list = session.selectList(NAMESPACE + ".learnlist", tno);
		return list;
	}

	// 과제 수정
	public boolean update(taskVO vo) 
	{
		session.update(NAMESPACE + ".update", vo);
		return true;
	}
	
	
	//R:강의 전체 갯수를 얻는다.
	//리턴값 : 전체 게시물 갯수
	public int GetTotal(searchVO vo)
	{
		int total = session.selectOne(NAMESPACE + ".total",vo);
		
		return total;
	}	
	
	
	//R:강의 목록을 조회한다.
	//리턴값 : 게시물 목록 List
	public List<lectureVO> List(searchVO vo)
	{
		List<lectureVO> list = session.selectList(NAMESPACE + ".list", vo);
		return list;
	}
	
	//과제 총 갯수를 구한다
	public int GetTaskTotal(searchVO vo)
	{
		int total = session.selectOne(NAMESPACE + ".tasktotal",vo);
		
		return total;
	}
	
	//R:강의의 과제 목록을 조회한다.
	//리턴값 : 게시물 목록 List
	public List<taskVO> TaskList(searchVO vo)
	{
		List<taskVO> list = session.selectList(NAMESPACE + ".tasklist",vo);
		return list;
	}
	
	//과제 총 갯수를 구한다
	public int GenStuTotal(searchVO vo)
	{
		int total = session.selectOne(NAMESPACE + ".stutotal",vo);
		
		return total;
	}

	// 과제 제출했는지 확인
	public int learnCount(String tno) 
	{
		int count = session.selectOne(NAMESPACE + ".learncount", tno);
		return count;
	}

	// 과제 채점
	public boolean evaluateOk(subtaskVO vo) 
	{
		session.update(NAMESPACE + ".evaluateok", vo);
		return true;
	}
}
	
	