package com.ezen.vo;

public class learnlistVO
{
	private String userid;     //아이디
	private String lno;        //강의번호
	private String learndate;  //수강신청일
	
	public String getUserid()    { return userid;    }
	public String getLno()       { return lno;       }
	public String getLearndate() { return learndate; }
	
	
	public void setUserid(String userid)       { this.userid = userid;       }
	public void setLno(String lno)             { this.lno = lno;             }
	public void setLearndate(String learndate) { this.learndate = learndate; }
}
