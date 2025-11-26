
USE vnfood;

INSERT IGNORE INTO dishes (class_id, image_url) VALUES (14, 'https://cdn.tgdd.vn/Files/2017/03/24/964495/cach-nau-bun-bo-hue-gio-heo-ngon-cong-thuc-chuan-vi-202208251613352995.jpg');
SET @dish_id = (SELECT id FROM dishes WHERE class_id = 14);
INSERT IGNORE INTO dish_translations (dish_id, language_code, name, description) VALUES
(@dish_id, 'vi', 'Bún Bò Huế', 'Một món bún đặc sản của Huế với nước dùng đậm đà vị sả, mắm ruốc, và vị cay. Ăn kèm bắp bò, giò heo, chả cua.'),
(@dish_id, 'en', 'Bun Bo Hue (Spicy Beef Noodle Soup)', 'A specialty noodle soup from Hue with a rich, spicy broth flavored with lemongrass and shrimp paste. Served with beef shank, pork hock, and crab cakes.');
INSERT IGNORE INTO ingredients (name_key) VALUES
('xuong_ong_bo'), ('gio_heo'), ('bap_bo'), ('nam_bo'), ('cha_hue'), ('mam_ruoc'), ('huyet_bo'), ('gung'),
('sa'), ('hanh_tay'), ('bun_soi_to'), ('chanh'), ('ot'), ('sa_te'), ('hat_dieu_do'), ('rau_song'), ('bap_chuoi_bao'),
('gia'), ('rau_thom'), ('hanh_tim'), ('toi'), ('hat_nem'), ('dau_an'), ('tieu'), ('duong'), ('muoi'), ('bot_ngot');

INSERT IGNORE INTO ingredient_translations (ingredient_id, language_code, name) VALUES
((SELECT id FROM ingredients WHERE name_key='xuong_ong_bo'), 'vi', 'Xương ống bò'),
((SELECT id FROM ingredients WHERE name_key='xuong_ong_bo'), 'en', 'Beef bone'),
((SELECT id FROM ingredients WHERE name_key='gio_heo'), 'vi', 'Giò heo'),
((SELECT id FROM ingredients WHERE name_key='gio_heo'), 'en', 'Pork knuckle'),
((SELECT id FROM ingredients WHERE name_key='bap_bo'), 'vi', 'Bắp bò'),
((SELECT id FROM ingredients WHERE name_key='bap_bo'), 'en', 'Beef brisket'),
((SELECT id FROM ingredients WHERE name_key='nam_bo'), 'vi', 'Nạm bò'),
((SELECT id FROM ingredients WHERE name_key='nam_bo'), 'en', 'Beef flank'),
((SELECT id FROM ingredients WHERE name_key='cha_hue'), 'vi', 'Chả Huế'),
((SELECT id FROM ingredients WHERE name_key='cha_hue'), 'en', 'Hue pork roll'),
((SELECT id FROM ingredients WHERE name_key='mam_ruoc'), 'vi', 'Mắm ruốc'),
((SELECT id FROM ingredients WHERE name_key='mam_ruoc'), 'en', 'Fermented shrimp paste'),
((SELECT id FROM ingredients WHERE name_key='huyet_bo'), 'vi', 'Huyết bò'),
((SELECT id FROM ingredients WHERE name_key='huyet_bo'), 'en', 'Beef blood cake'),
((SELECT id FROM ingredients WHERE name_key='gung'), 'vi', 'Gừng'),
((SELECT id FROM ingredients WHERE name_key='gung'), 'en', 'Ginger'),
((SELECT id FROM ingredients WHERE name_key='sa'), 'vi', 'Sả'),
((SELECT id FROM ingredients WHERE name_key='sa'), 'en', 'Lemongrass'),
((SELECT id FROM ingredients WHERE name_key='hanh_tay'), 'vi', 'Hành tây'),
((SELECT id FROM ingredients WHERE name_key='hanh_tay'), 'en', 'Onion'),
((SELECT id FROM ingredients WHERE name_key='bun_soi_to'), 'vi', 'Bún sợi to'),
((SELECT id FROM ingredients WHERE name_key='bun_soi_to'), 'en', 'Thick rice noodles'),
((SELECT id FROM ingredients WHERE name_key='chanh'), 'vi', 'Chanh'),
((SELECT id FROM ingredients WHERE name_key='chanh'), 'en', 'Lime'),
((SELECT id FROM ingredients WHERE name_key='ot'), 'vi', 'Ớt'),
((SELECT id FROM ingredients WHERE name_key='ot'), 'en', 'Chili'),
((SELECT id FROM ingredients WHERE name_key='sa_te'), 'vi', 'Sa tế'),
((SELECT id FROM ingredients WHERE name_key='sa_te'), 'en', 'Sate sauce'),
((SELECT id FROM ingredients WHERE name_key='hat_dieu_do'), 'vi', 'Hạt điều màu đỏ'),
((SELECT id FROM ingredients WHERE name_key='hat_dieu_do'), 'en', 'Red roasted cashew'),
((SELECT id FROM ingredients WHERE name_key='rau_song'), 'vi', 'Rau sống'),
((SELECT id FROM ingredients WHERE name_key='rau_song'), 'en', 'Raw vegetables / herbs'),
((SELECT id FROM ingredients WHERE name_key='bap_chuoi_bao'), 'vi', 'Bắp chuối bào'),
((SELECT id FROM ingredients WHERE name_key='bap_chuoi_bao'), 'en', 'Shredded banana blossom'),
((SELECT id FROM ingredients WHERE name_key='gia'), 'vi', 'Giá'),
((SELECT id FROM ingredients WHERE name_key='gia'), 'en', 'Bean sprouts'),
((SELECT id FROM ingredients WHERE name_key='rau_thom'), 'vi', 'Rau thơm'),
((SELECT id FROM ingredients WHERE name_key='rau_thom'), 'en', 'Herbs'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim'), 'vi', 'Hành tím'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim'), 'en', 'Shallot'),
((SELECT id FROM ingredients WHERE name_key='toi'), 'vi', 'Tỏi'),
((SELECT id FROM ingredients WHERE name_key='toi'), 'en', 'Garlic'),
((SELECT id FROM ingredients WHERE name_key='hat_nem'), 'vi', 'Hạt nêm'),
((SELECT id FROM ingredients WHERE name_key='hat_nem'), 'en', 'Seasoning powder'),
((SELECT id FROM ingredients WHERE name_key='dau_an'), 'vi', 'Dầu ăn'),
((SELECT id FROM ingredients WHERE name_key='dau_an'), 'en', 'Cooking oil'),
((SELECT id FROM ingredients WHERE name_key='tieu'), 'vi', 'Tiêu'),
((SELECT id FROM ingredients WHERE name_key='tieu'), 'en', 'Pepper'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'vi', 'Đường'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'en', 'Sugar'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'vi', 'Muối'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'en', 'Salt'),
((SELECT id FROM ingredients WHERE name_key='bot_ngot'), 'vi', 'Bột ngọt'),
((SELECT id FROM ingredients WHERE name_key='bot_ngot'), 'en', 'MSG');

