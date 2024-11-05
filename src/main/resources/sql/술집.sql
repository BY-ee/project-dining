-- 술집 테이블

CREATE SEQUENCE bar_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE TABLE 술집 (
    id NUMBER PRIMARY KEY,
    Industry_ID NUMBER NOT NULL,
    store_ID NUMBER NOT NULL,
    bar_category VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_industry_bar FOREIGN KEY (Industry_ID) REFERENCES 카테고리_업종(id),
    CONSTRAINT fk_store_bar FOREIGN KEY (store_ID) REFERENCES 가게(id)
);

CREATE TRIGGER bar_id_trigger
BEFORE INSERT ON 술집
FOR EACH ROW
BEGIN
    :NEW.id := bar_seq.NEXTVAL;
END;
/