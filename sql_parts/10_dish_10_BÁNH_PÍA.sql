
USE vnfood;

INSERT IGNORE INTO dishes (class_id, image_url) VALUES (10, 'https://cdn.tgdd.vn/Files/2021/08/06/1373509/cach-lam-banh-pia-sau-rieng-thom-ngon-cuc-de-lam-202201181115290618.jpg');
SET @dish_id = (SELECT id FROM dishes WHERE class_id = 10);
INSERT IGNORE INTO dish_translations (dish_id, language_code, name, description) VALUES
(@dish_id, 'vi', 'Bánh Pía', 'Đặc sản Sóc Trăng, có lớp vỏ xốp nhiều lớp, nhân sầu riêng, đậu xanh và trứng muối.'),
(@dish_id, 'en', 'Banh Pia (Durian Pastry)', 'A Soc Trang specialty, a flaky pastry with multiple layers, filled with durian, mung bean paste, and a salted egg yolk.');
INSERT IGNORE INTO ingredients (name_key) VALUES
('bot_mi_da_dung'), ('dau_xanh'), ('duong_cat'), ('sau_rieng'),
('bot_nang'), ('mo_heo'), ('mach_na'), ('long_do_trung_ga'), ('trung_muoi'), ('bot_no'), ('dau_an'), ('mau_do_thuc_pham'), ('ruou');

INSERT IGNORE INTO ingredient_translations (ingredient_id, language_code, name) VALUES
((SELECT id FROM ingredients WHERE name_key='bot_mi_da_dung'), 'vi', 'Bột mì đa dụng'),
((SELECT id FROM ingredients WHERE name_key='bot_mi_da_dung'), 'en', 'All-purpose flour'),
((SELECT id FROM ingredients WHERE name_key='dau_xanh'), 'vi', 'Đậu xanh bỏ vỏ'),
((SELECT id FROM ingredients WHERE name_key='dau_xanh'), 'en', 'Mung beans'),
((SELECT id FROM ingredients WHERE name_key='duong_cat'), 'vi', 'Đường cát trắng'),
((SELECT id FROM ingredients WHERE name_key='duong_cat'), 'en', 'White sugar'),
((SELECT id FROM ingredients WHERE name_key='sau_rieng'), 'vi', 'Sầu riêng'),
((SELECT id FROM ingredients WHERE name_key='sau_rieng'), 'en', 'Durian'),
((SELECT id FROM ingredients WHERE name_key='bot_nang'), 'vi', 'Bột năng'),
((SELECT id FROM ingredients WHERE name_key='bot_nang'), 'en', 'Tapioca starch'),
((SELECT id FROM ingredients WHERE name_key='mo_heo'), 'vi', 'Mỡ heo'),
((SELECT id FROM ingredients WHERE name_key='mo_heo'), 'en', 'Pork lard'),
((SELECT id FROM ingredients WHERE name_key='mach_na'), 'vi', 'Mạch nha'),
((SELECT id FROM ingredients WHERE name_key='mach_na'), 'en', 'Malt syrup'),
((SELECT id FROM ingredients WHERE name_key='long_do_trung_ga'), 'vi', 'Lòng đỏ trứng gà'),
((SELECT id FROM ingredients WHERE name_key='long_do_trung_ga'), 'en', 'Egg yolk'),
((SELECT id FROM ingredients WHERE name_key='trung_muoi'), 'vi', 'Lòng đỏ trứng muối'),
((SELECT id FROM ingredients WHERE name_key='trung_muoi'), 'en', 'Salted egg yolk'),
((SELECT id FROM ingredients WHERE name_key='bot_no'), 'vi', 'Bột nở'),
((SELECT id FROM ingredients WHERE name_key='bot_no'), 'en', 'Baking powder'),
((SELECT id FROM ingredients WHERE name_key='dau_an'), 'vi', 'Dầu ăn'),
((SELECT id FROM ingredients WHERE name_key='dau_an'), 'en', 'Cooking oil'),
((SELECT id FROM ingredients WHERE name_key='mau_do_thuc_pham'), 'vi', 'Màu đỏ thực phẩm'),
((SELECT id FROM ingredients WHERE name_key='mau_do_thuc_pham'), 'en', 'Food coloring (red)'),
((SELECT id FROM ingredients WHERE name_key='ruou'), 'vi', 'Rượu'),
((SELECT id FROM ingredients WHERE name_key='ruou'), 'en', 'Alcohol');

