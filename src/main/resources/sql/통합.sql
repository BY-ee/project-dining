-- ################## 멤버 테이블 ##################

-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE member_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- 2. 멤버 테이블 생성
CREATE TABLE member (
    id NUMBER PRIMARY KEY,
    category VARCHAR2(10) NOT NULL CHECK (category IN ('일반', '사업자')),
    registration_number VARCHAR2(20),
    member_id VARCHAR2(20) NOT NULL UNIQUE,
    naver_id VARCHAR2(50) UNIQUE,
    google_id VARCHAR2(50) UNIQUE,
    kakao_id VARCHAR2(50) UNIQUE,
    passwd VARCHAR2(100) NOT NULL,
    nickname VARCHAR2(50) NOT NULL UNIQUE,
    introduction VARCHAR2(1000),
    email VARCHAR2(50) NOT NULL UNIQUE,
    status VARCHAR2(10) DEFAULT 'active' NOT NULL CHECK (status IN ('active', 'deleted')),
    created_at DATE DEFAULT SYSDATE NOT NULL,
    inactive_date DATE,
    reactive_date DATE,
    deleted_date DATE,
    profile_image VARCHAR2(255),
    point NUMBER DEFAULT 0 CHECK (point >= 0)
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER member_id_trigger
BEFORE INSERT ON member
FOR EACH ROW
BEGIN
    :NEW.id := member_seq.NEXTVAL;
END;
/


-- ################## 가게 테이블 ##################

-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE store_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- 2. 가게 테이블 생성
CREATE TABLE store (
    id NUMBER PRIMARY KEY,
    member_id NUMBER,
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
    store_description VARCHAR2(1000),
    post_status VARCHAR2(10),
    enroll_status VARCHAR2(10),
    CONSTRAINT fk_store_member_id FOREIGN KEY (member_id) REFERENCES member(id)
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER store_id_trigger
BEFORE INSERT ON store
FOR EACH ROW
BEGIN
    :NEW.id := store_seq.NEXTVAL;
END;
/

--  ################## 지역 테이블 #######################

-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE local_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- 2. 지역 테이블 생성
CREATE TABLE local (
    id NUMBER PRIMARY KEY,
    store_id NUMBER NOT NULL,
    local VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_local_store_id FOREIGN KEY (store_id) REFERENCES store(id)
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER local_id_trigger
BEFORE INSERT ON local
FOR EACH ROW
BEGIN
    :NEW.id := local_seq.NEXTVAL;
END;
/

-- ################## 업종 테이블  ##################

-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE industry_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- 2. 업종 테이블 생성
CREATE TABLE industry (
    id NUMBER PRIMARY KEY,
    store_id NUMBER NOT NULL,
    industry VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_industry_store_id FOREIGN KEY (store_id) REFERENCES store(id),
    CONSTRAINT unique_industry_store UNIQUE (store_id, industry) -- 업종 중복 체크
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER industry_id_trigger
BEFORE INSERT ON industry
FOR EACH ROW
BEGIN
    :NEW.id := industry_seq.NEXTVAL;
END;
/

--  ################## 테마 테이블  ##################

-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE theme_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- 2. 테마 테이블 생성
CREATE TABLE theme (
    id NUMBER PRIMARY KEY,
    store_id NUMBER NOT NULL,
    theme VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_theme_store_id FOREIGN KEY (store_id) REFERENCES store(id)
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER theme_id_trigger
BEFORE INSERT ON theme
FOR EACH ROW
BEGIN
    :NEW.id := theme_seq.NEXTVAL;
END;
/

-- ################## 멤버라이크 테이블 ##################

-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE member_like_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- 2. 멤버 라이크 테이블 생성
CREATE TABLE member_like(
    id NUMBER PRIMARY KEY,
    store_id NUMBER NOT NULL,
    member_id NUMBER NOT NULL,
    created_at DATE DEFAULT SYSDATE,
   	CONSTRAINT fk_member_like_store_id FOREIGN KEY (store_id) REFERENCES store(id),
    CONSTRAINT fk_member_like_member_id FOREIGN KEY (member_id) REFERENCES member(id)
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER member_like_id_trigger
BEFORE INSERT ON member_like
FOR EACH ROW
BEGIN
    :NEW.id := member_like_seq.NEXTVAL;
END;
/

-- ################## 공지사항 테이블 ################## 

-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE notice_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- 2. 공지사항 테이블 생성
CREATE TABLE notice (
    id NUMBER PRIMARY KEY,
    category VARCHAR2(10) NOT NULL CHECK (category IN ('공지', '이벤트')),
    title VARCHAR2(100) NOT NULL,
    content CLOB,
    created_at DATE DEFAULT SYSDATE,
    start_date DATE,
    end_date DATE,
    status VARCHAR2(10) NOT NULL CHECK (status IN ('active', 'deleted')),
    notice_image VARCHAR2(255),
    views NUMBER DEFAULT 0 CHECK (views >= 0)
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER notice_id_trigger
BEFORE INSERT ON notice
FOR EACH ROW
BEGIN
    :NEW.id := notice_seq.NEXTVAL;
END;
/

-- ################## 리뷰 테이블 ##################

-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE review_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- 2. 리뷰 테이블 생성
CREATE TABLE review (
    id NUMBER PRIMARY KEY,
    member_id NUMBER NOT NULL,
    store_id NUMBER NOT NULL,
    score NUMBER(2, 1),
    content VARCHAR(1000),
    created_at DATE DEFAULT SYSDATE,
    CONSTRAINT fk_review_member_id FOREIGN KEY (member_id) REFERENCES member(id),
    CONSTRAINT fk_review_store_id FOREIGN KEY (store_id) REFERENCES store(id),
    CONSTRAINT unique_member_store UNIQUE (member_id, store_id) -- user_id와 store_id의 조합이 유일하도록 설정
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER review_id_trigger
BEFORE INSERT ON review
FOR EACH ROW
BEGIN
    :NEW.id := review_seq.NEXTVAL;
END;
/

-- ################## 메뉴 테이블 ##################

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
    CONSTRAINT fk_menu_store_id FOREIGN KEY (store_id) REFERENCES store(id)
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER menu_id_trigger
BEFORE INSERT ON menu
FOR EACH ROW
BEGIN
    :NEW.id := menu_seq.NEXTVAL;
END;
/

-- ################## 식당 테이블 ##################

-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE restaurant_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;


-- 2. 식당 테이블 생성
CREATE TABLE restaurant (
    id NUMBER PRIMARY KEY,
    industry_id NUMBER NOT NULL,
    store_id NUMBER NOT NULL,
    restaurant VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_restaurant_industry_id FOREIGN KEY (industry_id) REFERENCES industry(id),
    CONSTRAINT fk_restaurant_store_id FOREIGN KEY (store_id) REFERENCES store(id)
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER restaurant_id_trigger
BEFORE INSERT ON restaurant
FOR EACH ROW
BEGIN
    :NEW.id := restaurant_seq.NEXTVAL;
END;
/

-- ################## 카페 테이블 ##################

-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE cafe_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;


-- 2. 카페 테이블 생성
CREATE TABLE cafe (
    id NUMBER PRIMARY KEY,
    industry_id NUMBER NOT NULL,
    store_id NUMBER NOT NULL,
    cafe VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_cafe_industry_id FOREIGN KEY (industry_id) REFERENCES industry(id),
    CONSTRAINT fk_cafe_store_id FOREIGN KEY (store_id) REFERENCES store(id)
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER cafe_id_trigger
BEFORE INSERT ON cafe
FOR EACH ROW
BEGIN
    :NEW.id := cafe_seq.NEXTVAL;
END;
/


-- ################## 술집 테이블 ##################

-- 1. 시퀀스 생성 (id 자동 증가를 위한 시퀀스)
CREATE SEQUENCE bar_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;


-- 2. 술집 테이블 생성
CREATE TABLE bar (
    id NUMBER PRIMARY KEY,
    industry_id NUMBER NOT NULL,
    store_id NUMBER NOT NULL,
    bar VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_bar_industry_id FOREIGN KEY (industry_id) REFERENCES industry(id),
    CONSTRAINT fk_bar_store_id FOREIGN KEY (store_id) REFERENCES store(id)
);

-- 3. id 자동 증가 트리거 생성
CREATE TRIGGER bar_id_trigger
BEFORE INSERT ON bar
FOR EACH ROW
BEGIN
    :NEW.id := bar_seq.NEXTVAL;
END;
/