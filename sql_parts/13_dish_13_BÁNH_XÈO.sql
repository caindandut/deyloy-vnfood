
USE vnfood;

INSERT IGNORE INTO dishes (class_id, image_url) VALUES (13, 'https://cdn.tgdd.vn/2021/04/CookProduct/1200-1200x676-70.jpg');
SET @dish_id = (SELECT id FROM dishes WHERE class_id = 13);
INSERT IGNORE INTO dish_translations (dish_id, language_code, name, description) VALUES
(@dish_id, 'vi', 'Bánh Xèo', 'Bánh có lớp vỏ vàng, giòn rụm làm từ bột gạo và bột nghệ, nhân tôm, thịt, giá đỗ, được chiên trên chảo lớn.'),
(@dish_id, 'en', 'Banh Xeo (Crispy Pancake)', 'A crispy, savory pancake made from rice flour and turmeric, filled with shrimp, pork, and bean sprouts, fried in a large skillet.');
INSERT IGNORE INTO ingredients (name_key) VALUES
('bot_gao_kho'), ('bot_nghe'), ('thit_lon'), ('tom'), ('bia'), ('nam_huong'), ('hanh_tay'),
('gia_do'), ('rau_song'), ('muoi'), ('duong'), ('tieu'), ('hanh_tim'), ('gung'), ('hanh_la');

INSERT IGNORE INTO ingredient_translations (ingredient_id, language_code, name) VALUES
((SELECT id FROM ingredients WHERE name_key='bot_gao_kho'), 'vi', 'Bột gạo khô'),
((SELECT id FROM ingredients WHERE name_key='bot_gao_kho'), 'en', 'Rice flour'),
((SELECT id FROM ingredients WHERE name_key='bot_nghe'), 'vi', 'Bột nghệ'),
((SELECT id FROM ingredients WHERE name_key='bot_nghe'), 'en', 'Turmeric powder'),
((SELECT id FROM ingredients WHERE name_key='thit_lon'), 'vi', 'Thịt lợn'),
((SELECT id FROM ingredients WHERE name_key='thit_lon'), 'en', 'Pork'),
((SELECT id FROM ingredients WHERE name_key='tom'), 'vi', 'Tôm'),
((SELECT id FROM ingredients WHERE name_key='tom'), 'en', 'Shrimp'),
((SELECT id FROM ingredients WHERE name_key='bia'), 'vi', 'Bia'),
((SELECT id FROM ingredients WHERE name_key='bia'), 'en', 'Beer'),
((SELECT id FROM ingredients WHERE name_key='nam_huong'), 'vi', 'Nấm hương'),
((SELECT id FROM ingredients WHERE name_key='nam_huong'), 'en', 'Shiitake mushroom'),
((SELECT id FROM ingredients WHERE name_key='hanh_tay'), 'vi', 'Hành tây'),
((SELECT id FROM ingredients WHERE name_key='hanh_tay'), 'en', 'Onion'),
((SELECT id FROM ingredients WHERE name_key='gia_do'), 'vi', 'Giá đỗ'),
((SELECT id FROM ingredients WHERE name_key='gia_do'), 'en', 'Bean sprouts'),
((SELECT id FROM ingredients WHERE name_key='rau_song'), 'vi', 'Rau sống'),
((SELECT id FROM ingredients WHERE name_key='rau_song'), 'en', 'Raw vegetables / herbs'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'vi', 'Muối'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'en', 'Salt'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'vi', 'Đường'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'en', 'Sugar'),
((SELECT id FROM ingredients WHERE name_key='tieu'), 'vi', 'Tiêu'),
((SELECT id FROM ingredients WHERE name_key='tieu'), 'en', 'Pepper'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim'), 'vi', 'Hành tím'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim'), 'en', 'Shallot'),
((SELECT id FROM ingredients WHERE name_key='gung'), 'vi', 'Gừng'),
((SELECT id FROM ingredients WHERE name_key='gung'), 'en', 'Ginger'),
((SELECT id FROM ingredients WHERE name_key='hanh_la'), 'vi', 'Hành lá'),
((SELECT id FROM ingredients WHERE name_key='hanh_la'), 'en', 'Green onion');

INSERT IGNORE INTO dish_ingredients (dish_id, ingredient_id, quantity) VALUES
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bot_gao_kho'), '200g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bot_nghe'), '10g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='thit_lon'), '200g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tom'), '200g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bia'), '100ml'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='nam_huong'), '30g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_tay'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='gia_do'), '100g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='rau_song'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='muoi'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='duong'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tieu'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_tim'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='gung'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_la'), ' ');

