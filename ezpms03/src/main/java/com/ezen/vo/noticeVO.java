/*
 * 모듈명 : 테이블 user의 데이터를 표현하기 위한 클래스
 * 작성일 : 2025.04.11
 * 작성자 : 조효준
 */
package com.ezen.vo;

public class noticeVO
{
	private String nno;    //공지사항번호
	private String ntitle; //공지제목
	private String nnote;  //공지내용
	private String ndate;  //작성일
	private String userid; //작성자아이디
	
	//추가관리목록
	private String name;   //작성자
	
	public String getNno()    { return nno;	   }
	public String getNtitle() { return ntitle; }
	public String getNnote()  { return nnote;  }
	public String getNdate()  { return ndate;  }
	public String getUserid() { return userid; }
	public String getName()   { return name;   }
	
	public void setNno(String nno)       { this.nno = nno;       }
	public void setNtitle(String ntitle) { this.ntitle = ntitle; }
	public void setNnote(String nnote)   { this.nnote = nnote;   }
	public void setNdate(String ndate)   { this.ndate = ndate;   }
	public void setUserid(String userid) { this.userid = userid; }
	public void setName(String name)     { this.name = name;     }
}
