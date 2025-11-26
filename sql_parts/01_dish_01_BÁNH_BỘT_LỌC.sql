
USE vnfood;

INSERT IGNORE INTO dishes (class_id, image_url) VALUES (1, 'https://cdn.tgdd.vn/Files/2021/09/07/1380725/cach-lam-banh-bot-loc-goi-la-chuoi-dai-ngon-khong-can-khuay-202109301937549626.jpg');
SET @dish_id = (SELECT id FROM dishes WHERE class_id = 1);
INSERT IGNORE INTO dish_translations (dish_id, language_code, name, description) VALUES
(@dish_id, 'vi', 'Bánh Bột Lọc', 'Bánh có vỏ ngoài trong suốt làm từ bột năng, nhân tôm thịt, thường được gói trong lá chuối và hấp chín.'),
(@dish_id, 'en', 'Tapioca Dumplings', 'Dumplings with a clear, chewy tapioca wrapper, filled with shrimp and pork, typically wrapped in banana leaves and steamed.');
INSERT IGNORE INTO ingredients (name_key) VALUES
('la_chuoi'),
('bot_nang'),
('tom'),
('thit_heo'),
('hanh_tim_xay'),
('toi_bam'),
('muoi'),
('tieu'),
('dau_an'),
('ot_bot_han_quoc'),
('hat_nem');

INSERT IGNORE INTO ingredient_translations (ingredient_id, language_code, name) VALUES
((SELECT id FROM ingredients WHERE name_key='la_chuoi'), 'vi', 'Lá chuối'),
((SELECT id FROM ingredients WHERE name_key='la_chuoi'), 'en', 'Banana leaf'),
((SELECT id FROM ingredients WHERE name_key='bot_nang'), 'vi', 'Bột năng'),
((SELECT id FROM ingredients WHERE name_key='bot_nang'), 'en', 'Tapioca starch'),
((SELECT id FROM ingredients WHERE name_key='tom'), 'vi', 'Tôm'),
((SELECT id FROM ingredients WHERE name_key='tom'), 'en', 'Shrimp'),
((SELECT id FROM ingredients WHERE name_key='thit_heo'), 'vi', 'Thịt heo'),
((SELECT id FROM ingredients WHERE name_key='thit_heo'), 'en', 'Pork'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim_xay'), 'vi', 'Hành tím xay nhuyễn'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim_xay'), 'en', 'Minced shallots'),
((SELECT id FROM ingredients WHERE name_key='toi_bam'), 'vi', 'Tỏi băm'),
((SELECT id FROM ingredients WHERE name_key='toi_bam'), 'en', 'Minced garlic'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'vi', 'Muối'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'en', 'Salt'),
((SELECT id FROM ingredients WHERE name_key='tieu'), 'vi', 'Tiêu'),
((SELECT id FROM ingredients WHERE name_key='tieu'), 'en', 'Pepper'),
((SELECT id FROM ingredients WHERE name_key='dau_an'), 'vi', 'Dầu ăn'),
((SELECT id FROM ingredients WHERE name_key='dau_an'), 'en', 'Cooking oil'),
((SELECT id FROM ingredients WHERE name_key='ot_bot_han_quoc'), 'vi', 'Ớt bột Hàn Quốc'),
((SELECT id FROM ingredients WHERE name_key='ot_bot_han_quoc'), 'en', 'Korean chili powder'),
((SELECT id FROM ingredients WHERE name_key='hat_nem'), 'vi', 'Hạt nêm'),
((SELECT id FROM ingredients WHERE name_key='hat_nem'), 'en', 'Seasoning powder');

INSERT IGNORE INTO dish_ingredients (dish_id, ingredient_id, quantity) VALUES
(@dish_id, (SELECT id FROM ingredients WHERE name_key='la_chuoi'), '1 gói'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bot_nang'), '400g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tom'), '300g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='thit_heo'), '300g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_tim_xay'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='toi_bam'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='muoi'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tieu'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='dau_an'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='ot_bot_han_quoc'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hat_nem'), '');

