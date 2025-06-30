package com.ezen.dto;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ezen.vo.checkVO;
import com.ezen.vo.learnlistVO;
import com.ezen.vo.lectureVO;
import com.ezen.vo.noticeVO;
import com.ezen.vo.qnaVO;
import com.ezen.vo.searchVO;
import com.ezen.vo.subtaskVO;
import com.ezen.vo.taskVO;

@Repository
public class learnDTO
{
	@Autowired
	private SqlSession session;
	
	private final static String namespace = "com.ezen.learn";
	
	
	//R:수강신청 강의의 전체 갯수를 얻는다.
	//리턴값 : 전체 게시물 갯수
	public int GetTotal(searchVO vo)
	{
		int total = session.selectOne(namespace + ".total",vo);
		
		return total;
	}	
	
	
	//R:수강신청 강의의 목록을 조회한다.
	//리턴값 : 게시물 목록 List
	public List<lectureVO> LectureList(searchVO vo)
	{
		List<lectureVO> list = session.selectList(namespace + ".lecturelist",vo);
		return list;
	}
	
	//R:강의 정보를 조회한다.
	public lectureVO View(String lno)
	{
		lectureVO vo = session.selectOne(namespace + ".view",lno);

		return vo;
	}
	
	//C:수강신청을 한다
	public boolean Sign(learnlistVO vo)
	{
		int total = session.selectOne(namespace + ".checksign",vo);
		if(total > 0)
		{
			return true;
		}
		else
		{
			session.insert(namespace + ".sign", vo);
			return false;
		}
	}
	
	
	//R:수강신청 강의의 목록을 조회한다.
	//리턴값 : 게시물 목록 List
	public List<lectureVO> List(searchVO vo)
	{
		List<lectureVO> list = session.selectList(namespace + ".list",vo);
		return list;
	}
	
	public int GetListTotal(searchVO vo)
	{
		int total = session.selectOne(namespace + ".listtotal",vo);
		
		return total;
	}
	
	public void Delete(learnlistVO vo)
	{	
		session.delete(namespace + ".delete", vo);
	}
	
	
	//R:강의의 과제 목록을 조회한다.
	//리턴값 : 게시물 목록 List
	public List<taskVO> TaskList(searchVO vo)
	{
		List<taskVO> list = session.selectList(namespace + ".tasklist",vo);
		return list;
	}
	
	public int GetTaskTotal(searchVO vo)
	{
		int total = session.selectOne(namespace + ".tasktotal",vo);
		
		return total;
	}
	
	public taskVO TaskSub(String tno)
	{
		taskVO vo = session.selectOne(namespace + ".tasksub",tno);
		return vo;
	}
	
	
	public boolean Insert(subtaskVO vo)
	{
		session.insert(namespace + ".insert",vo);
		return false;
	}
	
	public boolean CheckTask(subtaskVO vo)
	{
		int total = session.selectOne(namespace + ".checktask",vo); //user의 learnlist에 수강정보가 있는지 확인
		int sub   = session.selectOne(namespace + ".checksub",vo);  //user의 subtask에 과제정보가 있는지 확인
		if(total <= 0)   //learnlist에 정보가 없다면 수강하고있지 않은상태이므로 false반환
		{
			return true;
		} else if(sub > 0) //subtask에 정보가 있다면 이미 제출한 과제이므로 false반환
		{
			return true;
		}
		return false;
	}
	
	public subtaskVO TaskView(taskVO tvo)
	{
		subtaskVO vo = session.selectOne(namespace + ".taskview", tvo);
		return vo;
	}
	
	
	public String QnaList(qnaVO vo)
	{
		List<qnaVO> list = session.selectList(namespace + ".qnalist",vo);
		String xml = "";
		
		xml += "<chatmsg>\n";
		for(qnaVO qvo : list) 
		{
			xml += "<msg>\n";
			xml += "<no>" + qvo.getQno() + "</no>\n";
			xml += "<name>" + qvo.getName() + "</name>\n";
			xml += "<note>" + qvo.getQnote() + "</note>\n";
			xml += "</msg>\n";
		}
		xml += "</chatmsg>\n";
		
		return xml;
	}
	
	public String QnaInsert(qnaVO vo)
	{
		session.insert(namespace + ".qnainsert",vo);
		return "ok";
	}
	
	
	//U:공지사항을 업데이트한다
	public boolean Update(subtaskVO vo)
	{
		session.update(namespace + ".update",vo);
		return true;
	}


	public List<taskVO> CheckSubTask(String userid) 
	{
		List<taskVO> tlist = session.selectList(namespace + ".checksubtask", userid);
		return tlist;
	}
	
	
}
