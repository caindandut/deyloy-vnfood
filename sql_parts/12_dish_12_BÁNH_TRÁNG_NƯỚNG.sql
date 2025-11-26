
USE vnfood;

INSERT IGNORE INTO dishes (class_id, image_url) VALUES (12, 'https://cdn.tgdd.vn/Files/2017/03/12/960051/cach-lam-banh-trang-nuong-ngon-cuc-nhanh-voi-chao-chong-dinh-202201051016161312.jpg');
SET @dish_id = (SELECT id FROM dishes WHERE class_id = 12);
INSERT IGNORE INTO dish_translations (dish_id, language_code, name, description) VALUES
(@dish_id, 'vi', 'Bánh Tráng Nướng', 'Được mệnh danh là "pizza Việt Nam", là một món ăn đường phố gồm bánh tráng, trứng, mỡ hành, tép khô, và các loại topping khác nướng trên bếp than.'),
(@dish_id, 'en', 'Vietnamese Pizza (Grilled Rice Paper)', 'Dubbed "Vietnamese Pizza," this is a street food snack made of rice paper, egg, scallions, dried shrimp, and other toppings grilled over charcoal.');
INSERT IGNORE INTO ingredients (name_key) VALUES
('banh_trang'), ('thit_heo_bam'), ('xuc_xich'), ('tep_say_kho'), ('trung_ga'), ('hanh_la'),
('tieu'), ('sa_te'), ('bo_thuc_vat'), ('mayonnaise'), ('tuong_ot');

INSERT IGNORE INTO ingredient_translations (ingredient_id, language_code, name) VALUES
((SELECT id FROM ingredients WHERE name_key='banh_trang'), 'vi', 'Bánh tráng'),
((SELECT id FROM ingredients WHERE name_key='banh_trang'), 'en', 'Rice paper'),
((SELECT id FROM ingredients WHERE name_key='thit_heo_bam'), 'vi', 'Thịt heo băm'),
((SELECT id FROM ingredients WHERE name_key='thit_heo_bam'), 'en', 'Minced pork'),
((SELECT id FROM ingredients WHERE name_key='xuc_xich'), 'vi', 'Xúc xích'),
((SELECT id FROM ingredients WHERE name_key='xuc_xich'), 'en', 'Sausage'),
((SELECT id FROM ingredients WHERE name_key='tep_say_kho'), 'vi', 'Tép sấy khô'),
((SELECT id FROM ingredients WHERE name_key='tep_say_kho'), 'en', 'Dried shrimp'),
((SELECT id FROM ingredients WHERE name_key='trung_ga'), 'vi', 'Trứng gà'),
((SELECT id FROM ingredients WHERE name_key='trung_ga'), 'en', 'Egg'),
((SELECT id FROM ingredients WHERE name_key='hanh_la'), 'vi', 'Hành lá'),
((SELECT id FROM ingredients WHERE name_key='hanh_la'), 'en', 'Green onion'),
((SELECT id FROM ingredients WHERE name_key='tieu'), 'vi', 'Tiêu'),
((SELECT id FROM ingredients WHERE name_key='tieu'), 'en', 'Pepper'),
((SELECT id FROM ingredients WHERE name_key='sa_te'), 'vi', 'Sa tế'),
((SELECT id FROM ingredients WHERE name_key='sa_te'), 'en', 'Sate sauce'),
((SELECT id FROM ingredients WHERE name_key='bo_thuc_vat'), 'vi', 'Bơ thực vật'),
((SELECT id FROM ingredients WHERE name_key='bo_thuc_vat'), 'en', 'Margarine'),
((SELECT id FROM ingredients WHERE name_key='mayonnaise'), 'vi', 'Mayonnaise'),
((SELECT id FROM ingredients WHERE name_key='mayonnaise'), 'en', 'Mayonnaise'),
((SELECT id FROM ingredients WHERE name_key='tuong_ot'), 'vi', 'Tương ớt'),
((SELECT id FROM ingredients WHERE name_key='tuong_ot'), 'en', 'Chili sauce');

