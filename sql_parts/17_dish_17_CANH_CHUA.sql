
USE vnfood;

INSERT IGNORE INTO dishes (class_id, image_url) VALUES (17, 'https://cdnv2.tgdd.vn/bhx-static/bhx/News/Images/2025/04/10/1576718/image3_202504101034423609.jpg');
SET @dish_id = (SELECT id FROM dishes WHERE class_id = 17);
INSERT IGNORE INTO dish_translations (dish_id, language_code, name, description) VALUES
(@dish_id, 'vi', 'Canh Chua', 'Món canh đặc trưng của miền Nam với vị chua từ me, ngọt từ dứa, thanh mát từ các loại rau như bạc hà, giá đỗ, cà chua, nấu cùng cá hoặc tôm.'),
(@dish_id, 'en', 'Vietnamese Sour Soup', 'A traditional Southern Vietnamese soup with a sour taste from tamarind, sweetness from pineapple, and various vegetables like taro stem, bean sprouts, and tomatoes, cooked with fish or shrimp.');
INSERT IGNORE INTO ingredients (name_key) VALUES
('ca_loc'),
('ot_sung'),
('ca_chua'),
('dua'),
('gia_do'),
('dau_bap'),
('tac'),
('bac_ha'),
('toi'),
('ngo_gai'),
('rau_om');

INSERT IGNORE INTO ingredient_translations (ingredient_id, language_code, name) VALUES
((SELECT id FROM ingredients WHERE name_key='ca_loc'), 'vi', 'Cá lóc'),
((SELECT id FROM ingredients WHERE name_key='ca_loc'), 'en', 'Snakehead fish'),
((SELECT id FROM ingredients WHERE name_key='ot_sung'), 'vi', 'Ớt sừng'),
((SELECT id FROM ingredients WHERE name_key='ot_sung'), 'en', 'Chili pepper'),
((SELECT id FROM ingredients WHERE name_key='ca_chua'), 'vi', 'Cà chua'),
((SELECT id FROM ingredients WHERE name_key='ca_chua'), 'en', 'Tomato'),
((SELECT id FROM ingredients WHERE name_key='dua'), 'vi', 'Dứa'),
((SELECT id FROM ingredients WHERE name_key='dua'), 'en', 'Pineapple'),
((SELECT id FROM ingredients WHERE name_key='gia_do'), 'vi', 'Giá đỗ'),
((SELECT id FROM ingredients WHERE name_key='gia_do'), 'en', 'Bean sprouts'),
((SELECT id FROM ingredients WHERE name_key='dau_bap'), 'vi', 'Đậu bắp'),
((SELECT id FROM ingredients WHERE name_key='dau_bap'), 'en', 'Okra'),
((SELECT id FROM ingredients WHERE name_key='tac'), 'vi', 'Tắc'),
((SELECT id FROM ingredients WHERE name_key='tac'), 'en', 'Calamansi'),
((SELECT id FROM ingredients WHERE name_key='bac_ha'), 'vi', 'Bạc hà'),
((SELECT id FROM ingredients WHERE name_key='bac_ha'), 'en', 'Taro stem'),
((SELECT id FROM ingredients WHERE name_key='toi'), 'vi', 'Tỏi'),
((SELECT id FROM ingredients WHERE name_key='toi'), 'en', 'Garlic'),
((SELECT id FROM ingredients WHERE name_key='ngo_gai'), 'vi', 'Ngò gai'),
((SELECT id FROM ingredients WHERE name_key='ngo_gai'), 'en', 'Culantro'),
((SELECT id FROM ingredients WHERE name_key='rau_om'), 'vi', 'Rau om'),
((SELECT id FROM ingredients WHERE name_key='rau_om'), 'en', 'Rice paddy herb');

INSERT IGNORE INTO dish_ingredients (dish_id, ingredient_id, quantity) VALUES
(@dish_id, (SELECT id FROM ingredients WHERE name_key='ca_loc'), '1 '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='ot_sung'), '1 '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='ca_chua'), '3 '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='dua'), '1 '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='gia_do'), '100g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='dau_bap'), '150g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='tac'), '4 '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='bac_ha'), '70g'),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='toi'), '6 '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='ngo_gai'), ' '),
(@dish_id, (SELECT id FROM ingredients WHERE name_key='rau_om'), ' ');