INSERT IGNORE INTO instructions (dish_id, step_number, image_url) VALUES
(@dish_id, 1, 'https://cdn.tgdd.vn/Files/2021/09/07/1380725/cach-lam-banh-bot-loc-goi-la-chuoi-dai-ngon-khong-can-khuay-202109301934087283.jpg'),
(@dish_id, 2, 'https://cdn.tgdd.vn/Files/2021/09/07/1380725/cach-lam-banh-bot-loc-goi-la-chuoi-dai-ngon-khong-can-khuay-202109301934194755.jpg'),
(@dish_id, 3, 'https://cdn.tgdd.vn/Files/2021/09/07/1380725/cach-lam-banh-bot-loc-goi-la-chuoi-dai-ngon-khong-can-khuay-202109301934328584.jpg'),
(@dish_id, 4, 'https://cdn.tgdd.vn/Files/2021/09/07/1380725/cach-lam-banh-bot-loc-goi-la-chuoi-dai-ngon-khong-can-khuay-202109301934453194.jpg'),
(@dish_id, 5, 'https://cdn.tgdd.vn/Files/2021/09/07/1380725/cach-lam-banh-bot-loc-goi-la-chuoi-dai-ngon-khong-can-khuay-202109301934596042.jpg'),
(@dish_id, 6, 'https://cdn.tgdd.vn/Files/2021/09/07/1380725/cach-lam-banh-bot-loc-goi-la-chuoi-dai-ngon-khong-can-khuay-202109301935159823.jpg'),
(@dish_id, 7, 'https://cdn.tgdd.vn/Files/2021/09/07/1380725/cach-lam-banh-bot-loc-goi-la-chuoi-dai-ngon-khong-can-khuay-202109301935290727.jpg');

