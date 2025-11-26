
USE vnfood;

INSERT IGNORE INTO dishes (class_id, image_url) VALUES (6, 'https://cdn.tgdd.vn/Files/2021/08/03/1372652/cach-lam-banh-duc-nong-ngon-khong-dung-voi-va-han-the-202201051626183294.jpg');
SET @dish_id = (SELECT id FROM dishes WHERE class_id = 6);
INSERT IGNORE INTO dish_translations (dish_id, language_code, name, description) VALUES
(@dish_id, 'vi', 'Bánh Đúc', 'Bánh làm từ bột gạo, có thể có thêm lạc. Thường ăn nguội, chấm với tương bần hoặc ăn nóng với canh riêu, thịt băm.'),
(@dish_id, 'en', 'Banh Duc (Rice Cake)', 'A cake made from rice flour, sometimes with peanuts. Often eaten cool with fermented tofu sauce or served hot with a savory topping.');
INSERT IGNORE INTO ingredients (name_key) VALUES
('bot_gao_te'),
('bot_nang'),
('nuoc'),
('muoi'),
('dau_an'),
('dau_me'),
('thit_lon'),
('moc_nhi'),
('nam_huong'),
('hanh_la'),
('nuoc_mam'),
('chanh'),
('duong'),
('tieu'),
('toi'),
('ot'),
('rau_mui'),
('hanh_tim');

INSERT IGNORE INTO ingredient_translations (ingredient_id, language_code, name) VALUES
((SELECT id FROM ingredients WHERE name_key='bot_gao_te'), 'vi', 'Bột gạo tẻ'),
((SELECT id FROM ingredients WHERE name_key='bot_gao_te'), 'en', 'Rice flour'),
((SELECT id FROM ingredients WHERE name_key='bot_nang'), 'vi', 'Bột năng'),
((SELECT id FROM ingredients WHERE name_key='bot_nang'), 'en', 'Tapioca starch'),
((SELECT id FROM ingredients WHERE name_key='nuoc'), 'vi', 'Nước'),
((SELECT id FROM ingredients WHERE name_key='nuoc'), 'en', 'Water'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'vi', 'Muối'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'en', 'Salt'),
((SELECT id FROM ingredients WHERE name_key='dau_an'), 'vi', 'Dầu ăn'),
((SELECT id FROM ingredients WHERE name_key='dau_an'), 'en', 'Cooking oil'),
((SELECT id FROM ingredients WHERE name_key='dau_me'), 'vi', 'Dầu mè'),
((SELECT id FROM ingredients WHERE name_key='dau_me'), 'en', 'Sesame oil'),
((SELECT id FROM ingredients WHERE name_key='thit_lon'), 'vi', 'Thịt lợn'),
((SELECT id FROM ingredients WHERE name_key='thit_lon'), 'en', 'Pork'),
((SELECT id FROM ingredients WHERE name_key='moc_nhi'), 'vi', 'Mộc nhĩ'),
((SELECT id FROM ingredients WHERE name_key='moc_nhi'), 'en', 'Wood ear mushroom'),
((SELECT id FROM ingredients WHERE name_key='nam_huong'), 'vi', 'Nấm hương'),
((SELECT id FROM ingredients WHERE name_key='nam_huong'), 'en', 'Shiitake mushroom'),
((SELECT id FROM ingredients WHERE name_key='hanh_la'), 'vi', 'Hành lá'),
((SELECT id FROM ingredients WHERE name_key='hanh_la'), 'en', 'Scallions'),
((SELECT id FROM ingredients WHERE name_key='nuoc_mam'), 'vi', 'Nước mắm'),
((SELECT id FROM ingredients WHERE name_key='nuoc_mam'), 'en', 'Fish sauce'),
((SELECT id FROM ingredients WHERE name_key='chanh'), 'vi', 'Chanh'),
((SELECT id FROM ingredients WHERE name_key='chanh'), 'en', 'Lime'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'vi', 'Đường'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'en', 'Sugar'),
((SELECT id FROM ingredients WHERE name_key='tieu'), 'vi', 'Tiêu'),
((SELECT id FROM ingredients WHERE name_key='tieu'), 'en', 'Pepper'),
((SELECT id FROM ingredients WHERE name_key='toi'), 'vi', 'Tỏi'),
((SELECT id FROM ingredients WHERE name_key='toi'), 'en', 'Garlic'),
((SELECT id FROM ingredients WHERE name_key='ot'), 'vi', 'Ớt'),
((SELECT id FROM ingredients WHERE name_key='ot'), 'en', 'Chili'),
((SELECT id FROM ingredients WHERE name_key='rau_mui'), 'vi', 'Rau mùi'),
((SELECT id FROM ingredients WHERE name_key='rau_mui'), 'en', 'Coriander'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim'), 'vi', 'Hành tím'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim'), 'en', 'Shallots');

