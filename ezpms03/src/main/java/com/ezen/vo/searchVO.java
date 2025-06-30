/* ********************************
클래스 기능 : 검색정보 클래스
작성자 : 조효준
작성일 : 2025.04.016
******************************** */ 

package com.ezen.vo;

public class searchVO 
{
	private int    pageno;  //페이지 번호
	private int    offset;  //limit 시작위치 
	private String index;    //kind => J 또는 H
	private String keyword; //검색어
	private String keyword2; //검색어2
	private String userid;
	private String sort;	// order구문
	

	//추가검색옵션
	private String day; 
	private String no;
	private int pagesize = 10; // 기본값 10


	
	
	
	public int    getPageno()  	{ return pageno;   } 
	public int    getOffset()   { return offset;   }
	public String getIndex()    { return index;    }
	public String getKeyword()  { return keyword;  }
	public String getKeyword2() { return keyword2; }
	public String getUserid()  	{ return userid;   }
	public String getSort()    	{ return sort;     }
	public String getDay()      { return day;      }
	public String getNo()       { return no;       }
	public int getPagesize()    { return pagesize; }
	
	
	
	
	public void setPageno(int pageno)      
	{ 
		this.pageno = pageno;
		this.offset = (this.pageno - 1) * this.pagesize;
	}
	
	public void setIndex(String index)     	 { this.index = index;       }
	public void setKeyword(String keyword) 	 { this.keyword = keyword;   }
	public void setKeyword2(String keyword2) { this.keyword2 = keyword2; }
	public void setUserid(String userid)   	 { this.userid = userid;     }
	public void setSort(String sort) 	   	 { this.sort = sort;         }
	public void setDay(String day)           { this.day = day;           }	
	public void setNo(String no)             { this.no = no;             }
	public void setPagesize(int pagesize)    { this.pagesize = pagesize; }
}
