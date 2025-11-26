
USE vnfood;

INSERT IGNORE INTO dishes (class_id, image_url) VALUES (22, 'https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/2024_1_9_638404130081431753_cach-lam-nem-chua-thumb.jpg');
SET @dish_id = (SELECT id FROM dishes WHERE class_id = 22);
INSERT IGNORE INTO dish_translations (dish_id, language_code, name, description) VALUES
(@dish_id, 'vi', 'Nem Chua', 'Món ăn làm từ thịt heo xay và bì lợn, được trộn với thính và gia vị, gói trong lá chuối và để lên men tự nhiên. Nem có vị chua, cay, giòn.'),
(@dish_id, 'en', 'Fermented Pork Roll', 'A dish made from ground pork and pork skin, mixed with roasted rice powder and spices, wrapped in banana leaves and left to ferment naturally. It has a sour, spicy, and crunchy taste.');
INSERT IGNORE INTO ingredients (name_key) VALUES
('thit_heo_nac'), ('bi_heo'), ('han_the'), ('toi'), ('ot'),
('la_sung'), ('la_chuoi'), ('day_thun'),
('hat_nem'), ('duong'), ('tieu_hot_gia_dap'), ('tieu_xay'), ('nuoc_mam');

INSERT IGNORE INTO ingredient_translations (ingredient_id, language_code, name) VALUES
((SELECT id FROM ingredients WHERE name_key='thit_heo_nac'), 'vi', 'Thịt heo nạc'),
((SELECT id FROM ingredients WHERE name_key='thit_heo_nac'), 'en', 'Lean pork'),
((SELECT id FROM ingredients WHERE name_key='bi_heo'), 'vi', 'Bì heo'),
((SELECT id FROM ingredients WHERE name_key='bi_heo'), 'en', 'Pork skin'),
((SELECT id FROM ingredients WHERE name_key='han_the'), 'vi', 'Hàn the'),
((SELECT id FROM ingredients WHERE name_key='han_the'), 'en', 'Alum'),
((SELECT id FROM ingredients WHERE name_key='toi'), 'vi', 'Tỏi'),
((SELECT id FROM ingredients WHERE name_key='toi'), 'en', 'Garlic'),
((SELECT id FROM ingredients WHERE name_key='ot'), 'vi', 'Ớt'),
((SELECT id FROM ingredients WHERE name_key='ot'), 'en', 'Chili'),
((SELECT id FROM ingredients WHERE name_key='la_sung'), 'vi', 'Lá sung'),
((SELECT id FROM ingredients WHERE name_key='la_sung'), 'en', 'Fig leaves'),
((SELECT id FROM ingredients WHERE name_key='la_chuoi'), 'vi', 'Lá chuối'),
((SELECT id FROM ingredients WHERE name_key='la_chuoi'), 'en', 'Banana leaves'),
((SELECT id FROM ingredients WHERE name_key='day_thun'), 'vi', 'Dây thun'),
((SELECT id FROM ingredients WHERE name_key='day_thun'), 'en', 'Rubber bands'),
((SELECT id FROM ingredients WHERE name_key='hat_nem'), 'vi', 'Hạt nêm'),
((SELECT id FROM ingredients WHERE name_key='hat_nem'), 'en', 'Seasoning powder'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'vi', 'Đường'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'en', 'Sugar'),
((SELECT id FROM ingredients WHERE name_key='tieu_hot_gia_dap'), 'vi', 'Tiêu hột giã dập'),
((SELECT id FROM ingredients WHERE name_key='tieu_hot_gia_dap'), 'en', 'Crushed black peppercorns'),
((SELECT id FROM ingredients WHERE name_key='tieu_xay'), 'vi', 'Hạt tiêu xay'),
((SELECT id FROM ingredients WHERE name_key='tieu_xay'), 'en', 'Ground black pepper'),
((SELECT id FROM ingredients WHERE name_key='nuoc_mam'), 'vi', 'Nước mắm'),
((SELECT id FROM ingredients WHERE name_key='nuoc_mam'), 'en', 'Fish sauce');

INSERT IGNORE INTO dish_ingredients (dish_id, ingredient_id, quantity) VALUES
(@dish_id, (SELECT id FROM ingredients WHERE name_key='thit_heo_nac'), '500g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bi_heo'), '100g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='han_the'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='toi'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='ot'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='la_sung'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='la_chuoi'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='day_thun'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hat_nem'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='duong'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tieu_hot_gia_dap'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tieu_xay'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='nuoc_mam'), ' ');

