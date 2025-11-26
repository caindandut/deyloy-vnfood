
USE vnfood;

INSERT IGNORE INTO dishes (class_id, image_url) VALUES (3, 'https://cdn.tgdd.vn/Files/2021/07/26/1370866/cach-nau-banh-canh-ca-loc-bot-gao-thom-ngon-doi-vi-cho-ca-nha-deu-me-202107261314191350.jpg');
SET @dish_id = (SELECT id FROM dishes WHERE class_id = 3);
INSERT IGNORE INTO dish_translations (dish_id, language_code, name, description) VALUES
(@dish_id, 'vi', 'Bánh Canh', 'Một món súp với sợi bánh to và dai (làm từ bột gạo hoặc bột lọc), nước dùng hầm từ xương, ăn kèm chả cá, thịt, giò heo.'),
(@dish_id, 'en', 'Banh Canh (Thick Noodle Soup)', 'A soup dish with thick, chewy noodles (made from rice flour or tapioca), a broth simmered from bones, served with fish cakes, pork, or pork hock.');
INSERT IGNORE INTO ingredients (name_key) VALUES
('banh_canh_bot_gao'),
('xuong_heo'),
('ca_loc'),
('re_va_goc_ngo'),
('ot_bam'),
('toi_bam'),
('hanh_tim_bam'),
('hanh_tim_cat_lat'),
('hanh_la_cat_nho'),
('cu_nen_bam'),
('dau_an'),
('nuoc_mam'),
('tieu'),
('duong'),
('hat_nem'),
('dau_dieu');

INSERT IGNORE INTO ingredient_translations (ingredient_id, language_code, name) VALUES
((SELECT id FROM ingredients WHERE name_key='banh_canh_bot_gao'), 'vi', 'Bánh canh bột gạo'),
((SELECT id FROM ingredients WHERE name_key='banh_canh_bot_gao'), 'en', 'Rice noodle soup (rice flour noodles)'),
((SELECT id FROM ingredients WHERE name_key='xuong_heo'), 'vi', 'Xương heo'),
((SELECT id FROM ingredients WHERE name_key='xuong_heo'), 'en', 'Pork bones'),
((SELECT id FROM ingredients WHERE name_key='ca_loc'), 'vi', 'Cá lóc'),
((SELECT id FROM ingredients WHERE name_key='ca_loc'), 'en', 'Snakehead fish'),
((SELECT id FROM ingredients WHERE name_key='re_va_goc_ngo'), 'vi', 'Rễ và gốc ngò'),
((SELECT id FROM ingredients WHERE name_key='re_va_goc_ngo'), 'en', 'Coriander roots and stems'),
((SELECT id FROM ingredients WHERE name_key='ot_bam'), 'vi', 'Ớt băm'),
((SELECT id FROM ingredients WHERE name_key='ot_bam'), 'en', 'Chopped chili'),
((SELECT id FROM ingredients WHERE name_key='toi_bam'), 'vi', 'Tỏi băm'),
((SELECT id FROM ingredients WHERE name_key='toi_bam'), 'en', 'Minced garlic'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim_bam'), 'vi', 'Hành tím băm'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim_bam'), 'en', 'Minced shallots'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim_cat_lat'), 'vi', 'Hành tím cắt lát'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim_cat_lat'), 'en', 'Sliced shallots'),
((SELECT id FROM ingredients WHERE name_key='hanh_la_cat_nho'), 'vi', 'Hành lá cắt nhỏ'),
((SELECT id FROM ingredients WHERE name_key='hanh_la_cat_nho'), 'en', 'Chopped scallions'),
((SELECT id FROM ingredients WHERE name_key='cu_nen_bam'), 'vi', 'Củ nén băm'),
((SELECT id FROM ingredients WHERE name_key='cu_nen_bam'), 'en', 'Minced shallot garlic (cu nen)'),
((SELECT id FROM ingredients WHERE name_key='dau_an'), 'vi', 'Dầu ăn'),
((SELECT id FROM ingredients WHERE name_key='dau_an'), 'en', 'Cooking oil'),
((SELECT id FROM ingredients WHERE name_key='nuoc_mam'), 'vi', 'Nước mắm'),
((SELECT id FROM ingredients WHERE name_key='nuoc_mam'), 'en', 'Fish sauce'),
((SELECT id FROM ingredients WHERE name_key='tieu'), 'vi', 'Tiêu'),
((SELECT id FROM ingredients WHERE name_key='tieu'), 'en', 'Pepper'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'vi', 'Đường'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'en', 'Sugar'),
((SELECT id FROM ingredients WHERE name_key='hat_nem'), 'vi', 'Hạt nêm'),
((SELECT id FROM ingredients WHERE name_key='hat_nem'), 'en', 'Seasoning powder'),
((SELECT id FROM ingredients WHERE name_key='dau_dieu'), 'vi', 'Dầu điều'),
((SELECT id FROM ingredients WHERE name_key='dau_dieu'), 'en', 'Annatto oil');

