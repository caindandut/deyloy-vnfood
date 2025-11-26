
USE vnfood;

INSERT IGNORE INTO dishes (class_id, image_url) VALUES (2, 'https://cdn.tgdd.vn/Files/2022/05/31/1436004/cach-lam-banh-can-mien-trung-don-gian-chuan-vi-que-huong-202205310707582924.jpg');
SET @dish_id = (SELECT id FROM dishes WHERE class_id = 2);
INSERT IGNORE INTO dish_translations (dish_id, language_code, name, description) VALUES
(@dish_id, 'vi', 'Bánh Căn', 'Bánh được nướng trong khuôn đất nung, làm từ bột gạo, thường có nhân trứng, tôm hoặc mực, ăn kèm nước chấm.'),
(@dish_id, 'en', 'Banh Can (Mini Pancakes)', 'A small, savory pancake grilled in a terracotta mold, made from rice flour, often topped with egg, shrimp, or squid, served with a dipping sauce.');
INSERT IGNORE INTO ingredients (name_key) VALUES
('tom'),
('trung_cut'),
('bot_gao'),
('bot_nang'),
('du_du_bao_soi'),
('hanh_la_cat_nhuyen'),
('toi_bam'),
('hanh_tim_bam'),
('ot_bam'),
('bot_nghe'),
('giam'),
('nuoc_mam'),
('dau_an'),
('muoi'),
('duong'),
('tieu'),
('hat_nem'),
('giam_trang'),
('nuoc_cot_chanh');

INSERT IGNORE INTO ingredient_translations (ingredient_id, language_code, name) VALUES
((SELECT id FROM ingredients WHERE name_key='tom'), 'vi', 'Tôm'),
((SELECT id FROM ingredients WHERE name_key='tom'), 'en', 'Shrimp'),
((SELECT id FROM ingredients WHERE name_key='trung_cut'), 'vi', 'Trứng cút'),
((SELECT id FROM ingredients WHERE name_key='trung_cut'), 'en', 'Quail eggs'),
((SELECT id FROM ingredients WHERE name_key='bot_gao'), 'vi', 'Bột gạo'),
((SELECT id FROM ingredients WHERE name_key='bot_gao'), 'en', 'Rice flour'),
((SELECT id FROM ingredients WHERE name_key='bot_nang'), 'vi', 'Bột năng'),
((SELECT id FROM ingredients WHERE name_key='bot_nang'), 'en', 'Tapioca starch'),
((SELECT id FROM ingredients WHERE name_key='du_du_bao_soi'), 'vi', 'Đu đủ bào sợi'),
((SELECT id FROM ingredients WHERE name_key='du_du_bao_soi'), 'en', 'Shredded papaya'),
((SELECT id FROM ingredients WHERE name_key='hanh_la_cat_nhuyen'), 'vi', 'Hành lá cắt nhuyễn'),
((SELECT id FROM ingredients WHERE name_key='hanh_la_cat_nhuyen'), 'en', 'Chopped scallions'),
((SELECT id FROM ingredients WHERE name_key='toi_bam'), 'vi', 'Tỏi băm'),
((SELECT id FROM ingredients WHERE name_key='toi_bam'), 'en', 'Minced garlic'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim_bam'), 'vi', 'Hành tím băm'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim_bam'), 'en', 'Minced shallots'),
((SELECT id FROM ingredients WHERE name_key='ot_bam'), 'vi', 'Ớt băm'),
((SELECT id FROM ingredients WHERE name_key='ot_bam'), 'en', 'Chopped chili'),
((SELECT id FROM ingredients WHERE name_key='bot_nghe'), 'vi', 'Bột nghệ'),
((SELECT id FROM ingredients WHERE name_key='bot_nghe'), 'en', 'Turmeric powder'),
((SELECT id FROM ingredients WHERE name_key='giam'), 'vi', 'Giấm'),
((SELECT id FROM ingredients WHERE name_key='giam'), 'en', 'Vinegar'),
((SELECT id FROM ingredients WHERE name_key='nuoc_mam'), 'vi', 'Nước mắm'),
((SELECT id FROM ingredients WHERE name_key='nuoc_mam'), 'en', 'Fish sauce'),
((SELECT id FROM ingredients WHERE name_key='dau_an'), 'vi', 'Dầu ăn'),
((SELECT id FROM ingredients WHERE name_key='dau_an'), 'en', 'Cooking oil'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'vi', 'Muối'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'en', 'Salt'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'vi', 'Đường'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'en', 'Sugar'),
((SELECT id FROM ingredients WHERE name_key='tieu'), 'vi', 'Tiêu'),
((SELECT id FROM ingredients WHERE name_key='tieu'), 'en', 'Pepper'),
((SELECT id FROM ingredients WHERE name_key='hat_nem'), 'vi', 'Hạt nêm'),
((SELECT id FROM ingredients WHERE name_key='hat_nem'), 'en', 'Seasoning powder'),
((SELECT id FROM ingredients WHERE name_key='giam_trang'), 'vi', 'Giấm trắng'),
((SELECT id FROM ingredients WHERE name_key='giam_trang'), 'en', 'White vinegar'),
((SELECT id FROM ingredients WHERE name_key='nuoc_cot_chanh'), 'vi', 'Nước cốt chanh'),
((SELECT id FROM ingredients WHERE name_key='nuoc_cot_chanh'), 'en', 'Lime juice');

