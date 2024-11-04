-- 유저라이크 테이블

-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE user_like_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- 2. 유저 라이크 테이블 생성
CREATE TABLE 유저_라이크 (
    id NUMBER PRIMARY KEY,
    store_ID NUMBER NOT NULL,
    user_ID NUMBER NOT NULL,
    like NUMBER(1) DEFAULT 0 CHECK (like IN (0, 1)),
    CONSTRAINT fk_store FOREIGN KEY (store_ID) REFERENCES 가게 상세페이지(id),
    CONSTRAINT fk_user FOREIGN KEY (user_ID) REFERENCES 유저(id)
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER user_like_id_trigger
BEFORE INSERT ON 유저_라이크
FOR EACH ROW
BEGIN
    :NEW.id := user_like_seq.NEXTVAL;
END;
/