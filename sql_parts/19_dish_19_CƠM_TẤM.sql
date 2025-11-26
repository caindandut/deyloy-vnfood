
USE vnfood;

INSERT IGNORE INTO dishes (class_id, image_url) VALUES (19, 'https://cdn.tgdd.vn/Files/2021/08/16/1375565/cach-nau-com-tam-suon-bi-cha-tai-nha-ngon-nhu-ngoai-tiem-202108162216045436.jpg');
SET @dish_id = (SELECT id FROM dishes WHERE class_id = 19);
INSERT IGNORE INTO dish_translations (dish_id, language_code, name, description) VALUES
(@dish_id, 'vi', 'Cơm Tấm', 'Món ăn đặc trưng của Sài Gòn, gồm cơm nấu từ hạt gạo tấm, ăn kèm sườn nướng, bì, chả trứng, trứng ốp la, và chan nước mắm chua ngọt.'),
(@dish_id, 'en', 'Broken Rice', 'A Saigon specialty, consisting of rice from broken grains, served with grilled pork ribs, shredded pork skin, steamed egg-pork meatloaf, a fried egg, and sweet fish sauce.');
INSERT IGNORE INTO ingredients (name_key) VALUES
('suon_cot_lot_heo'), ('gao_tam'), ('gao_trang'), ('bi_heo'), ('trung_ga'),
('thit_nac_xay'), ('mien'), ('nam_meo_kho'), ('sa_nho'), ('toi_bam'),
('hanh_tim_bam'), ('ot_bam'), ('hanh_la'), ('ca_chua'), ('dua_leo'),
('ca_rot'), ('cu_cai_trang'),
('mat_ong'), ('nuoc_mam'), ('bot_ngot'), ('muoi'), ('dau_hao'), ('tieu_xay'),
('duong'), ('giam');

INSERT IGNORE INTO ingredient_translations (ingredient_id, language_code, name) VALUES
((SELECT id FROM ingredients WHERE name_key='suon_cot_lot_heo'), 'vi', 'Sườn cốt lết heo'),
((SELECT id FROM ingredients WHERE name_key='suon_cot_lot_heo'), 'en', 'Pork chop (bone-in)'),
((SELECT id FROM ingredients WHERE name_key='gao_tam'), 'vi', 'Gạo tấm'),
((SELECT id FROM ingredients WHERE name_key='gao_tam'), 'en', 'Broken rice'),
((SELECT id FROM ingredients WHERE name_key='gao_trang'), 'vi', 'Gạo trắng (làm thính)'),
((SELECT id FROM ingredients WHERE name_key='gao_trang'), 'en', 'White rice (for roasted rice powder)'),
((SELECT id FROM ingredients WHERE name_key='bi_heo'), 'vi', 'Bì heo'),
((SELECT id FROM ingredients WHERE name_key='bi_heo'), 'en', 'Pork skin shreds'),
((SELECT id FROM ingredients WHERE name_key='trung_ga'), 'vi', 'Trứng gà'),
((SELECT id FROM ingredients WHERE name_key='trung_ga'), 'en', 'Egg'),
((SELECT id FROM ingredients WHERE name_key='thit_nac_xay'), 'vi', 'Thịt nạc heo xay'),
((SELECT id FROM ingredients WHERE name_key='thit_nac_xay'), 'en', 'Ground lean pork'),
((SELECT id FROM ingredients WHERE name_key='mien'), 'vi', 'Miến'),
((SELECT id FROM ingredients WHERE name_key='mien'), 'en', 'Glass noodles'),
((SELECT id FROM ingredients WHERE name_key='nam_meo_kho'), 'vi', 'Nấm mèo khô'),
((SELECT id FROM ingredients WHERE name_key='nam_meo_kho'), 'en', 'Dried wood ear mushroom'),
((SELECT id FROM ingredients WHERE name_key='sa_nho'), 'vi', 'Sả nhỏ'),
((SELECT id FROM ingredients WHERE name_key='sa_nho'), 'en', 'Small lemongrass stalks'),
((SELECT id FROM ingredients WHERE name_key='toi_bam'), 'vi', 'Tỏi băm'),
((SELECT id FROM ingredients WHERE name_key='toi_bam'), 'en', 'Minced garlic'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim_bam'), 'vi', 'Hành tím băm'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim_bam'), 'en', 'Minced shallot'),
((SELECT id FROM ingredients WHERE name_key='ot_bam'), 'vi', 'Ớt băm'),
((SELECT id FROM ingredients WHERE name_key='ot_bam'), 'en', 'Minced chili'),
((SELECT id FROM ingredients WHERE name_key='hanh_la'), 'vi', 'Hành lá'),
((SELECT id FROM ingredients WHERE name_key='hanh_la'), 'en', 'Spring onion'),
((SELECT id FROM ingredients WHERE name_key='ca_chua'), 'vi', 'Cà chua'),
((SELECT id FROM ingredients WHERE name_key='ca_chua'), 'en', 'Tomato'),
((SELECT id FROM ingredients WHERE name_key='dua_leo'), 'vi', 'Dưa leo'),
((SELECT id FROM ingredients WHERE name_key='dua_leo'), 'en', 'Cucumber'),
((SELECT id FROM ingredients WHERE name_key='ca_rot'), 'vi', 'Cà rốt'),
((SELECT id FROM ingredients WHERE name_key='ca_rot'), 'en', 'Carrot'),
((SELECT id FROM ingredients WHERE name_key='cu_cai_trang'), 'vi', 'Củ cải trắng'),
((SELECT id FROM ingredients WHERE name_key='cu_cai_trang'), 'en', 'Daikon'),
((SELECT id FROM ingredients WHERE name_key='mat_ong'), 'vi', 'Mật ong'),
((SELECT id FROM ingredients WHERE name_key='mat_ong'), 'en', 'Honey'),
((SELECT id FROM ingredients WHERE name_key='nuoc_mam'), 'vi', 'Nước mắm'),
((SELECT id FROM ingredients WHERE name_key='nuoc_mam'), 'en', 'Fish sauce'),
((SELECT id FROM ingredients WHERE name_key='bot_ngot'), 'vi', 'Bột ngọt'),
((SELECT id FROM ingredients WHERE name_key='bot_ngot'), 'en', 'MSG'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'vi', 'Muối'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'en', 'Salt'),
((SELECT id FROM ingredients WHERE name_key='dau_hao'), 'vi', 'Dầu hào'),
((SELECT id FROM ingredients WHERE name_key='dau_hao'), 'en', 'Oyster sauce'),
((SELECT id FROM ingredients WHERE name_key='tieu_xay'), 'vi', 'Tiêu xay'),
((SELECT id FROM ingredients WHERE name_key='tieu_xay'), 'en', 'Ground pepper'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'vi', 'Đường'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'en', 'Sugar'),
((SELECT id FROM ingredients WHERE name_key='giam'), 'vi', 'Giấm'),
((SELECT id FROM ingredients WHERE name_key='giam'), 'en', 'Vinegar');