INSERT IGNORE INTO dish_ingredients (dish_id, ingredient_id, quantity) VALUES
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bot_gao_te'), '100g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bot_nang'), '100g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='nuoc'), '600ml'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='muoi'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='dau_an'), '30ml'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='dau_me'), '15ml'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='thit_lon'), '200g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='moc_nhi'), '10g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='nam_huong'), '10g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_la'), '20g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='nuoc_mam'), '50ml'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='chanh'), '50 ml'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='duong'), '50g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='muoi'), '3g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tieu'), '3g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='toi'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='ot'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='rau_mui'), '100g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_tim'), '100g');

INSERT IGNORE INTO instructions (dish_id, step_number, image_url) VALUES
(@dish_id, 1, 'https://cdn.tgdd.vn/Files/2021/08/03/1372652/cach-lam-banh-duc-nong-ngon-khong-dung-voi-va-han-the-202108030850217612.jpg'),
(@dish_id, 2, 'https://cdn.tgdd.vn/Files/2021/08/03/1372652/cach-lam-banh-duc-nong-ngon-khong-dung-voi-va-han-the-202108030853346650.jpg'),
(@dish_id, 3, 'https://cdn.tgdd.vn/Files/2021/08/03/1372652/cach-lam-banh-duc-nong-ngon-khong-dung-voi-va-han-the-202108030853568740.jpg'),
(@dish_id, 4, 'https://cdn.tgdd.vn/Files/2021/08/03/1372652/cach-lam-banh-duc-nong-ngon-khong-dung-voi-va-han-the-202108030854227320.jpg'),
(@dish_id, 5, 'https://cdn.tgdd.vn/Files/2021/08/03/1372652/cach-lam-banh-duc-nong-ngon-khong-dung-voi-va-han-the-202108030854424290.jpg'),
(@dish_id, 6, 'https://cdn.tgdd.vn/Files/2021/08/03/1372652/cach-lam-banh-duc-nong-ngon-khong-dung-voi-va-han-the-202108030855163040.jpg');
SET @step1_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 1 LIMIT 1);
SET @step2_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 2 LIMIT 1);
SET @step3_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 3 LIMIT 1);
SET @step4_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 4 LIMIT 1);
SET @step5_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 5 LIMIT 1);
SET @step6_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 6 LIMIT 1);