INSERT IGNORE INTO instructions (dish_id, step_number, image_url) VALUES
(@dish_id, 1, 'https://cdnv2.tgdd.vn/bhx-static/bhx/News/Images/2025/04/10/1576718/image9_202504101028334320.jpg'),
(@dish_id, 2, 'https://cdnv2.tgdd.vn/bhx-static/bhx/News/Images/2025/04/10/1576718/image2_202504101029155265.jpg'),
(@dish_id, 3, 'https://cdnv2.tgdd.vn/bhx-static/bhx/News/Images/2025/04/10/1576718/image1_202504101033552509.jpg'),
(@dish_id, 4, 'https://cdnv2.tgdd.vn/bhx-static/bhx/News/Images/2025/04/10/1576718/image4_202504101034123646.jpg'),
(@dish_id, 5, 'https://cdnv2.tgdd.vn/bhx-static/bhx/News/Images/2025/04/10/1576718/image3_202504101034423609.jpg');

SET @step1_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 1 LIMIT 1);
SET @step2_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 2 LIMIT 1);
SET @step3_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 3 LIMIT 1);
SET @step4_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 4 LIMIT 1);
SET @step5_id = (SELECT id FROM instructions WHERE dish_id = @dish_id AND step_number = 5 LIMIT 1);
INSERT IGNORE INTO instruction_translations (instruction_id, language_code, description) VALUES
(@step1_id, 'vi', 'Sơ chế nguyên liệu Trước tiên, làm sạch cá lóc bằng cách đánh vảy, bỏ ruột, rửa cá với nước muối pha loãng và một ít nước cốt chanh để khử mùi tanh. Sau đó, cắt cá thành từng lát dày khoảng 3cm để khi nấu canh cá không bị nát mà vẫn giữ được độ ngọt tự nhiên. Tiếp theo thì bạn sơ chế rau củ: cà chua rửa sạch, cắt thành múi cau; dứa gọt vỏ, bỏ mắt, cắt thành miếng tam giác vừa ăn. Đậu bắp và bạc hà cắt xéo thành từng lát mỏng, còn ớt sừng cắt lát để tăng độ cay nhẹ. Tỏi lột vỏ, băm nhuyễn. Ngò gai, rau om thì bạn cắt nhỏ. Cuối cùng, vắt tắc lấy khoảng 1 muỗng canhnước cốt, lọc bỏ hạt để khi nêm không bị đắng.'),
(@step1_id, 'en', 'Prepare the ingredients First, clean the snakehead fish by removing the scales, gutting it, and washing it with diluted salt water and a little lemon juice to remove the fishy smell. Then, cut the fish into slices about 3cm thick so that when cooking the fish soup, it will not be crushed but still retain its natural sweetness. Next, you prepare the vegetables: wash the tomatoes, cut into wedges; peel the pineapple, remove the eyes, cut into bite-sized triangles. Cut the okra and mint diagonally into thin slices, and cut the chili peppers into slices to increase the mild spiciness. Peel the garlic, mince it. Chop the coriander and the om vegetable. Finally, squeeze the lime to get about 1 tablespoon of juice, filter out the seeds so that it is not bitter when seasoned.'),
(@step2_id, 'vi', 'Ướp cá Sau khi sơ chế xong, bạn tiến hành ướp cá để cá đậm đà hơn khi nấu. Cho cá vào một tô lớn, ướp với 1/3 muỗng canh hạt nêm, 1/2 muỗng canh nước mắm và 1 muỗng cà phê tỏi băm nhuyễn. Dùng đũa trộn đều để gia vị thấm vào cá, sau đó để yên trong khoảng 10 phút.'),
(@step2_id, 'en', 'Marinate the fish After preparing, marinate the fish to make it more flavorful when cooked. Put the fish in a large bowl, marinate with 1/3 tablespoon of seasoning powder, 1/2 tablespoon of fish sauce and 1 teaspoon of minced garlic. Use chopsticks to mix well so that the spices penetrate the fish, then let it sit for about 10 minutes.'),
(@step3_id, 'vi', 'Chiên sơ cá Bạn làm nóng chảo, cho một ít dầu ăn vào và phi tỏi băm cho vàng thơm. Sau đó, gắp từng lát cá vào chảo, chiên sơ ở lửa vừa cho đến khi bề mặt cá săn lại, giúp cá không bị vỡ khi nấu canh. Khi cá vừa săn lại, bạn gắp ra đĩa để riêng.'),
(@step3_id, 'en', 'Fry the fish Heat the pan, add a little cooking oil and fry the minced garlic until golden brown. Then, add each slice of fish to the pan and fry it over medium heat until the surface of the fish is firm, which will prevent the fish from breaking when cooking the soup. When the fish is firm, take it out and put it on a separate plate.'),
(@step4_id, 'vi', 'Nấu canh chua cá lóc Bắc một nồi lớn lên bếp, đổ vào khoảng 1.2 lít nước. Khi nước sôi lăn tăn, bạn cho vào 1/2 muỗng canh muối, 1/2 muỗng canh đường và 1/2 muỗng canh nước mắm, khuấy đều cho tan gia vị. Khi nước sôi, bạn nhẹ nhàng thả cá vào nồi, đun sôi trong khoảng 5 phút cho cá chín thì vớt cá ra. Trong lúc nấu, dùng muôi vớt bọt để nước canh trong hơn. Sau đó, bạn cho dứa, cà chua và đậu bắp vào, tiếp tục đun thêm 3 phút để rau củ chín. Bạn tiếp tục cho vào nồi 1.5 muỗng canh đường, 1 muỗng canh nước mắm và 1 muỗng canh nước cốt tắc. Dùng muỗng khuấy nhẹ để các gia vị hòa quyện, sau đó nếm thử và điều chỉnh lại cho vừa miệng. Khi nồi canh sôi trở lại, bạn cho bạc hà và giá đỗ vào, thêm 1/2 muỗng canh nước mắm để tăng hương vị. Cuối cùng, bạn cho rau om, ngò rí, ớt sừng cắt lát và cá vào nồi, đảo nhẹ một lần rồi tắt bếp. Để món canh thêm thơm, bạn rắc một ít tỏi phi lên trên trước khi múc ra tô.'),
(@step4_id, 'en', 'Cooking sour snakehead fish soup Put a large pot on the stove, pour in about 1.2 liters of water. When the water boils, add 1/2 tablespoon of salt, 1/2 tablespoon of sugar and 1/2 tablespoon of fish sauce, stir well to dissolve the spices. When the water boils, gently drop the fish into the pot, boil for about 5 minutes until the fish is cooked, then remove the fish. While cooking, use a ladle to skim off the foam to make the soup clearer. Then, add the pineapple, tomatoes and okra, continue to boil for another 3 minutes until the vegetables are cooked. Continue to add 1.5 tablespoons of sugar, 1 tablespoon of fish sauce and 1 tablespoon of lime juice to the pot. Use a spoon to stir gently to blend the spices, then taste and adjust to taste. When the pot of soup boils again, add mint and bean sprouts, add 1/2 tablespoon of fish sauce to enhance the flavor. Finally, add the braised vegetables, cilantro, sliced ​​chili peppers and fish to the pot, stir gently once and turn off the stove. To make the soup more fragrant, sprinkle some fried garlic on top before scooping it into a bowl.'),
(@step5_id, 'vi', 'Thành phẩm Bạn múc canh ra tô lớn, xếp cá lóc ở giữa, rau củ xung quanh, rồi rắc thêm hành phi, rau om và vài lát ớt sừng để món ăn thêm đẹp mắt.'),
(@step5_id, 'en', 'Finished product Ladle the soup into a large bowl, arrange the snakehead fish in the middle, vegetables around, then sprinkle with fried onions, braised vegetables and a few slices of chili to make the dish more beautiful.')');