INSERT IGNORE INTO dish_ingredients (dish_id, ingredient_id, quantity) VALUES
(@dish_id, (SELECT id FROM ingredients WHERE name_key='suon_cot_lot_heo'), '4'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='gao_tam'), '300g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='gao_trang'), '60g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bi_heo'), '100g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='trung_ga'), '3'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='thit_nac_xay'), '50g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='mien'), '50g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='nam_meo_kho'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='sa_nho'), '5 '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='toi_bam'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_tim_bam'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='ot_bam'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_la'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='ca_chua'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='dua_leo'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='ca_rot'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='cu_cai_trang'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='mat_ong'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='nuoc_mam'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bot_ngot'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='muoi'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='dau_hao'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tieu_xay'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='duong'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='giam'), ' ');

INSERT IGNORE INTO instructions (dish_id, step_number, image_url) VALUES
(@dish_id, 1, 'https://cdn.tgdd.vn/Files/2021/08/16/1375565/cach-nau-com-tam-suon-bi-cha-tai-nha-ngon-nhu-ngoai-tiem-202108162224522338.jpg'),
(@dish_id, 2, 'https://cdn.tgdd.vn/Files/2021/08/16/1375565/cach-nau-com-tam-suon-bi-cha-tai-nha-ngon-nhu-ngoai-tiem-202108162227044516.png'),
(@dish_id, 3, 'https://cdn.tgdd.vn/Files/2021/08/16/1375565/cach-nau-com-tam-suon-bi-cha-tai-nha-ngon-nhu-ngoai-tiem-202108162229339436.jpg'),
(@dish_id, 4, 'https://cdn.tgdd.vn/Files/2021/08/16/1375565/cach-nau-com-tam-suon-bi-cha-tai-nha-ngon-nhu-ngoai-tiem-202108162238309900.png'),
(@dish_id, 5, 'https://cdn.tgdd.vn/Files/2021/08/16/1375565/cach-nau-com-tam-suon-bi-cha-tai-nha-ngon-nhu-ngoai-tiem-202108162240202988.png'),
(@dish_id, 6, 'https://cdn.tgdd.vn/Files/2021/08/16/1375565/cach-nau-com-tam-suon-bi-cha-tai-nha-ngon-nhu-ngoai-tiem-202108162241503640.png'),
(@dish_id, 7, 'https://cdn.tgdd.vn/Files/2021/08/16/1375565/cach-nau-com-tam-suon-bi-cha-tai-nha-ngon-nhu-ngoai-tiem-202108162241503640.png');

