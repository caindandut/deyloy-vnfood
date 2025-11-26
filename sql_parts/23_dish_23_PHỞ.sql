
USE vnfood;

INSERT IGNORE INTO dishes (class_id, image_url) VALUES (23, 'https://cdn.tgdd.vn/Files/2017/03/18/962092/an-lien-3-bat-pho-voi-cong-thuc-nau-pho-nay-202201261419401397.jpg');
SET @dish_id = (SELECT id FROM dishes WHERE class_id = 23);
INSERT IGNORE INTO dish_translations (dish_id, language_code, name, description) VALUES
(@dish_id, 'vi', 'Phở', 'Món súp bò Việt Nam nổi tiếng với nước dùng thơm từ xương bò ninh lâu, sợi bánh phở dai, thịt bò thái mỏng, ăn kèm rau thơm, chanh và ớt.'),
INSERT IGNORE INTO ingredients (name_key) VALUES
('xuong_ong_bo'), ('phi_le_bo'), ('bo_vien'), ('banh_pho'),
('hanh_tim'), ('hanh_la'), ('hanh_tay'), ('chanh'), ('gung'),
('dinh_huong'), ('hoa_hoi'), ('thao_qua'), ('que_chi'),
('duong_phen'), ('muoi_hot'), ('bot_ngot');

INSERT IGNORE INTO ingredient_translations (ingredient_id, language_code, name) VALUES
((SELECT id FROM ingredients WHERE name_key='xuong_ong_bo'), 'vi', 'Xương ống bò'),
((SELECT id FROM ingredients WHERE name_key='xuong_ong_bo'), 'en', 'Beef leg bones'),
((SELECT id FROM ingredients WHERE name_key='phi_le_bo'), 'vi', 'Phi lê bò'),
((SELECT id FROM ingredients WHERE name_key='phi_le_bo'), 'en', 'Beef fillet'),
((SELECT id FROM ingredients WHERE name_key='bo_vien'), 'vi', 'Bò viên'),
((SELECT id FROM ingredients WHERE name_key='bo_vien'), 'en', 'Beef balls'),
((SELECT id FROM ingredients WHERE name_key='banh_pho'), 'vi', 'Bánh phở'),
((SELECT id FROM ingredients WHERE name_key='banh_pho'), 'en', 'Rice noodles'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim'), 'vi', 'Hành tím củ'),
((SELECT id FROM ingredients WHERE name_key='hanh_tim'), 'en', 'Shallots'),
((SELECT id FROM ingredients WHERE name_key='hanh_la'), 'vi', 'Hành lá'),
((SELECT id FROM ingredients WHERE name_key='hanh_la'), 'en', 'Spring onion'),
((SELECT id FROM ingredients WHERE name_key='hanh_tay'), 'vi', 'Hành tây'),
((SELECT id FROM ingredients WHERE name_key='hanh_tay'), 'en', 'Onion'),
((SELECT id FROM ingredients WHERE name_key='chanh'), 'vi', 'Chanh'),
((SELECT id FROM ingredients WHERE name_key='chanh'), 'en', 'Lemon'),
((SELECT id FROM ingredients WHERE name_key='gung'), 'vi', 'Gừng'),
((SELECT id FROM ingredients WHERE name_key='gung'), 'en', 'Ginger'),
((SELECT id FROM ingredients WHERE name_key='dinh_huong'), 'vi', 'Đinh hương'),
((SELECT id FROM ingredients WHERE name_key='dinh_huong'), 'en', 'Cloves'),
((SELECT id FROM ingredients WHERE name_key='hoa_hoi'), 'vi', 'Hoa hồi'),
((SELECT id FROM ingredients WHERE name_key='hoa_hoi'), 'en', 'Star anise'),
((SELECT id FROM ingredients WHERE name_key='thao_qua'), 'vi', 'Thảo quả'),
((SELECT id FROM ingredients WHERE name_key='thao_qua'), 'en', 'Cardamom'),
((SELECT id FROM ingredients WHERE name_key='que_chi'), 'vi', 'Quế chi'),
((SELECT id FROM ingredients WHERE name_key='que_chi'), 'en', 'Cinnamon stick'),
((SELECT id FROM ingredients WHERE name_key='duong_phen'), 'vi', 'Đường phèn'),
((SELECT id FROM ingredients WHERE name_key='duong_phen'), 'en', 'Rock sugar'),
((SELECT id FROM ingredients WHERE name_key='muoi_hot'), 'vi', 'Muối hột'),
((SELECT id FROM ingredients WHERE name_key='muoi_hot'), 'en', 'Salt'),
((SELECT id FROM ingredients WHERE name_key='bot_ngot'), 'vi', 'Bột ngọt'),
((SELECT id FROM ingredients WHERE name_key='bot_ngot'), 'en', 'MSG');

INSERT IGNORE INTO dish_ingredients (dish_id, ingredient_id, quantity) VALUES
(@dish_id, (SELECT id FROM ingredients WHERE name_key='xuong_ong_bo'), '1.5 kg'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='phi_le_bo'), '200g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bo_vien'), '500g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='banh_pho'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_tim'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_la'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_tay'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='chanh'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='gung'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='dinh_huong'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hoa_hoi'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='thao_qua'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='que_chi'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='duong_phen'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='muoi_hot'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bot_ngot'), ' ');