INSERT IGNORE INTO instruction_translations (instruction_id, language_code, description) VALUES
(@step1_id, 'vi', 'Pha bột Đầu tiên bạn cho 100g bột gạo tẻ, 100g bột năng, ¼ muỗng cà phê muối và 600ml nước vào một cái nồi lớn và khuấy đều cho tan hết rồi lọc qua rây để tránh bột bị vón cục. Sau đó bạn để yên hỗn hợp này trong vòng 1 – 1.5 giờ cho bột lắng xuống đáy. Khi hỗn hợp bột đã lắng xuống đáy thì bạn đổ đi phần nước trên mặt rồi lại thêm vào đúng lượng nước đã đổ đi và lại khuấy đều.'),
(@step1_id, 'en', 'Mix the dough First, put 100g of rice flour, 100g of tapioca starch, ¼ teaspoon of salt and 600ml of water into a large pot and stir until dissolved, then strain through a sieve to avoid lumps. Then let the mixture sit for 1-1.5 hours for the flour to settle to the bottom. When the flour mixture has settled to the bottom, pour out the water on top, then add the same amount of water and stir again.'),
(@step2_id, 'vi', 'Nấu bột Bạn bắc hỗn hợp bột đã ngâm lên bếp và dùng phới hay cây đánh trứng (để bột nhanh mịn) khuấy đều, liên tục trên lửa vừa cho đến khi bột bắt đầu đặc sệt lại thì bạn hạ nhỏ lửa và tiếp tục khuấy để tránh bột dưới đáy nồi bị cháy nhé. Bạn khuấy đến khi thấy nặng tay là bột đã đặc (càng đặc càng hạ nhỏ lửa) và ngả màu trắng đục thì thêm vào 30ml dầu ăn và 15ml dầu mè, tiếp tục khuấy đều đến khi bột mịn và hỗn hợp trở nên dính, dẻo, có thể kéo thành sợi. Nếu bạn cảm thấy hỗn hợp quá đặc so với sở thích của mình thì bạn có thể thêm nước. Sau đó bạn khuấy đều tay ở mức lửa nhỏ nhất trong 5 - 10 phút đến khi bột chuyển sang màu trong; nếm thấy không còn mùi bột sống, dẻo quánh và nâng phới lên thì bột bị đứt đoạn, như vậy là bột đã chín. Bạn tắt bếp và vẫn để hé vung tránh mặt trên của nồi bột bị khô nhé.'),
(@step2_id, 'en', 'Place the soaked flour mixture on the stove and use a whisk or egg beater (to make the batter smooth quickly) to stir it evenly and continuously over medium heat until the batter starts to thicken. Then, lower the heat and continue stirring to prevent the batter at the bottom of the pot from burning. Stir until your hand feels heavy, indicating the batter is thick (lower the heat even more as it thickens) and has turned milky white. At this point, add 30ml of cooking oil and 15ml of sesame oil, then continue stirring evenly until the batter is smooth and the mixture becomes sticky, elastic, and can be pulled into strands. If you find the mixture too thick for your preference, you can add some water. After that, stir steadily at the lowest heat setting for 5–10 minutes until the batter turns transparent; taste it and there no raw flour smell, it sticky and viscous, and when you lift the whisk, the batter breaks off in segments—that means it fully cooked. Turn off the heat and keep the lid slightly ajar to prevent the top surface of the batter in the pot from drying out.'),
(@step3_id, 'vi', 'Sơ chế nguyên liệu làm phần thịt ăn kèm Bạn ngâm các loại nấm khô (mộc nhĩ, nấm hương) trong nước ấm cho nhanh nở với thời gian khoảng 10 – 15 phút; sau đó rửa sạch, cắt bỏ phần chân cứng và băm nhỏ. Tiếp tục rửa sạch thịt lợn và băm nhuyễn, còn hành lá thì bạn rửa sạch rồi loại bỏ các phần thừa và băm nhỏ. Còn hành tím thì bạn bóc vỏ và thái lát, rau mùi rửa sạch thái nhỏ, tỏi, ớt rửa sạch, bóc vỏ và băm nhỏ là được nhé.'),
(@step3_id, 'en', 'Prepare the ingredients for the side dish Soak the dried mushrooms (wood ear mushrooms, shiitake mushrooms) in warm water to quickly expand for about 10-15 minutes; then wash, cut off the hard stem and chop finely. Continue to wash the pork and chop finely, wash the green onions, remove the excess parts and chop finely. Peel and slice the shallots, wash and chop the coriander, wash the garlic and chili, peel and chop finely.'),
(@step4_id, 'vi', ' Xào thịt, phi hành khô Bạn cho chút dầu ăn vào nồi và phi thơm hành lá trên lửa vừa, sau đó cho các nguyên liệu như thịt băm, nấm hương, mộc nhĩ vào xào săn và nêm gia vị cho vừa khẩu vị của gia đình bạn và tắt bếp nhé. Đối với hành tím thì phi trên dầu nóng đến khi vàng nhạt thì vớt ra để ráo dầu.'),
(@step4_id, 'en', 'Stir-fry meat, dry onion Put some cooking oil in the pot and sauté the green onions over medium heat, then add the ingredients such as minced meat, shiitake mushrooms, and wood ear mushrooms and stir-fry until fragrant and season to your family taste and turn off the stove. For the shallots, sauté in hot oil until light golden brown, then remove and drain.'),
(@step5_id, 'vi', 'Pha nước mắm Bạn cho vào bát bao gồm chanh, đường, nước theo tỉ lệ 1:1:1, khuấy tan đường rồi thêm từ từ nước mắm cho vừa khẩu vị của gia đình bạn. Sau đó bạn cho thêm tỏi và ớt băm vào.'),
(@step5_id, 'en', 'Mix fish sauce Put lemon, sugar, water in a bowl in a 1:1:1 ratio, dissolve the sugar and slowly add fish sauce to suit your family taste. Then add minced garlic and chili.'),
(@step6_id, 'vi', 'Vậy là chỉ sau 5 bước thôi là bạn đã có một chén bánh đúc nóng sánh mịn, nóng hổi thơm ngon rồi. Một chén đầy đủ topping thịt bằm, hành phi, nước mắm hấp dẫn, ngon mắt thì không thể nào chối từ được.'),
(@step6_id, 'en', 'So, after only 5 steps, you have a bowl of hot, smooth, hot and delicious banh duc. A bowl full of minced meat, fried onions, and attractive fish sauce is irresistible.');