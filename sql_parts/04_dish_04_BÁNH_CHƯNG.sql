
USE vnfood;

INSERT IGNORE INTO dishes (class_id, image_url) VALUES (4, 'https://cdn.tgdd.vn/Files/2016/12/30/932155/cach-lam-banh-chung-thom-ngon-xanh-deo-dam-da-huong-vi-tet-202209011455226787.jpg');
SET @dish_id = (SELECT id FROM dishes WHERE class_id = 4);
INSERT IGNORE INTO dish_translations (dish_id, language_code, name, description) VALUES
(@dish_id, 'vi', 'Bánh Chưng', 'Loại bánh truyền thống trong ngày Tết, làm từ gạo nếp, đậu xanh, thịt lợn, gói trong lá chuối và luộc chín trong nhiều giờ.'),
(@dish_id, 'en', 'Banh Chung (Sticky Rice Cake)', 'A traditional Vietnamese rice cake for the Lunar New Year, made from glutinous rice, mung beans, pork, wrapped in dong leaves and boiled for many hours.');


INSERT IGNORE INTO ingredients (name_key) VALUES
('gao_nep'),
('thit_ba_chi'),
('dau_xanh_tach_vo'),
('la_chuoi'),
('muoi'),
('duong'),
('tieu');

INSERT IGNORE INTO ingredient_translations (ingredient_id, language_code, name) VALUES
((SELECT id FROM ingredients WHERE name_key='gao_nep'), 'vi', 'Gạo nếp'),
((SELECT id FROM ingredients WHERE name_key='gao_nep'), 'en', 'Sticky rice'),
((SELECT id FROM ingredients WHERE name_key='thit_ba_chi'), 'vi', 'Thịt ba chỉ'),
((SELECT id FROM ingredients WHERE name_key='thit_ba_chi'), 'en', 'Pork belly'),
((SELECT id FROM ingredients WHERE name_key='dau_xanh_tach_vo'), 'vi', 'Đậu xanh tách vỏ'),
((SELECT id FROM ingredients WHERE name_key='dau_xanh_tach_vo'), 'en', 'Peeled mung beans'),
((SELECT id FROM ingredients WHERE name_key='la_chuoi'), 'vi', 'Lá chuối'),
((SELECT id FROM ingredients WHERE name_key='la_chuoi'), 'en', 'Banana leaves'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'vi', 'Muối'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'en', 'Salt'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'vi', 'Đường'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'en', 'Sugar'),
((SELECT id FROM ingredients WHERE name_key='tieu'), 'vi', 'Tiêu'),
((SELECT id FROM ingredients WHERE name_key='tieu'), 'en', 'Pepper');

INSERT IGNORE INTO dish_ingredients (dish_id, ingredient_id, quantity) VALUES
(@dish_id, (SELECT id FROM ingredients WHERE name_key='gao_nep'), '650g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='thit_ba_chi'), '300g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='dau_xanh_tach_vo'), '400g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='la_chuoi'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='muoi'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='duong'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tieu'), '');

INSERT IGNORE INTO instructions (dish_id, step_number, image_url) VALUES
(@dish_id, 1, 'https://cdn.tgdd.vn/Files/2016/12/30/932155/cach-lam-banh-chung-thom-ngon-xanh-deo-dam-da-huong-vi-tet-202209011503148065.jpg'),
(@dish_id, 2, 'https://cdn.tgdd.vn/Files/2016/12/30/932155/cach-lam-banh-chung-thom-ngon-xanh-deo-dam-da-huong-vi-tet-202209011503367408.jpg'),
(@dish_id, 3, 'https://cdn.tgdd.vn/Files/2016/12/30/932155/cach-lam-banh-chung-thom-ngon-xanh-deo-dam-da-huong-vi-tet-202209011504132143.jpg'),
(@dish_id, 4, 'https://cdn.tgdd.vn/Files/2016/12/30/932155/cach-lam-banh-chung-thom-ngon-xanh-deo-dam-da-huong-vi-tet-202209011500482105.jpg'),
(@dish_id, 5, 'https://cdn.tgdd.vn/Files/2016/12/30/932155/cach-lam-banh-chung-thom-ngon-xanh-deo-dam-da-huong-vi-tet-202209101533034320.jpg');


