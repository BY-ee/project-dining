-- 유저 테이블

-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE user_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- 2. 멤버 테이블 생성
CREATE TABLE member (
    id NUMBER PRIMARY KEY,
    category VARCHAR2(10) NOT NULL CHECK (category IN ('일반', '사업자')),
    registration_number VARCHAR2(20),
    member_id VARCHAR2(20) NOT NULL UNIQUE,
    naver_id VARCHAR2(50) UNIQUE,
    google_id VARCHAR2(50) UNIQUE,
    kakao_id VARCHAR2(50) UNIQUE,
    passwd VARCHAR2(50) NOT NULL,
    nickname VARCHAR2(50) NOT NULL UNIQUE,
    introduction CLOB,
    email VARCHAR2(50) NOT NULL UNIQUE,
    status VARCHAR2(10) NOT NULL CHECK (status IN ('active', 'deleted')),
    join_date DATE DEFAULT SYSDATE NOT NULL,
    off_date DATE,
    reactive_date DATE,
    leave_date DATE,
    profile_image VARCHAR2(255),
    point NUMBER DEFAULT 0 CHECK (point >= 0)
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER user_id_trigger
BEFORE INSERT ON member
FOR EACH ROW
BEGIN
    :NEW.id := user_seq.NEXTVAL;
END;
/