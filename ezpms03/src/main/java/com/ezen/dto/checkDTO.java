package com.ezen.dto;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ezen.vo.checkVO;

@Repository
public class checkDTO 
{
	@Autowired
	private SqlSession session;
	
	private final static String NAMESPACE = "com.ezen.check";
	
	// 권한 체크
	public int check(String checktable, String checkno, String no, String userid)
	{
		checkVO cvo = new checkVO();
		cvo.setChecktable(checktable);
		cvo.setCheckno(checkno);
		cvo.setNo(no);
		cvo.setUserid(userid);
		
		int count = session.selectOne(NAMESPACE + ".check", cvo);
		return count;
	}
	
	public int tcheck(String checktable, String checkno, String no, String userid)
	{
		checkVO cvo = new checkVO();
		cvo.setChecktable(checktable);
		cvo.setCheckno(checkno);
		cvo.setNo(no);
		cvo.setUserid(userid);
		
		int count = session.selectOne(NAMESPACE + ".taskcheck", cvo);
		return count;
	}
}
