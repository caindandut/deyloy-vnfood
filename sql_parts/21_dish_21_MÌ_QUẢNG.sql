
USE vnfood;

INSERT IGNORE INTO dishes (class_id, image_url) VALUES (21, 'https://cdn.tgdd.vn/Files/2019/03/08/1153609/cach-nau-mi-quang-dung-vi-ma-khong-can-ra-tiem-202201101026008893.jpg');
SET @dish_id = (SELECT id FROM dishes WHERE class_id = 21);
INSERT IGNORE INTO dish_translations (dish_id, language_code, name, description) VALUES
(@dish_id, 'vi', 'Mì Quảng', 'Đặc sản Quảng Nam - Đà Nẵng, sợi mì to, dẹt, màu vàng, ăn với rất ít nước dùng đậm đà, nhân tôm, thịt, trứng. Ăn kèm bánh tráng nướng và đậu phộng rang.'),
(@dish_id, 'en', 'Mi Quang (Quang Noodles)', 'A specialty of Quang Nam - Da Nang, featuring wide, flat, yellow noodles with very little rich broth, topped with shrimp, pork, and egg. Served with grilled rice paper and roasted peanuts.');
INSERT IGNORE INTO ingredients (name_key) VALUES
('uc_ga'), ('xuong_heo'), ('thit_ba_chi'), ('tom'), ('trung_cut'),
('mi_quang_tuoi'), ('banh_trang_nuong'), ('dau_mau_dieu'),
('bot_nghe'), ('ot_bot'), ('toi'), ('hanh_tim'),
('dau_phong_rang'), ('xa_lach'), ('rau_thom'), ('gia'),
('muoi'), ('tieu'), ('duong'), ('nuoc_mam'), ('dau_hao');

INSERT IGNORE INTO ingredient_translations (ingredient_id, language_code, name) VALUES
((SELECT id FROM ingredients WHERE name_key='uc_ga'), 'vi', 'Ức gà'),
((SELECT id FROM ingredients WHERE name_key='uc_ga'), 'en', 'Chicken breast'),
((SELECT id FROM ingredients WHERE name_key='xuong_heo'), 'vi', 'Xương heo'),
((SELECT id FROM ingredients WHERE name_key='xuong_heo'), 'en', 'Pork bones'),
((SELECT id FROM ingredients WHERE name_key='thit_ba_chi'), 'vi', 'Thịt ba chỉ'),
((SELECT id FROM ingredients WHERE name_key='thit_ba_chi'), 'en', 'Pork belly'),
((SELECT id FROM ingredients WHERE name_key='tom'), 'vi', 'Tôm'),
((SELECT id FROM ingredients WHERE name_key='tom'), 'en', 'Shrimp'),
((SELECT id FROM ingredients WHERE name_key='trung_cut'), 'vi', 'Trứng cút'),
((SELECT id FROM ingredients WHERE name_key='trung_cut'), 'en', 'Quail eggs'),
((SELECT id FROM ingredients WHERE name_key='mi_quang_tuoi'), 'vi', 'Mì Quảng tươi'),
((SELECT id FROM ingredients WHERE name_key='mi_quang_tuoi'), 'en', 'Fresh Mi Quang noodles'),
((SELECT id FROM ingredients WHERE name_key='banh_trang_nuong'), 'vi', 'Bánh tráng nướng'),
((SELECT id FROM ingredients WHERE name_key='banh_trang_nuong'), 'en', 'Grilled rice paper'),
((SELECT id FROM ingredients WHERE name_key='dau_mau_dieu'), 'vi', 'Dầu màu điều'),
((SELECT id FROM ingredients WHERE name_key='dau_mau_dieu'), 'en', 'Annatto oil'),
((SELECT id FROM ingredients WHERE name_key='bot_nghe'), 'vi', 'Bột nghệ'),
((SELECT id FROM ingredients WHERE name_key='bot_nghe'), 'en', 'Turmeric powder'),
((SELECT id FROM ingredients WHERE name_key='ot_bot'), 'vi', 'Ớt bột'),
((SELECT id FROM ingredients WHERE name_key='ot_bot'), 'en', 'Chili powder'),
((SELECT id FROM ingredients WHERE name_key='toi'), 'vi', 'Tỏi'),
((SELECT id FROM ingredients WHERE name_key='toi'), 'en', 'Garlic'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim'), 'vi', 'Hành tím'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim'), 'en', 'Shallot'),
((SELECT id FROM ingredients WHERE name_key='dau_phong_rang'), 'vi', 'Đậu phộng rang'),
((SELECT id FROM ingredients WHERE name_key='dau_phong_rang'), 'en', 'Roasted peanuts'),
((SELECT id FROM ingredients WHERE name_key='xa_lach'), 'vi', 'Xà lách'),
((SELECT id FROM ingredients WHERE name_key='xa_lach'), 'en', 'Lettuce'),
((SELECT id FROM ingredients WHERE name_key='rau_thom'), 'vi', 'Rau thơm'),
((SELECT id FROM ingredients WHERE name_key='rau_thom'), 'en', 'Herbs'),
((SELECT id FROM ingredients WHERE name_key='gia'), 'vi', 'Giá'),
((SELECT id FROM ingredients WHERE name_key='gia'), 'en', 'Bean sprouts'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'vi', 'Muối'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'en', 'Salt'),
((SELECT id FROM ingredients WHERE name_key='tieu'), 'vi', 'Tiêu'),
((SELECT id FROM ingredients WHERE name_key='tieu'), 'en', 'Pepper'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'vi', 'Đường'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'en', 'Sugar'),
((SELECT id FROM ingredients WHERE name_key='nuoc_mam'), 'vi', 'Nước mắm'),
((SELECT id FROM ingredients WHERE name_key='nuoc_mam'), 'en', 'Fish sauce'),
((SELECT id FROM ingredients WHERE name_key='dau_hao'), 'vi', 'Dầu hào'),
((SELECT id FROM ingredients WHERE name_key='dau_hao'), 'en', 'Oyster sauce');

