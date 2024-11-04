-- 메뉴 테이블

-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE menu_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- 2. 메뉴 테이블 생성
CREATE TABLE 메뉴 (
    id NUMBER PRIMARY KEY,
    store_ID NUMBER NOT NULL,
    menu_image1 VARCHAR2(255),
    menu_image2 VARCHAR2(255),
    menu_image3 VARCHAR2(255),
    menu_image4 VARCHAR2(255),
    menu_description CLOB,
    menuname VARCHAR2(50) NOT NULL,
    menuprice NUMBER,
    CONSTRAINT fk_store FOREIGN KEY (store_ID) REFERENCES 가게(id)
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER menu_id_trigger
BEFORE INSERT ON 메뉴
FOR EACH ROW
BEGIN
    :NEW.id := menu_seq.NEXTVAL;
END;
/