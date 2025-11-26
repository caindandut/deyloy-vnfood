
USE vnfood;

INSERT IGNORE INTO dishes (class_id, image_url) VALUES (8, 'https://cdn.tgdd.vn/Files/2020/10/13/1298451/cach-lam-banh-khot-vang-uom-gion-rum-ca-tieng-ma-khong-can-khuon-202203212135419978.jpg');
SET @dish_id = (SELECT id FROM dishes WHERE class_id = 8);
INSERT IGNORE INTO dish_translations (dish_id, language_code, name, description) VALUES
(@dish_id, 'vi', 'Bánh Khọt', 'Loại bánh nhỏ, giòn rụm làm từ bột gạo, nước cốt dừa, có nhân tôm, được chiên trong khuôn, ăn kèm rau sống và nước mắm.'),
(@dish_id, 'en', 'Banh Khot (Mini Savory Pancakes)', 'Small, crispy pancakes made from rice flour and coconut milk, topped with shrimp, fried in a special mold, and served with herbs and dipping sauce.');
INSERT IGNORE INTO ingredients (name_key) VALUES
('bot_gao'),
('bot_chien_gion'),
('bot_nghe'),
('nuoc_soda_khong_duong'),
('tom'),
('toi'),
('ot'),
('nuoc_cot_chanh'),
('duong'),
('muoi'),
('nuoc_mam');

INSERT IGNORE INTO ingredient_translations (ingredient_id, language_code, name) VALUES
((SELECT id FROM ingredients WHERE name_key='bot_gao'), 'vi', 'Bột gạo'),
((SELECT id FROM ingredients WHERE name_key='bot_gao'), 'en', 'Rice flour'),
((SELECT id FROM ingredients WHERE name_key='bot_chien_gion'), 'vi', 'Bột chiên giòn'),
((SELECT id FROM ingredients WHERE name_key='bot_chien_gion'), 'en', 'Tempura / Batter flour'),
((SELECT id FROM ingredients WHERE name_key='bot_nghe'), 'vi', 'Bột nghệ'),
((SELECT id FROM ingredients WHERE name_key='bot_nghe'), 'en', 'Turmeric powder'),
((SELECT id FROM ingredients WHERE name_key='nuoc_soda_khong_duong'), 'vi', 'Nước soda không đường'),
((SELECT id FROM ingredients WHERE name_key='nuoc_soda_khong_duong'), 'en', 'Unsweetened soda water'),
((SELECT id FROM ingredients WHERE name_key='tom'), 'vi', 'Tôm'),
((SELECT id FROM ingredients WHERE name_key='tom'), 'en', 'Shrimp'),
((SELECT id FROM ingredients WHERE name_key='toi'), 'vi', 'Tỏi'),
((SELECT id FROM ingredients WHERE name_key='toi'), 'en', 'Garlic'),
((SELECT id FROM ingredients WHERE name_key='ot'), 'vi', 'Ớt'),
((SELECT id FROM ingredients WHERE name_key='ot'), 'en', 'Chili'),
((SELECT id FROM ingredients WHERE name_key='nuoc_cot_chanh'), 'vi', 'Nước cốt chanh'),
((SELECT id FROM ingredients WHERE name_key='nuoc_cot_chanh'), 'en', 'Lime juice'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'vi', 'Đường'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'en', 'Sugar'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'vi', 'Muối'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'en', 'Salt'),
((SELECT id FROM ingredients WHERE name_key='nuoc_mam'), 'vi', 'Nước mắm'),
((SELECT id FROM ingredients WHERE name_key='nuoc_mam'), 'en', 'Fish sauce');

INSERT IGNORE INTO dish_ingredients (dish_id, ingredient_id, quantity) VALUES
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bot_gao'), '200g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bot_chien_gion'), '100g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bot_nghe'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='nuoc_soda_khong_duong'), '470ml'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tom'), '400g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='toi'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='ot'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='nuoc_cot_chanh'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='duong'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='muoi'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='nuoc_mam'), '');


INSERT IGNORE INTO instructions (dish_id, step_number, image_url) VALUES
(@dish_id, 1, 'https://cdn.tgdd.vn/Files/2020/10/13/1298451/cach-lam-banh-khot-vang-uom-gion-rum-ca-tieng-ma-khong-can-khuon-202010131033563007.jpg'),
(@dish_id, 2, 'https://cdn.tgdd.vn/Files/2020/10/13/1298451/cach-lam-banh-khot-vang-uom-gion-rum-ca-tieng-ma-khong-can-khuon-202010131034267833.jpg'),
(@dish_id, 3, 'https://cdn.tgdd.vn/Files/2020/10/13/1298451/cach-lam-banh-khot-vang-uom-gion-rum-ca-tieng-ma-khong-can-khuon-202010131035510443.jpg'),
(@dish_id, 4, 'https://cdn.tgdd.vn/Files/2020/10/13/1298451/cach-lam-banh-khot-vang-uom-gion-rum-ca-tieng-ma-khong-can-khuon-202010131036381884.jpg'),
(@dish_id, 5, 'https://cdn.tgdd.vn/Files/2020/10/13/1298451/cach-lam-banh-khot-vang-uom-gion-rum-ca-tieng-ma-khong-can-khuon-202010131036590167.jpg'),
(@dish_id, 6, 'https://cdn.tgdd.vn/Files/2020/10/13/1298451/cach-lam-banh-khot-vang-uom-gion-rum-ca-tieng-ma-khong-can-khuon-202010131037202559.jpg');