INSERT IGNORE INTO dish_ingredients (dish_id, ingredient_id, quantity) VALUES
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bot_mi_da_dung'), '400g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='dau_xanh'), '250g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='duong_cat'), '300g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='sau_rieng'), '200g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bot_nang'), '100g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='mo_heo'), '300g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='mach_na'), '15g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='long_do_trung_ga'), '1 quả'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='trung_muoi'), '12 quả'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bot_no'), '4g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='dau_an'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='mau_do_thuc_pham'), ''),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='ruou'), '');

INSERT IGNORE INTO instructions (dish_id, step_number, image_url) VALUES
(@dish_id, 1, 'https://cdn.tgdd.vn/Files/2021/08/06/1373509/cach-lam-banh-pia-sau-rieng-thom-ngon-cuc-de-lam-202108061957389880.jpg'),
(@dish_id, 2, 'https://cdn.tgdd.vn/Files/2021/08/06/1373509/cach-lam-banh-pia-sau-rieng-thom-ngon-cuc-de-lam-202108061958007540.jpg'),
(@dish_id, 3, 'https://cdn.tgdd.vn/Files/2021/08/06/1373509/cach-lam-banh-pia-sau-rieng-thom-ngon-cuc-de-lam-202108061959092115.jpg'),
(@dish_id, 4, 'https://cdn.tgdd.vn/Files/2021/08/06/1373509/cach-lam-banh-pia-sau-rieng-thom-ngon-cuc-de-lam-202108061959271976.jpg'),
(@dish_id, 5, 'https://cdn.tgdd.vn/Files/2021/08/06/1373509/cach-lam-banh-pia-sau-rieng-thom-ngon-cuc-de-lam-202108061959489147.jpg'),
(@dish_id, 6, 'https://cdn.tgdd.vn/Files/2021/08/06/1373509/cach-lam-banh-pia-sau-rieng-thom-ngon-cuc-de-lam-202108062000051797.jpg');

SET @step1_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 1 LIMIT 1);
SET @step2_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 2 LIMIT 1);
SET @step3_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 3 LIMIT 1);
SET @step4_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 4 LIMIT 1);
SET @step5_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 5 LIMIT 1);
SET @step6_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 6 LIMIT 1);



