
USE vnfood;

INSERT IGNORE INTO dishes (class_id, image_url) VALUES (5, 'https://cdn.tgdd.vn/Files/2022/01/03/1408683/tong-hop-12-cach-lam-banh-cuon-tai-nha-ngon-nhu-ngoai-hang-202203161544081729.jpg');
SET @dish_id = (SELECT id FROM dishes WHERE class_id = 5);
INSERT IGNORE INTO dish_translations (dish_id, language_code, name, description) VALUES
(@dish_id, 'vi', 'Bánh Cuốn', 'Bánh làm từ bột gạo tráng mỏng trên nồi hấp, nhân thịt băm và mộc nhĩ, ăn kèm chả lụa, hành phi và nước mắm chua ngọt.'),
(@dish_id, 'en', 'Steamed Rice Rolls', 'Thin sheets of steamed rice batter, filled with ground pork and wood-ear mushrooms, served with Vietnamese ham, fried shallots, and dipping sauce.');
INSERT IGNORE INTO ingredients (name_key) VALUES
('bot_gao'),
('thit_nac_dam'),
('cha_lua'),
('nam_meo'),
('cu_hanh_tim'),
('hanh_tay'),
('nuoc_mam'),
('muoi'),
('duong'),
('hat_tieu'),
('hat_nem'),
('ot'),
('toi');

INSERT IGNORE INTO ingredient_translations (ingredient_id, language_code, name) VALUES
((SELECT id FROM ingredients WHERE name_key='bot_gao'), 'vi', 'Bột gạo'),
((SELECT id FROM ingredients WHERE name_key='bot_gao'), 'en', 'Rice flour'),
((SELECT id FROM ingredients WHERE name_key='thit_nac_dam'), 'vi', 'Thịt nạc dăm'),
((SELECT id FROM ingredients WHERE name_key='thit_nac_dam'), 'en', 'Minced pork shoulder'),
((SELECT id FROM ingredients WHERE name_key='cha_lua'), 'vi', 'Chả lụa'),
((SELECT id FROM ingredients WHERE name_key='cha_lua'), 'en', 'Vietnamese sausage'),
((SELECT id FROM ingredients WHERE name_key='nam_meo'), 'vi', 'Nấm mèo'),
((SELECT id FROM ingredients WHERE name_key='nam_meo'), 'en', 'Wood ear mushrooms'),
((SELECT id FROM ingredients WHERE name_key='cu_hanh_tim'), 'vi', 'Củ hành tím'),
((SELECT id FROM ingredients WHERE name_key='cu_hanh_tim'), 'en', 'Shallots'),
((SELECT id FROM ingredients WHERE name_key='hanh_tay'), 'vi', 'Hành tây'),
((SELECT id FROM ingredients WHERE name_key='hanh_tay'), 'en', 'Onion'),
((SELECT id FROM ingredients WHERE name_key='nuoc_mam'), 'vi', 'Nước mắm'),
((SELECT id FROM ingredients WHERE name_key='nuoc_mam'), 'en', 'Fish sauce'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'vi', 'Muối'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'en', 'Salt'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'vi', 'Đường'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'en', 'Sugar'),
((SELECT id FROM ingredients WHERE name_key='hat_tieu'), 'vi', 'Hạt tiêu'),
((SELECT id FROM ingredients WHERE name_key='hat_tieu'), 'en', 'Pepper'),
((SELECT id FROM ingredients WHERE name_key='hat_nem'), 'vi', 'Hạt nêm'),
((SELECT id FROM ingredients WHERE name_key='hat_nem'), 'en', 'Seasoning powder'),
((SELECT id FROM ingredients WHERE name_key='ot'), 'vi', 'Ớt'),
((SELECT id FROM ingredients WHERE name_key='ot'), 'en', 'Chili'),
((SELECT id FROM ingredients WHERE name_key='toi'), 'vi', 'Tỏi'),
((SELECT id FROM ingredients WHERE name_key='toi'), 'en', 'Garlic');

INSERT IGNORE INTO dish_ingredients (dish_id, ingredient_id, quantity) VALUES
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bot_gao'), '500g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='thit_nac_dam'), '500g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='cha_lua'), '300g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='nam_meo'), '100g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='cu_hanh_tim'), '100g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_tay'), '1 củ'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='nuoc_mam'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='muoi'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='duong'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hat_tieu'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hat_nem'),''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='ot'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='toi'), '');

