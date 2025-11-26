
USE vnfood;

INSERT IGNORE INTO dishes (class_id, image_url) VALUES (20, 'https://cdn.tgdd.vn/Files/2017/03/22/963738/cach-lam-goi-cuon-tom-thit-thom-ngon-cho-bua-com-gian-don-202203021427281747.jpg');
SET @dish_id = (SELECT id FROM dishes WHERE class_id = 20);
INSERT IGNORE INTO dish_translations (dish_id, language_code, name, description) VALUES
(@dish_id, 'vi', 'Gỏi Cuốn', 'Món khai vị tươi mát gồm bún, tôm, thịt luộc, rau thơm, hẹ được cuốn trong bánh tráng. Chấm với tương đen hoặc nước mắm chua ngọt.'),
(@dish_id, 'en', 'Spring Rolls', 'A fresh appetizer made of rice vermicelli, shrimp, boiled pork, fresh herbs, and chives wrapped in rice paper. Served with hoisin-peanut sauce or sweet fish sauce.');
INSERT IGNORE INTO ingredients (name_key) VALUES
('thit_ba_chi'), ('tom'), ('bun_tuoi'), ('banh_trang'),
('xa_lach'), ('gia'), ('he'), ('rau_thom'), ('dua_leo'),
('hanh_tim'), ('toi'), ('ot'), ('dau_phong_rang'),
('duong'), ('muoi'), ('hat_nem'), ('tuong_den'), ('bo_dau_phong');

INSERT IGNORE INTO ingredient_translations (ingredient_id, language_code, name) VALUES
((SELECT id FROM ingredients WHERE name_key='thit_ba_chi'), 'vi', 'Thịt ba chỉ heo'),
((SELECT id FROM ingredients WHERE name_key='thit_ba_chi'), 'en', 'Pork belly'),
((SELECT id FROM ingredients WHERE name_key='tom'), 'vi', 'Tôm'),
((SELECT id FROM ingredients WHERE name_key='tom'), 'en', 'Shrimp'),
((SELECT id FROM ingredients WHERE name_key='bun_tuoi'), 'vi', 'Bún tươi'),
((SELECT id FROM ingredients WHERE name_key='bun_tuoi'), 'en', 'Fresh rice vermicelli'),
((SELECT id FROM ingredients WHERE name_key='banh_trang'), 'vi', 'Bánh tráng cuốn'),
((SELECT id FROM ingredients WHERE name_key='banh_trang'), 'en', 'Rice paper (for rolling)'),
((SELECT id FROM ingredients WHERE name_key='xa_lach'), 'vi', 'Xà lách'),
((SELECT id FROM ingredients WHERE name_key='xa_lach'), 'en', 'Lettuce'),
((SELECT id FROM ingredients WHERE name_key='gia'), 'vi', 'Giá'),
((SELECT id FROM ingredients WHERE name_key='gia'), 'en', 'Bean sprouts'),
((SELECT id FROM ingredients WHERE name_key='he'), 'vi', 'Hẹ'),
((SELECT id FROM ingredients WHERE name_key='he'), 'en', 'Chives'),
((SELECT id FROM ingredients WHERE name_key='rau_thom'), 'vi', 'Rau thơm'),
((SELECT id FROM ingredients WHERE name_key='rau_thom'), 'en', 'Herbs'),
((SELECT id FROM ingredients WHERE name_key='dua_leo'), 'vi', 'Dưa leo'),
((SELECT id FROM ingredients WHERE name_key='dua_leo'), 'en', 'Cucumber'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim'), 'vi', 'Hành tím'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim'), 'en', 'Shallot'),
((SELECT id FROM ingredients WHERE name_key='toi'), 'vi', 'Tỏi'),
((SELECT id FROM ingredients WHERE name_key='toi'), 'en', 'Garlic'),
((SELECT id FROM ingredients WHERE name_key='ot'), 'vi', 'Ớt'),
((SELECT id FROM ingredients WHERE name_key='ot'), 'en', 'Chili'),
((SELECT id FROM ingredients WHERE name_key='dau_phong_rang'), 'vi', 'Đậu phộng rang'),
((SELECT id FROM ingredients WHERE name_key='dau_phong_rang'), 'en', 'Roasted peanuts'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'vi', 'Đường'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'en', 'Sugar'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'vi', 'Muối'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'en', 'Salt'),
((SELECT id FROM ingredients WHERE name_key='hat_nem'), 'vi', 'Hạt nêm'),
((SELECT id FROM ingredients WHERE name_key='hat_nem'), 'en', 'Seasoning powder'),
((SELECT id FROM ingredients WHERE name_key='tuong_den'), 'vi', 'Tương đen (chấm)'),
((SELECT id FROM ingredients WHERE name_key='tuong_den'), 'en', 'Hoisin-peanut sauce'),
((SELECT id FROM ingredients WHERE name_key='bo_dau_phong'), 'vi', 'Bơ đậu phộng'),
((SELECT id FROM ingredients WHERE name_key='bo_dau_phong'), 'en', 'Peanut butter');

INSERT IGNORE INTO dish_ingredients (dish_id, ingredient_id, quantity) VALUES
(@dish_id, (SELECT id FROM ingredients WHERE name_key='thit_ba_chi'), '1 kg'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tom'), '300g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bun_tuoi'), '500g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='banh_trang'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='xa_lach'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='gia'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='he'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='rau_thom'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='dua_leo'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_tim'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='toi'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='ot'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='dau_phong_rang'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='duong'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='muoi'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hat_nem'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tuong_den'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bo_dau_phong'), ' ');