INSERT IGNORE INTO dish_ingredients (dish_id, ingredient_id, quantity) VALUES
(@dish_id, (SELECT id FROM ingredients WHERE name_key='banh_canh_bot_gao'), '100g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='xuong_heo'), '500g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='ca_loc'), '1kg'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='re_va_goc_ngo'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='ot_bam'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='toi_bam'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_tim_bam'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_tim_cat_lat'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_la_cat_nho'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='cu_nen_bam'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='dau_an'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='nuoc_mam'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tieu'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='duong'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hat_nem'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='dau_dieu'), '');

INSERT IGNORE INTO instructions (dish_id, step_number, image_url) VALUES
(@dish_id, 1, 'https://cdn.tgdd.vn/Files/2021/07/26/1370866/cach-nau-banh-canh-ca-loc-bot-gao-thom-ngon-doi-vi-cho-ca-nha-deu-me-202107261318396434.jpg'),
(@dish_id, 2, 'https://cdn.tgdd.vn/Files/2021/07/26/1370866/cach-nau-banh-canh-ca-loc-bot-gao-thom-ngon-doi-vi-cho-ca-nha-deu-me-202107261320430990.jpg'),
(@dish_id, 3, 'https://cdn.tgdd.vn/Files/2021/07/26/1370866/cach-nau-banh-canh-ca-loc-bot-gao-thom-ngon-doi-vi-cho-ca-nha-deu-me-202107261321144781.jpg'),
(@dish_id, 4, 'https://cdn.tgdd.vn/Files/2021/07/26/1370866/cach-nau-banh-canh-ca-loc-bot-gao-thom-ngon-doi-vi-cho-ca-nha-deu-me-202107261322581955.jpg'),
(@dish_id, 5, 'https://cdn.tgdd.vn/Files/2021/07/26/1370866/cach-nau-banh-canh-ca-loc-bot-gao-thom-ngon-doi-vi-cho-ca-nha-deu-me-202107261323389542.jpg'),
(@dish_id, 6, 'https://cdn.tgdd.vn/Files/2021/07/26/1370866/cach-nau-banh-canh-ca-loc-bot-gao-thom-ngon-doi-vi-cho-ca-nha-deu-me-202208251422171977.jpg');