INSERT IGNORE INTO dish_ingredients (dish_id, ingredient_id, quantity) VALUES
(@dish_id, (SELECT id FROM ingredients WHERE name_key='banh_trang'), '5'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='thit_heo_bam'), '20g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='xuc_xich'), '3'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tep_say_kho'), '20g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='trung_ga'), '5'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_la'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tieu'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='sa_te'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bo_thuc_vat'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='mayonnaise'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tuong_ot'), ' ');
INSERT IGNORE INTO instructions (dish_id, step_number, image_url) VALUES
(@dish_id, 1, 'https://cdn.tgdd.vn/Files/2017/03/12/960051/cach-lam-banh-trang-nuong-ngon-cuc-nhanh-voi-chao-chong-dinh-201910072227457024.jpg'),
(@dish_id, 2, 'https://cdn.tgdd.vn/Files/2017/03/12/960051/cach-lam-banh-trang-nuong-ngon-cuc-nhanh-voi-chao-chong-dinh-201910072228011534.jpg'),
(@dish_id, 3, 'https://cdn.tgdd.vn/Files/2017/03/12/960051/cach-lam-banh-trang-nuong-ngon-bang-chao-chong-dinh-tai-nha-202205251048018113.jpg'),

SET @step1_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 1 LIMIT 1);
SET @step2_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 2 LIMIT 1);
SET @step3_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 3 LIMIT 1);
INSERT IGNORE INTO instruction_translations (instruction_id, language_code, description) VALUES
(@step1_id, 'vi', 'Sơ chế nguyên liệu Thịt bằm sau khi mua về các bạn xào qua với tiêu cho chín, không cần nêm thêm gia vị nào đâu bạn nhé! Xúc xích các bạn thái lát mỏng để khi nướng xúc xích dễ bám vào bánh tráng hơn. Hành lá thì bạn cắt nhuyễn để tăng thêm hương vị.'),
(@step1_id, 'en', 'Prepare the ingredients After buying the minced meat, stir-fry it with pepper until cooked, no need to add any spices! Slice the sausages thinly so that when grilled, they will stick to the rice paper more easily. Finely chop the green onions to enhance the flavor.'),
(@step2_id, 'vi', 'Nướng bánh tráng Bạn chọn một chiếc chảo không dính có lòng chảo để vừa bánh tráng. Làm nóng chảo rồi cho bánh tráng vào. Sau đó, bạn nhanh tay phết bơ lên mặt bánh. Tiếp tục cho 1 thìa thịt xào, 1 thìa tép khô, 1 thìa hành lá vào mặt bánh, thêm nửa thìa sa tế và 1 quả trứng gà rồi trộn đều cho các nguyên liệu hòa lẫn với nhau rồi dàn đều trên mặt bánh. Bạn tránh dàn sát rìa bánh tráng vì sẽ làm bánh bị co dúm, không đẹp nữa nhé!'),
(@step2_id, 'en', 'Grilling rice paper Choose a non-stick pan with a pan large enough to fit the rice paper. Heat the pan and put the rice paper in. Then, quickly spread butter on the surface of the cake. Continue to add 1 spoon of stir-fried meat, 1 spoon of dried shrimp, 1 spoon of green onion to the surface of the cake, add half a spoon of satay sauce and 1 egg, mix well to combine the ingredients and spread evenly on the surface of the cake. Avoid spreading it close to the edge of the rice paper because it will make the cake shrink and not look good anymore!'),
(@step3_id, 'vi', 'Thành phẩm Mở lửa lớn, nướng đến khi trứng gần đông lại thì bạn cho xúc xích cắt lát vào. Khi bánh tráng đã chín vàng và bong khỏi mặt chảo, bạn cho tương ớt và mayonnaise lên trên. Vậy là món bánh tráng nướng của chúng ta đã hoàn thành rồi!'),
(@step3_id, 'en', 'Finished product Turn on high heat, grill until the eggs are almost set, then add the sliced ​​sausages. When the rice paper is golden brown and peels off the pan, add the chili sauce and mayonnaise on top. Our grilled rice paper is done!');