-- 카테고리 (업종) 테이블

CREATE SEQUENCE category_local_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE TABLE 카테고리_지역 (
    id NUMBER PRIMARY KEY,
    store_ID NUMBER NOT NULL,
    local VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_store_local FOREIGN KEY (store_ID) REFERENCES 가게 상세페이지(id)
);

CREATE TRIGGER category_local_id_trigger
BEFORE INSERT ON 카테고리_지역
FOR EACH ROW
BEGIN
    :NEW.id := category_local_seq.NEXTVAL;
END;
/