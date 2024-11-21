-- 유저 테이블

SELECT * FROM member;

CREATE TABLE member (
    id NUMBER PRIMARY KEY,
    category VARCHAR2(10) NOT NULL CHECK (category IN ('일반', '사업자')),
    registration_number VARCHAR2(20),
    userid VARCHAR2(20) NOT NULL,
    naver_id VARCHAR2(50),
    google_id VARCHAR2(50),
    kakao_id VARCHAR2(50),
    userpwd VARCHAR2(50) NOT NULL,
    nickname VARCHAR2(50) NOT NULL,
    introduction CLOB,
    email VARCHAR2(50) NOT NULL,
    status VARCHAR2(10) NOT NULL CHECK (status IN ('active', 'inactive')),
    join_date DATE NOT NULL,
    leave_date DATE,
    profile_image VARCHAR2(255),
    point NUMBER DEFAULT 0 CHECK (point >= 0)
);

INSERT INTO member (
    id, category, registration_number, userid, naver_id, google_id, kakao_id, 
    userpwd, nickname, introduction, email, status, join_date, leave_date, 
    profile_image, point
) VALUES (
    1, '일반', '123-45-6789', 'user001', 'naver123', 'google123', 'kakao123', 
    'password1', 'nickname1', '안녕하세요! 저는 일반 회원입니다.', 'user001@example.com', 
    'active', TO_DATE('2023-01-01', 'YYYY-MM-DD'), NULL, 
    'http://example.com/profile1.jpg', 100
);

INSERT INTO member (
    id, category, registration_number, userid, naver_id, google_id, kakao_id, 
    userpwd, nickname, introduction, email, status, join_date, leave_date, 
    profile_image, point
) VALUES (
    2, '사업자', '987-65-4321', 'user002', 'naver456', 'google456', 'kakao456', 
    'password2', 'nickname2', '안녕하세요! 저는 사업자 회원입니다.', 'user002@example.com', 
    'active', TO_DATE('2023-02-01', 'YYYY-MM-DD'), NULL, 
    'http://example.com/profile2.jpg', 200
);

INSERT INTO member (
    id, category, registration_number, userid, naver_id, google_id, kakao_id, 
    userpwd, nickname, introduction, email, status, join_date, leave_date, 
    profile_image, point
) VALUES (
    3, '일반', '111-22-3333', 'user003', 'naver789', 'google789', 'kakao789', 
    'password3', 'nickname3', '안녕하세요! 저는 일반 회원입니다.', 'user003@example.com', 
    'active', TO_DATE('2023-03-01', 'YYYY-MM-DD'), NULL, 
    'http://example.com/profile3.jpg', 150
);

INSERT INTO member (
    id, category, registration_number, userid, naver_id, google_id, kakao_id, 
    userpwd, nickname, introduction, email, status, join_date, leave_date, 
    profile_image, point
) VALUES (
    4, '사업자', '222-33-4444', 'user004', 'naver101', 'google101', 'kakao101', 
    'password4', 'nickname4', '안녕하세요! 저는 사업자 회원입니다.', 'user004@example.com', 
    'active', TO_DATE('2023-04-01', 'YYYY-MM-DD'), NULL, 
    'http://example.com/profile4.jpg', 250
);

INSERT INTO member (
    id, category, registration_number, userid, naver_id, google_id, kakao_id, 
    userpwd, nickname, introduction, email, status, join_date, leave_date, 
    profile_image, point
) VALUES (
    5, '일반', '333-44-5555', 'user005', 'naver202', 'google202', 'kakao202', 
    'password5', 'nickname5', '안녕하세요! 저는 일반 회원입니다.', 'user005@example.com', 
    'inactive', TO_DATE('2023-05-01', 'YYYY-MM-DD'), NULL, 
    'http://example.com/profile5.jpg', 120
);

