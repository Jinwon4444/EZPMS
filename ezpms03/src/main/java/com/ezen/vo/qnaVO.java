/*
 * 모듈명 : 테이블 user의 데이터를 표현하기 위한 클래스
 * 작성일 : 2025.04.11
 * 작성자 : 조효준
 */
package com.ezen.vo;

public class qnaVO
{
	private String qno;     //질의응답번호
	private String qnote;   //질의응답내용
	private String sno;     //제출번호
	private String userid;  //작성자아이디
	
	//추가 검색 사항
	public String name;
	
	
	public String getQno()    { return qno;    }
	public String getQnote()  { return qnote;  }
	public String getSno()    { return sno;    }
	public String getUserid() { return userid; }
	public String getName()   { return name;   }
	
	
	public void setQno(String qno)       { this.qno = qno;       }
	public void setQnote(String qnote)   { this.qnote = qnote;   }
	public void setSno(String sno)       { this.sno = sno;       }
	public void setUserid(String userid) { this.userid = userid; }
	public void setName(String name)     { this.name = name;     }
}