INSERT IGNORE INTO instruction_translations (instruction_id, language_code, description) VALUES
(@step1_id, 'vi', 'Làm phần bột cho vỏ bánh pía Bạn cho 300gr bột mì và 2gr bột nở vào trong một cái thau nhỏ rồi trộn đều. Bạn dùng dao cắt nhỏ 200gr mỡ heo rồi cho vào chảo thắng ở mức lửa vừa để lấy nước mỡ. Bạn thắng cho đến khi mỡ teo lại có màu vàng ươm thì tắt bếp rồi bạn vớt bỏ phần mỡ. Sau đó, bạn vun bột mì và bột nở tạo thành hình cái núi, khoét một lỗ ở giữa đỉnh núi bột rồi cho 40gr đường cát trắng, 120ml nước lọc, 50ml dầu ăn và 50ml mỡ nước vừa thắng với tỉ lệ 1:1 giữa dầu ăn và mỡ. Kế tiếp, bạn dùng tay nhào trộn bột để chúng hòa quyện vào nhau cho đến khi tạo thành một hỗn hợp bột dẻo. Bạn để bột nghỉ trong 30 phút rồi bạn chia bột làm 12 phần bằng nhau.'),
(@step1_id, 'en', 'Put 300g of wheat flour and 2g of baking powder into a small bowl and mix them evenly. Use a knife to chop 200g of pork lard into small pieces, then add it to a pan and render it over medium heat to extract the lard oil. Render until the lard shrinks and turns a golden yellow, then turn off the heat and strain out the solids. After that, mound the flour and baking powder into a mountain shape, poke a hole in the center of the flour mound, then add 40g of granulated white sugar, 120ml of filtered water, 50ml of cooking oil, and 50ml of the rendered lard oil (in a 1:1 ratio between the cooking oil and lard). Next, use your hands to knead and mix the dough until it comes together into an elastic mixture. Let the dough rest for 30 minutes, then divide it into 12 equal parts.'),
(@step2_id, 'vi', 'Làm phần bột cho ruột bánh pía Bạn cho 100gr bột mì, 100gr bột năng và 2gr bột nở vào một cái tô rồi dùng tay trộn đều bột lên. Kế tiếp, bạn cho 20gr đường cát trắng, 35ml mỡ nước, 100ml nước lọc và 45ml dầu ăn vào hỗn hợp bột khô vừa trộn rồi bạn cũng dùng tay trộn đều hỗn hợp trong 5 phút cho đến khi bột quyện đều, dẻo và mịn. Bạn để cho bột nghỉ trong 30 phút. Sau đó, bạn cũng chia bột làm 12 phần bằng nhau.'),
(@step2_id, 'en', 'Make the dough for the pia cake filling Put 100g of flour, 100g of tapioca starch and 2g of baking powder in a bowl and mix the dough well with your hands. Next, add 20g of white sugar, 35ml of lard, 100ml of filtered water and 45ml of cooking oil to the dry flour mixture and mix the mixture well with your hands for 5 minutes until the dough is smooth, elastic and supple. Let the dough rest for 30 minutes. Then, divide the dough into 12 equal parts.'),
(@step3_id, 'vi', 'Làm phần nhân bánh pía Chế biến mỡ heo: Bạn dùng 100gr mỡ lợn rửa sạch rồi cắt thành hạt lựu sau đó luộc chín mỡ. Kế tiếp, bạn vớt phần mỡ đã luộc ra rổ để ráo nước rồi trộn với 60gr đường cát trắng. Sau đó, bạn đem hỗn hợp ra chỗ có nắng để cho mỡ được trong lại. Chế biến trứng muối: Lòng đỏ trứng muối mua về bạn xả sạch dưới vòi nước rồi ngâm chúng trong rượu trắng khoảng 15 phút. Sau đó, bạn lấy trứng ra rồi đem đi hấp chín. Chế biến đậu xanh: Đậu xanh mua về bạn cho chúng vào nước ngâm cho mềm rồi vớt ra để ráo nước. Sau đó, bạn cho đậu xanh vào nồi cùng với 1 lít nước lọc rồi nấu cho đến khi đậu chín mềm. Trong quá trình nấu, bạn nên thường xuyên vớt bọt cho đậu được sạch. Sau khi đậu chín, bạn vớt đậu rồi cho vào máy xay sinh tố và xay cho đậu nhuyễn và mịn. Sên đậu xanh: Bạn cho một cái chảo chống dính lên bếp ở mức lửa lớn để cho chảo được nóng đều. Sau đó, bạn chỉnh lửa ở mức vừa rồi cho đậu xanh đã xay nhuyễn vào chảo cùng với 180gr đường rồi xào đều. Trong quá trình sên đậu, bạn nên cho dầu ăn vào chảo nhiều lần. Bạn sên cho đến khi đậu có độ dẻo và sệt thì bạn tiếp tục cho 200gr sầu riêng xay nhuyễn và 100gr mỡ đường vào xào cùng. Sau khi bạn sên thấy hỗn hợp đã trong, dẻo và không dính vào chảo nữa thì bạn cho 15gr mạch nha vào rồi trộn đều hỗn hợp và tắt bếp. Bạn để cho hỗn hợp được nguội rồi chia làm 12 phần bằng nhau, mỗi phần bạn bọc 1 lòng đỏ trứng muối vài vo thành viên tròn.'),
(@step3_id, 'en', 'Making the Filling for Banh Pia Preparing the Pork Lard: Use 100g of pork fat, wash it clean, then cut it into small cubes and boil until cooked. Next, drain the boiled fat in a colander to remove the water, then mix it with 60g of granulated white sugar. Then, take the mixture to a sunny spot to allow the fat to become clear again. Preparing the Salted Egg Yolks: Rinse the bought salted egg yolks under running water, then soak them in white rice wine for about 15 minutes. After that, remove them and steam until fully cooked. Preparing the Mung Beans: Soak the bought mung beans in water until soft, then drain. Then, place the mung beans in a pot with 1 liter of filtered water and cook until they are soft. During cooking, frequently skim off the foam to keep the beans clean. Once the beans are cooked, drain them, transfer to a blender, and blend until smooth and fine. Cooking the Mung Bean Paste: Place a non-stick pan on the stove over high heat to heat it evenly. Then, reduce to medium heat, add the blended mung beans to the pan along with 180g of sugar, and stir-fry evenly. During the cooking process, add cooking oil to the pan several times. Stir-fry until the mung beans become elastic and thick, then add 200g of blended durian and 100g of the sugared fat, and continue stir-frying together. Once the mixture appears translucent, elastic, and no longer sticks to the pan, add 15g of maltose, mix evenly, and turn off the heat. Let the mixture cool, then divide it into 12 equal parts. For each part, wrap one salted egg yolk and roll into a round ball.'),
(@step4_id, 'vi', 'Cách cán và gói bánh pía Bạn đặt 1 viên bột ở bước 1 ra một mặt phẳng sạch rồi cán mỏng, sau đó bạn tiếp tục đặt 1 viên bột ở bước 2 vào trong rồi bọc kín và vo tròn. Tiếp tục, bạn cán bột tạo thành một hình thoi dài với độ dày khoảng 0,3cm rồi dùng tay cuộn chặt lại theo chiều dọc. Kế tiếp, bạn cán cuộn bột tạo thành hình tròn mỏng, có độ lớn vừa đủ để bọc lấy viên nhân bánh và dư ra một chút. Lưu ý: Bạn nên cán sao cho ở giữa miếng bột thì dày còn các mép bên ngoài mỏng dần để dễ gói bánh. Tiếp tục, bạn đặt viên nhân bánh vào giữa bột vỏ, dùng tay gói lại cho phủ kín nhân và nắn nhẹ xung quanh tạo được hình khối cầu đều. Bạn nên gói lớp vỏ bánh bám sát vào viên nhân bánh, sao cho nhân không bị hở ra ngoài. Bạn dùng tay túm chặt phần bột dư lại rồi để phần túm bột làm đế bánh. Sau khi nặn bánh xong, bạn đặt bánh lên khay nướng có lót giấy nến chống dính rồi bạn dùng tay đè bánh hơi dẹt xuống một chút nhưng đảm bảo bề mặt bánh vẫn bằng phẳng.'),
(@step4_id, 'en', 'Rolling and Wrapping the Banh Pia Place one dough ball from step 1 on a clean flat surface and roll it thin, then place one dough ball from step 2 inside it, wrap it completely, and roll into a ball. Continue by rolling the dough into a long diamond shape about 0.3cm thick, then use your hands to roll it tightly lengthwise. Next, roll the rolled dough into a thin circle, sized just enough to wrap the filling ball with a little excess. Note: You should roll it so that the center of the dough is thicker while the outer edges gradually become thinner to make wrapping easier. Continue by placing the filling ball in the center of the wrapper dough, use your hands to wrap it completely covering the filling, and gently shape around the edges to form an even spherical shape. You should wrap the dough layer closely adhering to the filling ball so that the filling does not leak out. Use your hand to pinch the excess dough tightly and position that pinched part as the base of the pastry. After shaping the pastry, place it on a baking tray lined with non-stick parchment paper, then use your hand to press it slightly flat, but ensure the surface remains even.'),
(@step5_id, 'vi', 'Trang trí bánh Bạn dùng 2 – 3 miếng bông tẩy trang rồi đặt chúng lên một cái đĩa sạch. Sau đó, bạn hòa tan 3 – 4 giọt màu đỏ thực phẩm cùng với một ít nước rồi đổ lên miếng bông. Kế tiếp, bạn dùng tay ấn nhẹ miếng in hình lên mặt bông rồi in lên mặt bánh.'),
(@step5_id, 'en', 'Decorate the cake Use 2-3 cotton pads and place them on a clean plate. Then, dissolve 3-4 drops of red food coloring with a little water and pour it onto the cotton pad. Next, use your hand to lightly press the printed image onto the cotton pad and then print it onto the cake.'),
(@step6_id, 'vi', ' Nướng bánh pía Trước khi nướng, bạn lật úp bánh lại để khi nướng bánh không bị phồng lên. Bạn điều chỉnh lò nướng ở 200 độ C. Sau đó, bạn cho khay bánh vào nướng trong 15 – 20 phút cho đến khi bạn thấy vỏ bánh hơi đục và bắt đầu nở xốp thì bạn lấy bánh ra. Kế tiếp, bạn dùng tăm xăm vài lỗ trên mặt bánh để bánh có lỗ thoát khí. Sau đó, bạn dùng 1 lòng đỏ trứng gà đánh tan với 1 ít nước tạo thành hỗn hợp, bạn cho chổi thấm qua hỗn hợp rồi quét đều lên bánh. Tiếp tục, bạn để khay bánh vào lò ở nhiệt độ 180 độ C và nướng thêm trong 15 phút cho đến khi bánh chín có màu vàng đều là được.'),
(@step6_id, 'en', 'Baking Pia Cake Before baking, turn the cake upside down so that it does not puff up when baked. You adjust the oven to 200 degrees Celsius. Then, you put the baking tray in the oven for 15 - 20 minutes until you see the cake crust is slightly opaque and begins to puff up, then you take the cake out. Next, you use a toothpick to poke a few holes on the surface of the cake so that the cake has air holes. Then, you use 1 egg yolk beaten with a little water to create a mixture, you use a brush to soak the mixture and then brush it evenly on the cake. Continue, you put the baking tray in the oven at 180 degrees Celsius and bake for another 15 minutes until the cake is cooked and golden brown.');