INSERT INTO member (
    id, category, registration_number, userid, naver_id, google_id, kakao_id, 
    userpwd, nickname, introduction, email, status, join_date, leave_date, 
    profile_image, point
) VALUES (
    6, '사업자', '444-55-6666', 'user006', 'naver303', 'google303', 'kakao303', 
    'password6', 'nickname6', '안녕하세요! 저는 사업자 회원입니다.', 'user006@example.com', 
    'active', TO_DATE('2023-06-01', 'YYYY-MM-DD'), NULL, 
    'http://example.com/profile6.jpg', 300
);

INSERT INTO member (
    id, category, registration_number, userid, naver_id, google_id, kakao_id, 
    userpwd, nickname, introduction, email, status, join_date, leave_date, 
    profile_image, point
) VALUES (
    7, '일반', '555-66-7777', 'user007', 'naver404', 'google404', 'kakao404', 
    'password7', 'nickname7', '안녕하세요! 저는 일반 회원입니다.', 'user007@example.com', 
    'inactive', TO_DATE('2023-07-01', 'YYYY-MM-DD'), NULL, 
    'http://example.com/profile7.jpg', 180
);

INSERT INTO member (
    id, category, registration_number, userid, naver_id, google_id, kakao_id, 
    userpwd, nickname, introduction, email, status, join_date, leave_date, 
    profile_image, point
) VALUES (
    8, '일반', '666-77-8888', 'user008', 'naver505', 'google505', 'kakao505', 
    'password8', 'nickname8', '안녕하세요! 저는 일반 회원입니다.', 'user008@example.com', 
    'active', TO_DATE('2023-08-01', 'YYYY-MM-DD'), NULL, 
    'http://example.com/profile8.jpg', 160
);

INSERT INTO member (
    id, category, registration_number, userid, naver_id, google_id, kakao_id, 
    userpwd, nickname, introduction, email, status, join_date, leave_date, 
    profile_image, point
) VALUES (
    9, '사업자', '777-88-9999', 'user009', 'naver606', 'google606', 'kakao606', 
    'password9', 'nickname9', '안녕하세요! 저는 사업자 회원입니다.', 'user009@example.com', 
    'active', TO_DATE('2023-09-01', 'YYYY-MM-DD'), NULL, 
    'http://example.com/profile9.jpg', 280
);

INSERT INTO member (
    id, category, registration_number, userid, naver_id, google_id, kakao_id, 
    userpwd, nickname, introduction, email, status, join_date, leave_date, 
    profile_image, point
) VALUES (
    10, '일반', '888-99-1111', 'user010', 'naver707', 'google707', 'kakao707', 
    'password10', 'nickname10', '안녕하세요! 저는 일반 회원입니다.', 'user010@example.com', 
    'inactive', TO_DATE('2023-10-01', 'YYYY-MM-DD'), NULL, 
    'http://example.com/profile10.jpg', 90
);

INSERT INTO member (
    id, category, registration_number, userid, naver_id, google_id, kakao_id, 
    userpwd, nickname, introduction, email, status, join_date, leave_date, 
    profile_image, point
) VALUES (
    11, '사업자', '999-11-2222', 'user011', 'naver808', 'google808', 'kakao808', 
    'password11', 'nickname11', '안녕하세요! 저는 사업자 회원입니다.', 'user011@example.com', 
    'active', TO_DATE('2023-11-01', 'YYYY-MM-DD'), NULL, 
    'http://example.com/profile11.jpg', 320
);

INSERT INTO member (
    id, category, registration_number, userid, naver_id, google_id, kakao_id, 
    userpwd, nickname, introduction, email, status, join_date, leave_date, 
    profile_image, point
) VALUES (
    12, '일반', '111-22-3334', 'user012', 'naver909', 'google909', 'kakao909', 
    'password12', 'nickname12', '안녕하세요! 저는 일반 회원입니다.', 'user012@example.com', 
    'inactive', TO_DATE('2023-12-01', 'YYYY-MM-DD'), NULL, 
    'http://example.com/profile12.jpg', 130
);

