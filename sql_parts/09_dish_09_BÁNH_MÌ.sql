
USE vnfood;

INSERT IGNORE INTO dishes (class_id, image_url) VALUES (9, 'https://cdn.tgdd.vn/Files/2021/06/28/1363869/cach-lam-banh-mi-pate-thom-ngon-lot-bung-cho-bua-sang-202112311511081198.jpg');
SET @dish_id = (SELECT id FROM dishes WHERE class_id = 9);
INSERT IGNORE INTO dish_translations (dish_id, language_code, name, description) VALUES
(@dish_id, 'vi', 'Bánh Mì', 'Bánh mì kẹp Việt Nam nổi tiếng với vỏ giòn ruột mềm, nhân pate, thịt nguội, dưa chua, rau thơm và ớt.'),
(@dish_id, 'en', 'Banh Mi (Vietnamese Sandwich)', 'A famous Vietnamese sandwich on a crusty baguette with pate, cold cuts, pickled vegetables, fresh herbs, and chili.');
INSERT IGNORE INTO ingredients (name_key) VALUES
('gan_heo'),
('bi_heo'),
('sua_tuoi_khong_duong'),
('dua_leo'),
('banh_mi'),
('rau_thom'),
('duong'),
('bot_canh'),
('hanh_phi'),
('toi');

INSERT IGNORE INTO ingredient_translations (ingredient_id, language_code, name) VALUES
((SELECT id FROM ingredients WHERE name_key='gan_heo'), 'vi', 'Gan heo'),
((SELECT id FROM ingredients WHERE name_key='gan_heo'), 'en', 'Pork liver'),
((SELECT id FROM ingredients WHERE name_key='bi_heo'), 'vi', 'Bì heo'),
((SELECT id FROM ingredients WHERE name_key='bi_heo'), 'en', 'Pork skin'),
((SELECT id FROM ingredients WHERE name_key='sua_tuoi_khong_duong'), 'vi', 'Sữa tươi không đường'),
((SELECT id FROM ingredients WHERE name_key='sua_tuoi_khong_duong'), 'en', 'Unsweetened fresh milk'),
((SELECT id FROM ingredients WHERE name_key='dua_leo'), 'vi', 'Dưa leo'),
((SELECT id FROM ingredients WHERE name_key='dua_leo'), 'en', 'Cucumber'),
((SELECT id FROM ingredients WHERE name_key='banh_mi'), 'vi', 'Bánh mì'),
((SELECT id FROM ingredients WHERE name_key='banh_mi'), 'en', 'Baguette'),
((SELECT id FROM ingredients WHERE name_key='rau_thom'), 'vi', 'Rau thơm'),
((SELECT id FROM ingredients WHERE name_key='rau_thom'), 'en', 'Herbs'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'vi', 'Đường'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'en', 'Sugar'),
((SELECT id FROM ingredients WHERE name_key='bot_canh'), 'vi', 'Bột canh'),
((SELECT id FROM ingredients WHERE name_key='bot_canh'), 'en', 'Seasoning powder'),
((SELECT id FROM ingredients WHERE name_key='hanh_phi'), 'vi', 'Hành phi'),
((SELECT id FROM ingredients WHERE name_key='hanh_phi'), 'en', 'Fried shallots'),
((SELECT id FROM ingredients WHERE name_key='toi'), 'vi', 'Tỏi'),
((SELECT id FROM ingredients WHERE name_key='toi'), 'en', 'Garlic');

INSERT IGNORE INTO dish_ingredients (dish_id, ingredient_id, quantity) VALUES
(@dish_id, (SELECT id FROM ingredients WHERE name_key='gan_heo'), '300g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bi_heo'), '100g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='sua_tuoi_khong_duong'), '300ml'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='dua_leo'), '1'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='banh_mi'), '2'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='rau_thom'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='duong'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bot_canh'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_phi'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='toi'), '');


INSERT IGNORE INTO instructions (dish_id, step_number, image_url) VALUES
(@dish_id, 1, 'https://cdn.tgdd.vn/Files/2021/06/28/1363869/cach-lam-banh-mi-pate-thom-ngon-lot-bung-cho-bua-sang-202106281533178710.jpg'),
(@dish_id, 2, 'https://cdn.tgdd.vn/Files/2021/06/28/1363869/cach-lam-banh-mi-pate-thom-ngon-lot-bung-cho-bua-sang-202106281528408349.jpg'),
(@dish_id, 3, 'https://cdn.tgdd.vn/Files/2021/06/28/1363869/cach-lam-banh-mi-pate-thom-ngon-lot-bung-cho-bua-sang-202106281529097177.jpg');