SET @step1_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 1 LIMIT 1);
SET @step2_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 2 LIMIT 1);
SET @step3_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 3 LIMIT 1);
SET @step4_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 4 LIMIT 1);
SET @step5_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 5 LIMIT 1);
SET @step6_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 6 LIMIT 1);

INSERT IGNORE INTO instruction_translations (instruction_id, language_code, description) VALUES
(@step1_id, 'vi', 'Sơ chế nguyên liệu Bạn chuẩn bị 1 chiếc tô sau đó bỏ bột gạo, bột chiên giòn, muối, bột nghệ và nước soda vào khuấy đều sau đó để bột vào trong tủ lạnh để bột nghỉ khoảng 30 phút. Bỏ tôm vào tô và thêm vào 1 muỗng cà phê bột tỏi trộn đều.'),
(@step1_id, 'en', 'Prepare the ingredients Prepare a bowl, then add rice flour, fried flour, salt, turmeric powder and soda water, stir well, then put the dough in the refrigerator to rest for about 30 minutes. Put the shrimp in the bowl and add 1 teaspoon of garlic powder, mix well.'),
(@step2_id, 'vi', 'Pha nước mắm Bạn cho vào chén nhỏ 1 muỗng canh đường cát, 3 muỗng canh nước ấm (để pha cho đường nhanh tan) dùng muỗng khuấy cho đường tan tiếp đến cho vào 1 muỗng canh nước mắm, ⅔ muỗng canh nước cốt chanh, cuối cùng cho thêm tỏi, ớt băm nhuyễn và trộn đều.'),
(@step2_id, 'en', 'Mix fish sauce In a small bowl, add 1 tablespoon of sugar, 3 tablespoons of warm water (to mix so the sugar dissolves quickly), stir with a spoon until the sugar dissolves, then add 1 tablespoon of fish sauce, ⅔ tablespoon of lemon juice, finally add minced garlic and chili and mix well.'),
(@step3_id, 'vi', ' Đổ bánh khọt Để đổ bánh khọt nếu như bạn không có khuôn thì bạn có thể dùng những chiếc cupcy bằng silicon để an toàn bạn nên chọn khuôn chất lượng bạn nên đọc kỹ xem khuôn có thể chịu đựng được nhiệt độ bao nhiêu độ C cũng như nên chọn mua khuôn chuyên dùng để nấu ăn. Bây giờ bạn lấy tô bột ra khỏi tủ lạnh dùng muỗng khuấy đều. Bạn chia bột làm 2: Một nửa bột bạn cho vào từng khuôn sau đó một số chiếc khuôn thì bạn cho tôm vào luôn, còn một số chiếc khuôn khác thì bạn sẽ cho tôm vào sau. Một nửa bột thì bạn thêm chút hành lá vào để bánh thêm màu sắc và tăng hương vị.'),
(@step3_id, 'en', 'Pouring Banh Khot To pour Banh Khot if you do not have a mold, you can use silicone cups for safety. You should choose a quality mold. You should read carefully to see how many degrees Celsius the mold can withstand and should choose to buy a mold specifically for cooking. Now take the bowl of dough out of the fridge and stir it well with a spoon. Divide the dough into 2: Put half of the dough into each mold, then put the shrimp in some molds right away, and put the shrimp in some other molds later. Add some green onions to the other half of the dough to add color and flavor to the cake.'),
(@step4_id, 'vi', ' Nướng bánh Bạn bỏ phần bánh đã đổ vào trong lò nướng ở nhiệt độ 200 độ C lửa trên và lửa dưới nướng khoảng 6 phút, sau đó bạn lấy bánh ra bạn sẽ thấy khuôn có tôm bột còn lỏng, bạn tiếp tục bỏ phần bánh này vào nướng thêm vài phút để bánh cứng lại, còn khuôn mà không có tôm thì bột đã khô lại nhưng bề mặt vẫn còn hơi ướt thì bạn lấy bánh ra đĩa.'),
(@step4_id, 'en', 'Bake the cake You put the poured cake into the oven at 200 degrees Celsius, top and bottom heat, bake for about 6 minutes, then you take the cake out and you will see the mold with the shrimp batter is still liquid, you continue to put this cake in to bake for a few more minutes to harden the cake, and the mold without shrimp, the batter has dried but the surface is still a bit wet, then you take the cake out on a plate.'),
(@step5_id, 'vi', 'Chiên bánh Bạn bắc lên bếp 1 chảo dầu đun cho dầu nóng sau đó bỏ bánh khọt vào chiên, bánh khọt không có tôm thì bạn đặt thêm 1 con tôm, tôm sẽ dính vào mặt bánh, lấy phần bánh khọt có tôm ở trong lò nướng ra và chiên cùng. Chiên với lửa vừa để bánh vàng thơm, cuối cùng khi bánh vàng thì bạn gắp ra giấy thấm dầu.'),
(@step5_id, 'en', 'Frying the cake You put a pan of oil on the stove, heat the oil then put the banh khot in to fry, if the banh khot does not have shrimp, you add 1 shrimp, the shrimp will stick to the surface of the cake, take the part of the banh khot with shrimp out of the oven and fry it together. Fry over medium heat until the cake is golden brown, finally when the cake is golden brown, you take it out and put it on oil-absorbing paper.'),
(@step6_id, 'vi', 'Thành phẩm Bạn bày bánh khọt ra đĩa, bánh khọt giòn tan, với màu vàng cực kỳ bắt mắt chấm chung với nước mắm chua ngọt đảm bảo ai cũng thích mê.'),
(@step6_id, 'en', 'Finished product You put the banh khot on a plate, the banh khot is crispy, with an extremely eye-catching golden color, dipped in sweet and sour fish sauce, guaranteed everyone will love it.');