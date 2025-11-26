
USE vnfood;

INSERT IGNORE INTO dishes (class_id, image_url) VALUES (15, 'https://cdn.tgdd.vn/2021/12/CookDish/cach-lam-bun-dau-mam-tom-ngon-ngat-ngay-an-mot-lan-la-ghien-avt-1200x675.jpg');
SET @dish_id = (SELECT id FROM dishes WHERE class_id = 15);
INSERT IGNORE INTO dish_translations (dish_id, language_code, name, description) VALUES
(@dish_id, 'vi', 'Bún Đậu Mắm Tôm', 'Món ăn dân dã gồm bún lá, đậu phụ rán giòn, chả cốm, thịt luộc... chấm với mắm tôm pha chanh, đường, ớt.'),
(@dish_id, 'en', 'Noodles with Fried Tofu & Shrimp Paste', 'A rustic dish of rice noodles, deep-fried tofu, green rice pork nuggets, and boiled pork, served with shrimp paste dip (mam tom) mixed with lime, sugar, and chili.');
INSERT IGNORE INTO ingredients (name_key) VALUES
('bun_soi_nho'),
('dau_hu'),
('thit_chan_gio'),
('mam_tom'),
('rau_kinh_gioi'),
('dua_leo'),
('tia_to'),
('tac'),
('toi');

INSERT IGNORE INTO ingredient_translations (ingredient_id, language_code, name) VALUES
((SELECT id FROM ingredients WHERE name_key='bun_soi_nho'), 'vi', 'Bún sợi nhỏ'),
((SELECT id FROM ingredients WHERE name_key='bun_soi_nho'), 'en', 'Thin rice noodles'),
((SELECT id FROM ingredients WHERE name_key='dau_hu'), 'vi', 'Đậu hũ'),
((SELECT id FROM ingredients WHERE name_key='dau_hu'), 'en', 'Tofu'),
((SELECT id FROM ingredients WHERE name_key='thit_chan_gio'), 'vi', 'Thịt chân giò'),
((SELECT id FROM ingredients WHERE name_key='thit_chan_gio'), 'en', 'Pork leg'),
((SELECT id FROM ingredients WHERE name_key='mam_tom'), 'vi', 'Mắm tôm'),
((SELECT id FROM ingredients WHERE name_key='mam_tom'), 'en', 'Fermented shrimp paste'),
((SELECT id FROM ingredients WHERE name_key='rau_kinh_gioi'), 'vi', 'Rau kinh giới'),
((SELECT id FROM ingredients WHERE name_key='rau_kinh_gioi'), 'en', 'Vietnamese balm'),
((SELECT id FROM ingredients WHERE name_key='dua_leo'), 'vi', 'Dưa leo'),
((SELECT id FROM ingredients WHERE name_key='dua_leo'), 'en', 'Cucumber'),
((SELECT id FROM ingredients WHERE name_key='tia_to'), 'vi', 'Tía tô'),
((SELECT id FROM ingredients WHERE name_key='tia_to'), 'en', 'Perilla leaves'),
((SELECT id FROM ingredients WHERE name_key='tac'), 'vi', 'Tắc'),
((SELECT id FROM ingredients WHERE name_key='tac'), 'en', 'Calamansi'),
((SELECT id FROM ingredients WHERE name_key='toi'), 'vi', 'Tỏi'),
((SELECT id FROM ingredients WHERE name_key='toi'), 'en', 'Garlic');

