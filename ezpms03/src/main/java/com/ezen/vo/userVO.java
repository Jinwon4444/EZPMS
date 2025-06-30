/*
 * 모듈명 : 테이블 user의 데이터를 표현하기 위한 클래스
 * 작성일 : 2025.04.11
 * 작성자 : 조효준
 */

package com.ezen.vo;

public class userVO
{
	private String userid;   //아이디
	private String userpw;   //비밀번호
	private String name;     //이름
	private String tel;      //전화번호
	private String birthday; //생년월일
	private String gender;   //성별
	private String email;    //이메일
	private String state;    //탈퇴상태
	private String level;    //권한
	private String joindate;  //가입일
	
	//추가 검색 관리
	private String answer;
	private String score;
	private String sno;
	
	
	
	public String getUserid()   { return userid;   }
	public String getUserpw()   { return userpw;   }
	public String getName()     { return name;     }
	public String getTel()      { return tel;      }
	public String getBirthday() { return birthday; }
	public String getGender()   { return gender;   }
	public String getEmail()    { return email;    }
	public String getState()    { return state;    }
	public String getLevel()    { return level;    }
	public String getJoindate() { return joindate; }
	public String getAnswer()   { return answer;   }
	public String getScore()    { return score;    }
	public String getSno() 		{ return sno;      }
	

	public void setUserid(String userid)     { this.userid = userid;     }
	public void setUserpw(String userpw)     { this.userpw = userpw;     }
	public void setName(String name)         { this.name = name;         }
	public void setTel(String tel)           { this.tel = tel;           }
	public void setBirthday(String birthday) { this.birthday = birthday; }	
	public void setGender(String gender)     { this.gender = gender;     }	
	public void setEmail(String email)       { this.email = email;       }	
	public void setState(String state)       { this.state = state;       }	
	public void setLevel(String level)       { this.level = level;       }	
	public void setJoindate(String joindate) { this.joindate = joindate; }
	public void setAnswer(String answer)     { this.answer = answer;     }	
	public void setScore(String score)       { this.score = score;       }
	public void setSno(String sno) 			 { this.sno = sno;           }
	
}