INSERT IGNORE INTO dish_ingredients (dish_id, ingredient_id, quantity) VALUES
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tom'), '200g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='trung_cut'), '10 quả'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bot_gao'), '200g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bot_nang'), '100g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='du_du_bao_soi'), '100g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_la_cat_nhuyen'), '20g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='toi_bam'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_tim_bam'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='ot_bam'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bot_nghe'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='giam'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='nuoc_mam'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='dau_an'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='muoi'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='duong'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tieu'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hat_nem'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='giam_trang'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='nuoc_cot_chanh'), '');

INSERT IGNORE INTO instructions (dish_id, step_number, image_url) VALUES
(@dish_id, 1, 'https://cdn.tgdd.vn/Files/2022/05/31/1436004/cach-lam-banh-can-mien-trung-don-gian-chuan-vi-que-huong-202205310711257063.jpg'),
(@dish_id, 2, 'https://cdn.tgdd.vn/Files/2022/05/31/1436004/cach-lam-banh-can-mien-trung-don-gian-chuan-vi-que-huong-202205310711552239.jpg'),
(@dish_id, 3, 'https://cdn.tgdd.vn/Files/2022/05/31/1436004/cach-lam-banh-can-mien-trung-don-gian-chuan-vi-que-huong-202205310712050007.jpg'),
(@dish_id, 4, 'https://cdn.tgdd.vn/Files/2022/05/31/1436004/cach-lam-banh-can-mien-trung-don-gian-chuan-vi-que-huong-202205310712216203.jpg'),
(@dish_id, 5, 'https://cdn.tgdd.vn/Files/2022/05/31/1436004/cach-lam-banh-can-mien-trung-don-gian-chuan-vi-que-huong-202205310712377207.jpg'),
(@dish_id, 6, 'https://cdn.tgdd.vn/Files/2022/05/31/1436004/cach-lam-banh-can-mien-trung-don-gian-chuan-vi-que-huong-202205310712504242.jpg');

