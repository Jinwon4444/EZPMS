/*
 * 모듈명 : WebUitl은 각종 유틸리티 기능을 제공한다.
 * 작성일 : 2025.04.25
 * 작성자 : 서진원
 */
package com.ezen.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ezen.dto.checkDTO;
import com.ezen.dto.fileDTO;
import com.ezen.vo.fileVO;
import com.ezen.vo.userVO;

public class WebUtil 
{
	final static String uploadPath = "D:\\upload\\"; 
	
	@Autowired
	static
	checkDTO checkdto;
	
	//일반 텍스트 내용를 HTML 내용으로 변환
	//매개변수 : text - 일반 텍스트 내용
	//리턴값 : 변환된 HTML 내용	
	public static String Text2HTML(String text)
	{
		String note = text;
		//< 와 >를 변경한다.
		note = note.replace("<","&lt;");
		note = note.replace(">","&gt;");

		//엔터문자를 변경한다.
		note = note.replace("\n","<br>\n");
		return note;
	}
	
	//인증용 번호를 생성한다.
	public static String Random(int max)
	{
		String code = "abcdefghijklmnopqrstuvwxyz1234567890";
		int    rand;
		String msg = "";
		
		for(int i = 0 ; i < max; i++)
		{
			rand  = (int)(Math.random() * 1000) % code.length();
			msg  += code.charAt(rand);
		}
		return msg;
	}
	
	// 파일 업로드
	public static void fileName(@RequestParam("files")MultipartFile[] files, fileVO fvo, String ns, String no) throws IllegalStateException, IOException
	{
		for(MultipartFile file : files)
		{
			if (!file.isEmpty()) 
			{
				//2. 원본 파일 이름 알아오기
				String originalFileName = file.getOriginalFilename();
				System.out.println("원래파일명 :" + originalFileName);
				
				//3. 파일이름이 중복되어 저장되지 않도록 파일이름 변경(UUID)
				UUID uuid = UUID.randomUUID();
				String savedFileName = uuid.toString();
				System.out.println("저장파일명 :" + savedFileName);
				
				//4. 파일객체 생성
				File newFile = new File(uploadPath + savedFileName);
				
				//5. 파일을 upload 디렉토리에 저장
				file.transferTo(newFile);
				
				fvo.setFname(originalFileName);
				fvo.setPname(savedFileName);
				fvo.setNo(no);
				fvo.setNs(ns);
				
				fileDTO filedto = new fileDTO();
				filedto.Insert(fvo);
			}
		}
	}
	
	// 파일 다운로드
	public static void fileDown(@RequestParam("name")String orgName, @RequestParam("file")String saveName,
			HttpServletResponse response) throws IOException
	{
		File file = new File(uploadPath,saveName);
		
		// 파일명 인코딩
		String encodedFileName = new String (orgName.getBytes("UTF-8"), "ISO-8859-1");
		
		// file 다운로드 설정
		response.setContentType("application/download");
		response.setContentLength((int)file.length());
		response.setHeader("Content-Disposition", "attatchment;filename=\"" + encodedFileName + "\"");
		
		// 다운로드 시 저장되는 이름은 Response Header의 "Content-Disposition"에 명시
		OutputStream os = response.getOutputStream();
		
		FileInputStream fis = new FileInputStream(file);
		FileCopyUtils.copy(fis, os);
	}
	
}
