
USE vnfood;

INSERT IGNORE INTO dishes (class_id, image_url) VALUES (16, 'https://cdn.tgdd.vn/Files/2021/02/23/1329799/bi-quyet-nau-ca-kho-to-ngon-chuan-vi-ca-dai-mau-sac-chuan-dep-202208271627215315.jpg');
SET @dish_id = (SELECT id FROM dishes WHERE class_id = 16);
INSERT IGNORE INTO dish_translations (dish_id, language_code, name, description) VALUES
(@dish_id, 'vi', 'Cá Kho Tộ', 'Cá (thường là cá lóc, cá basa) được kho trong tộ đất với nước màu, nước mắm, tiêu, ớt, tạo nên hương vị đậm đà và màu sắc hấp dẫn.'),
(@dish_id, 'en', 'Caramelized Fish in Clay Pot', 'Fish (typically catfish or snakehead) braised in a clay pot with caramel sauce, fish sauce, pepper, and chili, creating a rich flavor and appealing color.');
INSERT IGNORE INTO ingredients (name_key) VALUES
('ca_basa_tuoi'),
('thit_ba_roi'),
('dua'),
('bot_mi'),
('bot_nang'),
('ruou_gung'),
('giam'),
('chanh'),
('toi'),
('ot'),
('hanh_tim'),
('hanh_la'),
('thi_la');

INSERT IGNORE INTO ingredient_translations (ingredient_id, language_code, name) VALUES
((SELECT id FROM ingredients WHERE name_key='ca_basa_tuoi'), 'vi', 'Cá basa tươi'),
((SELECT id FROM ingredients WHERE name_key='ca_basa_tuoi'), 'en', 'Fresh basa fish'),
((SELECT id FROM ingredients WHERE name_key='thit_ba_roi'), 'vi', 'Thịt ba rọi'),
((SELECT id FROM ingredients WHERE name_key='thit_ba_roi'), 'en', 'Pork belly'),
((SELECT id FROM ingredients WHERE name_key='dua'), 'vi', 'Dừa'),
((SELECT id FROM ingredients WHERE name_key='dua'), 'en', 'Coconut'),
((SELECT id FROM ingredients WHERE name_key='bot_mi'), 'vi', 'Bột mì'),
((SELECT id FROM ingredients WHERE name_key='bot_mi'), 'en', 'Wheat flour'),
((SELECT id FROM ingredients WHERE name_key='bot_nang'), 'vi', 'Bột năng'),
((SELECT id FROM ingredients WHERE name_key='bot_nang'), 'en', 'Tapioca starch'),
((SELECT id FROM ingredients WHERE name_key='ruou_gung'), 'vi', 'Rượu gừng'),
((SELECT id FROM ingredients WHERE name_key='ruou_gung'), 'en', 'Ginger wine'),
((SELECT id FROM ingredients WHERE name_key='giam'), 'vi', 'Giấm'),
((SELECT id FROM ingredients WHERE name_key='giam'), 'en', 'Vinegar'),
((SELECT id FROM ingredients WHERE name_key='chanh'), 'vi', 'Chanh'),
((SELECT id FROM ingredients WHERE name_key='chanh'), 'en', 'Lime'),
((SELECT id FROM ingredients WHERE name_key='toi'), 'vi', 'Tỏi'),
((SELECT id FROM ingredients WHERE name_key='toi'), 'en', 'Garlic'),
((SELECT id FROM ingredients WHERE name_key='ot'), 'vi', 'Ớt'),
((SELECT id FROM ingredients WHERE name_key='ot'), 'en', 'Chili'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim'), 'vi', 'Hành tím'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim'), 'en', 'Shallot'),
((SELECT id FROM ingredients WHERE name_key='hanh_la'), 'vi', 'Hành lá'),
((SELECT id FROM ingredients WHERE name_key='hanh_la'), 'en', 'Spring onion'),
((SELECT id FROM ingredients WHERE name_key='thi_la'), 'vi', 'Thì là'),
((SELECT id FROM ingredients WHERE name_key='thi_la'), 'en', 'Dill');

INSERT IGNORE INTO dish_ingredients (dish_id, ingredient_id, quantity) VALUES
(@dish_id, (SELECT id FROM ingredients WHERE name_key='ca_basa_tuoi'), '1kg'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='thit_ba_roi'), '250g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='dua'), '1'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bot_mi'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bot_nang'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='ruou_gung'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='giam'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='chanh'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='toi'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='ot'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_tim'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_la'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='thi_la'), ' ');

INSERT IGNORE INTO instructions (dish_id, step_number, image_url) VALUES
(@dish_id, 1, 'https://cdn.tgdd.vn/Files/2021/02/23/1329799/bi-quyet-nau-ca-kho-to-ngon-chuan-vi-ca-dai-mau-sac-chuan-dep-202209101128087734.jpg'),
(@dish_id, 2, 'https://cdn.tgdd.vn/Files/2021/02/23/1329799/bi-quyet-nau-ca-kho-to-ngon-chuan-vi-ca-dai-mau-sac-chuan-dep-202209101128264547.jpg'),
(@dish_id, 3, 'https://cdn.tgdd.vn/Files/2021/02/23/1329799/bi-quyet-nau-ca-kho-to-ngon-chuan-vi-ca-dai-mau-sac-chuan-dep-202209101128425937.jpg'),
(@dish_id, 4, 'https://cdn.tgdd.vn/Files/2021/02/23/1329799/bi-quyet-nau-ca-kho-to-ngon-chuan-vi-ca-dai-mau-sac-chuan-dep-202208271626294790.jpg'),