INSERT INTO member (
    id, category, registration_number, userid, naver_id, google_id, kakao_id, 
    userpwd, nickname, introduction, email, status, join_date, leave_date, 
    profile_image, point
) VALUES (
    13, '사업자', '222-33-4445', 'user013', 'naver010', 'google010', 'kakao010', 
    'password13', 'nickname13', '안녕하세요! 저는 사업자 회원입니다.', 'user013@example.com', 
    'active', TO_DATE('2024-01-01', 'YYYY-MM-DD'), NULL, 
    'http://example.com/profile13.jpg', 240
);

INSERT INTO member (
    id, category, registration_number, userid, naver_id, google_id, kakao_id, 
    userpwd, nickname, introduction, email, status, join_date, leave_date, 
    profile_image, point
) VALUES (
    14, '일반', '333-44-5556', 'user014', 'naver111', 'google111', 'kakao111', 
    'password14', 'nickname14', '안녕하세요! 저는 일반 회원입니다.', 'user014@example.com', 
    'active', TO_DATE('2024-02-01', 'YYYY-MM-DD'), NULL, 
    'http://example.com/profile14.jpg', 110
);

INSERT INTO member (
    id, category, registration_number, userid, naver_id, google_id, kakao_id, 
    userpwd, nickname, introduction, email, status, join_date, leave_date, 
    profile_image, point
) VALUES (
    15, '사업자', '444-55-6667', 'user015', 'naver212', 'google212', 'kakao212', 
    'password15', 'nickname15', '안녕하세요! 저는 사업자 회원입니다.', 'user015@example.com', 
    'active', TO_DATE('2024-03-01', 'YYYY-MM-DD'), NULL, 
    'http://example.com/profile15.jpg', 350
);

INSERT INTO member (
    id, category, registration_number, userid, naver_id, google_id, kakao_id, 
    userpwd, nickname, introduction, email, status, join_date, leave_date, 
    profile_image, point
) VALUES (
    16, '일반', '555-66-7778', 'user016', 'naver313', 'google313', 'kakao313', 
    'password16', 'nickname16', '안녕하세요! 저는 일반 회원입니다.', 'user016@example.com', 
    'inactive', TO_DATE('2024-04-01', 'YYYY-MM-DD'), NULL, 
    'http://example.com/profile16.jpg', 95
);

INSERT INTO member (
    id, category, registration_number, userid, naver_id, google_id, kakao_id, 
    userpwd, nickname, introduction, email, status, join_date, leave_date, 
    profile_image, point
) VALUES (
    17, '사업자', '666-77-8889', 'user017', 'naver414', 'google414', 'kakao414', 
    'password17', 'nickname17', '안녕하세요! 저는 사업자 회원입니다.', 'user017@example.com', 
    'active', TO_DATE('2024-05-01', 'YYYY-MM-DD'), NULL, 
    'http://example.com/profile17.jpg', 260
);

INSERT INTO member (
    id, category, registration_number, userid, naver_id, google_id, kakao_id, 
    userpwd, nickname, introduction, email, status, join_date, leave_date, 
    profile_image, point
) VALUES (
    18, '일반', '777-88-9990', 'user018', 'naver515', 'google515', 'kakao515', 
    'password18', 'nickname18', '안녕하세요! 저는 일반 회원입니다.', 'user018@example.com', 
    'active', TO_DATE('2024-06-01', 'YYYY-MM-DD'), NULL, 
    'http://example.com/profile18.jpg', 175
);


-- 가게 테이블


SELECT * FROM store;

