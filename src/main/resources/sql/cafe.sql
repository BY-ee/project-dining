-- 카페 테이블

-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE cafe_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;


-- 2. 카페 테이블 생성
CREATE TABLE cafe (
    id NUMBER PRIMARY KEY,
    industry_id NUMBER NOT NULL,
    store_id NUMBER NOT NULL,
    cafe VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_industry_cafe FOREIGN KEY (industry_id) REFERENCES industry(id),
    CONSTRAINT fk_store_cafe FOREIGN KEY (store_id) REFERENCES store(id)
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER cafe_id_trigger
BEFORE INSERT ON cafe
FOR EACH ROW
BEGIN
    :NEW.id := cafe_seq.NEXTVAL;
END;
/