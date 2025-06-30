/*
 * 모듈명 : 테이블 user의 데이터를 표현하기 위한 클래스
 * 작성일 : 2025.04.11
 * 작성자 : 조효준
 */
package com.ezen.vo;

public class subtaskVO
{
	private String sno;      //제출번호
	private String answer;   //답안
	private String score;    //점수
	private String subdate;  //제출일
	private String userid;   //아이디
	private String tno;      //과제번호
	
	//추가 검색 항목
	private String name;
	
	
	public String getSno()     { return sno;     }
	public String getAnswer()  { return answer;  }
	public String getScore()   { return score;   }
	public String getSubdate() { return subdate; }
	public String getUserid()  { return userid;  }
	public String getTno()     { return tno;     }
	public String getName()    { return name;    }
	
	public void setSno(String sno)         { this.sno = sno;         }
	public void setAnswer(String answer)   { this.answer = answer;   }
	public void setScore(String score)     { this.score = score;     }
	public void setSubdate(String subdate) { this.subdate = subdate; }
	public void setUserid(String userid)   { this.userid = userid;   }
	public void setTno(String tno)         { this.tno = tno;         }
	public void setName(String name)       { this.name = name;       }
}