CREATE TABLE store (
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

INSERT INTO store (id, store_name, address, detail_address, phone_number, owner_phone_number, main_image_1, main_image_2, latitude, longitude, views, open_time, store_description)
VALUES (1, 'Fresh Mart', '123 Main St, City A', 'Building A, Suite 101', '123-456-7890', '123-555-7890', 'image1_url.jpg', 'image2_url.jpg', 37.7749, -122.4194, 25, '08:00 - 21:00', 'A neighborhood grocery store offering fresh produce and daily essentials.');

INSERT INTO store (id, store_name, address, detail_address, phone_number, owner_phone_number, main_image_1, main_image_2, latitude, longitude, views, open_time, store_description)
VALUES (2, 'Tech Gear', '456 Tech Blvd, City B', 'Floor 2, Room 22', '555-123-4567', '555-555-4567', 'image3_url.jpg', 'image4_url.jpg', 40.7128, -74.0060, 42, '10:00 - 18:00', 'Specializing in electronics, gadgets, and tech accessories.');

INSERT INTO store (id, store_name, address, detail_address, phone_number, owner_phone_number, main_image_1, main_image_2, latitude, longitude, views, open_time, store_description)
VALUES (3, 'Book Nook', '789 Book Ave, City C', 'Apt. 302', '321-654-0987', '321-555-0987', 'image5_url.jpg', 'image6_url.jpg', 34.0522, -118.2437, 67, '09:00 - 20:00', 'A cozy bookstore with a wide selection of novels, comics, and stationery.');

INSERT INTO store (id, store_name, address, detail_address, phone_number, owner_phone_number, main_image_1, main_image_2, latitude, longitude, views, open_time, store_description)
VALUES (4, 'Healthy Bites', '321 Wellness St, City D', 'Shop 12', '987-654-3210', '987-555-3210', 'image7_url.jpg', 'image8_url.jpg', 41.8781, -87.6298, 34, '07:00 - 19:00', 'Serving organic and health-focused meals and snacks.');

INSERT INTO store (id, store_name, address, detail_address, phone_number, owner_phone_number, main_image_1, main_image_2, latitude, longitude, views, open_time, store_description)
VALUES (5, 'Pet Pals', '987 Animal Rd, City E', 'Unit B1', '654-321-0987', '654-555-0987', 'image9_url.jpg', 'image10_url.jpg', 35.6895, 139.6917, 28, '10:00 - 17:00', 'A pet store with a variety of supplies and food for cats, dogs, and small animals.');

INSERT INTO store (id, store_name, address, detail_address, phone_number, owner_phone_number, main_image_1, main_image_2, latitude, longitude, views, open_time, store_description)
VALUES (6, 'Vintage Finds', '654 Vintage St, City F', 'Warehouse 4', '456-789-1230', '456-555-1230', 'image11_url.jpg', 'image12_url.jpg', 48.8566, 2.3522, 55, '11:00 - 18:00', 'A unique store featuring vintage furniture and collectibles.');


-- 메뉴 테이블

SELECT * FROM menu;

CREATE TABLE menu (
    id NUMBER PRIMARY KEY,
    store_ID NUMBER NOT NULL,
    menu_image1 VARCHAR2(255),
    menu_image2 VARCHAR2(255),
    menu_image3 VARCHAR2(255),
    menu_image4 VARCHAR2(255),
    menu_description CLOB,
    menuname VARCHAR2(50) NOT NULL,
    menuprice NUMBER,
    CONSTRAINT fk_store FOREIGN KEY (store_ID) REFERENCES store(id)
);

INSERT INTO menu (id, store_id, menu_image1, menu_image2, menu_image3, menu_image4, menu_description, menuname, menuprice) VALUES 
(1, 1, 'menu1_img1.jpg', 'menu1_img2.jpg', 'menu1_img3.jpg', 'menu1_img4.jpg', 'A delicious starter with fresh ingredients.', 'Salad', 9500);
INSERT INTO menu (id, store_id, menu_image1, menu_image2, menu_image3, menu_image4, menu_description, menuname, menuprice) VALUES 
(2, 1, 'menu2_img1.jpg', 'menu2_img2.jpg', 'menu2_img3.jpg', 'menu2_img4.jpg', 'Savory pasta with a touch of Italian spices.', 'Pasta', 12500);
INSERT INTO menu (id, store_id, menu_image1, menu_image2, menu_image3, menu_image4, menu_description, menuname, menuprice) VALUES 
(3, 2, 'menu3_img1.jpg', 'menu3_img2.jpg', 'menu3_img3.jpg', 'menu3_img4.jpg', 'Spicy ramen with rich, flavorful broth.', 'Ramen', 8500);
INSERT INTO menu (id, store_id, menu_image1, menu_image2, menu_image3, menu_image4, menu_description, menuname, menuprice) VALUES 
(4, 2, 'menu4_img1.jpg', 'menu4_img2.jpg', 'menu4_img3.jpg', 'menu4_img4.jpg', 'Tasty sushi rolls made with fresh fish.', 'Sushi Roll', 12000);
INSERT INTO menu (id, store_id, menu_image1, menu_image2, menu_image3, menu_image4, menu_description, menuname, menuprice) VALUES 
(5, 3, 'menu5_img1.jpg', 'menu5_img2.jpg', 'menu5_img3.jpg', 'menu5_img4.jpg', 'A sweet dessert to finish your meal.', 'Cheesecake', 7000);
INSERT INTO menu (id, store_id, menu_image1, menu_image2, menu_image3, menu_image4, menu_description, menuname, menuprice) VALUES 
(6, 3, 'menu6_img1.jpg', 'menu6_img2.jpg', 'menu6_img3.jpg', 'menu6_img4.jpg', 'Classic burger with cheese and bacon.', 'Burger', 9500);
INSERT INTO menu (id, store_id, menu_image1, menu_image2, menu_image3, menu_image4, menu_description, menuname, menuprice) VALUES 
(7, 4, 'menu7_img1.jpg', 'menu7_img2.jpg', 'menu7_img3.jpg', 'menu7_img4.jpg', 'Refreshing smoothie with mixed berries.', 'Berry Smoothie', 6000);
INSERT INTO menu (id, store_id, menu_image1, menu_image2, menu_image3, menu_image4, menu_description, menuname, menuprice) VALUES 
(8, 4, 'menu8_img1.jpg', 'menu8_img2.jpg', 'menu8_img3.jpg', 'menu8_img4.jpg', 'Hot coffee brewed to perfection.', 'Coffee', 4500);
INSERT INTO menu (id, store_id, menu_image1, menu_image2, menu_image3, menu_image4, menu_description, menuname, menuprice) VALUES 
(9, 5, 'menu9_img1.jpg', 'menu9_img2.jpg', 'menu9_img3.jpg', 'menu9_img4.jpg', 'Freshly made ice cream in various flavors.', 'Ice Cream', 5500);
INSERT INTO menu (id, store_id, menu_image1, menu_image2, menu_image3, menu_image4, menu_description, menuname, menuprice) VALUES 
(10, 5, 'menu10_img1.jpg', 'menu10_img2.jpg', 'menu10_img3.jpg', 'menu10_img4.jpg', 'Grilled chicken with a side of veggies.', 'Grilled Chicken', 14500);
INSERT INTO menu (id, store_id, menu_image1, menu_image2, menu_image3, menu_image4, menu_description, menuname, menuprice) VALUES 
(11, 6, 'menu11_img1.jpg', 'menu11_img2.jpg', 'menu11_img3.jpg', 'menu11_img4.jpg', 'Healthy avocado toast with a twist.', 'Avocado Toast', 8500);
INSERT INTO menu (id, store_id, menu_image1, menu_image2, menu_image3, menu_image4, menu_description, menuname, menuprice) VALUES 
(12, 6, 'menu12_img1.jpg', 'menu12_img2.jpg', 'menu12_img3.jpg', 'menu12_img4.jpg', 'Fries with cheese and bacon topping.', 'Loaded Fries', 5000);


-- 리뷰 테이블

SELECT * FROM review;

CREATE TABLE review (
    id NUMBER PRIMARY KEY,
    user_ID NUMBER NOT NULL,
    store_ID NUMBER NOT NULL,
    score DECIMAL(2, 1),
    review CLOB,
    CONSTRAINT fk_user FOREIGN KEY (user_ID) REFERENCES member(id),
    CONSTRAINT fk_store_r FOREIGN KEY (store_ID) REFERENCES store(id),
    CONSTRAINT unique_user_store UNIQUE (user_ID, store_ID) -- user_ID와 store_ID의 조합이 유일하도록 설정
);

INSERT INTO review (id, user_ID, store_ID, score, review) VALUES 
(1, 1, 1, 4.5, 'Great place, loved the food and the atmosphere!');

INSERT INTO review (id, user_ID, store_ID, score, review) VALUES 
(2, 2, 2, 3.8, 'Good food but the service could be better.');

INSERT INTO review (id, user_ID, store_ID, score, review) VALUES 
(3, 3, 3, 5.0, 'Amazing experience, will definitely come back!');

INSERT INTO review (id, user_ID, store_ID, score, review) VALUES 
(4, 4, 4, 4.2, 'Nice ambiance, but the food was a bit too salty for my taste.');

INSERT INTO review (id, user_ID, store_ID, score, review) VALUES 
(5, 5, 5, 4.8, 'Delicious dishes and great staff, highly recommend!');


-- store 임시 데이터

INSERT INTO STORE (MEMBER_ID, STORE_NAME, ADDRESS, DETAIL_ADDRESS, TEL, PHONE_NUMBER, MAIN_IMAGE1, MAIN_IMAGE2, LATITUDE, LONGITUDE, VIEWS, OPEN_TIME, STORE_DESCRIPTION, POST_STATUS, ENROLL_STATUS)
VALUES (6, '진지아', '서울 송파구 백제고분로41길', '12-9, 1,2층', '02-418-5354', '010-9126-0000', 'jinjia1.png', 'jinjia2.png', 37.5615, 127.1599, 0, '11:45 - 21:30', '룸 있는 중식당', 'ACTIVE', 'ENROLLED')

INSERT INTO STORE (MEMBER_ID, STORE_NAME, ADDRESS, DETAIL_ADDRESS, TEL, PHONE_NUMBER, MAIN_IMAGE1, MAIN_IMAGE2, LATITUDE, LONGITUDE, VIEWS, OPEN_TIME, STORE_DESCRIPTION, POST_STATUS, ENROLL_STATUS)
VALUES (8, '돈까스의집', '서울 송파구 삼전로 100', '아카데미빌딩 1층', '02-413-5182', '010-5936-0000', 'donzip1.png', 'donzip2.png', 38.5615, 128.1599, 0, '11:00 - 21:50', '추억의 경양식 돈까스', 'ACTIVE', 'ENROLLED')

INSERT INTO STORE (MEMBER_ID, STORE_NAME, ADDRESS, DETAIL_ADDRESS, TEL, PHONE_NUMBER, MAIN_IMAGE1, MAIN_IMAGE2, LATITUDE, LONGITUDE, VIEWS, OPEN_TIME, STORE_DESCRIPTION, POST_STATUS, ENROLL_STATUS)
VALUES (9, '담은갈비', '서울 송파구 삼전로 93', '1층', '02-423-8053', '010-4126-0000', 'damungalbi1.png', 'damungalbi2.png', 38.5618, 128.1899, 0, '11:30 - 22:00', '잠실 최고의 수제갈비 전문점', 'ACTIVE', 'ENROLLED')

INSERT INTO STORE (MEMBER_ID, STORE_NAME, ADDRESS, DETAIL_ADDRESS, TEL, PHONE_NUMBER, MAIN_IMAGE1, MAIN_IMAGE2, LATITUDE, LONGITUDE, VIEWS, OPEN_TIME, STORE_DESCRIPTION, POST_STATUS, ENROLL_STATUS)
VALUES (10, '군산오징어 잠실본점', '서울 송파구 삼학사로 101', '군산오징어빌딩 1,2층', '02-413-2046', '010-2936-0000', 'gunojing1.png', 'gunojing2.png', 38.6618, 129.1899, 0, '11:30 - 22:30', '가성비 좋은 오삼불고기 맛집', 'ACTIVE', 'ENROLLED')

INSERT INTO STORE (MEMBER_ID, STORE_NAME, ADDRESS, DETAIL_ADDRESS, TEL, PHONE_NUMBER, MAIN_IMAGE1, MAIN_IMAGE2, LATITUDE, LONGITUDE, VIEWS, OPEN_TIME, STORE_DESCRIPTION, POST_STATUS, ENROLL_STATUS)
VALUES (11, '식당네오', '서울 송파구 삼전로12길 4', '101호', '02-123-2316', '010-2351-0000', 'neo1.png', 'neo2.png', 38.6718, 129.1799, 0, '18:00 - 21:00', '흑백요리사 최강록 쉐프의 일식 오마카세', 'ACTIVE', 'ENROLLED')

INSERT INTO MENU (STORE_ID, MENU_IMAGE, MENU_DESCRIPTION, MENU_NAME, MENU_PRICE)
VALUES (46, 'neo1.png', '식당네오', '선지', 10000)

INSERT INTO MENU (STORE_ID, MENU_IMAGE, MENU_DESCRIPTION, MENU_NAME, MENU_PRICE)
VALUES (41, 'jinjia2.png', '진지아', '우육면', 12000)

INSERT INTO MENU (STORE_ID, MENU_IMAGE, MENU_DESCRIPTION, MENU_NAME, MENU_PRICE)
VALUES (42, 'donzip1.png', '돈까스의집', '치즈돈까스', 12000)

INSERT INTO MENU (STORE_ID, MENU_IMAGE, MENU_DESCRIPTION, MENU_NAME, MENU_PRICE)
VALUES (43, 'damungalbi1.png', '담은갈비', '돼지갈비', 14000)

INSERT INTO MENU (STORE_ID, MENU_IMAGE, MENU_DESCRIPTION, MENU_NAME, MENU_PRICE)
VALUES (44, 'gunojing1.png', '군산오징어 잠실본점', '오징어볶음', 24000)


----------------------------------------- db -----------------------------------------

SELECT COUNT(*) FROM v$session;
SELECT COUNT(*) FROM v$process;

-- 세션 및 프로세스 제한 확인
SHOW PARAMETER sessions;
SHOW PARAMETER processes;

-- 세션 상세 확인
SELECT
    username,
    sid,
    serial#,
    status,
    osuser,
    machine,
    program,
    module,
    action,
    logon_time
FROM
    v$session
WHERE
    username IS NOT NULL
ORDER BY
    logon_time DESC;

-- 프로세스 상세 확인
SELECT
    pid,
    spid,
    program,
    background,
    traceid
FROM
    v$process;

-- 프로세스 상세 확인
SELECT
    s.sid,
    s.serial#,
    p.spid,
    s.username,
    s.osuser,
    s.machine,
    s.program,
    p.traceid
FROM
    v$session s
JOIN
    v$process p ON s.paddr = p.addr
WHERE
    p.program = '?';
    

-- 1시간 이상 비활성화 세션 삭제
BEGIN
    FOR r IN (
        SELECT sid, serial#
        FROM v$session
        WHERE status = 'INACTIVE'
        AND last_call_et > 3600 -- 1시간 이상 비활성
    ) LOOP
        EXECUTE IMMEDIATE 'ALTER SYSTEM KILL SESSION ''' || r.sid || ',' || r.serial# || '''';
    END LOOP;
END;
/

BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        job_name        => 'KILL_INACTIVE_SESSIONS',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'BEGIN FOR r IN (SELECT sid, serial# FROM v$session WHERE status = ''INACTIVE'' AND last_call_et > 3600) LOOP EXECUTE IMMEDIATE ''ALTER SYSTEM KILL SESSION '''''' || r.sid || '','' || r.serial# || ''''''; END LOOP; END;',
        start_date      => SYSDATE,
        repeat_interval => 'FREQ=MINUTELY; INTERVAL=15', -- 15분마다 실행
        enabled         => TRUE
    );
END;
/

-- kill된 세션 확인
SELECT sid, serial#, status
FROM v$session
WHERE status = 'KILLED';