INSERT IGNORE INTO dish_ingredients (dish_id, ingredient_id, quantity) VALUES
(@dish_id, (SELECT id FROM ingredients WHERE name_key='uc_ga'), '300g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='xuong_heo'), '200g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='thit_ba_chi'), '150g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tom'), '200g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='trung_cut'), '8 '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='mi_quang_tuoi'), '1 kg'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='banh_trang_nuong'), '2'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='dau_mau_dieu'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bot_nghe'), '10g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='ot_bot'), '5g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='toi'), '2'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_tim'), '1'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='dau_phong_rang'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='xa_lach'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='rau_thom'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='gia'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='muoi'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tieu'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='duong'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='nuoc_mam'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='dau_hao'), ' ');

INSERT IGNORE INTO instructions (dish_id, step_number, image_url) VALUES
(@dish_id, 1, 'https://cdn.tgdd.vn/Files/2019/03/08/1153609/cach-nau-mi-quang-dung-vi-ma-khong-can-ra-tiem-202208251547361141.jpg'),
(@dish_id, 2, 'https://cdn.tgdd.vn/Files/2019/03/08/1153609/cach-nau-mi-quang-dung-vi-ma-khong-can-ra-tiem-202208251545207969.jpg'),
(@dish_id, 3, 'https://cdn.tgdd.vn/Files/2019/03/08/1153609/cach-nau-mi-quang-dung-vi-ma-khong-can-ra-tiem-202208251546072250.jpg'),
(@dish_id, 4, 'https://cdn.tgdd.vn/Files/2019/03/08/1153609/cach-nau-mi-quang-dung-vi-ma-khong-can-ra-tiem-202208251546351248.jpg'),
(@dish_id, 5, 'https://cdn.tgdd.vn/Files/2019/03/08/1153609/cach-nau-mi-quang-dung-vi-ma-khong-can-ra-tiem-202208251542210348.jpg'),
(@dish_id, 6, 'https://cdn.tgdd.vn/Files/2019/03/08/1153609/cach-nau-mi-quang-dung-vi-ma-khong-can-ra-tiem-202208251543486142.jpg'),


