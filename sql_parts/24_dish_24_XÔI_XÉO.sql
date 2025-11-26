
USE vnfood;

INSERT IGNORE INTO dishes (class_id, image_url) VALUES (24, 'https://cdn.tgdd.vn/Files/2022/11/17/1487645/cach-nau-xoi-xeo-ngo-thom-ngon-deo-dep-mat-cho-bua-sang-202211171330393361.jpg');
SET @dish_id = (SELECT id FROM dishes WHERE class_id = 24);
INSERT IGNORE INTO dish_translations (dish_id, language_code, name, description) VALUES
(@dish_id, 'vi', 'Xôi Xéo', 'Món xôi ăn sáng đặc trưng của Hà Nội. Xôi được đồ từ gạo nếp với bột nghệ, ăn kèm đỗ xanh giã nhuyễn, hành phi và chan một chút mỡ gà.'),
(@dish_id, 'en', 'Mung Bean Sticky Rice', 'A signature breakfast sticky rice from Hanoi. The rice is steamed with turmeric, served with mashed mung bean, fried shallots, and a drizzle of chicken fat.');
INSERT IGNORE INTO ingredients (name_key) VALUES
('gao_nep'), ('dau_xanh_tach_vo'), ('bap_nep'), ('nghe_tuoi'),
('nuoc_vo_trong'), ('hanh_phi'), ('muoi');

INSERT IGNORE INTO ingredient_translations (ingredient_id, language_code, name) VALUES
((SELECT id FROM ingredients WHERE name_key='gao_nep'), 'vi', 'Gạo nếp'),
((SELECT id FROM ingredients WHERE name_key='gao_nep'), 'en', 'Sticky rice'),
((SELECT id FROM ingredients WHERE name_key='dau_xanh_tach_vo'), 'vi', 'Đậu xanh tách vỏ'),
((SELECT id FROM ingredients WHERE name_key='dau_xanh_tach_vo'), 'en', 'Shelled mung beans'),
((SELECT id FROM ingredients WHERE name_key='bap_nep'), 'vi', 'Bắp nếp'),
((SELECT id FROM ingredients WHERE name_key='bap_nep'), 'en', 'Sweet corn'),
((SELECT id FROM ingredients WHERE name_key='nghe_tuoi'), 'vi', 'Nghệ tươi'),
((SELECT id FROM ingredients WHERE name_key='nghe_tuoi'), 'en', 'Fresh turmeric'),
((SELECT id FROM ingredients WHERE name_key='nuoc_vo_trong'), 'vi', 'Nước vôi trong'),
((SELECT id FROM ingredients WHERE name_key='nuoc_vo_trong'), 'en', 'Lime water'),
((SELECT id FROM ingredients WHERE name_key='hanh_phi'), 'vi', 'Hành phi'),
((SELECT id FROM ingredients WHERE name_key='hanh_phi'), 'en', 'Fried shallots'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'vi', 'Muối'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'en', 'Salt');

INSERT IGNORE INTO dish_ingredients (dish_id, ingredient_id, quantity) VALUES
(@dish_id, (SELECT id FROM ingredients WHERE name_key='gao_nep'), '500g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='dau_xanh_tach_vo'), '150g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bap_nep'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='nghe_tuoi'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='nuoc_vo_trong'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_phi'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='muoi'), ' ');

INSERT IGNORE INTO instructions (dish_id, step_number, image_url) VALUES
(@dish_id, 1, 'https://cdn.tgdd.vn/Files/2022/11/17/1487645/cach-nau-xoi-xeo-ngo-thom-ngon-deo-dep-mat-cho-bua-sang-202211171348054272.jpg'),
(@dish_id, 2, 'https://cdn.tgdd.vn/Files/2022/11/17/1487645/cach-nau-xoi-xeo-ngo-thom-ngon-deo-dep-mat-cho-bua-sang-202211171348249621.jpg'),
(@dish_id, 3, 'https://cdn.tgdd.vn/Files/2022/11/17/1487645/cach-nau-xoi-xeo-ngo-thom-ngon-deo-dep-mat-cho-bua-sang-202211171348531927.jpg'),
(@dish_id, 4, 'https://cdn.tgdd.vn/Files/2022/11/17/1487645/cach-nau-xoi-xeo-ngo-thom-ngon-deo-dep-mat-cho-bua-sang-202211171349317191.jpg'),
(@dish_id, 5, 'https://cdn.tgdd.vn/Files/2022/11/17/1487645/cach-nau-xoi-xeo-ngo-thom-ngon-deo-dep-mat-cho-bua-sang-202211171349585361.jpg'),
(@dish_id, 6, 'https://cdn.tgdd.vn/Files/2022/11/17/1487645/cach-nau-xoi-xeo-ngo-thom-ngon-deo-dep-mat-cho-bua-sang-202211171350195717.jpg');

