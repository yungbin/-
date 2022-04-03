-- ȸ������ ��Ű��. - member, grade
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
gender VARCHAR2(6) NOT NULL CHECK (gender in('����', '����')),
birth DATE NOT NULL,
tel VARCHAR2(13),
email VARCHAR2(50) NOT NULL,
regDate DATE DEFAULT SYSDATE,
conDate DATE DEFAULT SYSDATE,
status VARCHAR2(6) DEFAULT '����' CHECK (status in ('����','����','Ż��','�޸�')) ,
photo VARCHAR2(100) DEFAULT '/upload/member/noImage.jpg',
-- 1: �Ϲ�ȸ��, 9: ������
gradeNo NUMBER(2) DEFAULT 1 REFERENCES grade(gradeNo)
);

INSERT INTO grade VALUES(1, '�Ϲ�ȸ��');
INSERT INTO grade VALUES(9, '������');
-- ������ ���� - ��޹�ȣ�� 9�� �ݵ�� ����� �Ѵ�.
INSERT INTO member(id, pw, nickname, name, gender, birth, tel, email, photo, gradeNo)
VALUES('admin', '1111', '[admin]������', '�ӿ���', '����', '1995-04-06', '010-1111-2222', 'admin@nate.com','/upload/member/admin.jpg', 9);
-- �Ϲ�ȸ�� ���� - ��޹�ȣ�� �⺻���� 1�� �ȴ�.
INSERT INTO member(id, pw, nickname, name, gender, birth, tel, email, photo)
VALUES('test', '1111', '������Ż', 'ȫ�浿', '����', '1994-01-01', '010-3333-4444', 'test@naver.com','/upload/member/test.jpg');

INSERT INTO member(id, pw, nickname, name, gender, birth, tel, email, photo)
VALUES('test1', '1111', '�����츮', '�̿츮', '����', '1993-01-01', '010-0000-0000', 'test1@naver.com', '/upload/member/noImage.jpg');

DROP TABLE song CASCADE CONSTRAINTS;
DROP SEQUENCE song_seq;

-- ���� �Խ��� ���̺�
-- code : ���� ���� �ڵ� , songName : ������ , songImage : �����̹��� , song : ����
-- artist : ��Ƽ��Ʈ , genre : �帣 , content : ����
-- writeDate : �ۼ��� , recom : ��õ�� , hit : ��ȸ��
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
VALUES(song_seq.NEXTVAL, 'test1', 'Spring Sound', '/upload/image/yellowBird.jpg', '/upload/song/spring sound.mp3', '�����츮', 'chill', '���� �Ҹ��� ������!');

-- ���� �Խ��� ���̺�
-- no : �۹�ȣ , title : ������ , theme : ������ , content : ����
-- writer : �ۼ��� , writeDate : �ۼ��� , hit : ��ȸ��

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
VALUES(board_seq.NEXTVAL, 'ȫ�� �Դϴ�.', 'pr', '�׽�Ʈ �Դϴ��Դϴ�.', '������Ż', 'test');

COMMIT;