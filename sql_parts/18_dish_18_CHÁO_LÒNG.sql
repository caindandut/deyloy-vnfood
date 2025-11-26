
USE vnfood;

INSERT IGNORE INTO dishes (class_id, image_url) VALUES (18, 'https://cdn.tgdd.vn/Files/2017/03/23/964106/cach-nau-chao-long-thom-ngon-sanh-ngang-hang-quan-202208261704159586.jpg');
SET @dish_id = (SELECT id FROM dishes WHERE class_id = 18);
INSERT IGNORE INTO dish_translations (dish_id, language_code, name, description) VALUES
(@dish_id, 'vi', 'Cháo Lòng', 'Món cháo nấu từ gạo và nước luộc lòng, ăn kèm các loại nội tạng lợn như dồi, gan, tim, phèo, và rau thơm.'),
(@dish_id, 'en', 'Pork Offal Congee', 'A congee (rice porridge) cooked with rice and offal broth, served with various pork offal such as dồi (sausage), liver, heart, intestines, and fresh herbs.');
INSERT IGNORE INTO ingredients (name_key) VALUES
('xuong_heo'),
('gao'),
('tim_heo'),
('luoi_heo'),
('huyet_heo'),
('long_non'),
('da_day'),
('gan_heo'),
('hanh_la'),
('gia_do'),
('ot'),
('rau_thom'),
('gung'),
('chanh'),
('hanh_tim');

INSERT IGNORE INTO ingredient_translations (ingredient_id, language_code, name) VALUES
((SELECT id FROM ingredients WHERE name_key='xuong_heo'), 'vi', 'Xương heo'),
((SELECT id FROM ingredients WHERE name_key='xuong_heo'), 'en', 'Pork bones'),
((SELECT id FROM ingredients WHERE name_key='gao'), 'vi', 'Gạo'),
((SELECT id FROM ingredients WHERE name_key='gao'), 'en', 'Rice'),
((SELECT id FROM ingredients WHERE name_key='tim_heo'), 'vi', 'Tim heo'),
((SELECT id FROM ingredients WHERE name_key='tim_heo'), 'en', 'Pork heart'),
((SELECT id FROM ingredients WHERE name_key='luoi_heo'), 'vi', 'Lưỡi heo'),
((SELECT id FROM ingredients WHERE name_key='luoi_heo'), 'en', 'Pork tongue'),
((SELECT id FROM ingredients WHERE name_key='huyet_heo'), 'vi', 'Huyết heo'),
((SELECT id FROM ingredients WHERE name_key='huyet_heo'), 'en', 'Pork blood'),
((SELECT id FROM ingredients WHERE name_key='long_non'), 'vi', 'Lòng non'),
((SELECT id FROM ingredients WHERE name_key='long_non'), 'en', 'Pork intestines'),
((SELECT id FROM ingredients WHERE name_key='da_day'), 'vi', 'Dạ dày'),
((SELECT id FROM ingredients WHERE name_key='da_day'), 'en', 'Pork stomach'),
((SELECT id FROM ingredients WHERE name_key='gan_heo'), 'vi', 'Gan heo'),
((SELECT id FROM ingredients WHERE name_key='gan_heo'), 'en', 'Pork liver'),
((SELECT id FROM ingredients WHERE name_key='hanh_la'), 'vi', 'Hành lá'),
((SELECT id FROM ingredients WHERE name_key='hanh_la'), 'en', 'Spring onion'),
((SELECT id FROM ingredients WHERE name_key='gia_do'), 'vi', 'Giá đỗ'),
((SELECT id FROM ingredients WHERE name_key='gia_do'), 'en', 'Bean sprouts'),
((SELECT id FROM ingredients WHERE name_key='ot'), 'vi', 'Ớt'),
((SELECT id FROM ingredients WHERE name_key='ot'), 'en', 'Chili'),
((SELECT id FROM ingredients WHERE name_key='rau_thom'), 'vi', 'Rau thơm'),
((SELECT id FROM ingredients WHERE name_key='rau_thom'), 'en', 'Herbs'),
((SELECT id FROM ingredients WHERE name_key='gung'), 'vi', 'Gừng'),
((SELECT id FROM ingredients WHERE name_key='gung'), 'en', 'Ginger'),
((SELECT id FROM ingredients WHERE name_key='chanh'), 'vi', 'Chanh'),
((SELECT id FROM ingredients WHERE name_key='chanh'), 'en', 'Lime'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim'), 'vi', 'Hành tím'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim'), 'en', 'Shallot');

INSERT IGNORE INTO dish_ingredients (dish_id, ingredient_id, quantity) VALUES
(@dish_id, (SELECT id FROM ingredients WHERE name_key='xuong_heo'), '500g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='gao'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tim_heo'), '100g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='luoi_heo'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='huyet_heo'), '100g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='long_non'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='da_day'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='gan_heo'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_la'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='gia_do'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='ot'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='rau_thom'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='gung'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='chanh'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_tim'), ' ');

