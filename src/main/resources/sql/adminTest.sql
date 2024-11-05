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
    status VARCHAR2(10) NOT NULL CHECK (status IN ('active', 'deleted')),
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
    user_seq.NEXTVAL, '일반', '123-45-6789', 'user001', 'naver123', 'google123', 'kakao123', 
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
