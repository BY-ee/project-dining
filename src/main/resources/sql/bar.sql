-- 술집 테이블

-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE bar_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;


-- 2. 술집 테이블 생성
CREATE TABLE bar (
    id NUMBER PRIMARY KEY,
    industry_id NUMBER NOT NULL,
    store_id NUMBER NOT NULL,
    bar VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_industry_bar FOREIGN KEY (industry_id) REFERENCES industry(id),
    CONSTRAINT fk_store_bar FOREIGN KEY (store_id) REFERENCES store(id)
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER bar_id_trigger
BEFORE INSERT ON bar
FOR EACH ROW
BEGIN
    :NEW.id := bar_seq.NEXTVAL;
END;
/