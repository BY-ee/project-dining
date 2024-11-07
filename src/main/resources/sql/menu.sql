-- 메뉴 테이블

-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE menu_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- 2. 메뉴 테이블 생성
CREATE TABLE menu (
    id NUMBER PRIMARY KEY,
    store_id NUMBER NOT NULL,
    menu_image VARCHAR2(255),
    menu_description CLOB,
    menu_name VARCHAR2(50) NOT NULL,
    menu_price NUMBER,
    CONSTRAINT fk_store FOREIGN KEY (store_id) REFERENCES store(id)
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER menu_id_trigger
BEFORE INSERT ON menu
FOR EACH ROW
BEGIN
    :NEW.id := menu_seq.NEXTVAL;
END;
/