INSERT IGNORE INTO dish_ingredients (dish_id, ingredient_id, quantity) VALUES
(@dish_id, (SELECT id FROM ingredients WHERE name_key='xuong_ong_bo'), '1 kg'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='gio_heo'), '800g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bap_bo'), '500g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='nam_bo'), '500g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='cha_hue'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='mam_ruoc'), '100g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='huyet_bo'), '100g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='gung'), '50g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='sa'), '10'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_tay'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bun_soi_to'), '2 kg'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='chanh'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='ot'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='sa_te'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hat_dieu_do'), '40g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='rau_song'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bap_chuoi_bao'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='gia'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='rau_thom'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_tim'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='toi'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hat_nem'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='dau_an'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tieu'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='duong'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='muoi'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bot_ngot'), ' ');

INSERT IGNORE INTO instructions (dish_id, step_number, image_url) VALUES
(@dish_id, 1, 'https://cdn.tgdd.vn/Files/2017/03/24/964495/cach-nau-bun-bo-hue-gio-heo-ngon-cong-thuc-chuan-vi-202208251620572272.jpg'),
(@dish_id, 2, 'https://cdn.tgdd.vn/Files/2017/03/24/964495/cach-nau-bun-bo-hue-gio-heo-ngon-cong-thuc-chuan-vi-202208251621182305.jpg'),
(@dish_id, 3, 'https://cdn.tgdd.vn/Files/2017/03/24/964495/cach-nau-bun-bo-hue-gio-heo-ngon-cong-thuc-chuan-vi-202208251621566332.jpg'),
(@dish_id, 4, 'https://cdn.tgdd.vn/Files/2017/03/24/964495/cach-nau-bun-bo-hue-gio-heo-ngon-cong-thuc-chuan-vi-202208251622167079.jpg'),
(@dish_id, 5, 'https://cdn.tgdd.vn/Files/2017/03/24/964495/cach-nau-bun-bo-hue-gio-heo-ngon-cong-thuc-chuan-vi-202208251617593627.jpg');


