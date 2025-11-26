
USE vnfood;

INSERT IGNORE INTO dishes (class_id, image_url) VALUES (11, 'https://cdn.tgdd.vn/Files/2020/10/24/1301703/chia-se-cach-lam-banh-tet-cuc-nhanh-chi-20-phut-la-chin-202110271428206976.jpg');
SET @dish_id = (SELECT id FROM dishes WHERE class_id = 11);
INSERT IGNORE INTO dish_translations (dish_id, language_code, name, description) VALUES
(@dish_id, 'vi', 'Bánh Tét', 'Tương tự bánh chưng nhưng có hình trụ dài, phổ biến ở miền Nam. Nguyên liệu là gạo nếp, đậu xanh, thịt mỡ, gói trong lá chuối.'),
(@dish_id, 'en', 'Banh Tet (Sticky Rice Log)', 'Similar to Banh Chung but in a cylindrical log shape, popular in Southern Vietnam. Ingredients are glutinous rice, mung bean, and fatty pork, wrapped in banana leaves.');
INSERT IGNORE INTO ingredients (name_key) VALUES
('gao_nep'), ('rau_bina'), ('thit_heo'), ('dau_xanh'), ('nuoc_cot_dua'), ('hanh_tay'), ('duong'), ('muoi'), ('tieu'), ('ruou_sake');

INSERT IGNORE INTO ingredient_translations (ingredient_id, language_code, name) VALUES
((SELECT id FROM ingredients WHERE name_key='gao_nep'), 'vi', 'Gạo nếp'),
((SELECT id FROM ingredients WHERE name_key='gao_nep'), 'en', 'Sticky rice'),
((SELECT id FROM ingredients WHERE name_key='rau_bina'), 'vi', 'Rau bina'),
((SELECT id FROM ingredients WHERE name_key='rau_bina'), 'en', 'Spinach'),
((SELECT id FROM ingredients WHERE name_key='thit_heo'), 'vi', 'Thịt heo cắt lát'),
((SELECT id FROM ingredients WHERE name_key='thit_heo'), 'en', 'Sliced pork'),
((SELECT id FROM ingredients WHERE name_key='dau_xanh'), 'vi', 'Đậu xanh không vỏ'),
((SELECT id FROM ingredients WHERE name_key='dau_xanh'), 'en', 'Mung beans (hulled)'),
((SELECT id FROM ingredients WHERE name_key='nuoc_cot_dua'), 'vi', 'Nước cốt dừa'),
((SELECT id FROM ingredients WHERE name_key='nuoc_cot_dua'), 'en', 'Coconut milk'),
((SELECT id FROM ingredients WHERE name_key='hanh_tay'), 'vi', 'Hành tây'),
((SELECT id FROM ingredients WHERE name_key='hanh_tay'), 'en', 'Onion'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'vi', 'Đường'),
((SELECT id FROM ingredients WHERE name_key='duong'), 'en', 'Sugar'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'vi', 'Muối'),
((SELECT id FROM ingredients WHERE name_key='muoi'), 'en', 'Salt'),
((SELECT id FROM ingredients WHERE name_key='tieu'), 'vi', 'Tiêu'),
((SELECT id FROM ingredients WHERE name_key='tieu'), 'en', 'Pepper'),
((SELECT id FROM ingredients WHERE name_key='ruou_sake'), 'vi', 'Rượu sake'),
((SELECT id FROM ingredients WHERE name_key='ruou_sake'), 'en', 'Sake');

