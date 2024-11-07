-- 유저라이크 테이블

-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE user_like_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- 2. 멤버 라이크 테이블 생성
CREATE TABLE member_like(
    id NUMBER PRIMARY KEY,
    store_id NUMBER NOT NULL,
    member_id NUMBER NOT NULL,
    created_at DATE DEFAULT SYSDATE,
    CONSTRAINT fk_store FOREIGN KEY (store_id) REFERENCES store(id),
    CONSTRAINT fk_user FOREIGN KEY (member_id) REFERENCES member(id)
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER user_like_id_trigger
BEFORE INSERT ON member_like
FOR EACH ROW
BEGIN
    :NEW.id := user_like_seq.NEXTVAL;
END;
/