SET @step1_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 1 LIMIT 1);
SET @step2_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 2 LIMIT 1);
SET @step3_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 3 LIMIT 1);
INSERT IGNORE INTO instruction_translations (instruction_id, language_code, description) VALUES
(@step1_id, 'vi', 'Sơ chế nguyên liệu Gan heo còn sống trước khi chế biến cần được rửa sạch, cắt nhỏ rồi cho vào chén ngâm với khoảng 180-200 ml sữa tươi không đường trong khoảng 20 – 30 phút, sau đó vớt ra rổ để ráo nước. Điều này giúp khử mùi cho gan tốt hơn. Tiếp tới rửa sạch bì heo và tiếp tục cắt nhỏ. ⅔ ổ bánh mì, ta làm vụn ra, sau đó ngâm với 100 ml sữa tươi không đường còn lại. Tỏi, hành bóc vỏ, băm nhuyễn. Rau thơm, dưa leo rửa sạch, trong lúc rửa ngâm sơ với nước muối. Sau khi rửa, với dưa leo ta gọt sạch vỏ rồi cắt thành lát dày, mỏng tùy thích.'),
(@step1_id, 'en', 'Prepare the ingredients Before processing, the raw pig liver needs to be washed, chopped, and then put in a bowl to soak with about 180-200 ml of unsweetened fresh milk for about 20-30 minutes, then removed to a basket to drain. This helps to deodorize the liver better. Next, wash the pig skin and continue to chop it. We crumble ⅔ of the bread, then soak it with the remaining 100 ml of unsweetened fresh milk. Peel and mince the garlic and onions. Wash the herbs and cucumbers, while washing, soak them in salt water. After washing, peel the cucumbers and cut them into thick or thin slices as desired.'),
(@step2_id, 'vi', ' Chế biến pate Bắc chảo lên bếp, đợi chảo nóng thì cho dầu ăn vào đun sôi. Cho tiếp tỏi băm vào phi thơm. Kế tới, ta cho gan đã ráo nước vào, nêm với ½ thìa cà phê đường, ½ thìa cà phê bột canh, tiếp tục đảo đều. Khi thấy gan dần chín tái, cho bánh mì vụn đã ngâm sữa vào, rắc một chút tiêu, rồi đảo thêm khoảng 2 – 3 phút. Tắt bếp. Cho toàn bộ phần gan trên vào máy xay sinh tố, xay nhuyễn. Sau khi xay xong, ta đã có có pate nhưng vẫn chưa hoàn thiện. Lúc này, bạn hãy quết thêm chút bơ rồi mang đi hấp cách thủy trong khoảng 20 – 30 phút. Chờ pate nguội lại là bạn hoàn thành phần chính của món ăn này rồi.'),
(@step2_id, 'en', 'Pate processing Place the pan on the stove, wait for the pan to heat up, then add cooking oil and bring to a boil. Add minced garlic and sauté until fragrant. Next, add the drained liver, season with ½ teaspoon sugar, ½ teaspoon seasoning powder, and continue to stir well. When the liver is almost cooked, add the breadcrumbs soaked in milk, sprinkle a little pepper, and stir for about 2-3 minutes. Turn off the stove. Put all the liver in the blender and blend. After blending, we have pate but it is not yet complete. At this point, you should spread a little butter and steam it for about 20-30 minutes. Wait for the pate to cool down and you have completed the main part of this dish.'),
(@step3_id, 'vi', 'Thành phẩm Cho bánh mì vào lò vi sóng nướng lên cho nóng. Dùng dao rạch bên hông bánh mì rồi cho pate vào, tiếp tục quết thêm bơ, rồi rau thơm, dưa leo. Nếu bạn thích ăn cay, hãy cho thêm một xíu tương ớt là có thể thưởng thức rồi. '),
(@step3_id, 'en', 'Finished product Put the bread in the microwave to heat up. Use a knife to cut the side of the bread and put the pate in, continue to spread butter, then herbs, cucumber. If you like spicy food, add a little chili sauce and enjoy.');