INSERT IGNORE INTO instructions (dish_id, step_number, image_url) VALUES
(@dish_id, 1, 'https://cdn.tgdd.vn/Files/2022/01/03/1408683/tong-hop-12-cach-lam-banh-cuon-tai-nha-ngon-nhu-ngoai-hang-202201030852443957.jpg'),
(@dish_id, 2, 'https://cdn.tgdd.vn/Files/2022/01/03/1408683/tong-hop-12-cach-lam-banh-cuon-tai-nha-ngon-nhu-ngoai-hang-202201030853031961.jpg'),
(@dish_id, 3, 'https://cdn.tgdd.vn/Files/2022/01/03/1408683/tong-hop-12-cach-lam-banh-cuon-tai-nha-ngon-nhu-ngoai-hang-202201030853169601.jpg'),
(@dish_id, 4, 'https://cdn.tgdd.vn/Files/2022/01/03/1408683/tong-hop-12-cach-lam-banh-cuon-tai-nha-ngon-nhu-ngoai-hang-202201030853305855.jpg');


SET @step1_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 1 LIMIT 1);
SET @step2_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 2 LIMIT 1);
SET @step3_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 3 LIMIT 1);
SET @step4_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 4 LIMIT 1);
INSERT IGNORE INTO instruction_translations (instruction_id, language_code, description) VALUES
(@step1_id, 'vi', 'Pha bột làm bánh Cho 1 lít nước vào bột gạo khuấy đều, cho thêm 1/4 muỗng cafe muối, để bột nở trong 30 phút.'),
(@step1_id, 'en', 'Mix the cake flour Add 1 liter of water to the rice flour, stir well, add 1/4 teaspoon of salt, let the dough rise for 30 minutes.'),
(@step2_id, 'vi', 'Làm nhân bánh Thịt nạc dăm rửa sạch, để ráo, thái miếng nhỏ rồi dùng dao băm nhuyễn. Hành tím bóc vỏ, 1/2 thái miếng nhỏ băm đều, 1/2 bào nhỏ. Cho 1 muỗng canh hành tím vào thịt để ướp rồi trộn đều nha các bạn. Hành tây bóc vỏ, rửa sạch, thái hạt lựu để làm phần nhân bánh. Nấm mèo ngâm nước, cắt cuống chân rồi cắt sợi, băm nhỏ.'),
(@step2_id, 'en', 'Making the filling Wash the lean meat, drain, cut into small pieces and then use a knife to mince it. Peel the shallots, cut half into small pieces and mince the other half, grate the other half. Add 1 tablespoon of shallots to the meat to marinate and mix well. Peel the shallots, wash them, and dice them to make the filling. Soak the wood ear mushrooms in water, cut off the stem, then cut into strips and mince.'),
(@step3_id, 'vi', 'Xào nhân bánh Cho chảo lên bếp thêm 2 muỗng canh dầu ăn rồi phi thơm phần hành tím còn lại cho tiếp thịt băm đã ướp vào chảo xào, cho phần hành tây thái hạt lựu vào chảo, xào đến khi hành tây chín rồi nêm 1 muỗng canh nước mắm, 2 muỗng cafe hạt nêm, 1 muỗng cafe đường vào trộn đều. Khi nước cạn, cho phần nấm mèo băm nhỏ vào, đảo đều lần nữa, cho 1 muỗng cafe hạt tiêu vào trước khi tắt bếp. '),
(@step3_id, 'en', 'Stir-fry the filling Put the pan on the stove, add 2 tablespoons of cooking oil, then sauté the remaining shallots, add the marinated minced meat to the pan, add the diced onions to the pan, stir-fry until the onions are cooked, then season with 1 tablespoon of fish sauce, 2 teaspoons of seasoning powder, 1 teaspoon of sugar and mix well. When the water is dry, add the chopped mushrooms, stir well again, add 1 teaspoon of pepper before turning off the stove.'),
(@step4_id, 'vi', 'Bắc phấn lên bếp, thoa lên một lớp dầu ăn thật tinh khiết để lửa vừa. Cho 1 kềm canh lớn nước bột trà vào vòng, lắc đều cho nước lan đều mặt. Đậy lại, để trong 5 giây là bánh chín, hỗ trợ một cái đĩa lớn đã có một lớp dầu ăn. Sau đó cho 1 lớp nhân bánh đã xào lên rồi cuộn lại là được.'),
(@step4_id, 'en', 'Place the cake on the stove, apply a layer of pure cooking oil on medium heat. Add a large bowl of tea powder water into the ring, shake well to spread the water evenly on the surface. Cover, leave for 5 seconds until the cake is cooked, support a large plate with a layer of cooking oil. Then add a layer of fried cake filling and roll it up.');