INSERT IGNORE INTO instructions (dish_id, step_number, image_url) VALUES
(@dish_id, 1, 'https://cdn.tgdd.vn/Files/2017/03/23/964106/cach-nau-chao-long-thom-ngon-sanh-ngang-hang-quan-202208261655167828.jpg'),
(@dish_id, 2, 'https://cdn.tgdd.vn/Files/2017/03/23/964106/cach-nau-chao-long-thom-ngon-sanh-ngang-hang-quan-202208261656351354.jpg'),
(@dish_id, 3, 'https://cdn.tgdd.vn/Files/2017/03/23/964106/cach-nau-chao-long-thom-ngon-sanh-ngang-hang-quan-202208261658560824.jpg'),
(@dish_id, 4, 'https://cdn.tgdd.vn/Files/2017/03/23/964106/cach-nau-chao-long-thom-ngon-sanh-ngang-hang-quan-202208261653201474.jpg');

SET @step1_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 1 LIMIT 1);
SET @step2_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 2 LIMIT 1);
SET @step3_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 3 LIMIT 1);
SET @step4_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 4 LIMIT 1);
INSERT IGNORE INTO instruction_translations (instruction_id, language_code, description) VALUES
(@step1_id, 'vi', 'Sơ chế nguyên liệu Hành lá, giá, rau thơm rửa sạch. Hành lá cắt nhỏ. Gừng gọt vỏ, cắt miếng. Rửa sạch xương heo, chặt miếng, chần sơ qua nước sôi cho hết chất bẩn, đem rửa sạch lại. Cho xương và hành tím cắt lát vào nồi nấu chung, thường xuyên vớt bọt.'),
(@step1_id, 'en', 'Prepare ingredients Wash green onions, bean sprouts, and herbs. Chop green onions. Peel and cut ginger into pieces. Wash pork bones, cut into pieces, blanch in boiling water to remove dirt, then wash again. Put bones and sliced ​​shallots in a pot to cook together, skimming off foam regularly.'),
(@step2_id, 'vi', ' Làm sạch và luộc lòng heo, tim, gan, lưỡi heo Tim, gan, lưỡi heo và lòng non rửa sạch với muối và chanh nhiều lần để hết mùi hôi. Đem luộc chín rồi vớt ra cho vào tô đá, vắt thêm ít chanh để cho lòng được trắng giòn. Sau đó vớt lòng ra dĩa và cắt miếng vừa ăn. Lòng heo cắt chia làm 2 phần như nhau.'),
(@step2_id, 'en', 'Clean and boil pig intestines, heart, liver, and tongue Wash the heart, liver, tongue, and intestines with salt and lemon several times to remove the odor. Boil until cooked, then remove and put in an ice bowl, squeeze a little lemon juice to make the intestines white and crispy. Then remove the intestines to a plate and cut into bite-sized pieces. Cut the pig intestines into 2 equal parts.'),
(@step3_id, 'vi', 'Cách nấu cháo lòng Ngâm gạo trong vòng 20 phút rồi đem vo sạch hoặc rang gạo thơm. Khi nước dùng đủ ngọt, cho gạo vào nấu tới khi cháo nhừ, liên tục khuấy cháo để khỏi bị cháy dưới đáy. Khi cháo nhừ, bỏ huyết heo vào nấu chung, sẽ có màu nâu đặc trưng của cháo lòng. Sau cùng cho thêm một nữa lòng heo đã cắt sẵn và gừng nấu chung. Nấu thêm khoảng 15 phút nữa thì tắt bếp, rắc thêm hành lá lên trên.'),
(@step3_id, 'en', 'How to cook porridge Soak the rice for 20 minutes, then wash or roast the rice until fragrant. When the broth is sweet enough, add the rice and cook until the porridge is soft, stirring constantly to avoid burning the bottom. When the porridge is soft, add the pig blood and cook together, it will have the characteristic brown color of porridge. Finally, add half of the pre-cut pig intestines and ginger and cook together. Cook for about 15 more minutes, then turn off the stove and sprinkle green onions on top.'),
(@step4_id, 'vi', 'Thành phẩm Múc cháo ra tô, cho thêm mấy miếng lòng heo, hành lá, giá, rau thơm, tiêu lên trên sao cho hấp dẫn. Bên cạnh là dĩa lòng heo đã cắt sẵn. '),
(@step4_id, 'en', 'Finished product Ladle the porridge into a bowl, add some pieces of pork intestines, green onions, bean sprouts, herbs, and pepper on top to make it more attractive. Next to it is a plate of pre-cut pork intestines.')');