INSERT IGNORE INTO instructions (dish_id, step_number, image_url) VALUES
(@dish_id, 1, 'https://cdn.tgdd.vn/Files/2017/03/18/962092/cach-nau-pho-bo-ngon-chuan-vi-ha-noi-nuoc-dung-dam-da-202201261501257467.jpg'),
(@dish_id, 2, 'https://cdn.tgdd.vn/Files/2017/03/18/962092/cach-nau-pho-bo-ngon-chuan-vi-ha-noi-nuoc-dung-dam-da-202201261501423561.jpg'),
(@dish_id, 3, 'https://cdn.tgdd.vn/Files/2017/03/18/962092/an-lien-3-bat-pho-voi-cong-thuc-nau-pho-nay-202201261426437466.jpg'),
SET @step1_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 1 LIMIT 1);
SET @step2_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 2 LIMIT 1);
SET @step3_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 3 LIMIT 1);
INSERT IGNORE INTO instruction_translations (instruction_id, language_code, description) VALUES
(@step1_id, 'vi', 'Sơ chế nguyên liệu Xương bò mua về rửa thật sạch. Ngâm xương bò trong nước khoảng 30 phút, pha thêm một ít muối hột hòa với chanh để đỡ mùi hôi của bò. Tiếp theo, chần xương qua nước sôi sau đó rửa thật sạch lại một lần nữa. Hành tây sau khi rửa sạch, để ráo nước. Và đem hành tây nướng trên lửa nhỏ, khi có mùi thơm là được. Tiếp theo, phi lê bò rửa thật sạch. Cắt phi lê bò thành lát mỏng, vừa ăn để sắp lên trên phở. Hành là cắt nhuyễn.'),
(@step1_id, 'en', 'Prepare the ingredients Wash the beef bones thoroughly. Soak the beef bones in water for about 30 minutes, add a little salt mixed with lemon to reduce the beef smell. Next, blanch the bones in boiling water and then wash them thoroughly again. After washing the onions, drain them. And grill the onions over low heat until fragrant. Next, wash the beef fillet thoroughly. Cut the beef fillet into thin slices, easy to eat, to arrange on top of the pho. Finely chop the onions.'),
(@step2_id, 'vi', 'Nấu nước dùng Sau đó cho xương vào nồi, thêm 1 lít nước, 1 muỗng canh muối, và hành tây đã nướng và bắt đầu hầm, nếu có nồi áp suất thì dùng nồi áp suất sẽ hầm nhanh hơn. Sau khi hầm xương khoảng 30 phút, cho vào thêm 1.5 lít nước. Tiếp tục cho bò viên và cuối cùng cho đinh hương, thảo quả, quế chi và hoa hồi vào nồi. Chúng ta nấu lửa vừa và lưu ý không đậy nắp, thường xuyên vớt bọt để nước dùng trong và thơm ngon hơn. Sau 30 phút hầm, chúng ta vớt hết xương bò và những gia vị thơm ra. Tiếp theo sẽ nêm phần nước dùng này, cho vào một muỗng canh muối hột, một muỗng canh đường phèn, một muỗng canh bột ngọt và khuấy đều để gia vị được hòa tan.'),
(@step2_id, 'en', 'Cook the broth Then put the bones in the pot, add 1 liter of water, 1 tablespoon of salt, and the roasted onions and start stewing. If you have a pressure cooker, use the pressure cooker to stew faster. After stewing the bones for about 30 minutes, add 1.5 liters of water. Continue to add the beef balls and finally add the cloves, cardamom, cinnamon and star anise to the pot. We cook over medium heat and remember not to cover the lid, regularly skim off the foam to make the broth clearer and more delicious. After 30 minutes of stewing, we remove all the beef bones and aromatic spices. Next, we will season this broth, add a tablespoon of coarse salt, a tablespoon of rock sugar, a tablespoon of MSG and stir well to dissolve the spices.'),
(@step3_id, 'vi', 'Thành phẩm Cho một ít bánh phở vào tô. Xếp những lát bò phi lê lên trên mặt và rắt thêm hành. Chế nước dùng vào, đã sẵn sàng cho bạn thưởng thức rồi nhé.'),
(@step3_id, 'en', 'Finished product Put some pho noodles in a bowl. Arrange the beef fillet slices on top and sprinkle with onions. Pour in the broth and it is ready to enjoy.');