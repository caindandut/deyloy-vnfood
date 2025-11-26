
USE vnfood;

INSERT IGNORE INTO dishes (class_id, image_url)
VALUES (0, 'https://cdn.tgdd.vn/Files/2017/03/21/963426/cach-lam-banh-beo-thom-ngon-202110041645542724.jpg');
SET @dish_id = (SELECT id FROM dishes WHERE class_id = 0);

INSERT IGNORE INTO dish_translations (dish_id, language_code, name, description) VALUES
(@dish_id, 'vi', 'Bánh Bèo', 'Bánh gạo hấp truyền thống kiểu miền Trung, ăn kèm tôm chấy, mỡ hành, và nước mắm chua ngọt đặc sệt.'),
(@dish_id, 'en', 'Water Fern Cake', 'Traditional Central Vietnamese steamed rice cakes, served in small bowls with dried shrimp floss, scallion oil, and a sweet and savory dipping sauce.');

INSERT IGNORE INTO ingredients (name_key) VALUES
('bot_gao'), ('bot_nang'), ('tom_tuoi'), ('hanh_la'), ('hanh_tim'), ('toi'), ('ot'), ('nuoc_mam'), ('duong'), ('muoi');
INSERT IGNORE INTO ingredient_translations (ingredient_id, language_code, name) VALUES
((SELECT id FROM ingredients WHERE name_key='bot_gao'), 'vi', 'Bột gạo'),
((SELECT id FROM ingredients WHERE name_key='bot_gao'), 'en', 'Rice flour'),
((SELECT id FROM ingredients WHERE name_key='bot_nang'), 'vi', 'Bột năng'),
((SELECT id FROM ingredients WHERE name_key='bot_nang'), 'en', 'Tapioca starch'),
((SELECT id FROM ingredients WHERE name_key='tom_tuoi'), 'vi', 'Tôm tươi'),
((SELECT id FROM ingredients WHERE name_key='tom_tuoi'), 'en', 'Fresh shrimp'),
((SELECT id FROM ingredients WHERE name_key='hanh_la'), 'vi', 'Hành lá'),
((SELECT id FROM ingredients WHERE name_key='hanh_la'), 'en', 'Scallions'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim'), 'vi', 'Hành tím'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim'), 'en', 'Shallots'),
((SELECT id FROM ingredients WHERE name_key='toi'), 'vi', 'Tỏi'),
((SELECT id FROM ingredients WHERE name_key='toi'), 'en', 'Garlic'),
((SELECT id FROM ingredients WHERE name_key='ot'), 'vi', 'Ớt'),
((SELECT id FROM ingredients WHERE name_key='ot'), 'en', 'Chili'),
((SELECT id FROM ingredients WHERE name_key='nuoc_mam'), 'vi', 'Nước mắm'),
((SELECT id FROM ingredients WHERE name_key='nuoc_mam'), 'en', 'Fish sauce'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'vi', 'Đường'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'en', 'Sugar'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'vi', 'Muối'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'en', 'Salt');


INSERT IGNORE INTO dish_ingredients (dish_id, ingredient_id, quantity) VALUES
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bot_gao'), '200g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bot_nang'), '30g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tom_tuoi'), '300g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_la'), '100g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_tim'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='nuoc_mam'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='duong'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='muoi'), '');


INSERT IGNORE INTO instructions (dish_id, step_number, image_url) VALUES
(@dish_id, 1, 'https://cdn.tgdd.vn/Files/2017/03/21/963426/cach-lam-banh-beo-thom-ngon-202110041640526577.jpg'),
(@dish_id, 2, 'https://cdn.tgdd.vn/Files/2017/03/21/963426/cach-lam-banh-beo-thom-ngon-202110041641109870.jpg'),
(@dish_id, 3, 'https://cdn.tgdd.vn/Files/2017/03/21/963426/cach-lam-banh-beo-thom-ngon-202110041637174991.jpg'),
(@dish_id, 4, 'https://cdn.tgdd.vn/Files/2017/03/21/963426/cach-lam-banh-beo-thom-ngon-202110041638285554.jpg'),
(@dish_id, 5, 'https://cdn.tgdd.vn/Files/2017/03/21/963426/cach-lam-banh-beo-thom-ngon-202110041638494814.jpg');
SET @step1_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 1 LIMIT 1);
SET @step2_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 2 LIMIT 1);
SET @step3_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 3 LIMIT 1);
SET @step4_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 4 LIMIT 1);
SET @step5_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 5 LIMIT 1);

