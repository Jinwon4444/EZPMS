/*
 * 모듈명 : 테이블 user의 데이터를 표현하기 위한 클래스
 * 작성일 : 2025.04.11
 * 작성자 : 조효준
 */
package com.ezen.vo;

public class lectureVO
{
	private String lno;     //강의번호
	private String ltitle;  //강의명
	private String lstart;  //강의시작일
	private String lend;    //강의종료일
	private String ltime;   //강의시간
	private String lnote;   //강의내용
	private String llimit;  //인원제한
	private String ldate;   //강의등록일
	private String userid;  //작성자아이디
	
	//추가관리항목
	private String name;   //작성자
	private String scount;  //수강중인 학생숫자
	private String tcount;  //강의 과제 숫자
	private String tcheck;	// 미제출 과제 확인
	private String rcheck;	// 평가완료 과제 확인
	
	public String getLno()    { return lno;    }
	public String getLtitle() { return ltitle; }
	public String getLstart() { return lstart; }
	public String getLend()   { return lend;   }
	public String getLtime()  { return ltime;  }
	public String getLnote()  { return lnote;  }
	public String getLlimit() { return llimit; }
	
	
	public String getLdate()  { return ldate;  }
	public String getUserid() { return userid; }
	public String getName()   { return name;   }
	public String getScount() { return scount; }
	public String getTcount() { return tcount; }
	public String getTcheck() {return tcheck;}
	public String getRcheck() {return rcheck;}
	
	
	public void setLno(String lno)       { this.lno = lno;       }
	public void setLtitle(String ltitle) { this.ltitle = ltitle; }
	public void setLstart(String lstart) { this.lstart = lstart; }
	public void setLend(String lend)     { this.lend = lend;     }
	public void setLtime(String ltime)   { this.ltime = ltime;   } 
	public void setLnote(String lnote)   { this.lnote = lnote;   }
	public void setLlimit(String llimit) { this.llimit = llimit; }
	public void setLdate(String ldate)   { this.ldate = ldate;   }
	public void setUserid(String userid) { this.userid = userid; }
	public void setName(String name)     { this.name = name;     }
	public void setScount(String scount) { this.scount = scount; }
	public void setTcount(String tcount) { this.tcount = tcount; }
	public void setTcheck(String tcheck) {this.tcheck = tcheck;}
	public void setRcheck(String rcheck) {this.rcheck = rcheck;}
}
