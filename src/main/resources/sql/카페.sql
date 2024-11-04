-- 카페 테이블
CREATE SEQUENCE cafe_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE TABLE 카페 (
    id NUMBER PRIMARY KEY,
    Industry_ID NUMBER NOT NULL,
    store_ID NUMBER NOT NULL,
    cafe_category VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_industry_cafe FOREIGN KEY (Industry_ID) REFERENCES 카테고리_업종(id),
    CONSTRAINT fk_store_cafe FOREIGN KEY (store_ID) REFERENCES 가게 상세 페이지(id)
);

CREATE TRIGGER cafe_id_trigger
BEFORE INSERT ON 카페
FOR EACH ROW
BEGIN
    :NEW.id := cafe_seq.NEXTVAL;
END;
/