SET @step1_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 1 LIMIT 1);
SET @step2_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 2 LIMIT 1);
SET @step3_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 3 LIMIT 1);
SET @step4_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 4 LIMIT 1);
SET @step5_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 5 LIMIT 1);
INSERT IGNORE INTO instruction_translations (instruction_id, language_code, description) VALUES
(@step1_id, 'vi', 'Lá chuối mua về, rửa sạch. Ngâm gạo nếp, đậu xanh không vỏ trước khi gói tầm 4 tiếng hoặc để qua đêm, có thể ngâm gạo nếp với lá chuối hay lá dứa để nếp thơm ngon và có màu xanh.'),
(@step1_id, 'en', 'Buy banana leaves, wash clean. Soak sticky rice and skinless mung beans before wrapping for about 4 hours or overnight. You can soak sticky rice in banana leaves or pandan leaves to make the sticky rice fragrant and green.'),
(@step2_id, 'vi', 'Sau khi ngâm xong, bạn đổ nếp ra rổ và để ráo, thêm 1 tới 2 muỗng muối vào và trộn đều. Đậu xanh cũng đổ ra rổ, thêm muối và tiêu rồi trộn đều. Thịt heo rửa và cắt miếng. Cách ướp thịt gói bánh chưng rất đơn giản, bạn chỉ cần ướp với muối, đường, tiêu với lượng vừa ăn là được. Ngoài ra, bạn có thể tham khảo thêm cách làm nhân bánh chưng ngon'),
(@step2_id, 'en', 'After soaking, pour the sticky rice into a basket and drain, add 1 to 2 tablespoons of salt and mix well. Pour the mung beans into a basket, add salt and pepper and mix well. Wash and cut the pork into pieces. The way to marinate the meat for banh chung is very simple, you just need to marinate it with salt, sugar, and pepper in the right amount. In addition, you can refer to the way to make delicious banh chung filling'),
(@step3_id, 'vi', 'Gói bánh bằng khuôn Để bánh chưng vuông vức đẹp mắt, bạn nên chuẩn bị các khuôn gói bánh chưng hình vuông để cố định hình dạng bánh. Bạn xếp khoảng 4 miếng lá chuối vào khuôn, mỗi lá bạn gập ngang lại tạo 1 đường thẳng, đặt lá chuối đứng theo đường thẳng này và xếp vào 4 góc của khung sau đó cho nếp, đậu xanh, thịt heo vào như hình bên dưới. Rải nếp đều 4 góc để tránh bánh bị lồi lõm, cho đậu xanh vào rồi thêm thịt sau đó lại thêm một lớp đậu xanh, cuối cùng là rải nếp phủ lên. Sau đó bạn gấp lá chuối lại, dùng 1 tay giữ miệng gấp rồi nhấc khuôn lên, lấy dây buộc 2 vòng theo hình chữ thập. Không buộc dây quá chặt, để tránh bánh nở không đẹp, ngon.'),
(@step3_id, 'en', 'Wrapping the cake with a mold To make the square banh chung look nice, you should prepare square banh chung molds to fix the shape of the cake. Arrange about 4 pieces of banana leaves in the mold, each leaf you fold horizontally to create a straight line, place the banana leaves vertically along this line and arrange them in the 4 corners of the frame, then add sticky rice, green beans, and pork as shown below. Spread the sticky rice evenly in the 4 corners to avoid the cake being concave and convex, add green beans and then add meat, then add another layer of green beans, and finally spread the sticky rice on top. Then fold the banana leaf, use one hand to hold the fold, then lift the mold, tie it with a string 2 times in a cross shape. Do not tie the string too tightly, to avoid the cake from rising beautifully and deliciously.'),
(@step4_id, 'vi', 'Cách luộc bánh chưng thì bạn thực hiện như sau: Đầu tiên xếp bánh chưng đã gói vào nồi, đổ nước ngập mặt bánh, luộc bánh kích cỡ nhỏ khoảng 5 tiếng sẽ chín nhưng bánh cỡ lớn sẽ có thời gian nấu lâu hơn. Luôn chuẩn bị 1 ấm nước sôi bên cạnh để khi nước trong nồi cạn, bạn kịp thời tiếp thêm nước, không đổ nước lạnh vào nồi. Khi luộc được nửa thời gian bạn nên mở nắp nồi, đảo mặt bánh để bánh chín đều hơn.'),
(@step4_id, 'en', 'To boil banh chung, you do as follows: First, arrange the wrapped banh chung in the pot, pour water to cover the cake, boil small size cakes for about 5 hours to cook but large size cakes will take longer to cook. Always prepare a kettle of boiling water next to you so that when the water in the pot is dry, you can add more water immediately, do not pour cold water into the pot. When half of the boiling time has passed, you should open the pot lid, turn the cake over so that the cake cooks more evenly.'),
(@step5_id, 'vi', 'Sau khi bánh chín, bạn lấy ra khỏi nồi cho bánh vào nước lạnh ngâm tầm 20 phút rồi xếp bánh ra mặt bàn, dùng đồ nặng đè lên để ép nước ra khỏi cho bánh ráo ngon và giữ được lâu, thời gian ép hết nước từ khoảng 5 đến 8 tiếng. Sau đó là có thể thưởng thức rồi nhé!'),
(@step5_id, 'en', 'After the cake is cooked, take it out of the pot and soak it in cold water for about 20 minutes, then arrange the cake on the table, use a heavy object to press down to squeeze out the water so that the cake is dry and delicious and can be kept for a long time. The time to squeeze out all the water is about 5 to 8 hours. Then you can enjoy it!');