INSERT IGNORE INTO dish_ingredients (dish_id, ingredient_id, quantity) VALUES
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bun_soi_nho'), '500g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='dau_hu'), '2 miếng'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='thit_chan_gio'), '400g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='mam_tom'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='rau_kinh_gioi'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='dua_leo'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tia_to'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tac'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='toi'), ' ');
INSERT IGNORE INTO instructions (dish_id, step_number, image_url) VALUES
(@dish_id, 1, 'https://cdn.tgdd.vn/Files/2017/03/21/963373/cach-lam-bun-dau-mam-tom-thom-ngon-1_760x450.jpg'),
(@dish_id, 2, 'https://cdn.tgdd.vn/Files/2017/03/21/963373/cach-lam-bun-dau-mam-tom-thom-ngon-2_760x450.jpg'),
(@dish_id, 3, 'https://cdn.tgdd.vn/Files/2017/03/21/963373/cach-lam-bun-dau-mam-tom-thom-ngon-3_760x450.jpg'),
(@dish_id, 4, 'https://cdn.tgdd.vn/Files/2017/03/21/963373/cach-lam-bun-dau-mam-tom-thom-ngon-4_760x450.jpg'),
(@dish_id, 5, 'https://cdn.tgdd.vn/Files/2017/03/21/963373/cach-lam-bun-dau-mam-tom-thom-ngon-5_760x449.jpg'),
(@dish_id, 6, 'https://cdn.tgdd.vn/Files/2017/03/21/963373/cach-lam-bun-dau-mam-tom-thom-ngon-6_760x450.jpg');
SET @step1_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 1 LIMIT 1);
SET @step2_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 2 LIMIT 1);
SET @step3_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 3 LIMIT 1);
SET @step4_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 4 LIMIT 1);
SET @step5_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 5 LIMIT 1);
SET @step6_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 6 LIMIT 1);
INSERT IGNORE INTO instruction_translations (instruction_id, language_code, description) VALUES
(@step1_id, 'vi', 'Luộc thịt Thịt chân giò mua về rửa sạch. Luộc sơ qua nước sôi khoảng 2 phút, vớt ra, rửa lại thật sạch với nước lạnh. Cho lên bếp một nồi nước khác, luộc thịt đến khi chín mềm là được. Cắt miếng nhỏ vừa ăn.'),
(@step1_id, 'en', 'Boil the meat Wash the pork leg. Boil it in boiling water for about 2 minutes, take it out, and rinse it thoroughly with cold water. Put another pot of water on the stove and boil the meat until it is tender. Cut it into bite-sized pieces.'),
(@step2_id, 'vi', 'Chiên đậu hũ Cắt miếng vừa ăn, chiên vàng đều 2 mặt, vừa thơm vừa giòn là được.'),
(@step2_id, 'en', 'Fried tofu Cut into bite-sized pieces, fry until golden brown on both sides, fragrant and crispy.'),
(@step3_id, 'vi', 'Ép bún Cách làm bún lá rất đơn giản. Để ép bún, bún tươi sau khi mua về bạn rửa sạch, trần sơ, sau đó lót lá chuối hoặc dùng giấy bọc thực phẩm dưới cái nia. Cho phần bún đã chuẩn bị lên trên phủ thêm một phần lá chuối hoặc giấy bọc thực phẩm lên mặt tiếp đến dùng một tấm thớt tròn, đè mạnh lên ép bún trong khoảng 2 tiếng, bún sẽ chắc nịch. Ép bún trong khuôn, sau đó cắt thành miếng nhỏ cho vừa ăn.'),
(@step3_id, 'en', 'Pressing vermicelli The way to make vermicelli is very simple. To press vermicelli, after buying fresh vermicelli, you wash it, blanch it, then line it with banana leaves or use food wrap under the winnowing tray. Put the prepared vermicelli on top, cover it with another banana leaf or food wrap, then use a round cutting board, press hard on the vermicelli for about 2 hours, the vermicelli will be firm. Press the vermicelli in the mold, then cut it into small pieces to eat.'),
(@step4_id, 'vi', 'Rửa rau Ngâm nước muối, rửa sạch, sắp lên dĩa cho đẹp mắt.'),
(@step4_id, 'en', 'Wash vegetables Soak in salt water, wash, arrange on a plate to look nice.'),
(@step5_id, 'vi', 'Pha mắm tôm Mắm tôm là loại mắm có mùi rất đậm và mặn, rất nồng được ủ từ tôm và muối lên men theo cách làm truyền thống, thường được ăn kèm món bún đậu nổi tiếng của Hà Nội. Khi được pha chế lại như một nước chấm thì nó giúp phát huy hết mùi vị thơm ngon nhất của các món chính đi kèm. Hay nói cách khác, ăn bún đậu nhất định phải kèm theo mắm tôm thì món ăn mới thực sự thơm ngon và tròn vị. Mắm tôm mua về, đun sôi, sau đó nêm thêm đường cho vừa ăn. Khi mắm tôm nguội bạn có thể thêm tắc vào, sẽ thơm ngon hơn nhé.'),
(@step5_id, 'en', 'Mixing shrimp paste Shrimp paste is a very strong and salty, very strong-smelling fish sauce made from fermented shrimp and salt in the traditional way, often eaten with Hanoi famous vermicelli and bean curd dish. When mixed as a dipping sauce, it helps to bring out the most delicious flavors of the main dishes that go with it. In other words, eating vermicelli and bean curd must be accompanied by shrimp paste for the dish to be truly delicious and flavorful. Buy the shrimp paste, boil it, then add sugar to taste. When the shrimp paste cools, you can add kumquat, it will be more delicious.'),
(@step6_id, 'vi', 'Thành phẩm Bún đậu mắm tôm rất thơm ngon, ăn kèm với mắm tôm, đậu hũ, thịt chân giò, chả cốm, rau thơm, đậu phụ, kinh giới, tía tô, tắc, chanh, ớt thì còn gì bằng.'),
(@step6_id, 'en', 'Finished product The banana leaf is very tasty, served with shrimp paste, tofu, pork leg, chả cốm, fresh herbs, bean sprouts, Vietnamese mint, perilla leaves, calamansi, lemon, and chili, there is nothing better than this.')');
