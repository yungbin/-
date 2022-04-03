-- 회원관리 스키마. - member, grade
DROP TABLE member CASCADE CONSTRAINTS;
DROP TABLE grade CASCADE CONSTRAINTS;

CREATE TABLE grade(
gradeNo NUMBER(2) PRIMARY KEY,
gradeName VARCHAR2(20)
);
CREATE TABLE member(
id VARCHAR2(20) PRIMARY KEY,
pw VARCHAR2(20) NOT NULL,
nickname VARCHAR2(30) NOT NULL,
name VARCHAR2(30) NOT NULL,
gender VARCHAR2(6) NOT NULL CHECK (gender in('남자', '여자')),
birth DATE NOT NULL,
tel VARCHAR2(13),
email VARCHAR2(50) NOT NULL,
regDate DATE DEFAULT SYSDATE,
conDate DATE DEFAULT SYSDATE,
status VARCHAR2(6) DEFAULT '정상' CHECK (status in ('정상','강퇴','탈퇴','휴면')) ,
photo VARCHAR2(100) DEFAULT '/upload/member/noImage.jpg',
-- 1: 일반회원, 9: 관리자
gradeNo NUMBER(2) DEFAULT 1 REFERENCES grade(gradeNo)
);

INSERT INTO grade VALUES(1, '일반회원');
INSERT INTO grade VALUES(9, '관리자');
-- 관리자 계정 - 등급번호을 9로 반드시 해줘야 한다.
INSERT INTO member(id, pw, nickname, name, gender, birth, tel, email, photo, gradeNo)
VALUES('admin', '1111', '[admin]관리자', '임영빈', '남자', '1995-04-06', '010-1111-2222', 'admin@nate.com','/upload/member/admin.jpg', 9);
-- 일반회원 계정 - 등급번호는 기본으로 1이 된다.
INSERT INTO member(id, pw, nickname, name, gender, birth, tel, email, photo)
VALUES('test', '1111', '엘레멘탈', '홍길동', '남자', '1994-01-01', '010-3333-4444', 'test@naver.com','/upload/member/test.jpg');

INSERT INTO member(id, pw, nickname, name, gender, birth, tel, email, photo)
VALUES('test1', '1111', '맑은우리', '이우리', '여자', '1993-01-01', '010-0000-0000', 'test1@naver.com', '/upload/member/noImage.jpg');

DROP TABLE song CASCADE CONSTRAINTS;
DROP SEQUENCE song_seq;

-- 음원 게시판 테이블
-- code : 음원 고유 코드 , songName : 음원명 , songImage : 음원이미지 , song : 음원
-- artist : 아티스트 , genre : 장르 , content : 내용
-- writeDate : 작성일 , recom : 추천수 , hit : 조회수
CREATE TABLE song
(
	code NUMBER PRIMARY KEY,
    id VARCHAR2(20) NOT NULL,
	songName VARCHAR2(60) NOT NULL,
	songImage VARCHAR2(60) NOT NULL,
    song VARCHAR2(60) NOT NULL,
	nickname VARCHAR2(30) NOT NULL,
	genre VARCHAR2(30) NOT NULL,
	content VARCHAR2(3000) NOT NULL,
	writeDate DATE DEFAULT SYSDATE,
	recom NUMBER DEFAULT 0,
	hit NUMBER DEFAULT 0
);
CREATE SEQUENCE song_seq;

INSERT INTO song(code, id, songName, songImage, song, nickname, genre, content)
VALUES(song_seq.NEXTVAL, 'test1', 'Spring Sound', '/upload/image/yellowBird.jpg', '/upload/song/spring sound.mp3', '맑은우리', 'chill', '봄의 소리를 들어보세요!');

-- 자유 게시판 테이블
-- no : 글번호 , title : 글제목 , theme : 글주제 , content : 내용
-- writer : 작성자 , writeDate : 작성일 , hit : 조회수

DROP TABLE board CASCADE CONSTRAINTS;
DROP SEQUENCE board_seq;

CREATE TABLE board
(
no NUMBER PRIMARY KEY,
title VARCHAR2(60) NOT NULL,
theme VARCHAR2(30) NOT NULL, 
content VARCHAR2(3000) NOT NULL,
nickname VARCHAR2(30) NOT NULL,
id VARCHAR2(20) NOT NULL,
writeDate DATE DEFAULT SYSDATE,
hit NUMBER DEFAULT 0
);
CREATE SEQUENCE board_seq;

INSERT INTO board(no, title, theme, content, nickname, id)
VALUES(board_seq.NEXTVAL, '홍보 입니다.', 'pr', '테스트 입니다입니다.', '엘레멘탈', 'test');

COMMIT;