
USE vnfood;

INSERT IGNORE INTO dishes (class_id, image_url) VALUES (7, 'https://cdn.tgdd.vn/Files/2019/11/20/1220697/huong-dan-cach-lam-banh-gio-nong-mem-min-don-gian-8-760x367.jpg');
SET @dish_id = (SELECT id FROM dishes WHERE class_id = 7);
INSERT IGNORE INTO dish_translations (dish_id, language_code, name, description) VALUES
(@dish_id, 'vi', 'Bánh Giò', 'Bánh có hình chóp nón, vỏ làm từ bột gạo tẻ, nhân thịt băm, mộc nhĩ, hành khô, được gói trong lá chuối và hấp chín.'),
(@dish_id, 'en', 'Pyramid Rice Dumpling', 'A pyramid-shaped dumpling with a rice flour shell, filled with minced pork, wood-ear mushroom, and shallots, wrapped in banana leaves and steamed.');
INSERT IGNORE INTO ingredients (name_key) VALUES
('thit_heo_bam'),
('bot_gao'),
('bot_nang'),
('trung_cut'),
('nam_huong'),
('nam_meo'),
('nuoc_dung_ga'),
('hanh_tay'),
('hanh_tim_bam'),
('la_chuoi'),
('hanh_phi'),
('toi_bam'),
('tieu'),
('hat_nem'),
('dau_an'),
('muoi');

INSERT IGNORE INTO ingredient_translations (ingredient_id, language_code, name) VALUES
((SELECT id FROM ingredients WHERE name_key='thit_heo_bam'), 'vi', 'Thịt heo băm'),
((SELECT id FROM ingredients WHERE name_key='thit_heo_bam'), 'en', 'Minced pork'),
((SELECT id FROM ingredients WHERE name_key='bot_gao'), 'vi', 'Bột gạo'),
((SELECT id FROM ingredients WHERE name_key='bot_gao'), 'en', 'Rice flour'),
((SELECT id FROM ingredients WHERE name_key='bot_nang'), 'vi', 'Bột năng'),
((SELECT id FROM ingredients WHERE name_key='bot_nang'), 'en', 'Tapioca starch'),
((SELECT id FROM ingredients WHERE name_key='trung_cut'), 'vi', 'Trứng cút'),
((SELECT id FROM ingredients WHERE name_key='trung_cut'), 'en', 'Quail eggs'),
((SELECT id FROM ingredients WHERE name_key='nam_huong'), 'vi', 'Nấm hương'),
((SELECT id FROM ingredients WHERE name_key='nam_huong'), 'en', 'Shiitake mushroom'),
((SELECT id FROM ingredients WHERE name_key='nam_meo'), 'vi', 'Nấm mèo'),
((SELECT id FROM ingredients WHERE name_key='nam_meo'), 'en', 'Wood ear mushrooms'),
((SELECT id FROM ingredients WHERE name_key='nuoc_dung_ga'), 'vi', 'Nước dùng gà'),
((SELECT id FROM ingredients WHERE name_key='nuoc_dung_ga'), 'en', 'Chicken stock'),
((SELECT id FROM ingredients WHERE name_key='hanh_tay'), 'vi', 'Hành tây'),
((SELECT id FROM ingredients WHERE name_key='hanh_tay'), 'en', 'Onion'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim_bam'), 'vi', 'Hành tím băm'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim_bam'), 'en', 'Minced shallots'),
((SELECT id FROM ingredients WHERE name_key='la_chuoi'), 'vi', 'Lá chuối'),
((SELECT id FROM ingredients WHERE name_key='la_chuoi'), 'en', 'Banana leaves'),
((SELECT id FROM ingredients WHERE name_key='hanh_phi'), 'vi', 'Hành phi'),
((SELECT id FROM ingredients WHERE name_key='hanh_phi'), 'en', 'Fried shallots'),
((SELECT id FROM ingredients WHERE name_key='toi_bam'), 'vi', 'Tỏi băm'),
((SELECT id FROM ingredients WHERE name_key='toi_bam'), 'en', 'Minced garlic'),
((SELECT id FROM ingredients WHERE name_key='tieu'), 'vi', 'Tiêu'),
((SELECT id FROM ingredients WHERE name_key='tieu'), 'en', 'Pepper'),
((SELECT id FROM ingredients WHERE name_key='hat_nem'), 'vi', 'Hạt nêm'),
((SELECT id FROM ingredients WHERE name_key='hat_nem'), 'en', 'Seasoning powder'),
((SELECT id FROM ingredients WHERE name_key='dau_an'), 'vi', 'Dầu ăn'),
((SELECT id FROM ingredients WHERE name_key='dau_an'), 'en', 'Cooking oil'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'vi', 'Muối'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'en', 'Salt');

INSERT IGNORE INTO dish_ingredients (dish_id, ingredient_id, quantity) VALUES
(@dish_id, (SELECT id FROM ingredients WHERE name_key='thit_heo_bam'), '200g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bot_gao'), '320g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bot_nang'), '80g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='trung_cut'), '10'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='nam_huong'), '20g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='nam_meo'), '30g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='nuoc_dung_ga'), '500ml'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_tay'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_tim_bam'), '200g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='la_chuoi'), '10'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_phi'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='toi_bam'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tieu'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hat_nem'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='dau_an'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='muoi'), '');