SET @step1_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 1 LIMIT 1);
SET @step2_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 2 LIMIT 1);
SET @step3_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 3 LIMIT 1);
SET @step4_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 4 LIMIT 1);
INSERT IGNORE INTO instruction_translations (instruction_id, language_code, description) VALUES
(@step1_id, 'vi', 'Sơ chế cá basa Bạn làm sạch cá bằng cách chặt bỏ vây, mổ bỏ nội tạng, tách bỏ mang, cạo sạch màng đen bên trong bụng cá. Sau đó, bạn dùng bột mì hoặc bột năng để loại bỏ lớp nhớt trên cá rồi lấy khăn sạch lau từ đầu xuống đuôi. Tiếp theo là dùng rượu gừng, muối hoặc giấm, chanh chà xát lên thân cá, cả bên trong và bên ngoài để khử mùi tanh triệt để. Cuối cùng là rửa lại thật sạch với nước. Bạn lấy dao chặt cá thành khúc khoảng 5cm rồi ướp cá theo tỷ lệ 1 thìa cà phê xì dầu, 1 thìa cà phê muối, ½ thìa cà phê tiêu, 1 - 3 thìa cà phê đường, 3 thìa canh nước mắm, 1 thìa canh dầu ăn và ớt băm. Bạn nhớ trộn để thấm gia vị trong 1 tiếng nhé!'),
(@step1_id, 'en', 'Prepare basa fish Clean the fish by cutting off the fins, removing the organs, removing the gills, and scraping off the black membrane inside the fish belly. Then, use flour or tapioca starch to remove the slime on the fish and then use a clean towel to wipe from head to tail. Next, use ginger wine, salt or vinegar, lemon to rub on the fish body, both inside and outside to completely remove the fishy smell. Finally, rinse thoroughly with water. Use a knife to chop the fish into pieces about 5cm long and then marinate the fish in the ratio of 1 teaspoon of soy sauce, 1 teaspoon of salt, ½ teaspoon of pepper, 1 - 3 teaspoons of sugar, 3 tablespoons of fish sauce, 1 tablespoon of cooking oil and chopped chili. Remember to mix to let the spices soak in for 1 hour!'),
(@step2_id, 'vi', 'Sơ chế các nguyên liệu khác Rửa sạch thịt ba rọi, cạo bì và thái miếng vuông. Bạn rửa hành, thì là và thái nhỏ. Lấy một tô khuấy tan đều hỗn hợp 1 muỗng canh xì dầu, 1 muỗng canh nước mắm và đổ cả nước dừa.'),
(@step2_id, 'en', 'Prepare other ingredients Wash the pork belly, scrape off the skin and cut into squares. Wash the onions and dill and chop them finely. Take a bowl and mix 1 tablespoon of soy sauce, 1 tablespoon of fish sauce and pour in the coconut water.'),
(@step3_id, 'vi', 'Chế biến món cá kho tộ Bạn bắc chảo lên bếp, cho dầu ăn tới khi nóng thì cho hành, tỏi, ớt băm vào phi thật thơm rồi thêm thịt ba chỉ vào đảo đến khi gần chínthì tắt bếp. Kết hợp độ béo ngậy của thịt ba chỉ kho cùng cá sẽ tăng sự hấp dẫn của món ăn hơn. Xếp các khúc cá vào niêu đất hoặc nồi sau đó để lớp thịt chỉ phía trên. Bạn nhớ đổ cả phần nước ướp vào niêu. Sau đó bạn đổ hỗn hợp xì dầu, nước mắm và nước dừa trên rồi đậy nắp vung lại để nấu.'),
(@step3_id, 'en', 'Cooking the braised fish in a clay pot Put the pan on the stove, add cooking oil until hot, then add chopped onions, garlic, and chili and sauté until fragrant, then add the pork belly and stir-fry until almost cooked, then turn off the stove. Combining the fatty taste of the braised pork belly with the fish will increase the attractiveness of the dish. Arrange the fish pieces in a clay pot or pot, then put the pork belly layer on top. Remember to pour the marinade into the pot. Then pour the mixture of soy sauce, fish sauce, and coconut water on top, then cover the pot to cook.'),
(@step4_id, 'vi', 'Thành phẩm Trước khi tắt bếp thì bạn cho hành lá và thì là lên phía trên bề mặt rồi nhấc xuống bếp là có thể thưởng thức ngay với cơm nóng.'),
(@step4_id, 'en', 'Finished product Before turning off the stove, add green onions and dill on top and remove from the stove to enjoy with hot rice.')');