INSERT IGNORE INTO dish_ingredients (dish_id, ingredient_id, quantity) VALUES
(@dish_id, (SELECT id FROM ingredients WHERE name_key='gao_nep'), '500g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='rau_bina'), '8'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='thit_heo'), '225g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='dau_xanh'), '160g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='nuoc_cot_dua'), '250ml'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='hanh_tay'), '50g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='duong'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='muoi'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tieu'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='ruou_sake'), '');
INSERT IGNORE INTO instructions (dish_id, step_number, image_url) VALUES
(@dish_id, 1, 'https://cdn.tgdd.vn/Files/2020/10/24/1301703/chia-se-cach-lam-banh-tet-cuc-nhanh-chi-20-phut-la-chin-202010241928161379.jpg'),
(@dish_id, 2, 'https://cdn.tgdd.vn/Files/2020/10/24/1301703/chia-se-cach-lam-banh-tet-cuc-nhanh-chi-20-phut-la-chin-202010241928365656.jpg'),
(@dish_id, 3, 'https://cdn.tgdd.vn/Files/2020/10/24/1301703/chia-se-cach-lam-banh-tet-cuc-nhanh-chi-20-phut-la-chin-202010241928482499.jpg'),
(@dish_id, 4, 'https://cdn.tgdd.vn/Files/2020/10/24/1301703/chia-se-cach-lam-banh-tet-cuc-nhanh-chi-20-phut-la-chin-202010241929068075.jpg'),
(@dish_id, 5, 'https://cdn.tgdd.vn/Files/2020/10/24/1301703/chia-se-cach-lam-banh-tet-cuc-nhanh-chi-20-phut-la-chin-202010241929239233.jpg'),
(@dish_id, 6, 'https://cdn.tgdd.vn/Files/2020/10/24/1301703/chia-se-cach-lam-banh-tet-cuc-nhanh-chi-20-phut-la-chin-202010241929342883.jpg'),
(@dish_id, 7, 'https://cdn.tgdd.vn/Files/2020/10/24/1301703/chia-se-cach-lam-banh-tet-cuc-nhanh-chi-20-phut-la-chin-202010241929482649.jpg');