SET @step1_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 1 LIMIT 1);
SET @step2_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 2 LIMIT 1);
SET @step3_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 3 LIMIT 1);
SET @step4_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 4 LIMIT 1);
SET @step5_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 5 LIMIT 1);
SET @step6_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 6 LIMIT 1);
INSERT IGNORE INTO instruction_translations (instruction_id, language_code, description) VALUES
(@step1_id, 'vi', 'Sơ chế nguyên liệu Tỏi, hành tím lột vỏ rồi băm nhuyễn, hành tây lột vỏ rồi cắt múi cau.'),
(@step1_id, 'en', 'Prepare ingredients Peel and mince garlic and shallots, peel and cut onions into wedges.'),
(@step2_id, 'vi', 'ơ chế gà Ức gà lọc phần thịt, phần xương dùng nấu nước dùng.'),
(@step2_id, 'en', 'Chicken breast Filter the meat from the chicken breast and use the bones to make broth.'),
(@step3_id, 'vi', ' Nấu nước dùng Xương heo và xương gà rửa sạch đem chần qua nước sôi rồi rửa lại bằng nước lạnh. Bắt một nồi nước rồi cho xương heo, xương gà, hành tây, 1/2 muỗng cà phê muối, 1 muỗng canh hạt nêm vào đun trong 30 phút để làm nước dùng.'),
(@step3_id, 'en', 'Cook the broth Wash the pork and chicken bones, blanch them in boiling water, then rinse with cold water. Heat a pot of water and add the pork bones, chicken bones, onions, 1/2 teaspoon salt, 1 tablespoon seasoning powder and boil for 30 minutes to make the broth.'),
(@step4_id, 'vi', 'Ướp tôm và sơ chế trứng Tôm bóc vỏ, bỏ đầu rồi ướp với 1 muỗng cà phê hạt nêm, 1/2 muỗng cà phê tiêu. Trứng gà luộc chín, bóc vỏ rồi cắt miếng.'),
(@step4_id, 'en', 'Marinate the shrimp and prepare the eggs Peel the shrimp, remove the heads and marinate with 1 teaspoon of seasoning powder and 1/2 teaspoon of pepper. Boil the eggs, peel and cut into pieces.'),
(@step5_id, 'vi', ' Ướp thịt ba chỉ và thịt gà Thịt ba chỉ và thịt gà rửa sạch rồi cắt miếng vừa ăn, ướp thịt với hành tỏi băm, 2 muỗng canh nước mắm, 1.5 muỗng canh hạt nêm, 1 muỗng canh đường, 1/2 muỗng canh dầu hào, 2 muỗng cà phê bột nghệ, 1 muỗng cà phê ớt bột, 1 muỗng cà phê tiêu trong 15 phút cho thịt ngấm gia vị. '),
(@step5_id, 'en', 'Marinate pork belly and chicken Wash pork belly and chicken, cut into bite-sized pieces, marinate with minced onion and garlic, 2 tablespoons fish sauce, 1.5 tablespoons seasoning powder, 1 tablespoon sugar, 1/2 tablespoon oyster sauce, 2 teaspoons turmeric powder, 1 teaspoon chili powder, 1 teaspoon pepper for 15 minutes to let the meat absorb the spices.'),
(@step6_id, 'vi', ' Thành phẩm Bắt chảo lên bếp, cho 2 muỗng canh dầu màu điều vào rồi cho tỏi băm vào phi thơm, sau đó cho phần thịt vừa ướp vào xào cho chín. Sau khi thịt chín thì tiếp tục đổ nước dùng vào chảo đang xào thịt rồi cho luôn trứng gà, tôm vào, tiếp tục nấu thêm 20 phút thì tắt bếp.'),
(@step6_id, 'en', 'Finished product Put the pan on the stove, add 2 tablespoons of annatto oil and then add minced garlic and sauté until fragrant, then add the marinated meat and stir-fry until cooked. After the meat is cooked, continue to pour the broth into the pan where the meat is being stir-fried, then add the eggs and shrimp, continue to cook for another 20 minutes and then turn off the stove.');