SET @step1_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 1 LIMIT 1);
SET @step2_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 2 LIMIT 1);
SET @step3_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 3 LIMIT 1);
SET @step4_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 4 LIMIT 1);
SET @step5_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 5 LIMIT 1);
SET @step6_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 6 LIMIT 1);
SET @step7_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 7 LIMIT 1);
INSERT IGNORE INTO instruction_translations (instruction_id, language_code, description) VALUES
(@step1_id, 'vi', 'Nấu cơm Gạo tấm mua về vo sạch qua 2 - 3 lần và nấu trong nồi cơm điện như bình thường.'),
(@step1_id, 'en', 'Cook rice Wash the broken rice 2-3 times and cook in a rice cooker as usual.'),
(@step2_id, 'vi', 'Làm phần sườn cốt lết nướng Thịt cốt lết mua về rửa sạch và dùng khăn thấm cho ráo. Tiếp đến, dùng búa đập thịt để làm thịt mỏng và mềm hơn (Nếu không có búa đập thịt bạn cũng có thể dùng chày giã bình thường). Ướp thịt theo công thức: 5 cây sả đập dập, ½ muỗng bột ngọt, 1 muỗng hạt nêm, 1 muỗng mật ong, 2 muỗng dầu hào, 1 muỗng nước mắm, ¼ muỗng tiêu xay, 1 muỗng hành tím băm, 1 muỗng tỏi băm và Nấu cơm cho món cơm tấm nhuyễn. Trộn đều và ướp thịt trong 1 tiếng. Nướng từng miếng thịt trên bếp than đến khi chín vàng đều hai mặt. Nếu bạn nướng bằng lò nướng hoặc nồi chiên không dầu có thể chỉnh nhiệt độ 180 độ C từ 30 - 45 phút.'),
(@step2_id, 'en', 'Making the grilled pork chops Wash the pork chops and pat dry with a towel. Next, use a meat hammer to make the meat thinner and softer (If you don not have a meat hammer, you can also use a normal pestle). Marinate the meat according to the recipe: 5 crushed lemongrass stalks, ½ teaspoon MSG, 1 teaspoon seasoning powder, 1 teaspoon honey, 2 tablespoons oyster sauce, 1 teaspoon fish sauce, ¼ teaspoon ground pepper, 1 teaspoon minced shallot, 1 teaspoon minced garlic and Cook rice for the soft broken rice dish. Mix well and marinate the meat for 1 hour. Grill each piece of meat on a charcoal stove until both sides are golden brown. If you grill in an oven or air fryer, you can set the temperature to 180 degrees Celsius for 30 - 45 minutes.'),
(@step3_id, 'vi', ' Làm chả trứng hấp Ngâm nấm mèo khô trong nước ấm 20 phút cho nở, sau đó rửa sạch, cắt bỏ phần chân và băm nhỏ. Miến ngâm trong 10 phút và cũng mang đi xắt nhỏ. Trộn đều thịt nạc heo xay, mộc nhĩ và miến đã xắt nhỏ. Đập thêm vào 2 quả trứng gà và 1 lòng trắng (1 lòng đỏ còn lại để tạo màu cho lớp bề mặt). Sau đó nêm với 2 muỗng muối, 1 muỗng đường, 1 muỗng nước mắm và 1 muỗng hành tím băm. Trộn đều để các nguyên liệu thấm đều gia vị. Cho phần chả trứng vào hấp cách thủy trong 30 phút. Sau đó cho lòng đỏ trứng còn lại lên bề mặt và hấp thêm 10 phút là hoàn tất.'),
(@step3_id, 'en', 'Making steamed egg patties Soak the dried mushrooms in warm water for 20 minutes to bloom, then wash, cut off the stem and chop finely. Soak the vermicelli for 10 minutes and also chop finely. Mix the minced pork, wood ear mushrooms and chopped vermicelli. Add 2 eggs and 1 egg white (the remaining yolk is for coloring the surface layer). Then season with 2 tablespoons of salt, 1 tablespoon of sugar, 1 tablespoon of fish sauce and 1 tablespoon of chopped shallots. Mix well so that the ingredients are evenly seasoned. Steam the egg patties for 30 minutes. Then add the remaining egg yolk on the surface and steam for another 10 minutes to complete.'),
(@step4_id, 'vi', '  Làm bì heo Bì heo mua về rửa sạch và mang đi luộc nhanh trong 15 phút để bì giữ được độ dai. Sau khi vớt ra cho ngay bì heo vào nước đá để giữ được độ giòn. Ngâm bì heo trong 5 phút và vớt ra để ráo. Xắt mỏng phần bì heo. Làm thính: Rang 60g gạo trắng đến khi chuyển sang màu vàng nâu. Để gạo cho nguội hoàn toàn và bỏ vào máy xay nhuyễn. Đây là một trong những cách làm bì cơm tấm hay cách trộn bì cơm tấm ngon mà bạn không thể bỏ qua.'),
(@step4_id, 'en', 'Making pork skin Wash the pork skin and boil it quickly for 15 minutes to keep it chewy. After removing it, immediately put the pork skin in ice water to keep it crispy. Soak the pork skin for 5 minutes and remove it to drain. Thinly slice the pork skin. Making rice powder: Roast 60g of white rice until it turns golden brown. Let the rice cool completely and put it in a blender. This is one of the ways to make broken rice skin or how to mix delicious broken rice skin that you cannot miss.'),
(@step5_id, 'vi', ' Củ cải trắng và cà rốt mua về rửa sạch, gọt vỏ và bào thành sợi nhỏ. Pha 100ml giấm, 3 muỗng đường và nửa muỗng muối và đổ vào phần củ đã thái sợi. Trộn đều và ngâm trong 1 tiếng là được. Đồ chua sau khi ngâm 1 tiếng có thể gắp ra và dùng ngay.'),
(@step5_id, 'en', 'Wash the white radish and carrots, peel them and shred them into thin strips. Mix 100ml vinegar, 3 tablespoons sugar and half a teaspoon salt and pour it into the shredded radish. Mix well and soak for 1 hour. After 1 hour of soaking, the pickles can be taken out and eaten immediately.'),
(@step6_id, 'vi', ' Làm phần mỡ hành Hành lá xắt nhuyễn cho thêm ¼ muỗng muối, ¼ muỗng đường và trộn đều. Dầu ăn nấu sôi và chế vào phần hành lá đã chuẩn bị. Trộn cho phần hành lá chín hết là hoàn thành.'),
(@step6_id, 'en', 'Make the scallion oil Slice the scallions finely, add ¼ teaspoon salt, ¼ teaspoon sugar and mix well. Boil the cooking oil and add it to the prepared scallions. Mix until the scallions are cooked and done.'),
(@step7_id, 'vi', ' Pha chế nước mắm Đun sôi và khuấy đều hỗn hợp 3 muỗng nước mắm, 3 muỗng đường, 3 muỗng nước ấm và 1 muỗng giấm. Để hỗn hợp nguội, sau đó thêm ½ muỗng mắm và ½ muỗng giấm vào, nêm vừa miệng. Ớt trái rửa sạch, đổ nước lạnh vừa đủ qua mặt ớt và đun sôi đến khi ớt mềm. Dùng thìa dầm ớt nhỏ ra. Đun nóng 1 muỗng dầu ăn, cho 1 muỗng tỏi vào phi thơm, sau đó cho phần ớt đã dầm nhuyễn vào. Thêm vào 1 muỗng đường, 1 muỗng giấm, đun sôi khoảng 5 phút, tắt bếp để nguội rồi cho hỗn hợp ớt vào cùng phần nước mắm đã nấu.'),
(@step7_id, 'en', 'Prepare the fish sauce Boil and stir well the mixture of 3 tablespoons of fish sauce, 3 tablespoons of sugar, 3 tablespoons of warm water and 1 tablespoon of vinegar. Let the mixture cool, then add ½ tablespoon of fish sauce and ½ tablespoon of vinegar, season to taste. Wash the chili, pour enough cold water over the chili and boil until the chili is soft. Use a spoon to crush the chili into small pieces. Heat 1 tablespoon of cooking oil, add 1 tablespoon of garlic and sauté until fragrant, then add the crushed chili. Add 1 tablespoon of sugar, 1 tablespoon of vinegar, boil for about 5 minutes, turn off the heat to cool, then add the chili mixture with the cooked fish sauce.');