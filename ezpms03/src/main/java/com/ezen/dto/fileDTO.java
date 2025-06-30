package com.ezen.dto;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ezen.vo.fileVO;

@Repository
public class fileDTO
{
	@Autowired
	private SqlSession session;
	
	private final static String namespace = "com.ezen.file";
	
	//C:게시물을 등록한다.
	//매개변수 : vo - 등록할 게시물 정보
	//리턴값 : true - 등록 성공, false - 등록 실패	
	public boolean Insert(fileVO vo)
	{
		session.insert(namespace + ".insert",vo);
		return true;
	}
	
	public List<fileVO> List(fileVO vo)
	{

		
		List<fileVO> list = session.selectList(namespace + ".file_list",vo);	
		
		return list;
	}
	
	public boolean Delete(fileVO vo)
	{
		session.delete(namespace + ".delete",vo);

		return true;
	}
}
