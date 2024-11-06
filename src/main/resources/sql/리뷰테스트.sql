-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE store_detail_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- 2. 가게 상세페이지 테이블 생성
CREATE TABLE store_detail (
    id NUMBER PRIMARY KEY,
    store_name VARCHAR2(100) NOT NULL,
    address VARCHAR2(255) NOT NULL,
    detail_address VARCHAR2(255),
    phone_number VARCHAR2(20),
    owner_phone_number VARCHAR2(20),
    main_image_1 VARCHAR2(255),
    main_image_2 VARCHAR2(255),
    latitude DECIMAL(11, 8),
    longitude DECIMAL(11, 8),
    views NUMBER DEFAULT 0 CHECK (views >= 0),
    open_time VARCHAR2(50),
    store_description CLOB
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER store_detail_id_trigger
BEFORE INSERT ON store_detail
FOR EACH ROW
BEGIN
    :NEW.id := store_detail_seq.NEXTVAL;
END;
/

-- 리뷰
-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE review_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- 2. 리뷰 테이블 생성
CREATE TABLE REVIEW (
    id NUMBER PRIMARY KEY,
    user_ID NUMBER NOT NULL,
    store_ID NUMBER NOT NULL,
    score DECIMAL(2, 1),
    review CLOB,
    CONSTRAINT fk_user FOREIGN KEY (user_ID) REFERENCES 유저(id),
    CONSTRAINT fk_store FOREIGN KEY (store_ID) REFERENCES store_detail(id),
    CONSTRAINT unique_user_store UNIQUE (user_ID, store_ID) -- user_ID와 store_ID의 조합이 유일하도록 설정
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER review_id_trigger
BEFORE INSERT ON review
FOR EACH ROW
BEGIN
    :NEW.id := review_seq.NEXTVAL;
END;
/


-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE user_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- 2. 유저 테이블 생성
CREATE TABLE 유저 (
    id NUMBER PRIMARY KEY,
    category VARCHAR2(10) NOT NULL CHECK (category IN ('일반', '사업자')),
    registration_number VARCHAR2(20),
    userid VARCHAR2(20) NOT NULL UNIQUE,
    naver_id VARCHAR2(50) UNIQUE,
    google_id VARCHAR2(50) UNIQUE,
    kakao_id VARCHAR2(50) UNIQUE,
    userpwd VARCHAR2(50) NOT NULL,
    nickname VARCHAR2(50) NOT NULL UNIQUE,
    introduction CLOB,
    email VARCHAR2(50) NOT NULL UNIQUE,
    status VARCHAR2(10) NOT NULL CHECK (status IN ('active', 'deleted')),
    join_date DATE NOT NULL,
    leave_date DATE,
    profile_image VARCHAR2(255),
    point NUMBER DEFAULT 0 CHECK (point >= 0)
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER user_id_trigger
BEFORE INSERT ON 유저
FOR EACH ROW
BEGIN
    :NEW.id := user_seq.NEXTVAL;
END;
/




INSERT INTO 유저 (id, category, userid, userpwd, nickname, email, join_date, status)
VALUES (user_seq.NEXTVAL, '일반', 'testuser', 'password123', 'nickname', 'testuser@example.com', SYSDATE, 'active');


-- 이미지를 서버의 /images/ 폴더에 저장했다고 가정하고, 이미지 경로를 데이터베이스에 저장
INSERT INTO store_detail (
    id, 
    store_name, 
    address, 
    detail_address, 
    phone_number, 
    owner_phone_number, 
    main_image_1, 
    main_image_2, 
    latitude, 
    longitude, 
    views, 
    open_time, 
    store_description
) VALUES (
    store_detail_seq.NEXTVAL,    
    '테스트 가게',               
    '서울특별시 강남구 테헤란로 123', 
    '2층 202호',                 
    '010-1234-5678',             
    '010-8765-4321',             
    '/img/store1.jpg',    -- 서버에 저장된 이미지의 경로
    '/img/store2.jpg',    
    37.5665,                     
    126.9780,                    
    0,                           
    '09:00 ~ 18:00',             
    '이곳은 테스트 가게입니다.'     
);

-- 가게 ID를 먼저 조회
SELECT id 
FROM store_detail 
WHERE store_name = '테스트 가게';


-- 리뷰 테이블에 데이터 삽입
INSERT INTO REVIEW (id, user_ID, store_ID, score, review, created_at) 
VALUES (review_seq.NEXTVAL, (SELECT id FROM 유저 WHERE userid = 'testuser'), 2, 5, '리뷰테스트', TO_DATE('2024-11-05', 'YYYY-MM-DD'));


SELECT user_id, store_id, score, review, created_at
        FROM REVIEW
        ORDER BY created_at DESC