SET @step1_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 1 LIMIT 1);
SET @step2_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 2 LIMIT 1);
SET @step3_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 3 LIMIT 1);
SET @step4_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 4 LIMIT 1);
SET @step5_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 5 LIMIT 1);
INSERT IGNORE INTO instruction_translations (instruction_id, language_code, description) VALUES
(@step1_id, 'vi', 'Sơ chế nguyên liệu Gừng, sả rửa sạch, đập dập. Hành tím, tỏi, một ít sả băm nhỏ Rau sống rửa sạch. Hành tây rửa sạch, thái mỏng ngâm nước đá cho bớt hăng. Giò heo cạo sạch lông, gỡ bỏ phần móng bên ngoài, chặt khúc sao cho vừa ăn rồi rửa sạch. Huyết cắt thành từng khúc.'),
(@step1_id, 'en', 'Prepare ingredients Wash and crush ginger and lemongrass. Shallots, garlic, and a little chopped lemongrass Wash raw vegetables. Wash and thinly slice onions and soak in ice water to reduce the pungency. Scrape off the pig hair, remove the outer hooves, chop into bite-sized pieces, and wash. Cut the blood into pieces.'),
(@step2_id, 'vi', 'Hầm thịt bò, xương Nấu một nồi nước, cho mắm ruốc vào khuấy đều, đun sôi, vớt bọt ra ngoài rồi tắt bếp, để nguội, lóng lấy nước. Cho nạm bò và bắp bò, xương vào nồi, 3 cây sả đã đập dập, 1 muỗng muối, đổ nước sao cho ngập mặt thịt khoảng chừng 1 cm. Đậy nắp rồi đun sôi, khi nước sôi thì hạ lửa, thường xuyên vớt bọt bên trên mặt nước, đun thêm khoảng 30 phút nữa rồi tắt bếp. Để một chút rồi mở nắp vớt bắp bò, nạm bò cho vào thau nước lạnh.'),
(@step2_id, 'en', 'Beef and bone stew Boil a pot of water, add shrimp paste and stir well, boil, remove foam and turn off the stove, let cool, and collect the water. Put beef shank and beef shank, bones in the pot, 3 crushed lemongrass stalks, 1 tablespoon of salt, pour water so that it covers the meat by about 1 cm. Cover and boil, when the water boils, lower the heat, regularly remove foam from the surface of the water, boil for about 30 more minutes and turn off the stove. Leave for a while then open the lid, remove beef shank and beef shank and put them in a bowl of cold water.'),
(@step3_id, 'vi', ' Tạo màu hạt điều Cho hạt điều vào chảo dầu rồi xào cho tới khi có màu đỏ, vớt hạt ra, cho thêm hành và tỏi băm vào xào đến khi vàng thơm thì tắt bếp.'),
(@step3_id, 'en', 'Cashew Coloring Put cashews in a pan of oil and stir-fry until red, remove the cashews, add chopped onions and garlic and stir-fry until golden brown and fragrant, then turn off the heat.'),
(@step4_id, 'vi', 'Nấu nước bún bò Đổ chung nước hầm xương với bắp bò, nạm bò, nước hầm giò heo, sả, hành tây vào một nồi lớn, thêm nước nếu thấy ít. Cho thêm hỗn hợp màu điều đã tạo vào. Đun sôi rồi nêm nếm gia vị: hạt nêm, đường, muối, bột ngọt và một ít nước mắm vào, cho một ít sa tế vào để có vị cay nhé, điều chỉnh gia vị sao cho vừa ăn.'),
(@step4_id, 'en', 'Cook the beef noodle soup Pour the bone broth, beef shank, beef brisket, pork leg broth, lemongrass, and onion into a large pot, adding more water if it seems low. Add the annatto color mixture. Boil and season with seasoning: seasoning powder, sugar, salt, MSG, and a little fish sauce, add a little chili sauce for a spicy taste, adjust the seasoning to taste..'),
(@step5_id, 'vi', 'Thành phẩm Trụng bún với nước sôi, cho ra tô, xếp giò heo, bắp bò, nạm bò, chả, hành tây và hành lên. Sau đó, chan nước dùng vào tô là bạn đã hoàn thành xong cách nấu bún bò giò heo rồi. Ăn kèm với rau sống, chanh, ớt thì còn gì bằng.'),
(@step5_id, 'en', 'Finished product Blanch the noodles with boiling water, put them in a bowl, arrange the pork leg, beef shank, beef brisket, sausage, onion and scallion on top. Then, pour the broth into the bowl and you have finished cooking the pork leg beef noodle soup. There is nothing better than eating it with raw vegetables, lemon, and chili.')');
