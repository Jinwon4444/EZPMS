/*
 * 모듈명 : 테이블 user의 데이터를 표현하기 위한 클래스
 * 작성일 : 2025.04.11
 * 작성자 : 조효준
 */
package com.ezen.vo;

public class taskVO
{
	private String tno;     //과제번호
	private String ttitle;  //제목
	private String tnote;   //내용
	private String tend;    //마감일
	private String tdate;   //과제등록일
	private String lno;     //강의번호
	
	//추가 관리 항목
	private String userid; //검색된 userid
	private String score;  //검색된 score
	private String count;
	private String sno;
	private String ltitle;
	
	
	public String getTno()    { return tno;    }
	public String getTtitle() { return ttitle; }
	public String getTnote()  { return tnote;  }
	public String getTend()   { return tend;   }
	public String getTdate()  { return tdate;  }
	public String getLno()    { return lno;    }
	public String getUserid() { return userid; }
	public String getScore()  { return score;  }
	public String getCount()  { return count;    }
	public String getSno()    {return sno;}
	public String getLtitle() {return ltitle;}
	
	public void setTno(String tno)       { this.tno = tno;       }
	public void setTtitle(String ttitle) { this.ttitle = ttitle; }
	public void setTnote(String tnote)   { this.tnote = tnote;   }
	public void setTend(String tend)     { this.tend = tend;     }
	public void setTdate(String tdate)   { this.tdate = tdate;   }
	public void setLno(String lno)       { this.lno = lno;       }
	public void setUserid(String userid) { this.userid = userid; }
	public void setScore(String score)   { this.score = score;   }
	public void setCount(String count)   { this.count = count;   }
	public void setSno(String sno) 		 {this.sno = sno;}
	public void setLtitle(String ltitle) {this.ltitle = ltitle;}
}
