-- 공지사항 테이블

-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE notice_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- 2. 공지사항 테이블 생성
CREATE TABLE notice (
    id NUMBER PRIMARY KEY,
    category VARCHAR2(10) NOT NULL CHECK (category IN ('공지', '이벤트')),
    title VARCHAR2(100) NOT NULL,
    content CLOB,
    created_at DATE DEFAULT SYSDATE,
    start_date DATE,
    end_date DATE,
    status VARCHAR2(10) NOT NULL CHECK (status IN ('active', 'deleted')),
    notice_image VARCHAR2(255),
    views NUMBER DEFAULT 0 CHECK (views >= 0)
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER notice_id_trigger
BEFORE INSERT ON notice
FOR EACH ROW
BEGIN
    :NEW.id := notice_seq.NEXTVAL;
END;
/