INSERT IGNORE INTO instructions (dish_id, step_number, image_url) VALUES
(@dish_id, 1, 'https://cdn.tgdd.vn/Files/2020/05/20/1256908/troi-mua-thu-lam-banh-xeo-kieu-mien-bac-gion-ngon-it-dau-mo-202005201032077748.jpg'),
(@dish_id, 2, 'https://cdn.tgdd.vn/Files/2020/05/20/1256908/troi-mua-thu-lam-banh-xeo-kieu-mien-bac-gion-ngon-it-dau-mo-202005201032216299.jpg'),
(@dish_id, 3, 'https://cdn.tgdd.vn/Files/2020/05/20/1256908/troi-mua-thu-lam-banh-xeo-kieu-mien-bac-gion-ngon-it-dau-mo-202005201032337113.jpg');


SET @step1_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 1 LIMIT 1);
SET @step2_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 2 LIMIT 1);
SET @step3_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 3 LIMIT 1);
INSERT IGNORE INTO instruction_translations (instruction_id, language_code, description) VALUES
(@step1_id, 'vi', 'Sơ chế nguyên liệu Tôm sau khi mua về rửa sạch, cắt râu, sau đó ướp tôm với một muỗng cà phê muối, 1 muỗng cà phê gừng giã ra trong 15-20 phút. Thịt heo rửa sạch với muối sau đó đem thái mỏng. Ướp thịt heo với 1 muỗng canh nước mắm, 1 muỗng cà phê bột ngọt, ½ muỗng cà phê tiêu và để trong 15-20 phút cho thịt thấm gia vị. Rửa sạch và cắt nhỏ hành lá, hành tây, giá và các loại rau.'),
(@step1_id, 'en', 'Prepare the ingredients After buying the shrimp, wash it, cut off the whiskers, then marinate it with 1 teaspoon of salt, 1 teaspoon of crushed ginger for 15-20 minutes. Wash the pork with salt then slice it thinly. Marinate the pork with 1 tablespoon of fish sauce, 1 teaspoon of MSG, ½ teaspoon of pepper and leave it for 15-20 minutes for the meat to absorb the spices. Wash and chop the green onions, onions, bean sprouts and other vegetables.'),
(@step2_id, 'vi', ' Làm vỏ bánh xèo và xào nhân bánh Để pha bột làm bánh xèo, bạn trộn 200gr bột gạo, 10gr bột nghệ, 250ml nước lọc, 100ml bia, 1 muỗng cà phê muối với hành lá băm lại, khuấy bột cho thật đều tay để bột tan hết. Bạn có thể cho thêm vào bột bánh một chút dầu ăn, khi bạn đổ bánh xèo, bánh sẽ dễ tróc ra và đẹp hơn. Bắc chảo dầu lên bếp và cho vào 2 muỗng dầu ăn, phi hành tím cho thơm. Sau đó, cho tôm, thịt, nấm hương vào xào cho đến khi săn lại, cho thêm hành tây vào đảo đều. Khi hành tây hơi chuyển màu, bạn nêm nếm cho vừa ăn rồi tắt bếp.'),
(@step2_id, 'en', 'Make the pancake crust and stir-fry the filling To mix the pancake batter, mix 200g of rice flour, 10g of turmeric powder, 250ml of water, 100ml of beer, 1 teaspoon of salt with chopped green onions, stir the batter well until the flour is completely dissolved. You can add a little cooking oil to the batter, when you pour the pancake, the pancake will be easier to peel and look more beautiful. Put the pan on the stove and add 2 tablespoons of cooking oil, fry the shallots until fragrant. Then, add the shrimp, meat, and shiitake mushrooms and stir-fry until they are firm, add the onions and stir-fry well. When the onions change color slightly, season to taste and turn off the stove.'),
(@step3_id, 'vi', 'Đổ bánh xèo Bắc chảo lên bếp và cho vào một lớp dầu mỏng. Sau khi dầu nóng, bạn múc muỗng canh bột vừa và tráng đều chảo. Hãy đổ một lớp bột vừa phải đủ để tráng hết mặt chảo nhưng đừng quá dày vì lớp bột dày làm bánh xèo không còn được giòn nữa. Sau đó, bạn chiên từ từ với lửa nhỏ để nước trong bột bốc hơi đi, thì bánh xèo của chúng ta sẽ giòn ngon vô cùng, hãy thử tham khảo mẹo làm bánh xèo giòn nhé! Sau đó, cho thêm một ít nhân và giá vào. Để lửa nhỏ, đợi khoảng 2 phút cho vỏ bánh khô giòn rồi bạn gấp đôi bánh lại hong thêm một chút và để bánh ra dĩa.'),
(@step3_id, 'en', 'Pour the pancakes Place the pan on the stove and add a thin layer of oil. Once the oil is hot, scoop a tablespoon of batter and spread it evenly in the pan. Pour a layer of batter that is enough to cover the entire pan, but not too thick because a thick layer of batter will make the pancakes less crispy. Then, fry slowly over low heat so that the water in the batter evaporates, then our pancakes will be extremely crispy and delicious. Try to refer to the tips for making crispy pancakes! Then, add a little filling and bean sprouts. Keep the heat low, wait about 2 minutes for the crust to dry and crisp, then fold the pancake in half and let it dry a little more and put it on a plate.')');