SET @step1_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 1 LIMIT 1);
SET @step2_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 2 LIMIT 1);
SET @step3_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 3 LIMIT 1);
SET @step4_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 4 LIMIT 1);
SET @step5_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 5 LIMIT 1);
SET @step6_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 6 LIMIT 1);
INSERT IGNORE INTO instruction_translations (instruction_id, language_code, description) VALUES
(@step1_id, 'vi', 'Đầu tiên, bạn cho vào một tô lớn 200g bột gạo, 100g bột năng, 1 muỗng cà phê bột nghệ, 1 muỗng cà phê hạt nêm, 1 muỗng cà phê muối, ½ muỗng cà phê hạt tiêu và 450ml nước, khuấy đều để hỗn hợp hòa quyện với nhau rồi cho tiếp khoảng 20g hành lá cắt nhuyễn, khuấy nhẹ và để bột nghỉ 1 tiếng.'),
(@step1_id, 'en', 'First, put in a large bowl 200g rice flour, 100g tapioca starch, 1 teaspoon turmeric powder, 1 teaspoon seasoning powder, 1 teaspoon salt, ½ teaspoon pepper and 450ml water, stir well to combine the mixture, then add about 20g chopped green onions, stir gently and let the dough rest for 1 hour.'),
(@step2_id, 'vi', 'Kế tiếp, bạn đem 200g tôm đi rửa sạch với nước lạnh, vớt ra để ráo, đem bỏ phần đầu và vỏ tôm đi rồi dùng dao rạch phần sống lưng để rút chỉ đen trên lưng tôm. Sau đó, bạn tiến hành ướp tôm với 1 muỗng cà phê hạt nêm, 1 muỗng cà phê đường, 1 muỗng cà phê nước mắm, ½ muỗng cà phê tiêu, 1 muỗng cà phê hành tím băm, 1 muỗng cà phê tỏi băm, trộn đều và để tôm trong ngăn mát tủ lạnh khoảng 30 phút.'),
(@step2_id, 'en', 'Next, wash 200g of shrimp with cold water, drain, remove the head and shell of the shrimp, then use a knife to cut the back to remove the black thread on the back of the shrimp. Then, marinate the shrimp with 1 teaspoon of seasoning powder, 1 teaspoon of sugar, 1 teaspoon of fish sauce, ½ teaspoon of pepper, 1 teaspoon of minced shallots, 1 teaspoon of minced garlic, mix well and leave the shrimp in the refrigerator for about 30 minutes.'),
(@step3_id, 'vi', 'Bước tiếp theo, bạn cho lần lượt vào chén 2 muỗng canh giấm trắng và 2 muỗng canh đường, khuấy đều để hỗn hợp tan với nhau rồi cho tiếp 100g đu đủ bào sợi vào chén, sau đó để như vậy khoảng 1 tiếng để đu đủ ngấm đều gia vị. '),
(@step3_id, 'en', 'Next step, add 2 tablespoons of white vinegar and 2 tablespoons of sugar to the bowl, stir well to dissolve the mixture, then add 100g of shredded papaya to the bowl, then leave it like that for about 1 hour to let the papaya absorb the spices.'),
(@step4_id, 'vi', 'Để làm nước mắm chua ngọt ăn kèm với bánh căn, bạn cho lần lượt vào chén 10 muỗng canh nước mắm, 10 muỗng canh đường, 20 muỗng canh nước lọc, 1 muỗng canh nước cốt chanh, 1 muỗng canh ớt băm và 1 muỗng canh tỏi băm, sau đó khuấy đều hỗn hợp nước mắm chua ngọt.'),
(@step4_id, 'en', 'To make the sweet and sour fish sauce to eat with banh can, you sequentially add to the bowl 10 tablespoons of fish sauce, 10 tablespoons of sugar, 20 tablespoons of filtered water, 1 tablespoon of lime juice, 1 tablespoon of chopped chili and 1 tablespoon of minced garlic, then stir the sweet and sour fish sauce mixture well.'),
(@step5_id, 'vi', 'Bắc loại chảo có khuôn để đổ bánh căn lên bếp, sau đó bạn cho ngập dầu ăn vào các khuôn bánh trong chảo và đun dầu nóng ở mức lửa nhỏ. Khi dầu đã sôi, bạn cho lần lượt vào các khuôn phần bột đã pha ở trên, trứng cút được đập vỡ và 1 - 2 con tôm, đậy nắp rồi tiếp tục chiên bánh trong khoảng 2 phút. Khi mở nắp ra, bạn chiên bánh căn thêm khoảng 2 phút nữa, đến khi bánh vàng đều và tôm lẫn trứng cút đều đã chín hết thì bạn gắp bánh ra dĩa có lót giấy thấm dầu.'),
(@step5_id, 'en', 'Place the pan with the molds for the banh can on the stove, then you fill the molds in the pan with cooking oil and heat the oil on low heat. When the oil is boiling, you put the above mixed batter, the broken quail eggs and 1-2 shrimp into the molds, cover and continue to fry the cake for about 2 minutes. When you open the lid, you fry the banh can for about 2 more minutes, until the cake is golden brown and the shrimp and quail eggs are cooked, then you take the cake out and put it on a plate lined with oil-absorbing paper.'),
(@step6_id, 'vi', 'Bên cạnh việc bổ sung đầy đủ dinh dưỡng cần thiết từ các nguyên liệu khác nhau, món bánh căn sau khi chế biến xong còn sẽ mang hương vị giòn rụm của lớp vỏ, sự tươi ngon, ngọt thịt của phần nhân tôm cũng như là vị bùi bùi, béo béo từ trứng cút, khiến bạn phải ngất ngây mà ăn mãi không ngừng được đó!'),
(@step6_id, 'en', 'Besides providing all the necessary nutrients from different ingredients, the finished banh can dish will also have the crispy taste of the crust, the freshness and sweetness of the shrimp filling as well as the rich, fatty taste of quail eggs, making you ecstatic and unable to stop eating!');