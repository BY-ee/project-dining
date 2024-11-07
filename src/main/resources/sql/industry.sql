-- 카테고리 (업종) 테이블

-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE category_food_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- 2. 업종 테이블 생성
CREATE TABLE industry (
    id NUMBER PRIMARY KEY,
    store_id NUMBER NOT NULL,
    food VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_store_food FOREIGN KEY (store_id) REFERENCES store(id),
    CONSTRAINT unique_food_store UNIQUE (store_id, food) -- 업종 중복 체크
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER category_food_id_trigger
BEFORE INSERT ON industry
FOR EACH ROW
BEGIN
    :NEW.id := category_food_seq.NEXTVAL;
END;
/