INSERT IGNORE INTO instructions (dish_id, step_number, image_url) VALUES
(@dish_id, 1, 'https://cdn.tgdd.vn/Files/2017/05/04/979185/cach-lam-nem-chua-hue-ngon-chuan-vi-202111011710016988.jpg'),
(@dish_id, 2, 'https://cdn.tgdd.vn/Files/2017/05/04/979185/cach-lam-nem-chua-hue-ngon-chuan-vi-202111011712124620.jpg'),
(@dish_id, 3, 'https://cdn.tgdd.vn/Files/2017/05/04/979185/cach-lam-nem-chua-hue-ngon-chuan-vi-202111011712401687.jpg'),
(@dish_id, 4, 'https://cdn.tgdd.vn/Files/2017/05/04/979185/cach-lam-nem-chua-hue-ngon-chuan-vi-202111011713034638.jpg');

SET @step1_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 1 LIMIT 1);
SET @step2_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 2 LIMIT 1);
SET @step3_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 3 LIMIT 1);
SET @step4_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 4 LIMIT 1);
INSERT IGNORE INTO instruction_translations (instruction_id, language_code, description) VALUES
(@step1_id, 'vi', 'Sơ chế nguyên liệu Bì heo rửa sạch, luộc chín, vớt ra ngâm vào nước đá lạnh khoảng 10 phút, đem rửa sạch và để ráo nước. Sau đó thái sợi nhỏ, ngắn. Tỏi bóc vỏ, thái lát mỏng với ớt. Lá sung rửa sạch, cắt thành từng miếng chữ nhật nhỏ. Lá chuối rửa kỹ hai mặt, phơi qua nắng cho hơi héo.'),
(@step1_id, 'en', 'Prepare ingredients Wash the pork skin, boil it, remove it and soak it in ice water for about 10 minutes, wash it and drain it. Then cut it into small, short strips. Peel the garlic, slice it thinly with the chili. Wash the fig leaves, cut them into small rectangular pieces. Wash the banana leaves thoroughly on both sides, dry them in the sun until they are slightly wilted.'),
(@step2_id, 'vi', 'Chế biến thịt gói nem Thịt heo nạc rửa sạch, thái miếng nhỏ, sau đó xay nhuyễn. Trộn thịt nạc với thính gạo và hàn the, 1 thìa cà phê hạt nêm, 1 thìa cà phê đường, một ít hạt tiêu, 2 thìa cà phê nước mắm, tỏi, ớt. Sau đó cho bì lợn vào trộn thật đều với thịt.'),
(@step2_id, 'en', 'Processing meat for spring rolls Wash the lean pork, cut into small pieces, then grind it. Mix the lean meat with rice bran and borax, 1 teaspoon of seasoning powder, 1 teaspoon of sugar, a little pepper, 2 teaspoons of fish sauce, garlic, chili. Then add the pork skin and mix well with the meat.'),
(@step3_id, 'vi', 'Gói nem Trải lá chuối ra mặt phẳng sạch, cho lá sung vào, tiếp đến trải đều một lớp thịt lên, sau đó đến tỏi, ớt. Cuộn lá chuối thật chặt bọc kín lấy phần nem chua, sau đó bẻ 2 đầu lá xuống và lấy dây thun buộc chặt.'),
(@step3_id, 'en', 'Wrapping the spring rolls Lay the banana leaves on a clean flat surface, add the fig leaves, then spread a layer of meat on top, then the garlic and chili. Roll the banana leaves tightly to cover the spring rolls, then fold the two ends down and tie them tightly with a rubber band.'),
(@step4_id, 'vi', ' Thành phẩm Để nem chua ở nơi thoáng mát từ 3 - 5 ngày để nem lên men là ăn được. Nem chua thơm nhẹ mùi lá chuối, dai giòn đặc trưng, gia vị nêm nếm vừa đủ, đậm đà, hơi the the của ớt, tiêu, tỏi chắc chắn sẽ khiến bạn ăn mãi không ngừng đấy.'),
(@step4_id, 'en', 'Finished product Leave the nem chua in a cool place for 3-5 days to ferment and then eat. Nem chua has a light banana leaf aroma, is chewy and crispy, has just the right amount of seasoning, is rich, and has a bit of chili, pepper, and garlic, which will definitely make you eat it forever.');