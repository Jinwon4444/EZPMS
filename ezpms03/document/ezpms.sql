SET SESSION FOREIGN_KEY_CHECKS=0;

drop database ezpms;

create database ezpms;
use ezpms;


/* Drop Tables */

DROP TABLE IF EXISTS file;
DROP TABLE IF EXISTS learnlist;
DROP TABLE IF EXISTS qna;
DROP TABLE IF EXISTS subtask;
DROP TABLE IF EXISTS task;
DROP TABLE IF EXISTS lecture;
DROP TABLE IF EXISTS notice;
DROP TABLE IF EXISTS user;




/* Create Tables */

CREATE TABLE file
(
	nno int comment '공지사항번호',
	lno int comment '강의번호',
	sno int comment '제출번호',
	tno int comment '과제번호',
	pname varchar(200) comment '물리파일명',
	fname varchar(200) comment '논리파일명'
);


CREATE TABLE learnlist
(
	userid varchar(50) NOT NULL comment '아이디',
	lno int NOT NULL comment '강의번호',
	learndate date default (current_date) comment '수강신청일'
);


CREATE TABLE lecture
(
	lno int PRIMARY KEY AUTO_INCREMENT comment '강의번호',
	userid varchar(50) NOT NULL comment '아이디',
	ltitle varchar(50) comment '강의명',
	lstart datetime comment '강의시작일',
	lend datetime comment '강의종료일',
	ltime varchar(50) comment '강의시간',
	lnote text comment '강의 내용',
	llimit int comment '인원제한',
	ldate date default (current_date) comment '강의등록일'
);


CREATE TABLE notice
(
	nno int PRIMARY KEY AUTO_INCREMENT comment '공지사항번호',
	userid varchar(50) NOT NULL comment '아이디',
	ntitle varchar(100) comment '제목',
	nnote text comment '내용',
	ndate date default (current_date) comment '작성일'
);


CREATE TABLE qna
(
	qno int PRIMARY KEY AUTO_INCREMENT comment '질의응답번호',
	sno int NOT NULL comment '제출번호',
	userid varchar(50) NOT NULL comment '아이디',
	qnote varchar(100) comment '질의응답내용'
);


CREATE TABLE subtask
(
	sno int PRIMARY KEY AUTO_INCREMENT comment '제출번호',
	userid varchar(50) NOT NULL comment '아이디',
	tno int NOT NULL comment '과제번호',
	answer text comment '답안',
	score varchar(10) comment '점수',
	subdate datetime default now() comment '제출일'
);


CREATE TABLE task
(
	tno int PRIMARY KEY AUTO_INCREMENT comment '과제번호',
	lno int NOT NULL comment '강의번호',
	ttitle varchar(50) comment '제목',
	tnote text comment '내용',
	tend datetime comment '마감일',
	tdate date default (current_date) comment '과제등록일'
);


CREATE TABLE user
(
	userid varchar(50) PRIMARY KEY comment '아이디',
	userpw varchar(100) comment '비밀번호',
	name varchar(200) comment '이름',
	tel varchar(100) comment '전화번호',
	birthday date comment '생년월일',
	gender varchar(10) comment '성별',
	email varchar(50) Unique Key NOT NULL comment '이메일',
	state varchar(10) default 'Y' comment '탈퇴상태',
	level varchar(10) comment '권한',
	joindate date default (current_date) comment '가입일'
);



/* Create Foreign Keys */

ALTER TABLE file
	ADD FOREIGN KEY (lno)
	REFERENCES lecture (lno)
	ON UPDATE CASCADE
	ON DELETE CASCADE
;


ALTER TABLE learnlist
	ADD FOREIGN KEY (lno)
	REFERENCES lecture (lno)
	ON UPDATE CASCADE
	ON DELETE CASCADE
;


ALTER TABLE task
	ADD FOREIGN KEY (lno)
	REFERENCES lecture (lno)
	ON UPDATE CASCADE
	ON DELETE CASCADE
;


ALTER TABLE file
	ADD FOREIGN KEY (nno)
	REFERENCES notice (nno)
	ON UPDATE CASCADE
	ON DELETE CASCADE
;


ALTER TABLE file
	ADD FOREIGN KEY (sno)
	REFERENCES subtask (sno)
	ON UPDATE CASCADE
	ON DELETE CASCADE
;


ALTER TABLE qna
	ADD FOREIGN KEY (sno)
	REFERENCES subtask (sno)
	ON UPDATE CASCADE
	ON DELETE CASCADE
;


ALTER TABLE file
	ADD FOREIGN KEY (tno)
	REFERENCES task (tno)
	ON UPDATE CASCADE
	ON DELETE CASCADE
;


ALTER TABLE subtask
	ADD FOREIGN KEY (tno)
	REFERENCES task (tno)
	ON UPDATE CASCADE
	ON DELETE CASCADE
;


ALTER TABLE learnlist
	ADD FOREIGN KEY (userid)
	REFERENCES user (userid)
	ON UPDATE CASCADE
	ON DELETE CASCADE
;


ALTER TABLE lecture
	ADD FOREIGN KEY (userid)
	REFERENCES user (userid)
	ON UPDATE CASCADE
	ON DELETE CASCADE
;


ALTER TABLE notice
	ADD FOREIGN KEY (userid)
	REFERENCES user (userid)
	ON UPDATE CASCADE
	ON DELETE CASCADE
;


ALTER TABLE qna
	ADD FOREIGN KEY (userid)
	REFERENCES user (userid)
	ON UPDATE CASCADE
	ON DELETE CASCADE
;


ALTER TABLE subtask
	ADD FOREIGN KEY (userid)
	REFERENCES user (userid)
	ON UPDATE CASCADE
	ON DELETE CASCADE
;

ALTER TABLE subtask
ADD CONSTRAINT user_task_unique UNIQUE (userid, tno);

ALTER TABLE learnlist
ADD CONSTRAINT learnlist_unique UNIQUE (lno, userid);

insert into user(userid, userpw, name, tel, birthday, gender, email, level) values('ezen', md5('ezen1234'), 'B팀', '', '1999-09-09', 'M', '', 'M');

