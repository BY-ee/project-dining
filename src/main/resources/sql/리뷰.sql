-- 리뷰 테이블

-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE review_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- 2. 리뷰 테이블 생성
CREATE TABLE 리뷰 (
    id NUMBER PRIMARY KEY,
    user_ID NUMBER NOT NULL,
    store_ID NUMBER NOT NULL,
    score DECIMAL(2, 1),
    review CLOB,
    created_at DATE DEFAULT SYSDATE,
    CONSTRAINT fk_user FOREIGN KEY (user_ID) REFERENCES 유저(id),
    CONSTRAINT fk_store FOREIGN KEY (store_ID) REFERENCES 가게 상세페이지(id),
    CONSTRAINT unique_user_store UNIQUE (user_ID, store_ID) -- user_ID와 store_ID의 조합이 유일하도록 설정
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER review_id_trigger
BEFORE INSERT ON 리뷰
FOR EACH ROW
BEGIN
    :NEW.id := review_seq.NEXTVAL;
END;
/