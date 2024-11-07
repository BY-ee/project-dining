-- 리뷰 테이블

-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE review_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- 2. 리뷰 테이블 생성
CREATE TABLE review (
    id NUMBER PRIMARY KEY,
    member_id NUMBER NOT NULL,
    store_id NUMBER NOT NULL,
    score NUMBER(2, 1),
    content CLOB,
    created_at DATE DEFAULT SYSDATE,
    CONSTRAINT fk_user FOREIGN KEY (member_id) REFERENCES member(id),
    CONSTRAINT fk_store FOREIGN KEY (store_id) REFERENCES store(id),
    CONSTRAINT unique_user_store UNIQUE (member_id, store_id) -- user_id와 store_id의 조합이 유일하도록 설정
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER review_id_trigger
BEFORE INSERT ON review
FOR EACH ROW
BEGIN
    :NEW.id := review_seq.NEXTVAL;
END;
/