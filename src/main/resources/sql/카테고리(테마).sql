-- 카테고리 (테마) 테이블
CREATE SEQUENCE category_theme_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE TABLE 카테고리_테마 (
    id NUMBER PRIMARY KEY,
    store_ID NUMBER NOT NULL,
    theme VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_store_theme FOREIGN KEY (store_ID) REFERENCES 가게 상세페이지(id)
);

CREATE TRIGGER category_theme_id_trigger
BEFORE INSERT ON 카테고리_테마
FOR EACH ROW
BEGIN
    :NEW.id := category_theme_seq.NEXTVAL;
END;
/