SET @step1_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 1 LIMIT 1);
SET @step2_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 2 LIMIT 1);
SET @step3_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 3 LIMIT 1);
SET @step4_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 4 LIMIT 1);
SET @step5_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 5 LIMIT 1);
SET @step6_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 6 LIMIT 1);
INSERT IGNORE INTO instruction_translations (instruction_id, language_code, description) VALUES
(@step1_id, 'vi', 'Xương heo chúng ta mua về rồi rửa qua nước muối, rồi rửa lại với nước sạch. Sau đó, cho xương heo vào nồi luộc sợ trong khoảng 3 phút rồi vớt ra để khử bớt mùi tanh rồi vớt ra để ráo. Tiếp đến, bạn cho xương heo vào nồi, cho thêm 4-5 củ hành tím đập dập và 5-7 phần thân rễ cây ngò để cho nước sẽ có vị ngọt và thơm hơn. Bạn nên để bếp ở mức độ lửa vừa và nấu trong khoảng thời gian 45-50 phút.'),
(@step1_id, 'en', 'We buy pork bones, then wash them with salt water, then rinse them with clean water. Then, put the pork bones in a pot and boil for about 3 minutes, then take them out to reduce the fishy smell, then take them out to drain. Next, put the pork bones in the pot, add 4-5 crushed shallots and 5-7 parts of coriander roots to make the water sweeter and more fragrant. You should keep the stove at medium heat and cook for about 45-50 minutes.'),
(@step2_id, 'vi', 'Cá lóc khi bạn mua ở chợ hoặc siêu thị thì người ta đã làm sẵn, bạn chỉ cần dùng muối chà sát lên thân cá để khử đi mùi tanh rồi sửa lại với nước sạch. Tiếp đến, dùng dao cắt thịt từ phần đuôi lên đến đầu để tách phần xương và phần thịt. Xương cá bạn nên cắt thành 2-3 đoạn, thịt cá bạn nên cắt thành những miếng vừa ăn. Cho xương cá và thịt cá vào một cái tô, sau đó cho vào 1 muỗng canh nước mắm, 1 muỗng canh hạt nêm, 1 muỗng canh đường, ½ muỗng canh củ nén giã nhỏ, ½ muỗng canh tỏi băm, ½ muỗng canh tiêu, 1 muỗng canh ớt băm và 2 muỗng canh dầu điều rồi trộn đều hỗn hợp để cho cá thấm đều gia vị và để trong 20 phút.'),
(@step2_id, 'en', 'When you buy snakehead fish at the market or supermarket, they are already prepared. You just need to rub salt on the fish to remove the fishy smell and then rinse it with clean water.  Next, use a knife to cut the meat from the tail to the head to separate the bones and meat. You should cut the fish bones into 2-3 sections, and the fish meat should be cut into bite-sized pieces. Put the fish bones and fish meat in a bowl, then add 1 tablespoon of fish sauce, 1 tablespoon of seasoning powder, 1 tablespoon of sugar, ½ tablespoon of crushed shallots, ½ tablespoon of minced garlic, ½ tablespoon of pepper, 1 tablespoon of minced chili and 2 tablespoons of annatto oil, then mix well to let the fish absorb the spices and leave for 20 minutes.'),
(@step3_id, 'vi', 'Bạn cho phần đầu và xương cá vào hầm trong khoảng thời gian 15-20 phút vào chung với nồi hầm xương ở bước 1. Tiếp đến, bạn cho vào 1 muỗng canh đường, 1 muỗng canh hạt nêm và 1 muỗng canh nước mắm và khuấy nhẹ.'),
(@step3_id, 'en', 'Add the fish head and bones to the pot of bone stew in step 1 and simmer for 15-20 minutes. Next, add 1 tablespoon of sugar, 1 tablespoon of seasoning powder and 1 tablespoon of fish sauce and stir gently.'),
(@step4_id, 'vi', 'Bạn để một cái chảo lên bếp rồi cho vào 2 muỗng canh dầu ăn, dầu nóng bạn cho củ nén giã nhỏ, tỏi băm, hành tím băm, ớt băm vào chảo phi thơm. Tiếp đến, bạn cho cá đã ướp vào chảo xào cho đến khi cá săn lại. Sau đó, bạn cho vào chảo khoảng 200ml nước rồi hạ lửa bếp ở mức nhỏ để cho nước cá kẹo lại, gia vị ngấm vào thịt cá là đã hoàn thành xong bước 4.'),
(@step4_id, 'en', 'You put a pan on the stove and add 2 tablespoons of cooking oil, when the oil is hot, add crushed shallots, minced garlic, minced shallots, and minced chili into the pan and sauté until fragrant. Next, add the marinated fish to the pan and stir-fry until the fish is firm. Then, add about 200ml of water to the pan and lower the heat to low to let the fish juice thicken, the spices soak into the fish meat and you have completed step 4.'),
(@step5_id, 'vi', 'Bạn đun lại nồi nước leo cho sôi lên, sau đó cho lượng bánh canh vào nồi, nấu trong khoảng 5-7 phút để bánh canh vừa nở ra và có độ mềm là bánh canh đã chín.'),
(@step5_id, 'en', 'You boil the pot of water again, then add the noodles to the pot, cook for about 5-7 minutes until the noodles have just expanded and become soft, the noodles are done.'),
(@step6_id, 'vi', 'Tiếp đến, bạn tắt bếp rồi múc bánh canh ra tô, bỏ một ít cá lóc kho lên trên bề mặt bánh canh, cho thêm một ít hành lá cắt nhỏ vào tô nữa là xong.'),
(@step6_id, 'en', 'Next turn off the stove and scoop the noodles into a bowl, put some braised snakehead fish on top of the noodles, add some chopped green onions to the bowl and you done.');