INSERT IGNORE INTO instructions (dish_id, step_number, image_url) VALUES
(@dish_id, 1, 'https://cdn.tgdd.vn/Files/2019/11/20/1220697/huong-dan-cach-lam-banh-gio-nong-mem-min-don-gian-9.jpg'),
(@dish_id, 2, 'https://cdn.tgdd.vn/Files/2019/11/20/1220697/huong-dan-cach-lam-banh-gio-nong-mem-min-don-gian-3.JPG'),
(@dish_id, 3, 'https://cdn.tgdd.vn/Files/2019/11/20/1220697/huong-dan-cach-lam-banh-gio-nong-mem-min-don-gian-4.JPG'),
(@dish_id, 4, 'https://cdn.tgdd.vn/Files/2019/11/20/1220697/huong-dan-cach-lam-banh-gio-nong-mem-min-don-gian-5.JPG'),
(@dish_id, 5, 'https://cdn.tgdd.vn/Files/2019/11/20/1220697/huong-dan-cach-lam-banh-gio-nong-mem-min-don-gian-6.JPG'),
(@dish_id, 6, 'https://cdn.tgdd.vn/Files/2019/11/20/1220697/huong-dan-cach-lam-banh-gio-nong-mem-min-don-gian-1.jpg');

SET @step1_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 1 LIMIT 1);
SET @step2_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 2 LIMIT 1);
SET @step3_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 3 LIMIT 1);
SET @step4_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 4 LIMIT 1);
SET @step5_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 5 LIMIT 1);
SET @step6_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 6 LIMIT 1);


INSERT IGNORE INTO instruction_translations (instruction_id, language_code, description) VALUES
(@step1_id, 'vi', 'Xào nhân bánh giò Đặt 1 cái chảo lên bếp, cho vào chảo 1 ít dầu ăn, đợi dầu nóng rồi cho tiếp 1 muỗng canh tỏi, 1 muỗng canh hành tây, 1 muỗng canh hành tím băm vào xào thơm rồi cho 200gr thịt heo bằm vào. Khi thịt gần chín thì cho 20gr nấm hương, 30gr nấm mèo đã ngâm mềm cắt nhỏ và 1 muỗng canh hành phi vào. Nêm 1 muỗng canh muối, 1 muỗng canh hạt nêm, 1 muỗng canh tiêu vào đảo đều 5 phút rồi tắt bếp.'),
(@step1_id, 'en', 'Stir-fry the banh gio filling Place a pan on the stove, add a little cooking oil, wait for the oil to heat up, then add 1 tablespoon of garlic, 1 tablespoon of onion, 1 tablespoon of minced shallots and stir-fry until fragrant, then add 200g of minced pork. When the meat is almost cooked, add 20g of shiitake mushrooms, 30g of soaked and chopped wood ear mushrooms and 1 tablespoon of fried onions. Season with 1 tablespoon of salt, 1 tablespoon of seasoning powder, 1 tablespoon of pepper, stir-fry for 5 minutes and turn off the heat.'),
(@step2_id, 'vi', 'Nấu bột vỏ bánh giò Cho 320gr bột gạo và 80gr bột năng, 1/2 muỗng canh muối trong 1 cái nồi lớn có 1,5 lít nước hầm xương rồi hòa đều. Sau đó bắt lên bếp khuấy liên tục trên lửa nhỏ, thêm 1 muỗng canh dầu ăn, khuấy liên tục đến khi bột đặc lại thì tắt bếp.'),
(@step2_id, 'en', 'Cook the dough for the banh gio crust Put 320g of rice flour and 80g of tapioca starch, 1/2 tbsp of salt in a large pot with 1.5 liters of bone broth and mix well. Then put on the stove, stirring continuously over low heat, add 1 tbsp of cooking oil, stirring continuously until the dough thickens, then turn off the stove.'),
(@step3_id, 'vi', 'Sơ chế lá chuối Lá chuối tươi bạn mua về trụng qua nước sôi cho sạch và dễ gói. Bạn trải 1 lớp màng bọc thực phẩm lên mặt bàn rồi đặt lá chuối lên trên và gấp lại thành hình phễu.'),
(@step3_id, 'en', 'Prepare banana leaves Blank the fresh banana leaves you bought in boiling water to clean them and make them easier to wrap. Spread a layer of plastic wrap on the table, then place the banana leaves on top and fold them into a funnel shape.'),
(@step4_id, 'vi', 'Gói bánh giò Múc 1 muỗng bột cho vào trong phễu rồi dàn đều. Sau đó cho hỗn hợp nhân và trứng cút vào giữa và múc thêm 1 muỗng bột nữa phủ lên phía trên phần nhân, dàn đều. Bạn có thể nhúng muỗng vào chén dầu ăn để việc dàn đều bột bánh dễ dàng.'),
(@step4_id, 'en', 'Wrapping Banh Gio Scoop 1 spoon of dough into the funnel and spread it evenly. Then put the filling and quail egg mixture in the middle and scoop another spoon of dough on top of the filling and spread it evenly. You can dip the spoon in a bowl of cooking oil to make it easier to spread the dough evenly.'),
(@step5_id, 'vi', 'Hấp bánh giò Gói chiếc bánh lại, cột dây cho bánh thêm chắc chắn rồi cho vào trong xửng, hấp khoảng 20 - 25 phút là bánh chín.'),
(@step5_id, 'en', 'Steamed Banh Gio Wrap the cake up, tie a string to make it more secure, then put it in the steamer and steam for about 20 - 25 minutes until the cake is cooked.'),
(@step6_id, 'vi', 'Thành phẩm Bánh gói đều, khi bóc lá ra mặt bánh bóng mượt. Bánh chín trong, cùi bánh mềm, không nhão. Nhân bánh dậy mùi hạt tiêu, thịt không dai, vị vừa ăn.'),
(@step6_id, 'en', 'Finished product The cake is wrapped evenly, when the leaves are peeled off, the surface of the cake is shiny. The cake is cooked through, the cake pulp is soft, not mushy. The cake filling has a peppery aroma, the meat is not tough, and the taste is just right.');