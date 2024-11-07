-- 지역 테이블

-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE category_local_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- 2. 지역 테이블 생성
CREATE TABLE local (
    id NUMBER PRIMARY KEY,
    store_id NUMBER NOT NULL,
    local VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_store_local FOREIGN KEY (store_id) REFERENCES store(id)
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER category_local_id_trigger
BEFORE INSERT ON local
FOR EACH ROW
BEGIN
    :NEW.id := category_local_seq.NEXTVAL;
END;
/