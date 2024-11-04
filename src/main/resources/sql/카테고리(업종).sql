-- 카테고리 (업종) 테이블

CREATE SEQUENCE category_food_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE TABLE 카테고리_업종 (
    id NUMBER PRIMARY KEY,
    store_ID NUMBER NOT NULL,
    food VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_store_food FOREIGN KEY (store_ID) REFERENCES 가게 상세페이지(id),
    CONSTRAINT unique_food_store UNIQUE (store_ID, food) -- 업종 중복 체크
);

CREATE TRIGGER category_food_id_trigger
BEFORE INSERT ON 카테고리_업종
FOR EACH ROW
BEGIN
    :NEW.id := category_food_seq.NEXTVAL;
END;
/