SET @step1_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 1 LIMIT 1);
SET @step2_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 2 LIMIT 1);
SET @step3_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 3 LIMIT 1);
SET @step4_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 4 LIMIT 1);
SET @step5_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 5 LIMIT 1);
SET @step6_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 6 LIMIT 1);
SET @step7_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 7 LIMIT 1);
INSERT IGNORE INTO instruction_translations (instruction_id, language_code, description) VALUES
(@step1_id, 'vi', 'Lá chuối sau khi mua về bạn rửa sạch với nước, dùng khăn lau sạch rồi cắt lá chuối thành những khổ vuông có cạnh dài 17-20cm. Bạn bắc 1 chảo nước lên bếp, cho lá chuối vừa cắt vào luộc trong vòng 5 -7 phút, đợi nước sôi lên thì bạn tắt bếp, lấy lá chuối ra gấp thử. Nếu bạn không nghe tiếng gấp của lá chuối nữa là có thể vớt lá chuối ra. Luộc lá chuối xong, bạn dùng 1 cái khăn khô để lau lá chuối thêm 1 lần nữa nhé! 300g thịt heo bạn tiến hành rửa sạch, cắt nhỏ cỡ hạt lựu. 300g tôm bạn bỏ vỏ và đầu, lấy chỉ lưng và rửa sạch với nước.'),
(@step1_id, 'en', 'After buying banana leaves, wash them thoroughly with water, wipe them clean with a cloth, and cut them into square pieces about 17–20 cm on each side. Place a pan of water on the stove and bring it to a boil. Add the cut banana leaves and boil them for about 5–7 minutes. Once the water starts boiling, turn off the heat and take out the leaves. Fold one to check — if you don''t hear the crackling sound anymore, the leaves are ready to be removed. After boiling, use a dry towel to wipe the banana leaves again. For 300g of pork, wash it thoroughly and cut it into small dice-sized pieces. For 300g of shrimp, remove the shell and head, devein, and rinse well with water.'),
(@step2_id, 'vi', 'Bạn cho vào máy trộn bột 400g bột năng, 300ml nước sôi, 1 muỗng cà phê muối và bật công tắt cho máy trộn bột trong vòng 15-20 phút. Sau khi bột đã được trộn khá mịn, bạn lấy bột ra, cho 2 muỗng canh dầu ăn lên tay và tiến hành nhồi bột thêm một lát nữa để bột được mềm mịn hơn. Nhồi bột xong bạn lấy màng bọc thực phẩm để bọc bột lại để ủ trong 2-3 tiếng.'),
(@step2_id, 'en', 'Add 400g of tapioca starch, 300ml of boiling water, and 1 teaspoon of salt into the dough mixer, then turn it on to knead the dough for about 15–20 minutes. Once the dough becomes fairly smooth, remove it from the mixer, rub 2 tablespoons of cooking oil on your hands, and knead the dough a bit more to make it softer and smoother. After kneading, wrap the dough with plastic wrap and let it rest for 2–3 hours.'),
(@step3_id, 'vi', 'Bạn bỏ 300g tôm và 300g thịt vào 2 cái tô riêng, sau đó nêm vào mỗi tô 1 muỗng cà phê hành tím xay nhuyễn, 1 muỗng cà phê tỏi băm, 1 muỗng canh nước mắm, 1 muỗng cà phê tiêu, 1 muỗng cà phê ớt bột Hàn Quốc, 1 muỗng cà phê muối. Bạn trộn đều rồi để tôm và thịt được thấm gia vị trong khoảng 30 phút.'),
(@step3_id, 'en', 'Put 300g of shrimp and 300g of pork into two separate bowls. In each bowl, add 1 teaspoon of minced shallots, 1 teaspoon of minced garlic, 1 tablespoon of fish sauce, 1 teaspoon of pepper, 1 teaspoon of Korean chili powder, and 1 teaspoon of salt. Mix well and let the shrimp and pork marinate for about 30 minutes to absorb the seasonings.'),
(@step4_id, 'vi', 'Tiếp đến bạn bắc chảo lên bếp, cho vào 2 muỗng canh dầu ăn. Đợi dầu nóng bạn cho 1 muỗng canh tỏi và 1 muỗng canh hành tím băm vào phi thơm. Khi hành tỏi dậy mùi thơm bạn cho thịt heo vào xào trước. Đảo đều tay đến khi thịt heo săn lại và mỡ heo bắt đầu chuyển sang màu hơi trong thì bạn cho tôm vào xào chung. Bạn xào đến khi tôm chuyển sang màu đỏ thì nêm thêm 1 muỗng cà phê hạt nêm, đảo đều tay 1 lượt nữa rồi tắt bếp.'),
(@step4_id, 'en', 'Next, place a pan on the stove and add 2 tablespoons of cooking oil. When the oil is hot, add 1 tablespoon of minced garlic and 1 tablespoon of minced shallots, then sauté until fragrant. Once the garlic and shallots release their aroma, add the pork and stir-fry first. Keep stirring until the pork firms up and the fat becomes slightly translucent, then add the shrimp and continue stir-frying together. When the shrimp turns red, add 1 teaspoon of seasoning powder, give it one last stir, and then turn off the heat.'),
(@step5_id, 'vi', 'Bạn chia bột thành những phần bằng nhau và ép dẹt thật mỏng. Bạn nhẹ nhàng đặt 1 lượng nhân vừa đủ bao gồm tôm và thịt lên rồi gấp cho mép bánh dính chặt lại với nhau để khi luộc, nhân không bị rơi ra khỏi bánh. Khi đã gói nhân bánh vào trong toàn bộ phần vỏ bánh, bạn bắt đầu gói bánh vào lá chuối. Bạn quét 1 lớp dầu mỏng lên lá chuối, đặt 1 cái bánh bột lọc vào và gập lá chuối lại cho đến khi lá chuối bao phủ lên toàn bộ bánh.'),
(@step5_id, 'en', 'Divide the dough into equal portions and flatten each piece into a thin sheet. Gently place an adequate amount of filling—consisting of shrimp and pork—onto the dough, then fold it and press the edges firmly together to prevent the filling from falling out during boiling. Once all the fillings are wrapped inside the dough, start wrapping the cakes in banana leaves. Brush a thin layer of oil onto the banana leaf, place one cake on it, and fold the leaf until it completely covers the cake.'),
(@step6_id, 'vi', 'Bạn chuẩn bị 1 nồi hấp, xếp bánh lên xửng hấp rồi đổ nước vào, bạn tiến hành hấp bánh bột lọc trong vòng 15-20 phút. Sau 15 phút, bạn thử lấy 1 cái bánh ra, nếu bánh chuyển sang màu trong, ăn thử có vị ngọt, mềm thì bánh đã chín.'),
(@step6_id, 'en', 'Prepare a steamer, arrange the cakes on the steaming rack, and pour water into the pot. Steam the bánh bột lọc for about 15–20 minutes. After 15 minutes, take one cake out to check — if the wrapper turns translucent and the cake tastes slightly sweet and tender, it means the cakes are fully cooked.'),
(@step7_id, 'vi', 'Bánh bột lọc sau khi hấp chín, bạn bày ra dĩa để chuẩn bị thưởng thức cùng với 1 chút nước mắm chua ngọt. Bạn ăn ngay khi bánh còn nóng thì quả là tuyệt cú mèo luôn'),
(@step7_id, 'en', 'After steaming the banh bot loc, you arrange it on a plate to enjoy with a little sweet and sour fish sauce. You eat it while it''s still hot, it''s absolutely delicious.');