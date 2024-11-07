-- 카테고리 (테마) 테이블

-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE category_theme_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- 2. 테마 테이블 생성
CREATE TABLE theme (
    id NUMBER PRIMARY KEY,
    store_id NUMBER NOT NULL,
    theme VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_store_theme FOREIGN KEY (store_id) REFERENCES store(id)
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER category_theme_id_trigger
BEFORE INSERT ON theme
FOR EACH ROW
BEGIN
    :NEW.id := category_theme_seq.NEXTVAL;
END;
/