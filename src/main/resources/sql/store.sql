-- 가게 상세페이지 테이블

-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE store_detail_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- 2. 가게 상세페이지 테이블 생성
CREATE TABLE store (
    id NUMBER PRIMARY KEY,
    store_name VARCHAR2(100) NOT NULL,
    address VARCHAR2(255) NOT NULL,
    detail_address VARCHAR2(255),
    tel VARCHAR2(20),
    phone_number VARCHAR2(20),
    main_image1 VARCHAR2(255),
    main_image2 VARCHAR2(255),
    latitude NUMBER(11, 8),
    longitude NUMBER(11, 8),
    views NUMBER DEFAULT 0 CHECK (views >= 0),
    open_time VARCHAR2(50),
    store_description CLOB,
    status VARCHAR2(10) NOT NULL CHECK (status IN ('active', 'deleted'))
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER store_detail_id_trigger
BEFORE INSERT ON store
FOR EACH ROW
BEGIN
    :NEW.id := store_detail_seq.NEXTVAL;
END;
/