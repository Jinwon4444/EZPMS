/*
 * 모듈명 : 권한check의 데이터를 표현하기 위한 클래스
 * 작성일 : 2025.04.29
 * 작성자 : 서진원
 */

package com.ezen.vo;

public class checkVO 
{
	private String userid;
	private String checktable;
	private String checkno;
	private String no;
	
	public String getUserid() {return userid;}
	public String getChecktable() {return checktable;}
	public String getCheckno() {return checkno;}
	public String getNo() {return no;}
	
	public void setUserid(String userid) {this.userid = userid;}
	public void setChecktable(String checktable) {this.checktable = checktable;}
	public void setCheckno(String checkno) {this.checkno = checkno;}
	public void setNo(String no) {this.no = no;}
	
}