SET @step1_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 1 LIMIT 1);
SET @step2_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 2 LIMIT 1);
SET @step3_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 3 LIMIT 1);
SET @step4_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 4 LIMIT 1);
SET @step5_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 5 LIMIT 1);
SET @step6_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 6 LIMIT 1);
SET @step7_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 7 LIMIT 1);
INSERT IGNORE INTO instruction_translations (instruction_id, language_code, description) VALUES
(@step1_id, 'vi', ' Sơ chế nguyên liệu Đần tiêu, bạn cho vào thịt heo cùng 10g đường, một ít muối, ít tiêu, hành băm và 1 muỗng cà phê rượu vào một cái tô vàtrộn đều. Sau đó, bạn đem nếp, đậu xanh và rau bina rửa sạch. Xong thì bạn cắt rau thành các khúc nhỏ, bỏ vào tô cùng 500ml nước và bắt đầu xay nhuyễn. Sau đó, bạn lọc hỗn hợp qua rây, giữ phần nước cốt rau và hớt bỏ bọt phía trên. Tiếp theo, bạn cho nếp đã rửa vào ngâm trong 300ml nước rau khoảng 2 tiếng để tạo màu xanh đẹp mắt cho bánh. Còn đậu xanh bạn cũng đem ngâm tầm 2 tiếng luôn nha.'),
(@step1_id, 'en', 'Prepare the ingredients Dần tiêu, you put in the pork with 10g of sugar, a little salt, a little pepper, minced onion and 1 teaspoon of wine in a bowl and mix well. Then, you wash the sticky rice, mung beans and spinach. Then, you cut the vegetables into small pieces, put them in a bowl with 500ml of water and start pureeing. Then, you filter the mixture through a sieve, keep the vegetable juice and skim off the foam on top. Next, you soak the washed sticky rice in 300ml of vegetable water for about 2 hours to create a beautiful green color for the cake. As for the mung beans, you also soak them for about 2 hours.'),
(@step2_id, 'vi', 'Nấu thịt Bạn cho 150ml nước và 70ml rượu sake lên chảo, khi hỗn hợp sôi thì cho thịt heo đã ướp vào. Đậy nắp và nấu đến khi cạn nước là được. Xong thì bạn gắp thịt ra dĩa.'),
(@step2_id, 'en', 'Cook the meat Put 150ml of water and 70ml of sake in a pan, when the mixture boils, add the marinated pork. Cover and cook until the water is gone. When finished, take the meat out and put it on a plate.'),
(@step3_id, 'vi', 'Thắng nước cốt Bạn bắc 250ml nước cốt dừa vào chảo, khi hỗn hợp sôi lên thì bạn dùng giá khuấy đều và hạ lửa nhỏ xuống. Bạn tiếp tục đảo đều đến khi ra dầu và cái chuyển sang màu trắng vàng thì tắt lửa.'),
(@step3_id, 'en', 'Coconut milk Put 250ml of coconut milk in the pan, when the mixture boils, use a spoon to stir well and reduce the heat to low. Continue stirring until the oil comes out and the mixture turns golden white, then turn off the heat.'),
(@step4_id, 'vi', 'Nấu nếp và đậu xanh Bạn cho nếp đã ngâm vào tô chịu nhiệt, đổ dừa thắng lên trên, trộn đều và dàn đều ra. Sau đó, bạn đổ 300ml nước cốt rau bina vào tô nếp, rồi dùng màng bọc thực phẩm bọc kín lại. Xong thì bạn đem bỏ vào lò vi sóng, nấu trong 10 phút ở 500W. Tương tự như vậy, bạn cũng cho đậu xanh đã ngâm vào tô chịu nhiệt, rồi rót thêm 170ml nước vào. Tiếp đến, bạn đặt tô đậu vào lò vi sóng, nấu trong 8 phút ở 500W. Đây là bước quan trọng tạo điều kiện để việc luộc bánh được diễn ra nhanh hơn đó. '),
(@step4_id,'en', 'Cook sticky rice and mung beans Put the soaked sticky rice in a heat-resistant bowl, pour the melted coconut on top, mix well and spread evenly. Then, pour 300ml of spinach juice into the bowl of sticky rice, then cover it with plastic wrap. Then, put it in the microwave and cook for 10 minutes at 500W. Similarly, put the soaked mung beans in a heat-resistant bowl, then pour in 170ml of water. Next, put the bowl of beans in the microwave and cook for 8 minutes at 500W. This is an important step to help the cake boil faster.'),
(@step5_id, 'vi', 'Gói bánh Bạn chia nếp và đậu đã nấu thành 6 phần bằng nhau. Sau đó, bạn lần lượt trải màng bọc thực phẩm và giấy nến lên bàn. Xong thì bạn múc 1 phần nếp dàn mỏng trên tờ giấy nến, rồi tới dàn 1 phần đậu lên và đặt miếng thịt luộc lên trên cùng. Tiếp đến, bạn lại cho thêm 1 phần đậu lên trên miếng thịt, rồi thêm 1 phần nếp lên trên cùng và cuộn tròn lại. Xong thì bạn gói thêm một lớp giấy nến bên ngoài, rồi mới dùng dây buộc bánh lại.'),
(@step5_id, 'en', 'Wrapping the cake Divide the cooked sticky rice and beans into 6 equal parts. Then, spread the plastic wrap and wax paper on the table. Then, scoop out 1 portion of sticky rice and spread it thinly on the wax paper, then spread 1 portion of beans on top and place the boiled meat on top. Next, add 1 portion of beans on top of the meat, then add 1 portion of sticky rice on top and roll it up. Then, wrap another layer of wax paper on the outside, then use string to tie the cake.'),
(@step6_id, 'vi', 'Nấu bánh Bạn cho nước vào khoảng nửa nồi áp suất và đun sôi. Khi nước sôi thì bạn cho bánh vào, đặt dĩa lên trên để giữ cho bánh luôn nằm trong nước. Xong thì bạn hãy luộc trong vòng 20 phút nhé. Cuối cùng, khi bánh chín, bạn có thể cắt thành từng khoanh và thưởng thức thôi nào.'),
(@step6_id, 'en', 'Cook the cake You fill the pressure cooker about half way with water and bring to a boil. When the water boils, you put the cake in, put a plate on top to keep the cake in the water. Then boil for 20 minutes. Finally, when the cake is done, you can cut it into slices and enjoy.'),
(@step7_id, 'vi', 'Thành phẩm Bánh sau khi được luộc trong nồi áp suất xong thì vô cùng thơm luôn. Bánh có màu xanh tươi rất đẹp mắt, gần giống với bánh gói bằng lá vậy. Khi thưởng thức, bạn sẽ cảm nhận được từng hạt nếp dẻo mềm, không bị nhão hay bị sượng gì cả. Trong đó, còn có vị bùi bùi của đậu xanh, beo béo từ nước cốt dừa và thịt heo thơm ngon, đậm vị nữa. Phải nói là rất tuyệt luôn.'),
(@step6_id, 'en', 'Finished product The cake is extremely fragrant after being boiled in the pressure cooker. The cake has a beautiful green color, similar to the cake wrapped in leaves. When enjoying it, you will feel each grain of sticky rice is soft, not mushy or tough. In it, there is also the rich taste of green beans, the fatty taste of coconut milk and the delicious, flavorful pork. It must be said that it is absolutely wonderful.')');