INSERT IGNORE INTO instruction_translations (instruction_id, language_code, description) VALUES
(@step1_id, 'vi', 'Bột gạo và bột năng, trộn đều lại với nhau. Sau đó, cho nước lọc vào và khuấy tan. Bạn có thể thêm một xíu muối cùng với nước lọc. Sau khi khuấy, để bột nghỉ khoảng 4 tiếng.'),
(@step1_id, 'en', 'Mix rice flour and tapioca starch well. Then add water and stir until the flour dissolves. You can add a little salt with the water. After stirring well, let the dough rest for about 4 hours.'),
(@step2_id, 'vi', 'Sau 4 tiếng, bạn vớt bỏ phần nước trong trên mặt bột, bạn cho thêm một lượng nước nóng bằng với lượng nước trong bỏ đi. Cho nồi hấp lên bếp, sắp chén vào nồi. Thoa đều dầu vào chén. Khi chén nóng, bạn khuấy đều bột, và đổ lượng bột vừa đủ vào chén. Trong quá trình hấp, để đều lửa, để bánh chín đều và không bị sống bột. Khoảng 10 phút, khi bánh đổi sang màu trắng đục là bánh đã chín rồi nhé.'),
(@step2_id, 'en', 'After 4 hours, remove the clear water on the surface of the dough, add an amount of hot water equal to the amount of clear water removed. Put the steamer on the stove, arrange the bowls in the pot. Spread oil evenly on the bowls. When the bowls are hot, stir the dough, and pour enough flour into the bowls. During the steaming process, keep the heat steady so that the cake is cooked evenly and the dough is not undercooked. After about 10 minutes, when the cake turns opaque white, the cake is done.'),
(@step3_id, 'vi', 'Tôm tươi rửa sạch, luộc chín. Tôm chín, lột vỏ và giã hơi dập. Tiếp đó cho tôm đã giã lên chảo, xào với màu điều. Đến khi tôm khô và tơi ra là được. Hành lá rửa sạch, cắt nhỏ. Cho chảo lên bếp, khi chảo nóng cho dầu vào, khi dầu sôi, cho hành lá vào, trộn đều để làm mỡ hành. '),
(@step3_id, 'en', 'Wash and boil the fresh shrimp. Peel and crush the shrimp slightly. Then put the crushed shrimp in the pan and stir-fry with annatto oil. Until the shrimp is dry and fluffy. Wash and chop the green onions. Put the pan on the stove, when the pan is hot, add oil, when the oil boils, add the green onions and mix well to make scallion oil.'),
(@step4_id, 'vi', 'Lấy một lượng nhỏ nước luộc tôm, đun nóng lên để pha nước chấm. Khi nước sôi, cho thêm nước mắm, đường, nếm có vị đậm đà ngọt dịu là được. Cho ra chén, để lên trên vài lát ớt cắt mỏng.'),
(@step4_id, 'en', 'Take a small amount of shrimp broth, heat it up to make the dipping sauce. When the water boils, add fish sauce, sugar, taste until it has a rich and sweet taste. Pour into a bowl, top with a few thinly sliced ​​chili peppers.'),
(@step5_id, 'vi', 'Khi ăn chúng ta cho tôm khô, da heo phồng, một ít mỡ hành lên trên bánh. Kèm theo chén nước chấm ớt, sẽ thơm ngon vô cùng nhé!'),
(@step5_id, 'en', 'When eating, we put dried shrimp, puffed pork skin, and a little scallion oil on top of the cake. Served with a bowl of chili dipping sauce, it will be extremely delicious!');

