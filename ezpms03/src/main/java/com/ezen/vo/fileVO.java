package com.ezen.vo;

public class fileVO
{

	private String pname;  //물리파일명
	private String fname;  //논리파일명
	
	//추가관리항목
	private String ns;
	private String no;
	

	public String getPname() { return pname; }
	public String getFname() { return fname; }
	public String getNs()    { return ns;    }
	public String getNo()    { return no;    }
	

	public void setPname(String pname) { this.pname = pname; }
	public void setFname(String fname) { this.fname = fname; }
	public void setNs(String ns)       { this.ns = ns;       }
	public void setNo(String no)       { this.no = no;       }
}