INSERT IGNORE INTO instructions (dish_id, step_number, image_url) VALUES
(@dish_id, 1, 'https://cdn.tgdd.vn/Files/2017/03/22/963738/cach-lam-goi-cuon-tom-thit-thom-ngon-cho-bua-com-gian-don-202112301129029086.jpg'),
(@dish_id, 2, 'https://cdn.tgdd.vn/Files/2017/03/22/963738/cach-lam-goi-cuon-thom-ngon-don-gian-2_760x451.jpg'),
(@dish_id, 3, 'https://cdn.tgdd.vn/Files/2017/03/22/963738/cach-lam-goi-cuon-thom-ngon-don-gian-3_760x450.jpg'),
(@dish_id, 4, 'https://cdn.tgdd.vn/Files/2017/03/22/963738/cach-lam-goi-cuon-tom-thit-thom-ngon-cho-bua-com-gian-don-202102201225481515.jpg'),
(@dish_id, 5, 'https://cdn.tgdd.vn/Files/2017/03/22/963738/cach-lam-goi-cuon-tom-thit-thom-ngon-cho-bua-com-gian-don-202103111042208754.jpg');



SET @step1_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 1 LIMIT 1);
SET @step2_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 2 LIMIT 1);
SET @step3_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 3 LIMIT 1);
SET @step4_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 4 LIMIT 1);
SET @step5_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 5 LIMIT 1);
INSERT IGNORE INTO instruction_translations (instruction_id, language_code, description) VALUES
(@step1_id, 'vi', 'Sơ chế rau Rau xà lách, rau thơm, giá, hẹ, dưa leo rửa sạch rồi để ráo nước. Dưa leo cắt dọc theo chiều dài.'),
(@step1_id, 'en', 'Prepare vegetables Wash lettuce, herbs, bean sprouts, chives, cucumbers and let them drain. Cut cucumbers lengthwise.'),
(@step2_id, 'vi', 'Luộc thịt heo Thịt heo cạo lông sạch sau đó lấy muối chà xát lên thịt heo rồi rửa lại với nước ấm, làm cách này thì thịt heo sẽ sạch hơn. Cho nồi nước lên bếp rồi cho củ hành và một ít muối luộc chung với thịt trongkhoảng 30 phút. Sau khi thịt chín, vớt thịt ra thau nước lạnh để thịt trắng và giòn hơn. Sau đó cắt thịt thành miếng mỏng vừa ăn và bày ra đĩa.'),
(@step2_id, 'en', 'Boil the pork Shave the pork clean, then rub salt on the pork and rinse with warm water. This will make the pork cleaner. Put the pot of water on the stove, add the onion and a little salt and boil with the meat for about 30 minutes. Once the meat is cooked, remove it to a bowl of cold water to make it whiter and crispier. Then cut the meat into thin, bite-sized pieces and arrange on a plate.'),
(@step3_id, 'vi', 'Luộc tôm Tôm rửa sạch, cho chảo lên bếp rồi cho tôm vào cùngmột ít muối và không cần thêm nước vì tôm tự tiết ra nước. Đậy nắp lại và luộc tôm, khi tôm chuyển sang màu đỏ thì vớt tôm ra. Lột vỏ tôm, bỏ chỉ lưng. Bày ra đĩa cho đẹp mắt.'),
(@step3_id, 'en', 'Boil the shrimp Wash the shrimp, put the pan on the stove and add the shrimp with a little salt and no need to add water because the shrimp will secrete water. Cover the lid and boil the shrimp, when the shrimp turns red, take the shrimp out. Peel the shrimp, remove the back vein. Arrange on a plate to look nice.'),
(@step4_id, 'vi', ' Cuốn gỏi cuốn Bạn lấy ít nước để làm ướt bánh tráng, sau đó đặt bánh tráng lên 1 cái dĩa hoặc thớt. Lấy một ít rau xà lách, rau thơm, giá, dưa leo và 1 cọng hẹ đặt lên bánh tráng. Sau đó, cho một ít bún, thịt và bắt đầu cuốn lại. Khi cuốn được 1 vòng, bạn cho thêm 2 con tôm rồi gấp 2 mép bánh tráng ở 2 bên lại. Cuối cùng, chỉ cần cuộn chặt tay đến khi hết miếng bánh tráng là xong.'),
(@step4_id, 'en', 'Spring Roll Use a little water to wet the rice paper, then place it on a plate or cutting board. Take some lettuce, herbs, bean sprouts, cucumber and 1 chive and place it on the rice paper. Then, add some vermicelli, meat and start rolling. When you have rolled 1 round, add 2 shrimp and fold the 2 edges of the rice paper on both sides. Finally, just roll tightly until the rice paper is finished.'),
(@step5_id, 'vi', ' Bạn cho nước mắm, đường và nước nóng vào chén, khuấy đều cho tan đường. Cho thêm 1 muỗng canh tỏi, 1 muỗng canh ớt băm và 1 muỗng canh nước cốt chanh vào khuấy đều lần nữa là đã hoàn thành nước mắm ngon chấm gỏi cuốn rồi nhé.'),
(@step5_id, 'en', 'Add fish sauce, sugar and hot water to a bowl, stir well to dissolve the sugar. Add 1 tablespoon of garlic, 1 tablespoon of minced chili and 1 tablespoon of lemon juice, stir well again and you have completed the delicious fish sauce to dip spring rolls.');