SET @step1_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 1 LIMIT 1);
SET @step2_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 2 LIMIT 1);
SET @step3_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 3 LIMIT 1);
SET @step4_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 4 LIMIT 1);
SET @step5_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 5 LIMIT 1);
SET @step6_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 6 LIMIT 1);

INSERT IGNORE INTO instruction_translations (instruction_id, language_code, description) VALUES
(@step1_id, 'vi', 'Sơ chế nguyên liệu Đậu xanh và nếp vo sơ với nước 1-2 lần cho sạch bụi. Nghệ xay nhuyễn vắt lấy nước. Ngô tách lấy hạt, sau đó ngâm trong nước vô trong 15 phút.'),
(@step1_id, 'en', 'Preliminary processing of ingredients Rinse mung beans and sticky rice with water 1-2 times to remove dust. Grind turmeric and squeeze to get the juice. Separate corn kernels, then soak in water for 15 minutes.'),
(@step2_id, 'vi', 'Ngâm đậu xanh và nếp Đậu xanh sau khi vo thì đổ nước vừa ngập đậu và ngâm trong 6 tiếng. Pha nước nghệ vừa vắt với nước, rồi cho nếp vào ngâm 6 tiếng. Dùng nghệ ngâm nếp sẽ giúp nếp mau mềm và thơm hơn.'),
(@step2_id, 'en', 'soaking green beans and sticky rice After washing the green beans, pour in enough water to cover the beans and soak for 6 hours. Mix the freshly squeezed turmeric juice with water, then add the sticky rice and soak for 6 hours. Using turmeric to soak the sticky rice will help the sticky rice soften faster and become more fragrant.'),
(@step3_id, 'vi', 'Hấp và nghiền đậu xanh Đậu xanh và nếp vo sơ với nước 1-2 lần cho sạch bụi. Nghệ xay nhuyễn vắt lấy nước. Ngô tách lấy hạt, sau đó ngâm trong nước vô trong 15 phút. Sau khi ngâm 6 tiếng thì vớt đậu ra và tiến hành hấp. Cho đậu xanh vào xửng hấp và hấp trong 15 phút là đậu chín. Cho đậu xanh vừa hấp vào cối rồi dùng chày giã nhuyễn. Có thể vò thành cục to hoặc để rời cũng được. Nếu vò thành cục thì vò xong cắt thành từng miếng nhỏ.'),
(@step3_id, 'en', 'Steam and grind green beans Rinse green beans and sticky rice with water 1-2 times to remove dust. Grind turmeric and squeeze out the water. Separate the corn kernels, then soak in water for 15 minutes. After soaking for 6 hours, take out the beans and steam. Put the green beans in a steamer and steam for 15 minutes until the beans are cooked. Put the steamed green beans in a mortar and pound them with a pestle. You can knead them into large lumps or leave them as separate pieces. If kneaded into lumps, cut them into small pieces after kneading.'),
(@step4_id, 'vi', ' Hấp ngô Ngô ngâm nước vôi trong xong thì rửa 2-3 lần với nước cho hết mùi vôi. Tiếp theo cho ngô vào xửng và hấp trong 20 phút.'),
(@step4_id, 'en', 'Steamed Corn After soaking the corn in lime water, rinse it 2-3 times with water to remove the lime smell. Next, put the corn in a steamer and steam for 20 minutes.'),
(@step5_id, 'vi', ' Hấp nếp Rửa sạch nếp đã ngâm với nước và để ráo. Phần ngô hấp chín rồi thì cho vô chung với nếp và thêm ít muối sau đó trộn đều rồi cho vào xửng tiến hành hấp trong 25 phút. Hấp được 25 phút thì mở nắp và cho 1 muỗng dầu ăn và trộn đều. Nếu có mỡ heo hay mỡ gà thì sẽ ngon và thơm hơn so với dùng dầu ăn. Tiếp tục nấu trong 2 phút nữa để dầu được thấm đều vào xôi rồi tắt bếp. Lúc này xôi đã chín rồi đấy.'),
(@step5_id, 'en', 'Steamed Sticky Rice Wash the soaked sticky rice with water and drain. Add the cooked corn to the sticky rice and add a little salt, mix well and steam for 25 minutes. After 25 minutes of steaming, open the lid and add 1 tablespoon of cooking oil and mix well. If you have pork fat or chicken fat, it will be more delicious and fragrant than using cooking oil. Continue cooking for another 2 minutes so that the oil is absorbed into the sticky rice and then turn off the stove. The sticky rice is now cooked.'),
(@step6_id, 'vi', ' Thành phẩm Vậy là món xôi xéo ngô đã hoàn thành rồi, lấy xôi ra đĩa rồi cho phần đậu xanh lên trên và cho thêm ít hành phi lên mặt và thưởng thức thôi nào.'),
(@step6_id, 'en', 'Finished product So the sticky rice with corn is done, take the sticky rice out on a plate, put the green beans on top and add some fried onions on top and enjoy.');