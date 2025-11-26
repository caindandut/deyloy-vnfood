-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 26, 2025 lúc 03:11 PM
-- Phiên bản máy phục vụ: 8.0.42
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `vnfood`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dishes`
--

CREATE TABLE `dishes` (
  `id` int NOT NULL,
  `class_id` int NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `video_url` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `dishes`
--

INSERT INTO `dishes` (`id`, `class_id`, `image_url`, `video_url`) VALUES
(1, 0, 'https://cdn.tgdd.vn/Files/2017/03/21/963426/cach-lam-banh-beo-thom-ngon-202110041645542724.jpg', 'https://youtu.be/gn2LsgCc3tI?si=0LE0JMpqHXL5FnEz'),
(2, 1, 'https://cdn.tgdd.vn/Files/2021/09/07/1380725/cach-lam-banh-bot-loc-goi-la-chuoi-dai-ngon-khong-can-khuay-202109301937549626.jpg', 'https://youtu.be/cIW9IrNk-5w?si=vtoWK36ZkevHGxxS'),
(3, 2, 'https://cdn.tgdd.vn/Files/2022/05/31/1436004/cach-lam-banh-can-mien-trung-don-gian-chuan-vi-que-huong-202205310707582924.jpg', 'https://youtu.be/Lz8qgx6yrbI?si=R3oHnHB_VeHQ2Zy9'),
(4, 3, 'https://cdn.tgdd.vn/Files/2021/07/26/1370866/cach-nau-banh-canh-ca-loc-bot-gao-thom-ngon-doi-vi-cho-ca-nha-deu-me-202107261314191350.jpg', 'https://youtu.be/ql64992r1KA?si=87h4PRK-PE2DeSdT'),
(5, 4, 'https://cdn.tgdd.vn/Files/2016/12/30/932155/cach-lam-banh-chung-thom-ngon-xanh-deo-dam-da-huong-vi-tet-202209011455226787.jpg', 'https://youtu.be/ZGs59VEu3hQ?si=zrY8srmYwF_8hRo3'),
(6, 5, 'https://cdn.tgdd.vn/Files/2022/01/03/1408683/tong-hop-12-cach-lam-banh-cuon-tai-nha-ngon-nhu-ngoai-hang-202203161544081729.jpg', 'https://youtu.be/1InuluyRWSc?si=PxD_6z9Heot7qW_g'),
(7, 6, 'https://cdn.tgdd.vn/Files/2021/08/03/1372652/cach-lam-banh-duc-nong-ngon-khong-dung-voi-va-han-the-202201051626183294.jpg', 'https://youtu.be/oLxsXVXiLr8?si=Txisr25Ae26HXpsx'),
(8, 7, 'https://cdn.tgdd.vn/Files/2019/11/20/1220697/huong-dan-cach-lam-banh-gio-nong-mem-min-don-gian-8-760x367.jpg', 'https://youtu.be/-YA9ey_0GRU?si=Z3OTD9J-KhOiy3YG'),
(13, 8, 'https://cdn.tgdd.vn/Files/2020/10/13/1298451/cach-lam-banh-khot-vang-uom-gion-rum-ca-tieng-ma-khong-can-khuon-202203212135419978.jpg', 'https://youtu.be/Rvo3698rSfk?si=4ga8Lt03WXBkLLsj'),
(15, 9, 'https://cdn.tgdd.vn/Files/2021/06/28/1363869/cach-lam-banh-mi-pate-thom-ngon-lot-bung-cho-bua-sang-202112311511081198.jpg', 'https://youtu.be/iOyQWmalmuI?si=3JCi8-B4G4tcx3Lb'),
(16, 10, 'https://cdn.tgdd.vn/Files/2021/08/06/1373509/cach-lam-banh-pia-sau-rieng-thom-ngon-cuc-de-lam-202201181115290618.jpg', 'https://youtu.be/kiFbeaeIpaw?si=be9ezuRkaJzRH4np'),
(17, 11, 'https://cdn.tgdd.vn/Files/2020/10/24/1301703/chia-se-cach-lam-banh-tet-cuc-nhanh-chi-20-phut-la-chin-202110271428206976.jpg', 'https://youtu.be/et3w1WeSbYU?si=AmmSWXhGPxKxeGdH'),
(18, 12, 'https://cdn.tgdd.vn/Files/2017/03/12/960051/cach-lam-banh-trang-nuong-ngon-cuc-nhanh-voi-chao-chong-dinh-202201051016161312.jpg', 'https://youtu.be/S7htO6EVF78?si=XaYM6BJ57iErUagQ'),
(22, 13, 'https://cdn.tgdd.vn/2021/04/CookProduct/1200-1200x676-70.jpg', 'https://youtu.be/olt5tmCmAd4?si=OWjgIupaME_DREMz'),
(23, 14, 'https://cdn.tgdd.vn/Files/2017/03/24/964495/cach-nau-bun-bo-hue-gio-heo-ngon-cong-thuc-chuan-vi-202208251613352995.jpg', 'https://youtu.be/A_o2qfaTgKs?si=e7J18A-T913MOAPJ'),
(24, 15, 'https://cdn.tgdd.vn/2021/12/CookDish/cach-lam-bun-dau-mam-tom-ngon-ngat-ngay-an-mot-lan-la-ghien-avt-1200x675.jpg', 'https://youtu.be/17G58vEKVJE?si=xNNuY5Q71Pd5cyp1'),
(26, 16, 'https://cdn.tgdd.vn/Files/2021/02/23/1329799/bi-quyet-nau-ca-kho-to-ngon-chuan-vi-ca-dai-mau-sac-chuan-dep-202208271627215315.jpg', 'https://youtu.be/zvlct2ZXhj8?si=aU0ZsuN_O2Y-lhuG'),
(27, 17, 'https://cdnv2.tgdd.vn/bhx-static/bhx/News/Images/2025/04/10/1576718/image3_202504101034423609.jpg', 'https://youtu.be/AQoI-o35EMA?si=VAUShp_6XYJheJl9'),
(28, 18, 'https://cdn.tgdd.vn/Files/2017/03/23/964106/cach-nau-chao-long-thom-ngon-sanh-ngang-hang-quan-202208261704159586.jpg', 'https://youtu.be/A3N2lnGIbvI?si=wbRJOKB0jb3AK1Vl'),
(29, 19, 'https://cdn.tgdd.vn/Files/2021/08/16/1375565/cach-nau-com-tam-suon-bi-cha-tai-nha-ngon-nhu-ngoai-tiem-202108162216045436.jpg', 'https://youtu.be/cJu6tFJe_Gc?si=959TmkTOjjjav1wc'),
(30, 20, 'https://cdn.tgdd.vn/Files/2017/03/22/963738/cach-lam-goi-cuon-tom-thit-thom-ngon-cho-bua-com-gian-don-202203021427281747.jpg', 'https://youtu.be/LJ_3BeqH63w?si=iRoK2CSUKMIq4AWW'),
(31, 21, 'https://cdn.tgdd.vn/Files/2019/03/08/1153609/cach-nau-mi-quang-dung-vi-ma-khong-can-ra-tiem-202201101026008893.jpg', 'https://youtu.be/mRYABUuK6RE?si=-54JXW7BSXFe1tHp'),
(32, 22, 'https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/2024_1_9_638404130081431753_cach-lam-nem-chua-thumb.jpg', 'https://youtu.be/S3GOw-Dx7aM?si=-mclAJY3kMVT-5aK'),
(33, 23, 'https://cdn.tgdd.vn/Files/2017/03/18/962092/an-lien-3-bat-pho-voi-cong-thuc-nau-pho-nay-202201261419401397.jpg', 'https://youtu.be/99tOr7JSr0k?si=ZpWlIBiqmMhBQoln'),
(35, 24, 'https://cdn.tgdd.vn/Files/2022/11/17/1487645/cach-nau-xoi-xeo-ngo-thom-ngon-deo-dep-mat-cho-bua-sang-202211171330393361.jpg', 'https://youtu.be/udUgaFFiA6M?si=TtNUwLhLRUSKBctp');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dish_ingredients`
--

CREATE TABLE `dish_ingredients` (
  `dish_id` int NOT NULL,
  `ingredient_id` int NOT NULL,
  `quantity` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `dish_ingredients`
--

INSERT INTO `dish_ingredients` (`dish_id`, `ingredient_id`, `quantity`) VALUES
(1, 1, '200g'),
(1, 2, '30g'),
(1, 3, '300g'),
(1, 4, '100g'),
(1, 5, ''),
(1, 8, ''),
(1, 9, ''),
(1, 10, ''),
(2, 2, '400g'),
(2, 10, ''),
(2, 11, '1 gói'),
(2, 12, '300g'),
(2, 13, '300g'),
(2, 14, ''),
(2, 15, ''),
(2, 16, ''),
(2, 17, ''),
(2, 18, ''),
(2, 19, ''),
(3, 1, '200g'),
(3, 2, '100g'),
(3, 8, ''),
(3, 9, ''),
(3, 10, ''),
(3, 12, '200g'),
(3, 15, ''),
(3, 16, ''),
(3, 17, ''),
(3, 19, ''),
(3, 22, '10 quả'),
(3, 23, '100g'),
(3, 24, '20g'),
(3, 25, ''),
(3, 26, ''),
(3, 27, ''),
(3, 28, ''),
(3, 29, ''),
(3, 30, ''),
(4, 8, ''),
(4, 9, ''),
(4, 15, ''),
(4, 16, ''),
(4, 17, ''),
(4, 19, ''),
(4, 25, ''),
(4, 26, ''),
(4, 41, '100g'),
(4, 42, '500g'),
(4, 43, '1kg'),
(4, 44, ''),
(4, 45, ''),
(4, 46, ''),
(4, 47, ''),
(4, 48, ''),
(5, 9, ''),
(5, 10, ''),
(5, 11, ''),
(5, 16, ''),
(5, 57, '650g'),
(5, 58, '300g'),
(5, 59, '400g'),
(6, 1, '500g'),
(6, 6, ''),
(6, 7, ''),
(6, 8, ''),
(6, 9, ''),
(6, 10, ''),
(6, 19, ''),
(6, 64, '500g'),
(6, 65, '300g'),
(6, 66, '100g'),
(6, 67, '100g'),
(6, 68, '1 củ'),
(6, 69, ''),
(7, 2, '100g'),
(7, 4, '20g'),
(7, 5, '100g'),
(7, 6, ''),
(7, 7, ''),
(7, 8, '50ml'),
(7, 9, '50g'),
(7, 10, ''),
(7, 16, '3g'),
(7, 17, '30ml'),
(7, 77, '100g'),
(7, 78, '600ml'),
(7, 79, '15ml'),
(7, 80, '200g'),
(7, 81, '10g'),
(7, 82, '10g'),
(7, 83, '50 ml'),
(7, 84, '100g'),
(8, 1, '320g'),
(8, 2, '80g'),
(8, 10, ''),
(8, 11, '10'),
(8, 15, ''),
(8, 16, ''),
(8, 17, ''),
(8, 19, ''),
(8, 22, '10'),
(8, 25, '200g'),
(8, 66, '30g'),
(8, 68, ''),
(8, 82, '20g'),
(8, 95, '200g'),
(8, 96, '500ml'),
(8, 97, ''),
(13, 1, '200g'),
(13, 6, ''),
(13, 7, ''),
(13, 8, ''),
(13, 9, ''),
(13, 10, ''),
(13, 12, '400g'),
(13, 27, ''),
(13, 30, ''),
(13, 143, '100g'),
(13, 144, '470ml'),
(15, 6, ''),
(15, 9, ''),
(15, 97, ''),
(15, 165, '300g'),
(15, 166, '100g'),
(15, 167, '300ml'),
(15, 168, '1'),
(15, 169, '2'),
(15, 170, ''),
(15, 171, ''),
(16, 2, '100g'),
(16, 17, ''),
(16, 175, '400g'),
(16, 176, '250g'),
(16, 177, '300g'),
(16, 178, '200g'),
(16, 179, '300g'),
(16, 180, '15g'),
(16, 181, '1 quả'),
(16, 182, '12 quả'),
(16, 183, '4g'),
(16, 184, ''),
(16, 185, ''),
(17, 9, ''),
(17, 10, ''),
(17, 13, '225g'),
(17, 16, ''),
(17, 57, '500g'),
(17, 68, '50g'),
(17, 176, '160g'),
(17, 188, '8'),
(17, 189, '250ml'),
(17, 190, ''),
(18, 4, ' '),
(18, 16, ' '),
(18, 95, '20g'),
(18, 198, '5'),
(18, 199, '3'),
(18, 200, '20g'),
(18, 201, '5'),
(18, 202, ' '),
(18, 203, ' '),
(18, 204, ' '),
(18, 205, ' '),
(22, 4, ' '),
(22, 5, ' '),
(22, 9, ' '),
(22, 10, ' '),
(22, 12, '200g'),
(22, 16, ' '),
(22, 27, '10g'),
(22, 68, ''),
(22, 80, '200g'),
(22, 82, '30g'),
(22, 242, '200g'),
(22, 243, '100ml'),
(22, 244, '100g'),
(22, 245, ' '),
(22, 246, ' '),
(23, 5, ' '),
(23, 6, ' '),
(23, 7, ' '),
(23, 9, ' '),
(23, 10, ' '),
(23, 16, ' '),
(23, 17, ' '),
(23, 19, ' '),
(23, 68, ' '),
(23, 83, ' '),
(23, 170, ' '),
(23, 202, ' '),
(23, 245, ' '),
(23, 246, '50g'),
(23, 257, '1 kg'),
(23, 258, '800g'),
(23, 259, '500g'),
(23, 260, '500g'),
(23, 261, ' '),
(23, 262, '100g'),
(23, 263, '100g'),
(23, 264, '10'),
(23, 265, '2 kg'),
(23, 266, '40g'),
(23, 267, ' '),
(23, 268, ' '),
(23, 269, ' '),
(24, 6, ' '),
(24, 168, ' '),
(24, 284, '500g'),
(24, 285, '2 miếng'),
(24, 286, '400g'),
(24, 287, ' '),
(24, 288, ' '),
(24, 289, ' '),
(24, 290, ' '),
(26, 2, ' '),
(26, 4, ' '),
(26, 5, ' '),
(26, 6, ' '),
(26, 7, ' '),
(26, 28, ' '),
(26, 83, ' '),
(26, 302, '1kg'),
(26, 303, '250g'),
(26, 304, '1'),
(26, 305, ' '),
(26, 306, ' '),
(26, 307, ' '),
(27, 6, '6 '),
(27, 43, '1 '),
(27, 244, '100g'),
(27, 290, '4 '),
(27, 304, '1 '),
(27, 315, '1 '),
(27, 316, '3 '),
(27, 317, '150g'),
(27, 318, '70g'),
(27, 319, ' '),
(27, 320, ' '),
(28, 4, ' '),
(28, 5, ' '),
(28, 7, ' '),
(28, 42, '500g'),
(28, 83, ' '),
(28, 165, ' '),
(28, 170, ' '),
(28, 244, ' '),
(28, 246, ' '),
(28, 326, ' '),
(28, 327, '100g'),
(28, 328, ' '),
(28, 329, '100g'),
(28, 330, ' '),
(28, 331, ' '),
(29, 4, ' '),
(29, 8, ' '),
(29, 9, ' '),
(29, 10, ' '),
(29, 15, ' '),
(29, 25, ' '),
(29, 26, ' '),
(29, 28, ' '),
(29, 166, '100g'),
(29, 168, ' '),
(29, 201, '3'),
(29, 269, ' '),
(29, 316, ' '),
(29, 341, '4'),
(29, 342, '300g'),
(29, 343, '60g'),
(29, 344, '50g'),
(29, 345, '50g'),
(29, 346, ' '),
(29, 347, '5 '),
(29, 348, ' '),
(29, 349, ' '),
(29, 350, ' '),
(29, 351, ' '),
(29, 352, ' '),
(30, 5, ' '),
(30, 6, ' '),
(30, 7, ' '),
(30, 9, ' '),
(30, 10, ' '),
(30, 12, '300g'),
(30, 19, ' '),
(30, 58, '1 kg'),
(30, 168, ' '),
(30, 170, ' '),
(30, 198, ''),
(30, 268, ' '),
(30, 366, '500g'),
(30, 367, ' '),
(30, 368, ' '),
(30, 369, ' '),
(30, 370, ' '),
(30, 371, ' '),
(31, 5, '1'),
(31, 6, '2'),
(31, 8, ' '),
(31, 9, ' '),
(31, 10, ' '),
(31, 12, '200g'),
(31, 16, ' '),
(31, 22, '8 '),
(31, 27, '10g'),
(31, 42, '200g'),
(31, 58, '150g'),
(31, 170, ' '),
(31, 268, ' '),
(31, 351, ' '),
(31, 367, ' '),
(31, 369, ' '),
(31, 384, '300g'),
(31, 385, '1 kg'),
(31, 386, '2'),
(31, 387, ' '),
(31, 388, '5g'),
(32, 6, ' '),
(32, 7, ' '),
(32, 8, ' '),
(32, 9, ' '),
(32, 11, ' '),
(32, 19, ' '),
(32, 166, '100g'),
(32, 352, ' '),
(32, 405, '500g'),
(32, 406, ' '),
(32, 407, ' '),
(32, 408, ' '),
(32, 409, ' '),
(33, 4, ' '),
(33, 5, ' '),
(33, 68, ' '),
(33, 83, ' '),
(33, 246, ' '),
(33, 257, '1.5 kg'),
(33, 269, ' '),
(33, 418, '200g'),
(33, 419, '500g'),
(33, 420, ' '),
(33, 421, ' '),
(33, 422, ' '),
(33, 423, ' '),
(33, 424, ' '),
(33, 425, ' '),
(33, 426, ' '),
(35, 10, ' '),
(35, 57, '500g'),
(35, 59, '150g'),
(35, 97, ' '),
(35, 434, ' '),
(35, 435, ' '),
(35, 436, ' ');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dish_translations`
--

CREATE TABLE `dish_translations` (
  `dish_id` int NOT NULL,
  `language_code` varchar(5) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `region_info` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `dish_translations`
--

INSERT INTO `dish_translations` (`dish_id`, `language_code`, `name`, `description`, `region_info`) VALUES
(1, 'en', 'Water Fern Cake', 'Traditional Central Vietnamese steamed rice cakes, served in small bowls with dried shrimp floss, scallion oil, and a sweet and savory dipping sauce.', 'Hue specialty that represents Central Vietnamese cuisine.'),
(1, 'vi', 'Bánh Bèo', 'Bánh gạo hấp truyền thống kiểu miền Trung, ăn kèm tôm chấy, mỡ hành, và nước mắm chua ngọt đặc sệt.', 'Đặc sản xứ Huế, tinh hoa ẩm thực miền Trung.'),
(2, 'en', 'Tapioca Dumplings', 'Dumplings with a clear, chewy tapioca wrapper, filled with shrimp and pork, typically wrapped in banana leaves and steamed.', 'Hue favorite featuring chewy tapioca dumplings with shrimp and pork.'),
(2, 'vi', 'Bánh Bột Lọc', 'Bánh có vỏ ngoài trong suốt làm từ bột năng, nhân tôm thịt, thường được gói trong lá chuối và hấp chín.', 'Đặc sản Huế với lớp vỏ bột lọc dai và nhân tôm thịt đậm đà.'),
(3, 'en', 'Banh Can (Mini Pancakes)', 'A small, savory pancake grilled in a terracotta mold, made from rice flour, often topped with egg, shrimp, or squid, served with a dipping sauce.', 'Street staple from Ninh Thuan and Binh Thuan in south-central Vietnam.'),
(3, 'vi', 'Bánh Căn', 'Bánh được nướng trong khuôn đất nung, làm từ bột gạo, thường có nhân trứng, tôm hoặc mực, ăn kèm nước chấm.', 'Món ăn đường phố nổi tiếng của Ninh Thuận - Bình Thuận (Nam Trung Bộ).'),
(4, 'en', 'Banh Canh (Thick Noodle Soup)', 'A soup dish with thick, chewy noodles (made from rice flour or tapioca), a broth simmered from bones, served with fish cakes, pork, or pork hock.', 'Comforting noodle soup associated with Quang Tri in Central Vietnam.'),
(4, 'vi', 'Bánh Canh', 'Một món súp với sợi bánh to và dai (làm từ bột gạo hoặc bột lọc), nước dùng hầm từ xương, ăn kèm chả cá, thịt, giò heo.', 'Bánh canh Quảng Trị - món súp đậm vị miền Trung.'),
(5, 'en', 'Banh Chung (Sticky Rice Cake)', 'A traditional Vietnamese rice cake for the Lunar New Year, made from glutinous rice, mung beans, pork, wrapped in dong leaves and boiled for many hours.', 'Tet holiday icon from Northern Vietnam, especially Hanoi.'),
(5, 'vi', 'Bánh Chưng', 'Loại bánh truyền thống trong ngày Tết, làm từ gạo nếp, đậu xanh, thịt lợn, gói trong lá chuối và luộc chín trong nhiều giờ.', 'Biểu tượng ngày Tết của miền Bắc, đặc biệt là Hà Nội.'),
(6, 'en', 'Steamed Rice Rolls', 'Thin sheets of steamed rice batter, filled with ground pork and wood-ear mushrooms, served with Vietnamese ham, fried shallots, and dipping sauce.', 'Hanoi-style steamed rice rolls, a classic Northern breakfast.'),
(6, 'vi', 'Bánh Cuốn', 'Bánh làm từ bột gạo tráng mỏng trên nồi hấp, nhân thịt băm và mộc nhĩ, ăn kèm chả lụa, hành phi và nước mắm chua ngọt.', 'Đặc sản bánh cuốn Hà Nội, ăn sáng quen thuộc của miền Bắc.'),
(7, 'en', 'Banh Duc (Rice Cake)', 'A cake made from rice flour, sometimes with peanuts. Often eaten cool with fermented tofu sauce or served hot with a savory topping.', 'Rustic rice cake from Northern villages.'),
(7, 'vi', 'Bánh Đúc', 'Bánh làm từ bột gạo, có thể có thêm lạc. Thường ăn nguội, chấm với tương bần hoặc ăn nóng với canh riêu, thịt băm.', 'Bánh đúc dân dã của đồng bằng Bắc Bộ.'),
(8, 'en', 'Pyramid Rice Dumpling', 'A pyramid-shaped dumpling with a rice flour shell, filled with minced pork, wood-ear mushroom, and shallots, wrapped in banana leaves and steamed.', 'Beloved Hanoi breakfast snack.'),
(8, 'vi', 'Bánh Giò', 'Bánh có hình chóp nón, vỏ làm từ bột gạo tẻ, nhân thịt băm, mộc nhĩ, hành khô, được gói trong lá chuối và hấp chín.', 'Món quà sáng thân thuộc của người Hà Nội.'),
(13, 'en', 'Banh Khot (Mini Savory Pancakes)', 'Small, crispy pancakes made from rice flour and coconut milk, topped with shrimp, fried in a special mold, and served with herbs and dipping sauce.', 'Signature mini pancake from the seaside city of Vung Tau (Southern Vietnam).'),
(13, 'vi', 'Bánh Khọt', 'Loại bánh nhỏ, giòn rụm làm từ bột gạo, nước cốt dừa, có nhân tôm, được chiên trong khuôn, ăn kèm rau sống và nước mắm.', 'Đặc sản Vũng Tàu với hương vị biển miền Nam.'),
(15, 'en', 'Banh Mi (Vietnamese Sandwich)', 'A famous Vietnamese sandwich on a crusty baguette with pate, cold cuts, pickled vegetables, fresh herbs, and chili.', 'Saigon street-food icon celebrated nationwide.'),
(15, 'vi', 'Bánh Mì', 'Bánh mì kẹp Việt Nam nổi tiếng với vỏ giòn ruột mềm, nhân pate, thịt nguội, dưa chua, rau thơm và ớt.', 'Biểu tượng ẩm thực đường phố Sài Gòn, lan rộng khắp Việt Nam.'),
(16, 'en', 'Banh Pia (Durian Pastry)', 'A Soc Trang specialty, a flaky pastry with multiple layers, filled with durian, mung bean paste, and a salted egg yolk.', 'Signature pastry from Soc Trang in the Mekong Delta.'),
(16, 'vi', 'Bánh Pía', 'Đặc sản Sóc Trăng, có lớp vỏ xốp nhiều lớp, nhân sầu riêng, đậu xanh và trứng muối.', 'Đặc sản Sóc Trăng, miền Tây Nam Bộ với nhân sầu riêng trứ danh.'),
(17, 'en', 'Banh Tet (Sticky Rice Log)', 'Similar to Banh Chung but in a cylindrical log shape, popular in Southern Vietnam. Ingredients are glutinous rice, mung bean, and fatty pork, wrapped in banana leaves.', 'Traditional Lunar New Year cake from Central and Southern families.'),
(17, 'vi', 'Bánh Tét', 'Tương tự bánh chưng nhưng có hình trụ dài, phổ biến ở miền Nam. Nguyên liệu là gạo nếp, đậu xanh, thịt mỡ, gói trong lá chuối.', 'Bánh tết truyền thống của miền Nam và miền Trung.'),
(18, 'en', 'Vietnamese Pizza (Grilled Rice Paper)', 'Dubbed \"Vietnamese Pizza,\" this is a street food snack made of rice paper, egg, scallions, dried shrimp, and other toppings grilled over charcoal.', 'Da Lat’s famous grilled rice paper, nicknamed “Vietnamese pizza”.'),
(18, 'vi', 'Bánh Tráng Nướng', 'Được mệnh danh là \"pizza Việt Nam\", là một món ăn đường phố gồm bánh tráng, trứng, mỡ hành, tép khô, và các loại topping khác nướng trên bếp than.', 'Đặc sản Đà Lạt, từng được gọi là “pizza Việt Nam”.'),
(22, 'en', 'Banh Xeo (Crispy Pancake)', 'A crispy, savory pancake made from rice flour and turmeric, filled with shrimp, pork, and bean sprouts, fried in a large skillet.', 'Crispy savoury crepe rooted in the Mekong Delta.'),
(22, 'vi', 'Bánh Xèo', 'Bánh có lớp vỏ vàng, giòn rụm làm từ bột gạo và bột nghệ, nhân tôm, thịt, giá đỗ, được chiên trên chảo lớn.', 'Bánh xèo giòn rụm của miền Tây Nam Bộ.'),
(23, 'en', 'Bun Bo Hue (Spicy Beef Noodle Soup)', 'A specialty noodle soup from Hue with a rich, spicy broth flavored with lemongrass and shrimp paste. Served with beef shank, pork hock, and crab cakes.', 'Imperial specialty from Hue in Central Vietnam.'),
(23, 'vi', 'Bún Bò Huế', 'Một món bún đặc sản của Huế với nước dùng đậm đà vị sả, mắm ruốc, và vị cay. Ăn kèm bắp bò, giò heo, chả cua.', 'Đặc sản cung đình Huế, tượng trưng ẩm thực miền Trung.'),
(24, 'en', 'Noodles with Fried Tofu & Shrimp Paste', 'A rustic dish of rice noodles, deep-fried tofu, green rice pork nuggets, and boiled pork, served with shrimp paste dip (mam tom) mixed with lime, sugar, and chili.', 'Hanoi-style snack from Northern Vietnam.'),
(24, 'vi', 'Bún Đậu Mắm Tôm', 'Món ăn dân dã gồm bún lá, đậu phụ rán giòn, chả cốm, thịt luộc... chấm với mắm tôm pha chanh, đường, ớt.', 'Món quà vặt đậm chất Hà Nội – miền Bắc.'),
(26, 'en', 'Caramelized Fish in Clay Pot', 'Fish (typically catfish or snakehead) braised in a clay pot with caramel sauce, fish sauce, pepper, and chili, creating a rich flavor and appealing color.', 'Claypot comfort dish from Southern households (Mekong Delta).'),
(26, 'vi', 'Cá Kho Tộ', 'Cá (thường là cá lóc, cá basa) được kho trong tộ đất với nước màu, nước mắm, tiêu, ớt, tạo nên hương vị đậm đà và màu sắc hấp dẫn.', 'Món cơm nhà quen thuộc của người miền Tây Nam Bộ.'),
(27, 'en', 'Vietnamese Sour Soup', 'A traditional Southern Vietnamese soup with a sour taste from tamarind, sweetness from pineapple, and various vegetables like taro stem, bean sprouts, and tomatoes, cooked with fish or shrimp.', 'Sour soup staple from the Mekong Delta.'),
(27, 'vi', 'Canh Chua', 'Món canh đặc trưng của miền Nam với vị chua từ me, ngọt từ dứa, thanh mát từ các loại rau như bạc hà, giá đỗ, cà chua, nấu cùng cá hoặc tôm.', 'Canh chua đặc trưng miền Tây sông nước.'),
(28, 'en', 'Pork Offal Congee', 'A congee (rice porridge) cooked with rice and offal broth, served with various pork offal such as dồi (sausage), liver, heart, intestines, and fresh herbs.', 'Hearty offal porridge from Saigon eateries.'),
(28, 'vi', 'Cháo Lòng', 'Món cháo nấu từ gạo và nước luộc lòng, ăn kèm các loại nội tạng lợn như dồi, gan, tim, phèo, và rau thơm.', 'Cháo lòng nóng hổi kiểu Sài Gòn – miền Nam.'),
(29, 'en', 'Broken Rice', 'A Saigon specialty, consisting of rice from broken grains, served with grilled pork ribs, shredded pork skin, steamed egg-pork meatloaf, a fried egg, and sweet fish sauce.', 'Saigon’s signature broken rice plate.'),
(29, 'vi', 'Cơm Tấm', 'Món ăn đặc trưng của Sài Gòn, gồm cơm nấu từ hạt gạo tấm, ăn kèm sườn nướng, bì, chả trứng, trứng ốp la, và chan nước mắm chua ngọt.', 'Cơm tấm là đặc sản Sài Gòn, biểu tượng ẩm thực miền Nam.'),
(30, 'en', 'Spring Rolls', 'A fresh appetizer made of rice vermicelli, shrimp, boiled pork, fresh herbs, and chives wrapped in rice paper. Served with hoisin-peanut sauce or sweet fish sauce.', 'Fresh spring rolls from Southern Vietnam.'),
(30, 'vi', 'Gỏi Cuốn', 'Món khai vị tươi mát gồm bún, tôm, thịt luộc, rau thơm, hẹ được cuốn trong bánh tráng. Chấm với tương đen hoặc nước mắm chua ngọt.', 'Gỏi cuốn thanh mát của vùng Nam Bộ.'),
(31, 'en', 'Mi Quang (Quang Noodles)', 'A specialty of Quang Nam - Da Nang, featuring wide, flat, yellow noodles with very little rich broth, topped with shrimp, pork, and egg. Served with grilled rice paper and roasted peanuts.', 'Quang Nam specialty noodle dish from Central Vietnam.'),
(31, 'vi', 'Mì Quảng', 'Đặc sản Quảng Nam - Đà Nẵng, sợi mì to, dẹt, màu vàng, ăn với rất ít nước dùng đậm đà, nhân tôm, thịt, trứng. Ăn kèm bánh tráng nướng và đậu phộng rang.', 'Đặc sản Quảng Nam - Đà Nẵng, niềm tự hào miền Trung.'),
(32, 'en', 'Fermented Pork Roll', 'A dish made from ground pork and pork skin, mixed with roasted rice powder and spices, wrapped in banana leaves and left to ferment naturally. It has a sour, spicy, and crunchy taste.', 'Fermented pork rolls from Thanh Hoa province.'),
(32, 'vi', 'Nem Chua', 'Món ăn làm từ thịt heo xay và bì lợn, được trộn với thính và gia vị, gói trong lá chuối và để lên men tự nhiên. Nem có vị chua, cay, giòn.', 'Nem chua Thanh Hóa – món đặc sản xứ Thanh.'),
(33, 'en', 'Pho', 'Iconic Vietnamese beef noodle soup with aromatic broth, rice noodles and fresh herbs.', 'Hanoi specialty'),
(33, 'vi', 'Phở', 'Món súp bò Việt Nam nổi tiếng với nước dùng thơm từ xương bò ninh lâu, sợi bánh phở dai, thịt bò thái mỏng, ăn kèm rau thơm, chanh và ớt.', 'Phở Hà Nội – tinh hoa ẩm thực miền Bắc.'),
(35, 'en', 'Mung Bean Sticky Rice', 'A signature breakfast sticky rice from Hanoi. The rice is steamed with turmeric, served with mashed mung bean, fried shallots, and a drizzle of chicken fat.', 'Sticky rice breakfast from Hanoi’s Old Quarter.'),
(35, 'vi', 'Xôi Xéo', 'Món xôi ăn sáng đặc trưng của Hà Nội. Xôi được đồ từ gạo nếp với bột nghệ, ăn kèm đỗ xanh giã nhuyễn, hành phi và chan một chút mỡ gà.', 'Xôi xéo – món xôi sáng quen thuộc của phố cổ Hà Nội.');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `favorites`
--

CREATE TABLE `favorites` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `dish_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `favorites`
--

INSERT INTO `favorites` (`id`, `user_id`, `dish_id`, `created_at`) VALUES
(3, 2, 24, '2025-11-23 09:55:11'),
(9, 2, 15, '2025-11-26 10:58:46');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `history`
--

CREATE TABLE `history` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `dish_id` int NOT NULL,
  `recognized_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `history`
--

INSERT INTO `history` (`id`, `user_id`, `dish_id`, `recognized_at`) VALUES
(1, 1, 15, '2025-11-23 09:05:13'),
(2, 2, 24, '2025-11-23 09:55:10'),
(3, 2, 1, '2025-11-23 10:51:07'),
(4, 2, 33, '2025-11-26 08:37:10'),
(5, 2, 28, '2025-11-26 09:30:25'),
(6, 2, 3, '2025-11-26 09:33:46'),
(7, 3, 29, '2025-11-26 12:52:21');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `ingredients`
--

CREATE TABLE `ingredients` (
  `id` int NOT NULL,
  `name_key` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `ingredients`
--

INSERT INTO `ingredients` (`id`, `name_key`) VALUES
(318, 'bac_ha'),
(41, 'banh_canh_bot_gao'),
(169, 'banh_mi'),
(420, 'banh_pho'),
(198, 'banh_trang'),
(386, 'banh_trang_nuong'),
(259, 'bap_bo'),
(267, 'bap_chuoi_bao'),
(434, 'bap_nep'),
(166, 'bi_heo'),
(243, 'bia'),
(371, 'bo_dau_phong'),
(203, 'bo_thuc_vat'),
(419, 'bo_vien'),
(171, 'bot_canh'),
(143, 'bot_chien_gion'),
(1, 'bot_gao'),
(242, 'bot_gao_kho'),
(77, 'bot_gao_te'),
(305, 'bot_mi'),
(175, 'bot_mi_da_dung'),
(2, 'bot_nang'),
(27, 'bot_nghe'),
(269, 'bot_ngot'),
(183, 'bot_no'),
(284, 'bun_soi_nho'),
(265, 'bun_soi_to'),
(366, 'bun_tuoi'),
(302, 'ca_basa_tuoi'),
(316, 'ca_chua'),
(43, 'ca_loc'),
(348, 'ca_rot'),
(261, 'cha_hue'),
(65, 'cha_lua'),
(83, 'chanh'),
(349, 'cu_cai_trang'),
(67, 'cu_hanh_tim'),
(47, 'cu_nen_bam'),
(331, 'da_day'),
(17, 'dau_an'),
(317, 'dau_bap'),
(48, 'dau_dieu'),
(351, 'dau_hao'),
(285, 'dau_hu'),
(387, 'dau_mau_dieu'),
(79, 'dau_me'),
(369, 'dau_phong_rang'),
(176, 'dau_xanh'),
(59, 'dau_xanh_tach_vo'),
(408, 'day_thun'),
(421, 'dinh_huong'),
(23, 'du_du_bao_soi'),
(304, 'dua'),
(168, 'dua_leo'),
(9, 'duong'),
(177, 'duong_cat'),
(425, 'duong_phen'),
(165, 'gan_heo'),
(326, 'gao'),
(57, 'gao_nep'),
(342, 'gao_tam'),
(343, 'gao_trang'),
(268, 'gia'),
(244, 'gia_do'),
(28, 'giam'),
(29, 'giam_trang'),
(258, 'gio_heo'),
(246, 'gung'),
(406, 'han_the'),
(4, 'hanh_la'),
(46, 'hanh_la_cat_nho'),
(24, 'hanh_la_cat_nhuyen'),
(97, 'hanh_phi'),
(68, 'hanh_tay'),
(5, 'hanh_tim'),
(25, 'hanh_tim_bam'),
(45, 'hanh_tim_cat_lat'),
(14, 'hanh_tim_xay'),
(266, 'hat_dieu_do'),
(19, 'hat_nem'),
(69, 'hat_tieu'),
(368, 'he'),
(422, 'hoa_hoi'),
(263, 'huyet_bo'),
(329, 'huyet_heo'),
(11, 'la_chuoi'),
(407, 'la_sung'),
(181, 'long_do_trung_ga'),
(330, 'long_non'),
(328, 'luoi_heo'),
(180, 'mach_na'),
(262, 'mam_ruoc'),
(287, 'mam_tom'),
(350, 'mat_ong'),
(184, 'mau_do_thuc_pham'),
(204, 'mayonnaise'),
(385, 'mi_quang_tuoi'),
(345, 'mien'),
(179, 'mo_heo'),
(81, 'moc_nhi'),
(10, 'muoi'),
(426, 'muoi_hot'),
(260, 'nam_bo'),
(82, 'nam_huong'),
(66, 'nam_meo'),
(346, 'nam_meo_kho'),
(435, 'nghe_tuoi'),
(319, 'ngo_gai'),
(78, 'nuoc'),
(30, 'nuoc_cot_chanh'),
(189, 'nuoc_cot_dua'),
(96, 'nuoc_dung_ga'),
(8, 'nuoc_mam'),
(144, 'nuoc_soda_khong_duong'),
(436, 'nuoc_vo_trong'),
(7, 'ot'),
(26, 'ot_bam'),
(388, 'ot_bot'),
(18, 'ot_bot_han_quoc'),
(315, 'ot_sung'),
(418, 'phi_le_bo'),
(424, 'que_chi'),
(188, 'rau_bina'),
(288, 'rau_kinh_gioi'),
(84, 'rau_mui'),
(320, 'rau_om'),
(245, 'rau_song'),
(170, 'rau_thom'),
(44, 're_va_goc_ngo'),
(185, 'ruou'),
(306, 'ruou_gung'),
(190, 'ruou_sake'),
(264, 'sa'),
(347, 'sa_nho'),
(202, 'sa_te'),
(178, 'sau_rieng'),
(167, 'sua_tuoi_khong_duong'),
(341, 'suon_cot_lot_heo'),
(290, 'tac'),
(200, 'tep_say_kho'),
(423, 'thao_qua'),
(307, 'thi_la'),
(58, 'thit_ba_chi'),
(303, 'thit_ba_roi'),
(286, 'thit_chan_gio'),
(13, 'thit_heo'),
(95, 'thit_heo_bam'),
(405, 'thit_heo_nac'),
(80, 'thit_lon'),
(64, 'thit_nac_dam'),
(344, 'thit_nac_xay'),
(289, 'tia_to'),
(16, 'tieu'),
(409, 'tieu_hot_gia_dap'),
(352, 'tieu_xay'),
(327, 'tim_heo'),
(6, 'toi'),
(15, 'toi_bam'),
(12, 'tom'),
(3, 'tom_tuoi'),
(22, 'trung_cut'),
(201, 'trung_ga'),
(182, 'trung_muoi'),
(370, 'tuong_den'),
(205, 'tuong_ot'),
(384, 'uc_ga'),
(367, 'xa_lach'),
(199, 'xuc_xich'),
(42, 'xuong_heo'),
(257, 'xuong_ong_bo');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `ingredient_translations`
--

CREATE TABLE `ingredient_translations` (
  `ingredient_id` int NOT NULL,
  `language_code` varchar(5) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `ingredient_translations`
--

INSERT INTO `ingredient_translations` (`ingredient_id`, `language_code`, `name`) VALUES
(1, 'en', 'Rice flour'),
(1, 'vi', 'Bột gạo'),
(2, 'en', 'Tapioca starch'),
(2, 'vi', 'Bột năng'),
(3, 'en', 'Fresh shrimp'),
(3, 'vi', 'Tôm tươi'),
(4, 'en', 'Scallions'),
(4, 'vi', 'Hành lá'),
(5, 'en', 'Shallots'),
(5, 'vi', 'Hành tím'),
(6, 'en', 'Garlic'),
(6, 'vi', 'Tỏi'),
(7, 'en', 'Chili'),
(7, 'vi', 'Ớt'),
(8, 'en', 'Fish sauce'),
(8, 'vi', 'Nước mắm'),
(9, 'en', 'Sugar'),
(9, 'vi', 'Đường'),
(10, 'en', 'Salt'),
(10, 'vi', 'Muối'),
(11, 'en', 'Banana leaf'),
(11, 'vi', 'Lá chuối'),
(12, 'en', 'Shrimp'),
(12, 'vi', 'Tôm'),
(13, 'en', 'Pork'),
(13, 'vi', 'Thịt heo'),
(14, 'en', 'Minced shallots'),
(14, 'vi', 'Hành tím xay nhuyễn'),
(15, 'en', 'Minced garlic'),
(15, 'vi', 'Tỏi băm'),
(16, 'en', 'Pepper'),
(16, 'vi', 'Tiêu'),
(17, 'en', 'Cooking oil'),
(17, 'vi', 'Dầu ăn'),
(18, 'en', 'Korean chili powder'),
(18, 'vi', 'Ớt bột Hàn Quốc'),
(19, 'en', 'Seasoning powder'),
(19, 'vi', 'Hạt nêm'),
(22, 'en', 'Quail eggs'),
(22, 'vi', 'Trứng cút'),
(23, 'en', 'Shredded papaya'),
(23, 'vi', 'Đu đủ bào sợi'),
(24, 'en', 'Chopped scallions'),
(24, 'vi', 'Hành lá cắt nhuyễn'),
(25, 'en', 'Minced shallots'),
(25, 'vi', 'Hành tím băm'),
(26, 'en', 'Chopped chili'),
(26, 'vi', 'Ớt băm'),
(27, 'en', 'Turmeric powder'),
(27, 'vi', 'Bột nghệ'),
(28, 'en', 'Vinegar'),
(28, 'vi', 'Giấm'),
(29, 'en', 'White vinegar'),
(29, 'vi', 'Giấm trắng'),
(30, 'en', 'Lime juice'),
(30, 'vi', 'Nước cốt chanh'),
(41, 'en', 'Rice noodle soup (rice flour noodles)'),
(41, 'vi', 'Bánh canh bột gạo'),
(42, 'en', 'Pork bones'),
(42, 'vi', 'Xương heo'),
(43, 'en', 'Snakehead fish'),
(43, 'vi', 'Cá lóc'),
(44, 'en', 'Coriander roots and stems'),
(44, 'vi', 'Rễ và gốc ngò'),
(45, 'en', 'Sliced shallots'),
(45, 'vi', 'Hành tím cắt lát'),
(46, 'en', 'Chopped scallions'),
(46, 'vi', 'Hành lá cắt nhỏ'),
(47, 'en', 'Minced shallot garlic (cu nen)'),
(47, 'vi', 'Củ nén băm'),
(48, 'en', 'Annatto oil'),
(48, 'vi', 'Dầu điều'),
(57, 'en', 'Sticky rice'),
(57, 'vi', 'Gạo nếp'),
(58, 'en', 'Pork belly'),
(58, 'vi', 'Thịt ba chỉ'),
(59, 'en', 'Peeled mung beans'),
(59, 'vi', 'Đậu xanh tách vỏ'),
(64, 'en', 'Minced pork shoulder'),
(64, 'vi', 'Thịt nạc dăm'),
(65, 'en', 'Vietnamese sausage'),
(65, 'vi', 'Chả lụa'),
(66, 'en', 'Wood ear mushrooms'),
(66, 'vi', 'Nấm mèo'),
(67, 'en', 'Shallots'),
(67, 'vi', 'Củ hành tím'),
(68, 'en', 'Onion'),
(68, 'vi', 'Hành tây'),
(69, 'en', 'Pepper'),
(69, 'vi', 'Hạt tiêu'),
(77, 'en', 'Rice flour'),
(77, 'vi', 'Bột gạo tẻ'),
(78, 'en', 'Water'),
(78, 'vi', 'Nước'),
(79, 'en', 'Sesame oil'),
(79, 'vi', 'Dầu mè'),
(80, 'en', 'Pork'),
(80, 'vi', 'Thịt lợn'),
(81, 'en', 'Wood ear mushroom'),
(81, 'vi', 'Mộc nhĩ'),
(82, 'en', 'Shiitake mushroom'),
(82, 'vi', 'Nấm hương'),
(83, 'en', 'Lime'),
(83, 'vi', 'Chanh'),
(84, 'en', 'Coriander'),
(84, 'vi', 'Rau mùi'),
(95, 'en', 'Minced pork'),
(95, 'vi', 'Thịt heo băm'),
(96, 'en', 'Chicken stock'),
(96, 'vi', 'Nước dùng gà'),
(97, 'en', 'Fried shallots'),
(97, 'vi', 'Hành phi'),
(143, 'en', 'Tempura / Batter flour'),
(143, 'vi', 'Bột chiên giòn'),
(144, 'en', 'Unsweetened soda water'),
(144, 'vi', 'Nước soda không đường'),
(165, 'en', 'Pork liver'),
(165, 'vi', 'Gan heo'),
(166, 'en', 'Pork skin'),
(166, 'vi', 'Bì heo'),
(167, 'en', 'Unsweetened fresh milk'),
(167, 'vi', 'Sữa tươi không đường'),
(168, 'en', 'Cucumber'),
(168, 'vi', 'Dưa leo'),
(169, 'en', 'Baguette'),
(169, 'vi', 'Bánh mì'),
(170, 'en', 'Herbs'),
(170, 'vi', 'Rau thơm'),
(171, 'en', 'Seasoning powder'),
(171, 'vi', 'Bột canh'),
(175, 'en', 'All-purpose flour'),
(175, 'vi', 'Bột mì đa dụng'),
(176, 'en', 'Mung beans'),
(176, 'vi', 'Đậu xanh bỏ vỏ'),
(177, 'en', 'White sugar'),
(177, 'vi', 'Đường cát trắng'),
(178, 'en', 'Durian'),
(178, 'vi', 'Sầu riêng'),
(179, 'en', 'Pork lard'),
(179, 'vi', 'Mỡ heo'),
(180, 'en', 'Malt syrup'),
(180, 'vi', 'Mạch nha'),
(181, 'en', 'Egg yolk'),
(181, 'vi', 'Lòng đỏ trứng gà'),
(182, 'en', 'Salted egg yolk'),
(182, 'vi', 'Lòng đỏ trứng muối'),
(183, 'en', 'Baking powder'),
(183, 'vi', 'Bột nở'),
(184, 'en', 'Food coloring (red)'),
(184, 'vi', 'Màu đỏ thực phẩm'),
(185, 'en', 'Alcohol'),
(185, 'vi', 'Rượu'),
(188, 'en', 'Spinach'),
(188, 'vi', 'Rau bina'),
(189, 'en', 'Coconut milk'),
(189, 'vi', 'Nước cốt dừa'),
(190, 'en', 'Sake'),
(190, 'vi', 'Rượu sake'),
(198, 'en', 'Rice paper'),
(198, 'vi', 'Bánh tráng'),
(199, 'en', 'Sausage'),
(199, 'vi', 'Xúc xích'),
(200, 'en', 'Dried shrimp'),
(200, 'vi', 'Tép sấy khô'),
(201, 'en', 'Egg'),
(201, 'vi', 'Trứng gà'),
(202, 'en', 'Sate sauce'),
(202, 'vi', 'Sa tế'),
(203, 'en', 'Margarine'),
(203, 'vi', 'Bơ thực vật'),
(204, 'en', 'Mayonnaise'),
(204, 'vi', 'Mayonnaise'),
(205, 'en', 'Chili sauce'),
(205, 'vi', 'Tương ớt'),
(242, 'en', 'Rice flour'),
(242, 'vi', 'Bột gạo khô'),
(243, 'en', 'Beer'),
(243, 'vi', 'Bia'),
(244, 'en', 'Bean sprouts'),
(244, 'vi', 'Giá đỗ'),
(245, 'en', 'Raw vegetables / herbs'),
(245, 'vi', 'Rau sống'),
(246, 'en', 'Ginger'),
(246, 'vi', 'Gừng'),
(257, 'en', 'Beef bone'),
(257, 'vi', 'Xương ống bò'),
(258, 'en', 'Pork knuckle'),
(258, 'vi', 'Giò heo'),
(259, 'en', 'Beef brisket'),
(259, 'vi', 'Bắp bò'),
(260, 'en', 'Beef flank'),
(260, 'vi', 'Nạm bò'),
(261, 'en', 'Hue pork roll'),
(261, 'vi', 'Chả Huế'),
(262, 'en', 'Fermented shrimp paste'),
(262, 'vi', 'Mắm ruốc'),
(263, 'en', 'Beef blood cake'),
(263, 'vi', 'Huyết bò'),
(264, 'en', 'Lemongrass'),
(264, 'vi', 'Sả'),
(265, 'en', 'Thick rice noodles'),
(265, 'vi', 'Bún sợi to'),
(266, 'en', 'Red roasted cashew'),
(266, 'vi', 'Hạt điều màu đỏ'),
(267, 'en', 'Shredded banana blossom'),
(267, 'vi', 'Bắp chuối bào'),
(268, 'en', 'Bean sprouts'),
(268, 'vi', 'Giá'),
(269, 'en', 'MSG'),
(269, 'vi', 'Bột ngọt'),
(284, 'en', 'Thin rice noodles'),
(284, 'vi', 'Bún sợi nhỏ'),
(285, 'en', 'Tofu'),
(285, 'vi', 'Đậu hũ'),
(286, 'en', 'Pork leg'),
(286, 'vi', 'Thịt chân giò'),
(287, 'en', 'Fermented shrimp paste'),
(287, 'vi', 'Mắm tôm'),
(288, 'en', 'Vietnamese balm'),
(288, 'vi', 'Rau kinh giới'),
(289, 'en', 'Perilla leaves'),
(289, 'vi', 'Tía tô'),
(290, 'en', 'Calamansi'),
(290, 'vi', 'Tắc'),
(302, 'en', 'Fresh basa fish'),
(302, 'vi', 'Cá basa tươi'),
(303, 'en', 'Pork belly'),
(303, 'vi', 'Thịt ba rọi'),
(304, 'en', 'Coconut'),
(304, 'vi', 'Dừa'),
(305, 'en', 'Wheat flour'),
(305, 'vi', 'Bột mì'),
(306, 'en', 'Ginger wine'),
(306, 'vi', 'Rượu gừng'),
(307, 'en', 'Dill'),
(307, 'vi', 'Thì là'),
(315, 'en', 'Chili pepper'),
(315, 'vi', 'Ớt sừng'),
(316, 'en', 'Tomato'),
(316, 'vi', 'Cà chua'),
(317, 'en', 'Okra'),
(317, 'vi', 'Đậu bắp'),
(318, 'en', 'Taro stem'),
(318, 'vi', 'Bạc hà'),
(319, 'en', 'Culantro'),
(319, 'vi', 'Ngò gai'),
(320, 'en', 'Rice paddy herb'),
(320, 'vi', 'Rau om'),
(326, 'en', 'Rice'),
(326, 'vi', 'Gạo'),
(327, 'en', 'Pork heart'),
(327, 'vi', 'Tim heo'),
(328, 'en', 'Pork tongue'),
(328, 'vi', 'Lưỡi heo'),
(329, 'en', 'Pork blood'),
(329, 'vi', 'Huyết heo'),
(330, 'en', 'Pork intestines'),
(330, 'vi', 'Lòng non'),
(331, 'en', 'Pork stomach'),
(331, 'vi', 'Dạ dày'),
(341, 'en', 'Pork chop (bone-in)'),
(341, 'vi', 'Sườn cốt lết heo'),
(342, 'en', 'Broken rice'),
(342, 'vi', 'Gạo tấm'),
(343, 'en', 'White rice (for roasted rice powder)'),
(343, 'vi', 'Gạo trắng (làm thính)'),
(344, 'en', 'Ground lean pork'),
(344, 'vi', 'Thịt nạc heo xay'),
(345, 'en', 'Glass noodles'),
(345, 'vi', 'Miến'),
(346, 'en', 'Dried wood ear mushroom'),
(346, 'vi', 'Nấm mèo khô'),
(347, 'en', 'Small lemongrass stalks'),
(347, 'vi', 'Sả nhỏ'),
(348, 'en', 'Carrot'),
(348, 'vi', 'Cà rốt'),
(349, 'en', 'Daikon'),
(349, 'vi', 'Củ cải trắng'),
(350, 'en', 'Honey'),
(350, 'vi', 'Mật ong'),
(351, 'en', 'Oyster sauce'),
(351, 'vi', 'Dầu hào'),
(352, 'en', 'Ground pepper'),
(352, 'vi', 'Tiêu xay'),
(366, 'en', 'Fresh rice vermicelli'),
(366, 'vi', 'Bún tươi'),
(367, 'en', 'Lettuce'),
(367, 'vi', 'Xà lách'),
(368, 'en', 'Chives'),
(368, 'vi', 'Hẹ'),
(369, 'en', 'Roasted peanuts'),
(369, 'vi', 'Đậu phộng rang'),
(370, 'en', 'Hoisin-peanut sauce'),
(370, 'vi', 'Tương đen (chấm)'),
(371, 'en', 'Peanut butter'),
(371, 'vi', 'Bơ đậu phộng'),
(384, 'en', 'Chicken breast'),
(384, 'vi', 'Ức gà'),
(385, 'en', 'Fresh Mi Quang noodles'),
(385, 'vi', 'Mì Quảng tươi'),
(386, 'en', 'Grilled rice paper'),
(386, 'vi', 'Bánh tráng nướng'),
(387, 'en', 'Annatto oil'),
(387, 'vi', 'Dầu màu điều'),
(388, 'en', 'Chili powder'),
(388, 'vi', 'Ớt bột'),
(405, 'en', 'Lean pork'),
(405, 'vi', 'Thịt heo nạc'),
(406, 'en', 'Alum'),
(406, 'vi', 'Hàn the'),
(407, 'en', 'Fig leaves'),
(407, 'vi', 'Lá sung'),
(408, 'en', 'Rubber bands'),
(408, 'vi', 'Dây thun'),
(409, 'en', 'Crushed black peppercorns'),
(409, 'vi', 'Tiêu hột giã dập'),
(418, 'en', 'Beef fillet'),
(418, 'vi', 'Phi lê bò'),
(419, 'en', 'Beef balls'),
(419, 'vi', 'Bò viên'),
(420, 'en', 'Rice noodles'),
(420, 'vi', 'Bánh phở'),
(421, 'en', 'Cloves'),
(421, 'vi', 'Đinh hương'),
(422, 'en', 'Star anise'),
(422, 'vi', 'Hoa hồi'),
(423, 'en', 'Cardamom'),
(423, 'vi', 'Thảo quả'),
(424, 'en', 'Cinnamon stick'),
(424, 'vi', 'Quế chi'),
(425, 'en', 'Rock sugar'),
(425, 'vi', 'Đường phèn'),
(426, 'en', 'Salt'),
(426, 'vi', 'Muối hột'),
(434, 'en', 'Sweet corn'),
(434, 'vi', 'Bắp nếp'),
(435, 'en', 'Fresh turmeric'),
(435, 'vi', 'Nghệ tươi'),
(436, 'en', 'Lime water'),
(436, 'vi', 'Nước vôi trong');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `instructions`
--

CREATE TABLE `instructions` (
  `id` int NOT NULL,
  `dish_id` int NOT NULL,
  `step_number` int NOT NULL,
  `image_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `instructions`
--

INSERT INTO `instructions` (`id`, `dish_id`, `step_number`, `image_url`) VALUES
(1, 1, 1, 'https://cdn.tgdd.vn/Files/2017/03/21/963426/cach-lam-banh-beo-thom-ngon-202110041640526577.jpg'),
(2, 1, 2, 'https://cdn.tgdd.vn/Files/2017/03/21/963426/cach-lam-banh-beo-thom-ngon-202110041641109870.jpg'),
(3, 1, 3, 'https://cdn.tgdd.vn/Files/2017/03/21/963426/cach-lam-banh-beo-thom-ngon-202110041637174991.jpg'),
(4, 1, 4, 'https://cdn.tgdd.vn/Files/2017/03/21/963426/cach-lam-banh-beo-thom-ngon-202110041638285554.jpg'),
(5, 1, 5, 'https://cdn.tgdd.vn/Files/2017/03/21/963426/cach-lam-banh-beo-thom-ngon-202110041638494814.jpg'),
(6, 2, 1, 'https://cdn.tgdd.vn/Files/2021/09/07/1380725/cach-lam-banh-bot-loc-goi-la-chuoi-dai-ngon-khong-can-khuay-202109301934087283.jpg'),
(7, 2, 2, 'https://cdn.tgdd.vn/Files/2021/09/07/1380725/cach-lam-banh-bot-loc-goi-la-chuoi-dai-ngon-khong-can-khuay-202109301934194755.jpg'),
(8, 2, 3, 'https://cdn.tgdd.vn/Files/2021/09/07/1380725/cach-lam-banh-bot-loc-goi-la-chuoi-dai-ngon-khong-can-khuay-202109301934328584.jpg'),
(9, 2, 4, 'https://cdn.tgdd.vn/Files/2021/09/07/1380725/cach-lam-banh-bot-loc-goi-la-chuoi-dai-ngon-khong-can-khuay-202109301934453194.jpg'),
(10, 2, 5, 'https://cdn.tgdd.vn/Files/2021/09/07/1380725/cach-lam-banh-bot-loc-goi-la-chuoi-dai-ngon-khong-can-khuay-202109301934596042.jpg'),
(11, 2, 6, 'https://cdn.tgdd.vn/Files/2021/09/07/1380725/cach-lam-banh-bot-loc-goi-la-chuoi-dai-ngon-khong-can-khuay-202109301935159823.jpg'),
(12, 2, 7, 'https://cdn.tgdd.vn/Files/2021/09/07/1380725/cach-lam-banh-bot-loc-goi-la-chuoi-dai-ngon-khong-can-khuay-202109301935290727.jpg'),
(13, 3, 1, 'https://cdn.tgdd.vn/Files/2022/05/31/1436004/cach-lam-banh-can-mien-trung-don-gian-chuan-vi-que-huong-202205310711257063.jpg'),
(14, 3, 2, 'https://cdn.tgdd.vn/Files/2022/05/31/1436004/cach-lam-banh-can-mien-trung-don-gian-chuan-vi-que-huong-202205310711552239.jpg'),
(15, 3, 3, 'https://cdn.tgdd.vn/Files/2022/05/31/1436004/cach-lam-banh-can-mien-trung-don-gian-chuan-vi-que-huong-202205310712050007.jpg'),
(16, 3, 4, 'https://cdn.tgdd.vn/Files/2022/05/31/1436004/cach-lam-banh-can-mien-trung-don-gian-chuan-vi-que-huong-202205310712216203.jpg'),
(17, 3, 5, 'https://cdn.tgdd.vn/Files/2022/05/31/1436004/cach-lam-banh-can-mien-trung-don-gian-chuan-vi-que-huong-202205310712377207.jpg'),
(18, 3, 6, 'https://cdn.tgdd.vn/Files/2022/05/31/1436004/cach-lam-banh-can-mien-trung-don-gian-chuan-vi-que-huong-202205310712504242.jpg'),
(19, 4, 1, 'https://cdn.tgdd.vn/Files/2021/07/26/1370866/cach-nau-banh-canh-ca-loc-bot-gao-thom-ngon-doi-vi-cho-ca-nha-deu-me-202107261318396434.jpg'),
(20, 4, 2, 'https://cdn.tgdd.vn/Files/2021/07/26/1370866/cach-nau-banh-canh-ca-loc-bot-gao-thom-ngon-doi-vi-cho-ca-nha-deu-me-202107261320430990.jpg'),
(21, 4, 3, 'https://cdn.tgdd.vn/Files/2021/07/26/1370866/cach-nau-banh-canh-ca-loc-bot-gao-thom-ngon-doi-vi-cho-ca-nha-deu-me-202107261321144781.jpg'),
(22, 4, 4, 'https://cdn.tgdd.vn/Files/2021/07/26/1370866/cach-nau-banh-canh-ca-loc-bot-gao-thom-ngon-doi-vi-cho-ca-nha-deu-me-202107261322581955.jpg'),
(23, 4, 5, 'https://cdn.tgdd.vn/Files/2021/07/26/1370866/cach-nau-banh-canh-ca-loc-bot-gao-thom-ngon-doi-vi-cho-ca-nha-deu-me-202107261323389542.jpg'),
(24, 4, 6, 'https://cdn.tgdd.vn/Files/2021/07/26/1370866/cach-nau-banh-canh-ca-loc-bot-gao-thom-ngon-doi-vi-cho-ca-nha-deu-me-202208251422171977.jpg'),
(25, 5, 1, 'https://cdn.tgdd.vn/Files/2016/12/30/932155/cach-lam-banh-chung-thom-ngon-xanh-deo-dam-da-huong-vi-tet-202209011503148065.jpg'),
(26, 5, 2, 'https://cdn.tgdd.vn/Files/2016/12/30/932155/cach-lam-banh-chung-thom-ngon-xanh-deo-dam-da-huong-vi-tet-202209011503367408.jpg'),
(27, 5, 3, 'https://cdn.tgdd.vn/Files/2016/12/30/932155/cach-lam-banh-chung-thom-ngon-xanh-deo-dam-da-huong-vi-tet-202209011504132143.jpg'),
(28, 5, 4, 'https://cdn.tgdd.vn/Files/2016/12/30/932155/cach-lam-banh-chung-thom-ngon-xanh-deo-dam-da-huong-vi-tet-202209011500482105.jpg'),
(29, 5, 5, 'https://cdn.tgdd.vn/Files/2016/12/30/932155/cach-lam-banh-chung-thom-ngon-xanh-deo-dam-da-huong-vi-tet-202209101533034320.jpg'),
(30, 6, 1, 'https://cdn.tgdd.vn/Files/2022/01/03/1408683/tong-hop-12-cach-lam-banh-cuon-tai-nha-ngon-nhu-ngoai-hang-202201030852443957.jpg'),
(31, 6, 2, 'https://cdn.tgdd.vn/Files/2022/01/03/1408683/tong-hop-12-cach-lam-banh-cuon-tai-nha-ngon-nhu-ngoai-hang-202201030853031961.jpg'),
(32, 6, 3, 'https://cdn.tgdd.vn/Files/2022/01/03/1408683/tong-hop-12-cach-lam-banh-cuon-tai-nha-ngon-nhu-ngoai-hang-202201030853169601.jpg'),
(33, 6, 4, 'https://cdn.tgdd.vn/Files/2022/01/03/1408683/tong-hop-12-cach-lam-banh-cuon-tai-nha-ngon-nhu-ngoai-hang-202201030853305855.jpg'),
(34, 7, 1, 'https://cdn.tgdd.vn/Files/2021/08/03/1372652/cach-lam-banh-duc-nong-ngon-khong-dung-voi-va-han-the-202108030850217612.jpg'),
(35, 7, 2, 'https://cdn.tgdd.vn/Files/2021/08/03/1372652/cach-lam-banh-duc-nong-ngon-khong-dung-voi-va-han-the-202108030853346650.jpg'),
(36, 7, 3, 'https://cdn.tgdd.vn/Files/2021/08/03/1372652/cach-lam-banh-duc-nong-ngon-khong-dung-voi-va-han-the-202108030853568740.jpg'),
(37, 7, 4, 'https://cdn.tgdd.vn/Files/2021/08/03/1372652/cach-lam-banh-duc-nong-ngon-khong-dung-voi-va-han-the-202108030854227320.jpg'),
(38, 7, 5, 'https://cdn.tgdd.vn/Files/2021/08/03/1372652/cach-lam-banh-duc-nong-ngon-khong-dung-voi-va-han-the-202108030854424290.jpg'),
(39, 7, 6, 'https://cdn.tgdd.vn/Files/2021/08/03/1372652/cach-lam-banh-duc-nong-ngon-khong-dung-voi-va-han-the-202108030855163040.jpg'),
(40, 8, 1, 'https://cdn.tgdd.vn/Files/2019/11/20/1220697/huong-dan-cach-lam-banh-gio-nong-mem-min-don-gian-9.jpg'),
(41, 8, 2, 'https://cdn.tgdd.vn/Files/2019/11/20/1220697/huong-dan-cach-lam-banh-gio-nong-mem-min-don-gian-3.JPG'),
(42, 8, 3, 'https://cdn.tgdd.vn/Files/2019/11/20/1220697/huong-dan-cach-lam-banh-gio-nong-mem-min-don-gian-4.JPG'),
(43, 8, 4, 'https://cdn.tgdd.vn/Files/2019/11/20/1220697/huong-dan-cach-lam-banh-gio-nong-mem-min-don-gian-5.JPG'),
(44, 8, 5, 'https://cdn.tgdd.vn/Files/2019/11/20/1220697/huong-dan-cach-lam-banh-gio-nong-mem-min-don-gian-6.JPG'),
(45, 8, 6, 'https://cdn.tgdd.vn/Files/2019/11/20/1220697/huong-dan-cach-lam-banh-gio-nong-mem-min-don-gian-1.jpg'),
(46, 8, 1, 'https://cdn.tgdd.vn/Files/2019/11/20/1220697/huong-dan-cach-lam-banh-gio-nong-mem-min-don-gian-9.jpg'),
(47, 8, 2, 'https://cdn.tgdd.vn/Files/2019/11/20/1220697/huong-dan-cach-lam-banh-gio-nong-mem-min-don-gian-3.JPG'),
(48, 8, 3, 'https://cdn.tgdd.vn/Files/2019/11/20/1220697/huong-dan-cach-lam-banh-gio-nong-mem-min-don-gian-4.JPG'),
(49, 8, 4, 'https://cdn.tgdd.vn/Files/2019/11/20/1220697/huong-dan-cach-lam-banh-gio-nong-mem-min-don-gian-5.JPG'),
(50, 8, 5, 'https://cdn.tgdd.vn/Files/2019/11/20/1220697/huong-dan-cach-lam-banh-gio-nong-mem-min-don-gian-6.JPG'),
(51, 8, 6, 'https://cdn.tgdd.vn/Files/2019/11/20/1220697/huong-dan-cach-lam-banh-gio-nong-mem-min-don-gian-1.jpg'),
(52, 8, 1, 'https://cdn.tgdd.vn/Files/2019/11/20/1220697/huong-dan-cach-lam-banh-gio-nong-mem-min-don-gian-9.jpg'),
(53, 8, 2, 'https://cdn.tgdd.vn/Files/2019/11/20/1220697/huong-dan-cach-lam-banh-gio-nong-mem-min-don-gian-3.JPG'),
(54, 8, 3, 'https://cdn.tgdd.vn/Files/2019/11/20/1220697/huong-dan-cach-lam-banh-gio-nong-mem-min-don-gian-4.JPG'),
(55, 8, 4, 'https://cdn.tgdd.vn/Files/2019/11/20/1220697/huong-dan-cach-lam-banh-gio-nong-mem-min-don-gian-5.JPG'),
(56, 8, 5, 'https://cdn.tgdd.vn/Files/2019/11/20/1220697/huong-dan-cach-lam-banh-gio-nong-mem-min-don-gian-6.JPG'),
(57, 8, 6, 'https://cdn.tgdd.vn/Files/2019/11/20/1220697/huong-dan-cach-lam-banh-gio-nong-mem-min-don-gian-1.jpg'),
(58, 13, 1, 'https://cdn.tgdd.vn/Files/2020/10/13/1298451/cach-lam-banh-khot-vang-uom-gion-rum-ca-tieng-ma-khong-can-khuon-202010131033563007.jpg'),
(59, 13, 2, 'https://cdn.tgdd.vn/Files/2020/10/13/1298451/cach-lam-banh-khot-vang-uom-gion-rum-ca-tieng-ma-khong-can-khuon-202010131034267833.jpg'),
(60, 13, 3, 'https://cdn.tgdd.vn/Files/2020/10/13/1298451/cach-lam-banh-khot-vang-uom-gion-rum-ca-tieng-ma-khong-can-khuon-202010131035510443.jpg'),
(61, 13, 4, 'https://cdn.tgdd.vn/Files/2020/10/13/1298451/cach-lam-banh-khot-vang-uom-gion-rum-ca-tieng-ma-khong-can-khuon-202010131036381884.jpg'),
(62, 13, 5, 'https://cdn.tgdd.vn/Files/2020/10/13/1298451/cach-lam-banh-khot-vang-uom-gion-rum-ca-tieng-ma-khong-can-khuon-202010131036590167.jpg'),
(63, 13, 6, 'https://cdn.tgdd.vn/Files/2020/10/13/1298451/cach-lam-banh-khot-vang-uom-gion-rum-ca-tieng-ma-khong-can-khuon-202010131037202559.jpg'),
(64, 13, 1, 'https://cdn.tgdd.vn/Files/2020/10/13/1298451/cach-lam-banh-khot-vang-uom-gion-rum-ca-tieng-ma-khong-can-khuon-202010131033563007.jpg'),
(65, 13, 2, 'https://cdn.tgdd.vn/Files/2020/10/13/1298451/cach-lam-banh-khot-vang-uom-gion-rum-ca-tieng-ma-khong-can-khuon-202010131034267833.jpg'),
(66, 13, 3, 'https://cdn.tgdd.vn/Files/2020/10/13/1298451/cach-lam-banh-khot-vang-uom-gion-rum-ca-tieng-ma-khong-can-khuon-202010131035510443.jpg'),
(67, 13, 4, 'https://cdn.tgdd.vn/Files/2020/10/13/1298451/cach-lam-banh-khot-vang-uom-gion-rum-ca-tieng-ma-khong-can-khuon-202010131036381884.jpg'),
(68, 13, 5, 'https://cdn.tgdd.vn/Files/2020/10/13/1298451/cach-lam-banh-khot-vang-uom-gion-rum-ca-tieng-ma-khong-can-khuon-202010131036590167.jpg'),
(69, 13, 6, 'https://cdn.tgdd.vn/Files/2020/10/13/1298451/cach-lam-banh-khot-vang-uom-gion-rum-ca-tieng-ma-khong-can-khuon-202010131037202559.jpg'),
(70, 15, 1, 'https://cdn.tgdd.vn/Files/2021/06/28/1363869/cach-lam-banh-mi-pate-thom-ngon-lot-bung-cho-bua-sang-202106281533178710.jpg'),
(71, 15, 2, 'https://cdn.tgdd.vn/Files/2021/06/28/1363869/cach-lam-banh-mi-pate-thom-ngon-lot-bung-cho-bua-sang-202106281528408349.jpg'),
(72, 15, 3, 'https://cdn.tgdd.vn/Files/2021/06/28/1363869/cach-lam-banh-mi-pate-thom-ngon-lot-bung-cho-bua-sang-202106281529097177.jpg'),
(73, 16, 1, 'https://cdn.tgdd.vn/Files/2021/08/06/1373509/cach-lam-banh-pia-sau-rieng-thom-ngon-cuc-de-lam-202108061957389880.jpg'),
(74, 16, 2, 'https://cdn.tgdd.vn/Files/2021/08/06/1373509/cach-lam-banh-pia-sau-rieng-thom-ngon-cuc-de-lam-202108061958007540.jpg'),
(75, 16, 3, 'https://cdn.tgdd.vn/Files/2021/08/06/1373509/cach-lam-banh-pia-sau-rieng-thom-ngon-cuc-de-lam-202108061959092115.jpg'),
(76, 16, 4, 'https://cdn.tgdd.vn/Files/2021/08/06/1373509/cach-lam-banh-pia-sau-rieng-thom-ngon-cuc-de-lam-202108061959271976.jpg'),
(77, 16, 5, 'https://cdn.tgdd.vn/Files/2021/08/06/1373509/cach-lam-banh-pia-sau-rieng-thom-ngon-cuc-de-lam-202108061959489147.jpg'),
(78, 16, 6, 'https://cdn.tgdd.vn/Files/2021/08/06/1373509/cach-lam-banh-pia-sau-rieng-thom-ngon-cuc-de-lam-202108062000051797.jpg'),
(79, 17, 1, 'https://cdn.tgdd.vn/Files/2020/10/24/1301703/chia-se-cach-lam-banh-tet-cuc-nhanh-chi-20-phut-la-chin-202010241928161379.jpg'),
(80, 17, 2, 'https://cdn.tgdd.vn/Files/2020/10/24/1301703/chia-se-cach-lam-banh-tet-cuc-nhanh-chi-20-phut-la-chin-202010241928365656.jpg'),
(81, 17, 3, 'https://cdn.tgdd.vn/Files/2020/10/24/1301703/chia-se-cach-lam-banh-tet-cuc-nhanh-chi-20-phut-la-chin-202010241928482499.jpg'),
(82, 17, 4, 'https://cdn.tgdd.vn/Files/2020/10/24/1301703/chia-se-cach-lam-banh-tet-cuc-nhanh-chi-20-phut-la-chin-202010241929068075.jpg'),
(83, 17, 5, 'https://cdn.tgdd.vn/Files/2020/10/24/1301703/chia-se-cach-lam-banh-tet-cuc-nhanh-chi-20-phut-la-chin-202010241929239233.jpg'),
(84, 17, 6, 'https://cdn.tgdd.vn/Files/2020/10/24/1301703/chia-se-cach-lam-banh-tet-cuc-nhanh-chi-20-phut-la-chin-202010241929342883.jpg'),
(85, 17, 7, 'https://cdn.tgdd.vn/Files/2020/10/24/1301703/chia-se-cach-lam-banh-tet-cuc-nhanh-chi-20-phut-la-chin-202010241929482649.jpg'),
(86, 18, 1, 'https://cdn.tgdd.vn/Files/2017/03/12/960051/cach-lam-banh-trang-nuong-ngon-cuc-nhanh-voi-chao-chong-dinh-201910072227457024.jpg'),
(87, 18, 2, 'https://cdn.tgdd.vn/Files/2017/03/12/960051/cach-lam-banh-trang-nuong-ngon-cuc-nhanh-voi-chao-chong-dinh-201910072228011534.jpg'),
(88, 18, 3, 'https://cdn.tgdd.vn/Files/2017/03/12/960051/cach-lam-banh-trang-nuong-ngon-bang-chao-chong-dinh-tai-nha-202205251048018113.jpg'),
(89, 22, 1, 'https://cdn.tgdd.vn/Files/2020/05/20/1256908/troi-mua-thu-lam-banh-xeo-kieu-mien-bac-gion-ngon-it-dau-mo-202005201032077748.jpg'),
(90, 22, 2, 'https://cdn.tgdd.vn/Files/2020/05/20/1256908/troi-mua-thu-lam-banh-xeo-kieu-mien-bac-gion-ngon-it-dau-mo-202005201032216299.jpg'),
(91, 22, 3, 'https://cdn.tgdd.vn/Files/2020/05/20/1256908/troi-mua-thu-lam-banh-xeo-kieu-mien-bac-gion-ngon-it-dau-mo-202005201032337113.jpg'),
(92, 23, 1, 'https://cdn.tgdd.vn/Files/2017/03/24/964495/cach-nau-bun-bo-hue-gio-heo-ngon-cong-thuc-chuan-vi-202208251620572272.jpg'),
(93, 23, 2, 'https://cdn.tgdd.vn/Files/2017/03/24/964495/cach-nau-bun-bo-hue-gio-heo-ngon-cong-thuc-chuan-vi-202208251621182305.jpg'),
(94, 23, 3, 'https://cdn.tgdd.vn/Files/2017/03/24/964495/cach-nau-bun-bo-hue-gio-heo-ngon-cong-thuc-chuan-vi-202208251621566332.jpg'),
(95, 23, 4, 'https://cdn.tgdd.vn/Files/2017/03/24/964495/cach-nau-bun-bo-hue-gio-heo-ngon-cong-thuc-chuan-vi-202208251622167079.jpg'),
(96, 23, 5, 'https://cdn.tgdd.vn/Files/2017/03/24/964495/cach-nau-bun-bo-hue-gio-heo-ngon-cong-thuc-chuan-vi-202208251617593627.jpg'),
(97, 24, 1, 'https://cdn.tgdd.vn/Files/2017/03/21/963373/cach-lam-bun-dau-mam-tom-thom-ngon-1_760x450.jpg'),
(98, 24, 2, 'https://cdn.tgdd.vn/Files/2017/03/21/963373/cach-lam-bun-dau-mam-tom-thom-ngon-2_760x450.jpg'),
(99, 24, 3, 'https://cdn.tgdd.vn/Files/2017/03/21/963373/cach-lam-bun-dau-mam-tom-thom-ngon-3_760x450.jpg'),
(100, 24, 4, 'https://cdn.tgdd.vn/Files/2017/03/21/963373/cach-lam-bun-dau-mam-tom-thom-ngon-4_760x450.jpg'),
(101, 24, 5, 'https://cdn.tgdd.vn/Files/2017/03/21/963373/cach-lam-bun-dau-mam-tom-thom-ngon-5_760x449.jpg'),
(102, 24, 6, 'https://cdn.tgdd.vn/Files/2017/03/21/963373/cach-lam-bun-dau-mam-tom-thom-ngon-6_760x450.jpg'),
(103, 24, 1, 'https://cdn.tgdd.vn/Files/2017/03/21/963373/cach-lam-bun-dau-mam-tom-thom-ngon-1_760x450.jpg'),
(104, 24, 2, 'https://cdn.tgdd.vn/Files/2017/03/21/963373/cach-lam-bun-dau-mam-tom-thom-ngon-2_760x450.jpg'),
(105, 24, 3, 'https://cdn.tgdd.vn/Files/2017/03/21/963373/cach-lam-bun-dau-mam-tom-thom-ngon-3_760x450.jpg'),
(106, 24, 4, 'https://cdn.tgdd.vn/Files/2017/03/21/963373/cach-lam-bun-dau-mam-tom-thom-ngon-4_760x450.jpg'),
(107, 24, 5, 'https://cdn.tgdd.vn/Files/2017/03/21/963373/cach-lam-bun-dau-mam-tom-thom-ngon-5_760x449.jpg'),
(108, 24, 6, 'https://cdn.tgdd.vn/Files/2017/03/21/963373/cach-lam-bun-dau-mam-tom-thom-ngon-6_760x450.jpg'),
(109, 26, 1, 'https://cdn.tgdd.vn/Files/2021/02/23/1329799/bi-quyet-nau-ca-kho-to-ngon-chuan-vi-ca-dai-mau-sac-chuan-dep-202209101128087734.jpg'),
(110, 26, 2, 'https://cdn.tgdd.vn/Files/2021/02/23/1329799/bi-quyet-nau-ca-kho-to-ngon-chuan-vi-ca-dai-mau-sac-chuan-dep-202209101128264547.jpg'),
(111, 26, 3, 'https://cdn.tgdd.vn/Files/2021/02/23/1329799/bi-quyet-nau-ca-kho-to-ngon-chuan-vi-ca-dai-mau-sac-chuan-dep-202209101128425937.jpg'),
(112, 26, 4, 'https://cdn.tgdd.vn/Files/2021/02/23/1329799/bi-quyet-nau-ca-kho-to-ngon-chuan-vi-ca-dai-mau-sac-chuan-dep-202208271626294790.jpg'),
(113, 27, 1, 'https://cdnv2.tgdd.vn/bhx-static/bhx/News/Images/2025/04/10/1576718/image9_202504101028334320.jpg'),
(114, 27, 2, 'https://cdnv2.tgdd.vn/bhx-static/bhx/News/Images/2025/04/10/1576718/image2_202504101029155265.jpg'),
(115, 27, 3, 'https://cdnv2.tgdd.vn/bhx-static/bhx/News/Images/2025/04/10/1576718/image1_202504101033552509.jpg'),
(116, 27, 4, 'https://cdnv2.tgdd.vn/bhx-static/bhx/News/Images/2025/04/10/1576718/image4_202504101034123646.jpg'),
(117, 27, 5, 'https://cdnv2.tgdd.vn/bhx-static/bhx/News/Images/2025/04/10/1576718/image3_202504101034423609.jpg'),
(118, 28, 1, 'https://cdn.tgdd.vn/Files/2017/03/23/964106/cach-nau-chao-long-thom-ngon-sanh-ngang-hang-quan-202208261655167828.jpg'),
(119, 28, 2, 'https://cdn.tgdd.vn/Files/2017/03/23/964106/cach-nau-chao-long-thom-ngon-sanh-ngang-hang-quan-202208261656351354.jpg'),
(120, 28, 3, 'https://cdn.tgdd.vn/Files/2017/03/23/964106/cach-nau-chao-long-thom-ngon-sanh-ngang-hang-quan-202208261658560824.jpg'),
(121, 28, 4, 'https://cdn.tgdd.vn/Files/2017/03/23/964106/cach-nau-chao-long-thom-ngon-sanh-ngang-hang-quan-202208261653201474.jpg'),
(122, 29, 1, 'https://cdn.tgdd.vn/Files/2021/08/16/1375565/cach-nau-com-tam-suon-bi-cha-tai-nha-ngon-nhu-ngoai-tiem-202108162224522338.jpg'),
(123, 29, 2, 'https://cdn.tgdd.vn/Files/2021/08/16/1375565/cach-nau-com-tam-suon-bi-cha-tai-nha-ngon-nhu-ngoai-tiem-202108162227044516.png'),
(124, 29, 3, 'https://cdn.tgdd.vn/Files/2021/08/16/1375565/cach-nau-com-tam-suon-bi-cha-tai-nha-ngon-nhu-ngoai-tiem-202108162229339436.jpg'),
(125, 29, 4, 'https://cdn.tgdd.vn/Files/2021/08/16/1375565/cach-nau-com-tam-suon-bi-cha-tai-nha-ngon-nhu-ngoai-tiem-202108162238309900.png'),
(126, 29, 5, 'https://cdn.tgdd.vn/Files/2021/08/16/1375565/cach-nau-com-tam-suon-bi-cha-tai-nha-ngon-nhu-ngoai-tiem-202108162240202988.png'),
(127, 29, 6, 'https://cdn.tgdd.vn/Files/2021/08/16/1375565/cach-nau-com-tam-suon-bi-cha-tai-nha-ngon-nhu-ngoai-tiem-202108162241503640.png'),
(128, 29, 7, 'https://cdn.tgdd.vn/Files/2021/08/16/1375565/cach-nau-com-tam-suon-bi-cha-tai-nha-ngon-nhu-ngoai-tiem-202108162241503640.png'),
(129, 30, 1, 'https://cdn.tgdd.vn/Files/2017/03/22/963738/cach-lam-goi-cuon-tom-thit-thom-ngon-cho-bua-com-gian-don-202112301129029086.jpg'),
(130, 30, 2, 'https://cdn.tgdd.vn/Files/2017/03/22/963738/cach-lam-goi-cuon-thom-ngon-don-gian-2_760x451.jpg'),
(131, 30, 3, 'https://cdn.tgdd.vn/Files/2017/03/22/963738/cach-lam-goi-cuon-thom-ngon-don-gian-3_760x450.jpg'),
(132, 30, 4, 'https://cdn.tgdd.vn/Files/2017/03/22/963738/cach-lam-goi-cuon-tom-thit-thom-ngon-cho-bua-com-gian-don-202102201225481515.jpg'),
(133, 30, 5, 'https://cdn.tgdd.vn/Files/2017/03/22/963738/cach-lam-goi-cuon-tom-thit-thom-ngon-cho-bua-com-gian-don-202103111042208754.jpg'),
(134, 31, 1, 'https://cdn.tgdd.vn/Files/2019/03/08/1153609/cach-nau-mi-quang-dung-vi-ma-khong-can-ra-tiem-202208251547361141.jpg'),
(135, 31, 2, 'https://cdn.tgdd.vn/Files/2019/03/08/1153609/cach-nau-mi-quang-dung-vi-ma-khong-can-ra-tiem-202208251545207969.jpg'),
(136, 31, 3, 'https://cdn.tgdd.vn/Files/2019/03/08/1153609/cach-nau-mi-quang-dung-vi-ma-khong-can-ra-tiem-202208251546072250.jpg'),
(137, 31, 4, 'https://cdn.tgdd.vn/Files/2019/03/08/1153609/cach-nau-mi-quang-dung-vi-ma-khong-can-ra-tiem-202208251546351248.jpg'),
(138, 31, 5, 'https://cdn.tgdd.vn/Files/2019/03/08/1153609/cach-nau-mi-quang-dung-vi-ma-khong-can-ra-tiem-202208251542210348.jpg'),
(139, 31, 6, 'https://cdn.tgdd.vn/Files/2019/03/08/1153609/cach-nau-mi-quang-dung-vi-ma-khong-can-ra-tiem-202208251543486142.jpg'),
(140, 32, 1, 'https://cdn.tgdd.vn/Files/2017/05/04/979185/cach-lam-nem-chua-hue-ngon-chuan-vi-202111011710016988.jpg'),
(141, 32, 2, 'https://cdn.tgdd.vn/Files/2017/05/04/979185/cach-lam-nem-chua-hue-ngon-chuan-vi-202111011712124620.jpg'),
(142, 32, 3, 'https://cdn.tgdd.vn/Files/2017/05/04/979185/cach-lam-nem-chua-hue-ngon-chuan-vi-202111011712401687.jpg'),
(143, 32, 4, 'https://cdn.tgdd.vn/Files/2017/05/04/979185/cach-lam-nem-chua-hue-ngon-chuan-vi-202111011713034638.jpg'),
(144, 33, 1, 'https://cdn.tgdd.vn/Files/2017/03/18/962092/cach-nau-pho-bo-ngon-chuan-vi-ha-noi-nuoc-dung-dam-da-202201261501257467.jpg'),
(145, 33, 2, 'https://cdn.tgdd.vn/Files/2017/03/18/962092/cach-nau-pho-bo-ngon-chuan-vi-ha-noi-nuoc-dung-dam-da-202201261501423561.jpg'),
(146, 33, 3, 'https://cdn.tgdd.vn/Files/2017/03/18/962092/an-lien-3-bat-pho-voi-cong-thuc-nau-pho-nay-202201261426437466.jpg'),
(147, 35, 1, 'https://cdn.tgdd.vn/Files/2022/11/17/1487645/cach-nau-xoi-xeo-ngo-thom-ngon-deo-dep-mat-cho-bua-sang-202211171348054272.jpg'),
(148, 35, 2, 'https://cdn.tgdd.vn/Files/2022/11/17/1487645/cach-nau-xoi-xeo-ngo-thom-ngon-deo-dep-mat-cho-bua-sang-202211171348249621.jpg'),
(149, 35, 3, 'https://cdn.tgdd.vn/Files/2022/11/17/1487645/cach-nau-xoi-xeo-ngo-thom-ngon-deo-dep-mat-cho-bua-sang-202211171348531927.jpg'),
(150, 35, 4, 'https://cdn.tgdd.vn/Files/2022/11/17/1487645/cach-nau-xoi-xeo-ngo-thom-ngon-deo-dep-mat-cho-bua-sang-202211171349317191.jpg'),
(151, 35, 5, 'https://cdn.tgdd.vn/Files/2022/11/17/1487645/cach-nau-xoi-xeo-ngo-thom-ngon-deo-dep-mat-cho-bua-sang-202211171349585361.jpg'),
(152, 35, 6, 'https://cdn.tgdd.vn/Files/2022/11/17/1487645/cach-nau-xoi-xeo-ngo-thom-ngon-deo-dep-mat-cho-bua-sang-202211171350195717.jpg');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `instruction_translations`
--

CREATE TABLE `instruction_translations` (
  `instruction_id` int NOT NULL,
  `language_code` varchar(5) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `instruction_translations`
--

INSERT INTO `instruction_translations` (`instruction_id`, `language_code`, `description`) VALUES
(1, 'en', 'Mix rice flour and tapioca starch well. Then add water and stir until the flour dissolves. You can add a little salt with the water. After stirring well, let the dough rest for about 4 hours.'),
(1, 'vi', 'Bột gạo và bột năng, trộn đều lại với nhau. Sau đó, cho nước lọc vào và khuấy tan. Bạn có thể thêm một xíu muối cùng với nước lọc. Sau khi khuấy, để bột nghỉ khoảng 4 tiếng.'),
(2, 'en', 'After 4 hours, remove the clear water on the surface of the dough, add an amount of hot water equal to the amount of clear water removed. Put the steamer on the stove, arrange the bowls in the pot. Spread oil evenly on the bowls. When the bowls are hot, stir the dough, and pour enough flour into the bowls. During the steaming process, keep the heat steady so that the cake is cooked evenly and the dough is not undercooked. After about 10 minutes, when the cake turns opaque white, the cake is done.'),
(2, 'vi', 'Sau 4 tiếng, bạn vớt bỏ phần nước trong trên mặt bột, bạn cho thêm một lượng nước nóng bằng với lượng nước trong bỏ đi. Cho nồi hấp lên bếp, sắp chén vào nồi. Thoa đều dầu vào chén. Khi chén nóng, bạn khuấy đều bột, và đổ lượng bột vừa đủ vào chén. Trong quá trình hấp, để đều lửa, để bánh chín đều và không bị sống bột. Khoảng 10 phút, khi bánh đổi sang màu trắng đục là bánh đã chín rồi nhé.'),
(3, 'en', 'Wash and boil the fresh shrimp. Peel and crush the shrimp slightly. Then put the crushed shrimp in the pan and stir-fry with annatto oil. Until the shrimp is dry and fluffy. Wash and chop the green onions. Put the pan on the stove, when the pan is hot, add oil, when the oil boils, add the green onions and mix well to make scallion oil.'),
(3, 'vi', 'Tôm tươi rửa sạch, luộc chín. Tôm chín, lột vỏ và giã hơi dập. Tiếp đó cho tôm đã giã lên chảo, xào với màu điều. Đến khi tôm khô và tơi ra là được. Hành lá rửa sạch, cắt nhỏ. Cho chảo lên bếp, khi chảo nóng cho dầu vào, khi dầu sôi, cho hành lá vào, trộn đều để làm mỡ hành. '),
(4, 'en', 'Take a small amount of shrimp broth, heat it up to make the dipping sauce. When the water boils, add fish sauce, sugar, taste until it has a rich and sweet taste. Pour into a bowl, top with a few thinly sliced ​​chili peppers.'),
(4, 'vi', 'Lấy một lượng nhỏ nước luộc tôm, đun nóng lên để pha nước chấm. Khi nước sôi, cho thêm nước mắm, đường, nếm có vị đậm đà ngọt dịu là được. Cho ra chén, để lên trên vài lát ớt cắt mỏng.'),
(5, 'en', 'When eating, we put dried shrimp, puffed pork skin, and a little scallion oil on top of the cake. Served with a bowl of chili dipping sauce, it will be extremely delicious!'),
(5, 'vi', 'Khi ăn chúng ta cho tôm khô, da heo phồng, một ít mỡ hành lên trên bánh. Kèm theo chén nước chấm ớt, sẽ thơm ngon vô cùng nhé!'),
(6, 'en', 'After buying banana leaves, wash them thoroughly with water, wipe them clean with a cloth, and cut them into square pieces about 17–20 cm on each side. Place a pan of water on the stove and bring it to a boil. Add the cut banana leaves and boil them for about 5–7 minutes. Once the water starts boiling, turn off the heat and take out the leaves. Fold one to check — if you don\'t hear the crackling sound anymore, the leaves are ready to be removed. After boiling, use a dry towel to wipe the banana leaves again. For 300g of pork, wash it thoroughly and cut it into small dice-sized pieces. For 300g of shrimp, remove the shell and head, devein, and rinse well with water.'),
(6, 'vi', 'Lá chuối sau khi mua về bạn rửa sạch với nước, dùng khăn lau sạch rồi cắt lá chuối thành những khổ vuông có cạnh dài 17-20cm. Bạn bắc 1 chảo nước lên bếp, cho lá chuối vừa cắt vào luộc trong vòng 5 -7 phút, đợi nước sôi lên thì bạn tắt bếp, lấy lá chuối ra gấp thử. Nếu bạn không nghe tiếng gấp của lá chuối nữa là có thể vớt lá chuối ra. Luộc lá chuối xong, bạn dùng 1 cái khăn khô để lau lá chuối thêm 1 lần nữa nhé! 300g thịt heo bạn tiến hành rửa sạch, cắt nhỏ cỡ hạt lựu. 300g tôm bạn bỏ vỏ và đầu, lấy chỉ lưng và rửa sạch với nước.'),
(7, 'en', 'Add 400g of tapioca starch, 300ml of boiling water, and 1 teaspoon of salt into the dough mixer, then turn it on to knead the dough for about 15–20 minutes. Once the dough becomes fairly smooth, remove it from the mixer, rub 2 tablespoons of cooking oil on your hands, and knead the dough a bit more to make it softer and smoother. After kneading, wrap the dough with plastic wrap and let it rest for 2–3 hours.'),
(7, 'vi', 'Bạn cho vào máy trộn bột 400g bột năng, 300ml nước sôi, 1 muỗng cà phê muối và bật công tắt cho máy trộn bột trong vòng 15-20 phút. Sau khi bột đã được trộn khá mịn, bạn lấy bột ra, cho 2 muỗng canh dầu ăn lên tay và tiến hành nhồi bột thêm một lát nữa để bột được mềm mịn hơn. Nhồi bột xong bạn lấy màng bọc thực phẩm để bọc bột lại để ủ trong 2-3 tiếng.'),
(8, 'en', 'Put 300g of shrimp and 300g of pork into two separate bowls. In each bowl, add 1 teaspoon of minced shallots, 1 teaspoon of minced garlic, 1 tablespoon of fish sauce, 1 teaspoon of pepper, 1 teaspoon of Korean chili powder, and 1 teaspoon of salt. Mix well and let the shrimp and pork marinate for about 30 minutes to absorb the seasonings.'),
(8, 'vi', 'Bạn bỏ 300g tôm và 300g thịt vào 2 cái tô riêng, sau đó nêm vào mỗi tô 1 muỗng cà phê hành tím xay nhuyễn, 1 muỗng cà phê tỏi băm, 1 muỗng canh nước mắm, 1 muỗng cà phê tiêu, 1 muỗng cà phê ớt bột Hàn Quốc, 1 muỗng cà phê muối. Bạn trộn đều rồi để tôm và thịt được thấm gia vị trong khoảng 30 phút.'),
(9, 'en', 'Next, place a pan on the stove and add 2 tablespoons of cooking oil. When the oil is hot, add 1 tablespoon of minced garlic and 1 tablespoon of minced shallots, then sauté until fragrant. Once the garlic and shallots release their aroma, add the pork and stir-fry first. Keep stirring until the pork firms up and the fat becomes slightly translucent, then add the shrimp and continue stir-frying together. When the shrimp turns red, add 1 teaspoon of seasoning powder, give it one last stir, and then turn off the heat.'),
(9, 'vi', 'Tiếp đến bạn bắc chảo lên bếp, cho vào 2 muỗng canh dầu ăn. Đợi dầu nóng bạn cho 1 muỗng canh tỏi và 1 muỗng canh hành tím băm vào phi thơm. Khi hành tỏi dậy mùi thơm bạn cho thịt heo vào xào trước. Đảo đều tay đến khi thịt heo săn lại và mỡ heo bắt đầu chuyển sang màu hơi trong thì bạn cho tôm vào xào chung. Bạn xào đến khi tôm chuyển sang màu đỏ thì nêm thêm 1 muỗng cà phê hạt nêm, đảo đều tay 1 lượt nữa rồi tắt bếp.'),
(10, 'en', 'Divide the dough into equal portions and flatten each piece into a thin sheet. Gently place an adequate amount of filling—consisting of shrimp and pork—onto the dough, then fold it and press the edges firmly together to prevent the filling from falling out during boiling. Once all the fillings are wrapped inside the dough, start wrapping the cakes in banana leaves. Brush a thin layer of oil onto the banana leaf, place one cake on it, and fold the leaf until it completely covers the cake.'),
(10, 'vi', 'Bạn chia bột thành những phần bằng nhau và ép dẹt thật mỏng. Bạn nhẹ nhàng đặt 1 lượng nhân vừa đủ bao gồm tôm và thịt lên rồi gấp cho mép bánh dính chặt lại với nhau để khi luộc, nhân không bị rơi ra khỏi bánh. Khi đã gói nhân bánh vào trong toàn bộ phần vỏ bánh, bạn bắt đầu gói bánh vào lá chuối. Bạn quét 1 lớp dầu mỏng lên lá chuối, đặt 1 cái bánh bột lọc vào và gập lá chuối lại cho đến khi lá chuối bao phủ lên toàn bộ bánh.'),
(11, 'en', 'Prepare a steamer, arrange the cakes on the steaming rack, and pour water into the pot. Steam the bánh bột lọc for about 15–20 minutes. After 15 minutes, take one cake out to check — if the wrapper turns translucent and the cake tastes slightly sweet and tender, it means the cakes are fully cooked.'),
(11, 'vi', 'Bạn chuẩn bị 1 nồi hấp, xếp bánh lên xửng hấp rồi đổ nước vào, bạn tiến hành hấp bánh bột lọc trong vòng 15-20 phút. Sau 15 phút, bạn thử lấy 1 cái bánh ra, nếu bánh chuyển sang màu trong, ăn thử có vị ngọt, mềm thì bánh đã chín.'),
(12, 'en', 'After steaming the banh bot loc, you arrange it on a plate to enjoy with a little sweet and sour fish sauce. You eat it while it\'s still hot, it\'s absolutely delicious.'),
(12, 'vi', 'Bánh bột lọc sau khi hấp chín, bạn bày ra dĩa để chuẩn bị thưởng thức cùng với 1 chút nước mắm chua ngọt. Bạn ăn ngay khi bánh còn nóng thì quả là tuyệt cú mèo luôn'),
(13, 'en', 'First, put in a large bowl 200g rice flour, 100g tapioca starch, 1 teaspoon turmeric powder, 1 teaspoon seasoning powder, 1 teaspoon salt, ½ teaspoon pepper and 450ml water, stir well to combine the mixture, then add about 20g chopped green onions, stir gently and let the dough rest for 1 hour.'),
(13, 'vi', 'Đầu tiên, bạn cho vào một tô lớn 200g bột gạo, 100g bột năng, 1 muỗng cà phê bột nghệ, 1 muỗng cà phê hạt nêm, 1 muỗng cà phê muối, ½ muỗng cà phê hạt tiêu và 450ml nước, khuấy đều để hỗn hợp hòa quyện với nhau rồi cho tiếp khoảng 20g hành lá cắt nhuyễn, khuấy nhẹ và để bột nghỉ 1 tiếng.'),
(14, 'en', 'Next, wash 200g of shrimp with cold water, drain, remove the head and shell of the shrimp, then use a knife to cut the back to remove the black thread on the back of the shrimp. Then, marinate the shrimp with 1 teaspoon of seasoning powder, 1 teaspoon of sugar, 1 teaspoon of fish sauce, ½ teaspoon of pepper, 1 teaspoon of minced shallots, 1 teaspoon of minced garlic, mix well and leave the shrimp in the refrigerator for about 30 minutes.'),
(14, 'vi', 'Kế tiếp, bạn đem 200g tôm đi rửa sạch với nước lạnh, vớt ra để ráo, đem bỏ phần đầu và vỏ tôm đi rồi dùng dao rạch phần sống lưng để rút chỉ đen trên lưng tôm. Sau đó, bạn tiến hành ướp tôm với 1 muỗng cà phê hạt nêm, 1 muỗng cà phê đường, 1 muỗng cà phê nước mắm, ½ muỗng cà phê tiêu, 1 muỗng cà phê hành tím băm, 1 muỗng cà phê tỏi băm, trộn đều và để tôm trong ngăn mát tủ lạnh khoảng 30 phút.'),
(15, 'en', 'Next step, add 2 tablespoons of white vinegar and 2 tablespoons of sugar to the bowl, stir well to dissolve the mixture, then add 100g of shredded papaya to the bowl, then leave it like that for about 1 hour to let the papaya absorb the spices.'),
(15, 'vi', 'Bước tiếp theo, bạn cho lần lượt vào chén 2 muỗng canh giấm trắng và 2 muỗng canh đường, khuấy đều để hỗn hợp tan với nhau rồi cho tiếp 100g đu đủ bào sợi vào chén, sau đó để như vậy khoảng 1 tiếng để đu đủ ngấm đều gia vị. '),
(16, 'en', 'To make the sweet and sour fish sauce to eat with banh can, you sequentially add to the bowl 10 tablespoons of fish sauce, 10 tablespoons of sugar, 20 tablespoons of filtered water, 1 tablespoon of lime juice, 1 tablespoon of chopped chili and 1 tablespoon of minced garlic, then stir the sweet and sour fish sauce mixture well.'),
(16, 'vi', 'Để làm nước mắm chua ngọt ăn kèm với bánh căn, bạn cho lần lượt vào chén 10 muỗng canh nước mắm, 10 muỗng canh đường, 20 muỗng canh nước lọc, 1 muỗng canh nước cốt chanh, 1 muỗng canh ớt băm và 1 muỗng canh tỏi băm, sau đó khuấy đều hỗn hợp nước mắm chua ngọt.'),
(17, 'en', 'Place the pan with the molds for the banh can on the stove, then you fill the molds in the pan with cooking oil and heat the oil on low heat. When the oil is boiling, you put the above mixed batter, the broken quail eggs and 1-2 shrimp into the molds, cover and continue to fry the cake for about 2 minutes. When you open the lid, you fry the banh can for about 2 more minutes, until the cake is golden brown and the shrimp and quail eggs are cooked, then you take the cake out and put it on a plate lined with oil-absorbing paper.'),
(17, 'vi', 'Bắc loại chảo có khuôn để đổ bánh căn lên bếp, sau đó bạn cho ngập dầu ăn vào các khuôn bánh trong chảo và đun dầu nóng ở mức lửa nhỏ. Khi dầu đã sôi, bạn cho lần lượt vào các khuôn phần bột đã pha ở trên, trứng cút được đập vỡ và 1 - 2 con tôm, đậy nắp rồi tiếp tục chiên bánh trong khoảng 2 phút. Khi mở nắp ra, bạn chiên bánh căn thêm khoảng 2 phút nữa, đến khi bánh vàng đều và tôm lẫn trứng cút đều đã chín hết thì bạn gắp bánh ra dĩa có lót giấy thấm dầu.'),
(18, 'en', 'Besides providing all the necessary nutrients from different ingredients, the finished banh can dish will also have the crispy taste of the crust, the freshness and sweetness of the shrimp filling as well as the rich, fatty taste of quail eggs, making you ecstatic and unable to stop eating!'),
(18, 'vi', 'Bên cạnh việc bổ sung đầy đủ dinh dưỡng cần thiết từ các nguyên liệu khác nhau, món bánh căn sau khi chế biến xong còn sẽ mang hương vị giòn rụm của lớp vỏ, sự tươi ngon, ngọt thịt của phần nhân tôm cũng như là vị bùi bùi, béo béo từ trứng cút, khiến bạn phải ngất ngây mà ăn mãi không ngừng được đó!'),
(19, 'en', 'We buy pork bones, then wash them with salt water, then rinse them with clean water. Then, put the pork bones in a pot and boil for about 3 minutes, then take them out to reduce the fishy smell, then take them out to drain. Next, put the pork bones in the pot, add 4-5 crushed shallots and 5-7 parts of coriander roots to make the water sweeter and more fragrant. You should keep the stove at medium heat and cook for about 45-50 minutes.'),
(19, 'vi', 'Xương heo chúng ta mua về rồi rửa qua nước muối, rồi rửa lại với nước sạch. Sau đó, cho xương heo vào nồi luộc sợ trong khoảng 3 phút rồi vớt ra để khử bớt mùi tanh rồi vớt ra để ráo. Tiếp đến, bạn cho xương heo vào nồi, cho thêm 4-5 củ hành tím đập dập và 5-7 phần thân rễ cây ngò để cho nước sẽ có vị ngọt và thơm hơn. Bạn nên để bếp ở mức độ lửa vừa và nấu trong khoảng thời gian 45-50 phút.'),
(20, 'en', 'When you buy snakehead fish at the market or supermarket, they are already prepared. You just need to rub salt on the fish to remove the fishy smell and then rinse it with clean water.  Next, use a knife to cut the meat from the tail to the head to separate the bones and meat. You should cut the fish bones into 2-3 sections, and the fish meat should be cut into bite-sized pieces. Put the fish bones and fish meat in a bowl, then add 1 tablespoon of fish sauce, 1 tablespoon of seasoning powder, 1 tablespoon of sugar, ½ tablespoon of crushed shallots, ½ tablespoon of minced garlic, ½ tablespoon of pepper, 1 tablespoon of minced chili and 2 tablespoons of annatto oil, then mix well to let the fish absorb the spices and leave for 20 minutes.'),
(20, 'vi', 'Cá lóc khi bạn mua ở chợ hoặc siêu thị thì người ta đã làm sẵn, bạn chỉ cần dùng muối chà sát lên thân cá để khử đi mùi tanh rồi sửa lại với nước sạch. Tiếp đến, dùng dao cắt thịt từ phần đuôi lên đến đầu để tách phần xương và phần thịt. Xương cá bạn nên cắt thành 2-3 đoạn, thịt cá bạn nên cắt thành những miếng vừa ăn. Cho xương cá và thịt cá vào một cái tô, sau đó cho vào 1 muỗng canh nước mắm, 1 muỗng canh hạt nêm, 1 muỗng canh đường, ½ muỗng canh củ nén giã nhỏ, ½ muỗng canh tỏi băm, ½ muỗng canh tiêu, 1 muỗng canh ớt băm và 2 muỗng canh dầu điều rồi trộn đều hỗn hợp để cho cá thấm đều gia vị và để trong 20 phút.'),
(21, 'en', 'Add the fish head and bones to the pot of bone stew in step 1 and simmer for 15-20 minutes. Next, add 1 tablespoon of sugar, 1 tablespoon of seasoning powder and 1 tablespoon of fish sauce and stir gently.'),
(21, 'vi', 'Bạn cho phần đầu và xương cá vào hầm trong khoảng thời gian 15-20 phút vào chung với nồi hầm xương ở bước 1. Tiếp đến, bạn cho vào 1 muỗng canh đường, 1 muỗng canh hạt nêm và 1 muỗng canh nước mắm và khuấy nhẹ.'),
(22, 'en', 'You put a pan on the stove and add 2 tablespoons of cooking oil, when the oil is hot, add crushed shallots, minced garlic, minced shallots, and minced chili into the pan and sauté until fragrant. Next, add the marinated fish to the pan and stir-fry until the fish is firm. Then, add about 200ml of water to the pan and lower the heat to low to let the fish juice thicken, the spices soak into the fish meat and you have completed step 4.'),
(22, 'vi', 'Bạn để một cái chảo lên bếp rồi cho vào 2 muỗng canh dầu ăn, dầu nóng bạn cho củ nén giã nhỏ, tỏi băm, hành tím băm, ớt băm vào chảo phi thơm. Tiếp đến, bạn cho cá đã ướp vào chảo xào cho đến khi cá săn lại. Sau đó, bạn cho vào chảo khoảng 200ml nước rồi hạ lửa bếp ở mức nhỏ để cho nước cá kẹo lại, gia vị ngấm vào thịt cá là đã hoàn thành xong bước 4.'),
(23, 'en', 'You boil the pot of water again, then add the noodles to the pot, cook for about 5-7 minutes until the noodles have just expanded and become soft, the noodles are done.'),
(23, 'vi', 'Bạn đun lại nồi nước leo cho sôi lên, sau đó cho lượng bánh canh vào nồi, nấu trong khoảng 5-7 phút để bánh canh vừa nở ra và có độ mềm là bánh canh đã chín.'),
(24, 'en', 'Next turn off the stove and scoop the noodles into a bowl, put some braised snakehead fish on top of the noodles, add some chopped green onions to the bowl and you done.'),
(24, 'vi', 'Tiếp đến, bạn tắt bếp rồi múc bánh canh ra tô, bỏ một ít cá lóc kho lên trên bề mặt bánh canh, cho thêm một ít hành lá cắt nhỏ vào tô nữa là xong.'),
(25, 'en', 'Buy banana leaves, wash clean. Soak sticky rice and skinless mung beans before wrapping for about 4 hours or overnight. You can soak sticky rice in banana leaves or pandan leaves to make the sticky rice fragrant and green.'),
(25, 'vi', 'Lá chuối mua về, rửa sạch. Ngâm gạo nếp, đậu xanh không vỏ trước khi gói tầm 4 tiếng hoặc để qua đêm, có thể ngâm gạo nếp với lá chuối hay lá dứa để nếp thơm ngon và có màu xanh.'),
(26, 'en', 'After soaking, pour the sticky rice into a basket and drain, add 1 to 2 tablespoons of salt and mix well. Pour the mung beans into a basket, add salt and pepper and mix well. Wash and cut the pork into pieces. The way to marinate the meat for banh chung is very simple, you just need to marinate it with salt, sugar, and pepper in the right amount. In addition, you can refer to the way to make delicious banh chung filling'),
(26, 'vi', 'Sau khi ngâm xong, bạn đổ nếp ra rổ và để ráo, thêm 1 tới 2 muỗng muối vào và trộn đều. Đậu xanh cũng đổ ra rổ, thêm muối và tiêu rồi trộn đều. Thịt heo rửa và cắt miếng. Cách ướp thịt gói bánh chưng rất đơn giản, bạn chỉ cần ướp với muối, đường, tiêu với lượng vừa ăn là được. Ngoài ra, bạn có thể tham khảo thêm cách làm nhân bánh chưng ngon'),
(27, 'en', 'Wrapping the cake with a mold To make the square banh chung look nice, you should prepare square banh chung molds to fix the shape of the cake. Arrange about 4 pieces of banana leaves in the mold, each leaf you fold horizontally to create a straight line, place the banana leaves vertically along this line and arrange them in the 4 corners of the frame, then add sticky rice, green beans, and pork as shown below. Spread the sticky rice evenly in the 4 corners to avoid the cake being concave and convex, add green beans and then add meat, then add another layer of green beans, and finally spread the sticky rice on top. Then fold the banana leaf, use one hand to hold the fold, then lift the mold, tie it with a string 2 times in a cross shape. Do not tie the string too tightly, to avoid the cake from rising beautifully and deliciously.'),
(27, 'vi', 'Gói bánh bằng khuôn Để bánh chưng vuông vức đẹp mắt, bạn nên chuẩn bị các khuôn gói bánh chưng hình vuông để cố định hình dạng bánh. Bạn xếp khoảng 4 miếng lá chuối vào khuôn, mỗi lá bạn gập ngang lại tạo 1 đường thẳng, đặt lá chuối đứng theo đường thẳng này và xếp vào 4 góc của khung sau đó cho nếp, đậu xanh, thịt heo vào như hình bên dưới. Rải nếp đều 4 góc để tránh bánh bị lồi lõm, cho đậu xanh vào rồi thêm thịt sau đó lại thêm một lớp đậu xanh, cuối cùng là rải nếp phủ lên. Sau đó bạn gấp lá chuối lại, dùng 1 tay giữ miệng gấp rồi nhấc khuôn lên, lấy dây buộc 2 vòng theo hình chữ thập. Không buộc dây quá chặt, để tránh bánh nở không đẹp, ngon.'),
(28, 'en', 'To boil banh chung, you do as follows: First, arrange the wrapped banh chung in the pot, pour water to cover the cake, boil small size cakes for about 5 hours to cook but large size cakes will take longer to cook. Always prepare a kettle of boiling water next to you so that when the water in the pot is dry, you can add more water immediately, do not pour cold water into the pot. When half of the boiling time has passed, you should open the pot lid, turn the cake over so that the cake cooks more evenly.'),
(28, 'vi', 'Cách luộc bánh chưng thì bạn thực hiện như sau: Đầu tiên xếp bánh chưng đã gói vào nồi, đổ nước ngập mặt bánh, luộc bánh kích cỡ nhỏ khoảng 5 tiếng sẽ chín nhưng bánh cỡ lớn sẽ có thời gian nấu lâu hơn. Luôn chuẩn bị 1 ấm nước sôi bên cạnh để khi nước trong nồi cạn, bạn kịp thời tiếp thêm nước, không đổ nước lạnh vào nồi. Khi luộc được nửa thời gian bạn nên mở nắp nồi, đảo mặt bánh để bánh chín đều hơn.'),
(29, 'en', 'After the cake is cooked, take it out of the pot and soak it in cold water for about 20 minutes, then arrange the cake on the table, use a heavy object to press down to squeeze out the water so that the cake is dry and delicious and can be kept for a long time. The time to squeeze out all the water is about 5 to 8 hours. Then you can enjoy it!'),
(29, 'vi', 'Sau khi bánh chín, bạn lấy ra khỏi nồi cho bánh vào nước lạnh ngâm tầm 20 phút rồi xếp bánh ra mặt bàn, dùng đồ nặng đè lên để ép nước ra khỏi cho bánh ráo ngon và giữ được lâu, thời gian ép hết nước từ khoảng 5 đến 8 tiếng. Sau đó là có thể thưởng thức rồi nhé!'),
(30, 'en', 'Mix the cake flour Add 1 liter of water to the rice flour, stir well, add 1/4 teaspoon of salt, let the dough rise for 30 minutes.'),
(30, 'vi', 'Pha bột làm bánh Cho 1 lít nước vào bột gạo khuấy đều, cho thêm 1/4 muỗng cafe muối, để bột nở trong 30 phút.'),
(31, 'en', 'Making the filling Wash the lean meat, drain, cut into small pieces and then use a knife to mince it. Peel the shallots, cut half into small pieces and mince the other half, grate the other half. Add 1 tablespoon of shallots to the meat to marinate and mix well. Peel the shallots, wash them, and dice them to make the filling. Soak the wood ear mushrooms in water, cut off the stem, then cut into strips and mince.'),
(31, 'vi', 'Làm nhân bánh Thịt nạc dăm rửa sạch, để ráo, thái miếng nhỏ rồi dùng dao băm nhuyễn. Hành tím bóc vỏ, 1/2 thái miếng nhỏ băm đều, 1/2 bào nhỏ. Cho 1 muỗng canh hành tím vào thịt để ướp rồi trộn đều nha các bạn. Hành tây bóc vỏ, rửa sạch, thái hạt lựu để làm phần nhân bánh. Nấm mèo ngâm nước, cắt cuống chân rồi cắt sợi, băm nhỏ.'),
(32, 'en', 'Stir-fry the filling Put the pan on the stove, add 2 tablespoons of cooking oil, then sauté the remaining shallots, add the marinated minced meat to the pan, add the diced onions to the pan, stir-fry until the onions are cooked, then season with 1 tablespoon of fish sauce, 2 teaspoons of seasoning powder, 1 teaspoon of sugar and mix well. When the water is dry, add the chopped mushrooms, stir well again, add 1 teaspoon of pepper before turning off the stove.'),
(32, 'vi', 'Xào nhân bánh Cho chảo lên bếp thêm 2 muỗng canh dầu ăn rồi phi thơm phần hành tím còn lại cho tiếp thịt băm đã ướp vào chảo xào, cho phần hành tây thái hạt lựu vào chảo, xào đến khi hành tây chín rồi nêm 1 muỗng canh nước mắm, 2 muỗng cafe hạt nêm, 1 muỗng cafe đường vào trộn đều. Khi nước cạn, cho phần nấm mèo băm nhỏ vào, đảo đều lần nữa, cho 1 muỗng cafe hạt tiêu vào trước khi tắt bếp. '),
(33, 'en', 'Place the cake on the stove, apply a layer of pure cooking oil on medium heat. Add a large bowl of tea powder water into the ring, shake well to spread the water evenly on the surface. Cover, leave for 5 seconds until the cake is cooked, support a large plate with a layer of cooking oil. Then add a layer of fried cake filling and roll it up.'),
(33, 'vi', 'Bắc phấn lên bếp, thoa lên một lớp dầu ăn thật tinh khiết để lửa vừa. Cho 1 kềm canh lớn nước bột trà vào vòng, lắc đều cho nước lan đều mặt. Đậy lại, để trong 5 giây là bánh chín, hỗ trợ một cái đĩa lớn đã có một lớp dầu ăn. Sau đó cho 1 lớp nhân bánh đã xào lên rồi cuộn lại là được.'),
(34, 'en', 'Mix the dough First, put 100g of rice flour, 100g of tapioca starch, ¼ teaspoon of salt and 600ml of water into a large pot and stir until dissolved, then strain through a sieve to avoid lumps. Then let the mixture sit for 1-1.5 hours for the flour to settle to the bottom. When the flour mixture has settled to the bottom, pour out the water on top, then add the same amount of water and stir again.'),
(34, 'vi', 'Pha bột Đầu tiên bạn cho 100g bột gạo tẻ, 100g bột năng, ¼ muỗng cà phê muối và 600ml nước vào một cái nồi lớn và khuấy đều cho tan hết rồi lọc qua rây để tránh bột bị vón cục. Sau đó bạn để yên hỗn hợp này trong vòng 1 – 1.5 giờ cho bột lắng xuống đáy. Khi hỗn hợp bột đã lắng xuống đáy thì bạn đổ đi phần nước trên mặt rồi lại thêm vào đúng lượng nước đã đổ đi và lại khuấy đều.'),
(35, 'en', 'Place the soaked flour mixture on the stove and use a whisk or egg beater (to make the batter smooth quickly) to stir it evenly and continuously over medium heat until the batter starts to thicken. Then, lower the heat and continue stirring to prevent the batter at the bottom of the pot from burning. Stir until your hand feels heavy, indicating the batter is thick (lower the heat even more as it thickens) and has turned milky white. At this point, add 30ml of cooking oil and 15ml of sesame oil, then continue stirring evenly until the batter is smooth and the mixture becomes sticky, elastic, and can be pulled into strands. If you find the mixture too thick for your preference, you can add some water. After that, stir steadily at the lowest heat setting for 5–10 minutes until the batter turns transparent; taste it and there no raw flour smell, it sticky and viscous, and when you lift the whisk, the batter breaks off in segments—that means it fully cooked. Turn off the heat and keep the lid slightly ajar to prevent the top surface of the batter in the pot from drying out.'),
(35, 'vi', 'Nấu bột Bạn bắc hỗn hợp bột đã ngâm lên bếp và dùng phới hay cây đánh trứng (để bột nhanh mịn) khuấy đều, liên tục trên lửa vừa cho đến khi bột bắt đầu đặc sệt lại thì bạn hạ nhỏ lửa và tiếp tục khuấy để tránh bột dưới đáy nồi bị cháy nhé. Bạn khuấy đến khi thấy nặng tay là bột đã đặc (càng đặc càng hạ nhỏ lửa) và ngả màu trắng đục thì thêm vào 30ml dầu ăn và 15ml dầu mè, tiếp tục khuấy đều đến khi bột mịn và hỗn hợp trở nên dính, dẻo, có thể kéo thành sợi. Nếu bạn cảm thấy hỗn hợp quá đặc so với sở thích của mình thì bạn có thể thêm nước. Sau đó bạn khuấy đều tay ở mức lửa nhỏ nhất trong 5 - 10 phút đến khi bột chuyển sang màu trong; nếm thấy không còn mùi bột sống, dẻo quánh và nâng phới lên thì bột bị đứt đoạn, như vậy là bột đã chín. Bạn tắt bếp và vẫn để hé vung tránh mặt trên của nồi bột bị khô nhé.'),
(36, 'en', 'Prepare the ingredients for the side dish Soak the dried mushrooms (wood ear mushrooms, shiitake mushrooms) in warm water to quickly expand for about 10-15 minutes; then wash, cut off the hard stem and chop finely. Continue to wash the pork and chop finely, wash the green onions, remove the excess parts and chop finely. Peel and slice the shallots, wash and chop the coriander, wash the garlic and chili, peel and chop finely.'),
(36, 'vi', 'Sơ chế nguyên liệu làm phần thịt ăn kèm Bạn ngâm các loại nấm khô (mộc nhĩ, nấm hương) trong nước ấm cho nhanh nở với thời gian khoảng 10 – 15 phút; sau đó rửa sạch, cắt bỏ phần chân cứng và băm nhỏ. Tiếp tục rửa sạch thịt lợn và băm nhuyễn, còn hành lá thì bạn rửa sạch rồi loại bỏ các phần thừa và băm nhỏ. Còn hành tím thì bạn bóc vỏ và thái lát, rau mùi rửa sạch thái nhỏ, tỏi, ớt rửa sạch, bóc vỏ và băm nhỏ là được nhé.'),
(37, 'en', 'Stir-fry meat, dry onion Put some cooking oil in the pot and sauté the green onions over medium heat, then add the ingredients such as minced meat, shiitake mushrooms, and wood ear mushrooms and stir-fry until fragrant and season to your family taste and turn off the stove. For the shallots, sauté in hot oil until light golden brown, then remove and drain.'),
(37, 'vi', ' Xào thịt, phi hành khô Bạn cho chút dầu ăn vào nồi và phi thơm hành lá trên lửa vừa, sau đó cho các nguyên liệu như thịt băm, nấm hương, mộc nhĩ vào xào săn và nêm gia vị cho vừa khẩu vị của gia đình bạn và tắt bếp nhé. Đối với hành tím thì phi trên dầu nóng đến khi vàng nhạt thì vớt ra để ráo dầu.'),
(38, 'en', 'Mix fish sauce Put lemon, sugar, water in a bowl in a 1:1:1 ratio, dissolve the sugar and slowly add fish sauce to suit your family taste. Then add minced garlic and chili.'),
(38, 'vi', 'Pha nước mắm Bạn cho vào bát bao gồm chanh, đường, nước theo tỉ lệ 1:1:1, khuấy tan đường rồi thêm từ từ nước mắm cho vừa khẩu vị của gia đình bạn. Sau đó bạn cho thêm tỏi và ớt băm vào.'),
(39, 'en', 'So, after only 5 steps, you have a bowl of hot, smooth, hot and delicious banh duc. A bowl full of minced meat, fried onions, and attractive fish sauce is irresistible.'),
(39, 'vi', 'Vậy là chỉ sau 5 bước thôi là bạn đã có một chén bánh đúc nóng sánh mịn, nóng hổi thơm ngon rồi. Một chén đầy đủ topping thịt bằm, hành phi, nước mắm hấp dẫn, ngon mắt thì không thể nào chối từ được.'),
(40, 'en', 'Stir-fry the banh gio filling Place a pan on the stove, add a little cooking oil, wait for the oil to heat up, then add 1 tablespoon of garlic, 1 tablespoon of onion, 1 tablespoon of minced shallots and stir-fry until fragrant, then add 200g of minced pork. When the meat is almost cooked, add 20g of shiitake mushrooms, 30g of soaked and chopped wood ear mushrooms and 1 tablespoon of fried onions. Season with 1 tablespoon of salt, 1 tablespoon of seasoning powder, 1 tablespoon of pepper, stir-fry for 5 minutes and turn off the heat.'),
(40, 'vi', 'Xào nhân bánh giò Đặt 1 cái chảo lên bếp, cho vào chảo 1 ít dầu ăn, đợi dầu nóng rồi cho tiếp 1 muỗng canh tỏi, 1 muỗng canh hành tây, 1 muỗng canh hành tím băm vào xào thơm rồi cho 200gr thịt heo bằm vào. Khi thịt gần chín thì cho 20gr nấm hương, 30gr nấm mèo đã ngâm mềm cắt nhỏ và 1 muỗng canh hành phi vào. Nêm 1 muỗng canh muối, 1 muỗng canh hạt nêm, 1 muỗng canh tiêu vào đảo đều 5 phút rồi tắt bếp.'),
(41, 'en', 'Cook the dough for the banh gio crust Put 320g of rice flour and 80g of tapioca starch, 1/2 tbsp of salt in a large pot with 1.5 liters of bone broth and mix well. Then put on the stove, stirring continuously over low heat, add 1 tbsp of cooking oil, stirring continuously until the dough thickens, then turn off the stove.'),
(41, 'vi', 'Nấu bột vỏ bánh giò Cho 320gr bột gạo và 80gr bột năng, 1/2 muỗng canh muối trong 1 cái nồi lớn có 1,5 lít nước hầm xương rồi hòa đều. Sau đó bắt lên bếp khuấy liên tục trên lửa nhỏ, thêm 1 muỗng canh dầu ăn, khuấy liên tục đến khi bột đặc lại thì tắt bếp.'),
(42, 'en', 'Prepare banana leaves Blank the fresh banana leaves you bought in boiling water to clean them and make them easier to wrap. Spread a layer of plastic wrap on the table, then place the banana leaves on top and fold them into a funnel shape.'),
(42, 'vi', 'Sơ chế lá chuối Lá chuối tươi bạn mua về trụng qua nước sôi cho sạch và dễ gói. Bạn trải 1 lớp màng bọc thực phẩm lên mặt bàn rồi đặt lá chuối lên trên và gấp lại thành hình phễu.'),
(43, 'en', 'Wrapping Banh Gio Scoop 1 spoon of dough into the funnel and spread it evenly. Then put the filling and quail egg mixture in the middle and scoop another spoon of dough on top of the filling and spread it evenly. You can dip the spoon in a bowl of cooking oil to make it easier to spread the dough evenly.'),
(43, 'vi', 'Gói bánh giò Múc 1 muỗng bột cho vào trong phễu rồi dàn đều. Sau đó cho hỗn hợp nhân và trứng cút vào giữa và múc thêm 1 muỗng bột nữa phủ lên phía trên phần nhân, dàn đều. Bạn có thể nhúng muỗng vào chén dầu ăn để việc dàn đều bột bánh dễ dàng.'),
(44, 'en', 'Steamed Banh Gio Wrap the cake up, tie a string to make it more secure, then put it in the steamer and steam for about 20 - 25 minutes until the cake is cooked.'),
(44, 'vi', 'Hấp bánh giò Gói chiếc bánh lại, cột dây cho bánh thêm chắc chắn rồi cho vào trong xửng, hấp khoảng 20 - 25 phút là bánh chín.'),
(45, 'en', 'Finished product The cake is wrapped evenly, when the leaves are peeled off, the surface of the cake is shiny. The cake is cooked through, the cake pulp is soft, not mushy. The cake filling has a peppery aroma, the meat is not tough, and the taste is just right.'),
(45, 'vi', 'Thành phẩm Bánh gói đều, khi bóc lá ra mặt bánh bóng mượt. Bánh chín trong, cùi bánh mềm, không nhão. Nhân bánh dậy mùi hạt tiêu, thịt không dai, vị vừa ăn.'),
(58, 'en', 'Prepare the ingredients Prepare a bowl, then add rice flour, fried flour, salt, turmeric powder and soda water, stir well, then put the dough in the refrigerator to rest for about 30 minutes. Put the shrimp in the bowl and add 1 teaspoon of garlic powder, mix well.'),
(58, 'vi', 'Sơ chế nguyên liệu Bạn chuẩn bị 1 chiếc tô sau đó bỏ bột gạo, bột chiên giòn, muối, bột nghệ và nước soda vào khuấy đều sau đó để bột vào trong tủ lạnh để bột nghỉ khoảng 30 phút. Bỏ tôm vào tô và thêm vào 1 muỗng cà phê bột tỏi trộn đều.'),
(59, 'en', 'Mix fish sauce In a small bowl, add 1 tablespoon of sugar, 3 tablespoons of warm water (to mix so the sugar dissolves quickly), stir with a spoon until the sugar dissolves, then add 1 tablespoon of fish sauce, ⅔ tablespoon of lemon juice, finally add minced garlic and chili and mix well.'),
(59, 'vi', 'Pha nước mắm Bạn cho vào chén nhỏ 1 muỗng canh đường cát, 3 muỗng canh nước ấm (để pha cho đường nhanh tan) dùng muỗng khuấy cho đường tan tiếp đến cho vào 1 muỗng canh nước mắm, ⅔ muỗng canh nước cốt chanh, cuối cùng cho thêm tỏi, ớt băm nhuyễn và trộn đều.'),
(60, 'en', 'Pouring Banh Khot To pour Banh Khot if you do not have a mold, you can use silicone cups for safety. You should choose a quality mold. You should read carefully to see how many degrees Celsius the mold can withstand and should choose to buy a mold specifically for cooking. Now take the bowl of dough out of the fridge and stir it well with a spoon. Divide the dough into 2: Put half of the dough into each mold, then put the shrimp in some molds right away, and put the shrimp in some other molds later. Add some green onions to the other half of the dough to add color and flavor to the cake.'),
(60, 'vi', ' Đổ bánh khọt Để đổ bánh khọt nếu như bạn không có khuôn thì bạn có thể dùng những chiếc cupcy bằng silicon để an toàn bạn nên chọn khuôn chất lượng bạn nên đọc kỹ xem khuôn có thể chịu đựng được nhiệt độ bao nhiêu độ C cũng như nên chọn mua khuôn chuyên dùng để nấu ăn. Bây giờ bạn lấy tô bột ra khỏi tủ lạnh dùng muỗng khuấy đều. Bạn chia bột làm 2: Một nửa bột bạn cho vào từng khuôn sau đó một số chiếc khuôn thì bạn cho tôm vào luôn, còn một số chiếc khuôn khác thì bạn sẽ cho tôm vào sau. Một nửa bột thì bạn thêm chút hành lá vào để bánh thêm màu sắc và tăng hương vị.'),
(61, 'en', 'Bake the cake You put the poured cake into the oven at 200 degrees Celsius, top and bottom heat, bake for about 6 minutes, then you take the cake out and you will see the mold with the shrimp batter is still liquid, you continue to put this cake in to bake for a few more minutes to harden the cake, and the mold without shrimp, the batter has dried but the surface is still a bit wet, then you take the cake out on a plate.'),
(61, 'vi', ' Nướng bánh Bạn bỏ phần bánh đã đổ vào trong lò nướng ở nhiệt độ 200 độ C lửa trên và lửa dưới nướng khoảng 6 phút, sau đó bạn lấy bánh ra bạn sẽ thấy khuôn có tôm bột còn lỏng, bạn tiếp tục bỏ phần bánh này vào nướng thêm vài phút để bánh cứng lại, còn khuôn mà không có tôm thì bột đã khô lại nhưng bề mặt vẫn còn hơi ướt thì bạn lấy bánh ra đĩa.'),
(62, 'en', 'Frying the cake You put a pan of oil on the stove, heat the oil then put the banh khot in to fry, if the banh khot does not have shrimp, you add 1 shrimp, the shrimp will stick to the surface of the cake, take the part of the banh khot with shrimp out of the oven and fry it together. Fry over medium heat until the cake is golden brown, finally when the cake is golden brown, you take it out and put it on oil-absorbing paper.'),
(62, 'vi', 'Chiên bánh Bạn bắc lên bếp 1 chảo dầu đun cho dầu nóng sau đó bỏ bánh khọt vào chiên, bánh khọt không có tôm thì bạn đặt thêm 1 con tôm, tôm sẽ dính vào mặt bánh, lấy phần bánh khọt có tôm ở trong lò nướng ra và chiên cùng. Chiên với lửa vừa để bánh vàng thơm, cuối cùng khi bánh vàng thì bạn gắp ra giấy thấm dầu.'),
(63, 'en', 'Finished product You put the banh khot on a plate, the banh khot is crispy, with an extremely eye-catching golden color, dipped in sweet and sour fish sauce, guaranteed everyone will love it.'),
(63, 'vi', 'Thành phẩm Bạn bày bánh khọt ra đĩa, bánh khọt giòn tan, với màu vàng cực kỳ bắt mắt chấm chung với nước mắm chua ngọt đảm bảo ai cũng thích mê.'),
(70, 'en', 'Prepare the ingredients Before processing, the raw pig liver needs to be washed, chopped, and then put in a bowl to soak with about 180-200 ml of unsweetened fresh milk for about 20-30 minutes, then removed to a basket to drain. This helps to deodorize the liver better. Next, wash the pig skin and continue to chop it. We crumble ⅔ of the bread, then soak it with the remaining 100 ml of unsweetened fresh milk. Peel and mince the garlic and onions. Wash the herbs and cucumbers, while washing, soak them in salt water. After washing, peel the cucumbers and cut them into thick or thin slices as desired.'),
(70, 'vi', 'Sơ chế nguyên liệu Gan heo còn sống trước khi chế biến cần được rửa sạch, cắt nhỏ rồi cho vào chén ngâm với khoảng 180-200 ml sữa tươi không đường trong khoảng 20 – 30 phút, sau đó vớt ra rổ để ráo nước. Điều này giúp khử mùi cho gan tốt hơn. Tiếp tới rửa sạch bì heo và tiếp tục cắt nhỏ. ⅔ ổ bánh mì, ta làm vụn ra, sau đó ngâm với 100 ml sữa tươi không đường còn lại. Tỏi, hành bóc vỏ, băm nhuyễn. Rau thơm, dưa leo rửa sạch, trong lúc rửa ngâm sơ với nước muối. Sau khi rửa, với dưa leo ta gọt sạch vỏ rồi cắt thành lát dày, mỏng tùy thích.'),
(71, 'en', 'Pate processing Place the pan on the stove, wait for the pan to heat up, then add cooking oil and bring to a boil. Add minced garlic and sauté until fragrant. Next, add the drained liver, season with ½ teaspoon sugar, ½ teaspoon seasoning powder, and continue to stir well. When the liver is almost cooked, add the breadcrumbs soaked in milk, sprinkle a little pepper, and stir for about 2-3 minutes. Turn off the stove. Put all the liver in the blender and blend. After blending, we have pate but it is not yet complete. At this point, you should spread a little butter and steam it for about 20-30 minutes. Wait for the pate to cool down and you have completed the main part of this dish.'),
(71, 'vi', ' Chế biến pate Bắc chảo lên bếp, đợi chảo nóng thì cho dầu ăn vào đun sôi. Cho tiếp tỏi băm vào phi thơm. Kế tới, ta cho gan đã ráo nước vào, nêm với ½ thìa cà phê đường, ½ thìa cà phê bột canh, tiếp tục đảo đều. Khi thấy gan dần chín tái, cho bánh mì vụn đã ngâm sữa vào, rắc một chút tiêu, rồi đảo thêm khoảng 2 – 3 phút. Tắt bếp. Cho toàn bộ phần gan trên vào máy xay sinh tố, xay nhuyễn. Sau khi xay xong, ta đã có có pate nhưng vẫn chưa hoàn thiện. Lúc này, bạn hãy quết thêm chút bơ rồi mang đi hấp cách thủy trong khoảng 20 – 30 phút. Chờ pate nguội lại là bạn hoàn thành phần chính của món ăn này rồi.'),
(72, 'en', 'Finished product Put the bread in the microwave to heat up. Use a knife to cut the side of the bread and put the pate in, continue to spread butter, then herbs, cucumber. If you like spicy food, add a little chili sauce and enjoy.'),
(72, 'vi', 'Thành phẩm Cho bánh mì vào lò vi sóng nướng lên cho nóng. Dùng dao rạch bên hông bánh mì rồi cho pate vào, tiếp tục quết thêm bơ, rồi rau thơm, dưa leo. Nếu bạn thích ăn cay, hãy cho thêm một xíu tương ớt là có thể thưởng thức rồi. '),
(73, 'en', 'Put 300g of wheat flour and 2g of baking powder into a small bowl and mix them evenly. Use a knife to chop 200g of pork lard into small pieces, then add it to a pan and render it over medium heat to extract the lard oil. Render until the lard shrinks and turns a golden yellow, then turn off the heat and strain out the solids. After that, mound the flour and baking powder into a mountain shape, poke a hole in the center of the flour mound, then add 40g of granulated white sugar, 120ml of filtered water, 50ml of cooking oil, and 50ml of the rendered lard oil (in a 1:1 ratio between the cooking oil and lard). Next, use your hands to knead and mix the dough until it comes together into an elastic mixture. Let the dough rest for 30 minutes, then divide it into 12 equal parts.'),
(73, 'vi', 'Làm phần bột cho vỏ bánh pía Bạn cho 300gr bột mì và 2gr bột nở vào trong một cái thau nhỏ rồi trộn đều. Bạn dùng dao cắt nhỏ 200gr mỡ heo rồi cho vào chảo thắng ở mức lửa vừa để lấy nước mỡ. Bạn thắng cho đến khi mỡ teo lại có màu vàng ươm thì tắt bếp rồi bạn vớt bỏ phần mỡ. Sau đó, bạn vun bột mì và bột nở tạo thành hình cái núi, khoét một lỗ ở giữa đỉnh núi bột rồi cho 40gr đường cát trắng, 120ml nước lọc, 50ml dầu ăn và 50ml mỡ nước vừa thắng với tỉ lệ 1:1 giữa dầu ăn và mỡ. Kế tiếp, bạn dùng tay nhào trộn bột để chúng hòa quyện vào nhau cho đến khi tạo thành một hỗn hợp bột dẻo. Bạn để bột nghỉ trong 30 phút rồi bạn chia bột làm 12 phần bằng nhau.'),
(74, 'en', 'Make the dough for the pia cake filling Put 100g of flour, 100g of tapioca starch and 2g of baking powder in a bowl and mix the dough well with your hands. Next, add 20g of white sugar, 35ml of lard, 100ml of filtered water and 45ml of cooking oil to the dry flour mixture and mix the mixture well with your hands for 5 minutes until the dough is smooth, elastic and supple. Let the dough rest for 30 minutes. Then, divide the dough into 12 equal parts.'),
(74, 'vi', 'Làm phần bột cho ruột bánh pía Bạn cho 100gr bột mì, 100gr bột năng và 2gr bột nở vào một cái tô rồi dùng tay trộn đều bột lên. Kế tiếp, bạn cho 20gr đường cát trắng, 35ml mỡ nước, 100ml nước lọc và 45ml dầu ăn vào hỗn hợp bột khô vừa trộn rồi bạn cũng dùng tay trộn đều hỗn hợp trong 5 phút cho đến khi bột quyện đều, dẻo và mịn. Bạn để cho bột nghỉ trong 30 phút. Sau đó, bạn cũng chia bột làm 12 phần bằng nhau.'),
(75, 'en', 'Making the Filling for Banh Pia Preparing the Pork Lard: Use 100g of pork fat, wash it clean, then cut it into small cubes and boil until cooked. Next, drain the boiled fat in a colander to remove the water, then mix it with 60g of granulated white sugar. Then, take the mixture to a sunny spot to allow the fat to become clear again. Preparing the Salted Egg Yolks: Rinse the bought salted egg yolks under running water, then soak them in white rice wine for about 15 minutes. After that, remove them and steam until fully cooked. Preparing the Mung Beans: Soak the bought mung beans in water until soft, then drain. Then, place the mung beans in a pot with 1 liter of filtered water and cook until they are soft. During cooking, frequently skim off the foam to keep the beans clean. Once the beans are cooked, drain them, transfer to a blender, and blend until smooth and fine. Cooking the Mung Bean Paste: Place a non-stick pan on the stove over high heat to heat it evenly. Then, reduce to medium heat, add the blended mung beans to the pan along with 180g of sugar, and stir-fry evenly. During the cooking process, add cooking oil to the pan several times. Stir-fry until the mung beans become elastic and thick, then add 200g of blended durian and 100g of the sugared fat, and continue stir-frying together. Once the mixture appears translucent, elastic, and no longer sticks to the pan, add 15g of maltose, mix evenly, and turn off the heat. Let the mixture cool, then divide it into 12 equal parts. For each part, wrap one salted egg yolk and roll into a round ball.'),
(75, 'vi', 'Làm phần nhân bánh pía Chế biến mỡ heo: Bạn dùng 100gr mỡ lợn rửa sạch rồi cắt thành hạt lựu sau đó luộc chín mỡ. Kế tiếp, bạn vớt phần mỡ đã luộc ra rổ để ráo nước rồi trộn với 60gr đường cát trắng. Sau đó, bạn đem hỗn hợp ra chỗ có nắng để cho mỡ được trong lại. Chế biến trứng muối: Lòng đỏ trứng muối mua về bạn xả sạch dưới vòi nước rồi ngâm chúng trong rượu trắng khoảng 15 phút. Sau đó, bạn lấy trứng ra rồi đem đi hấp chín. Chế biến đậu xanh: Đậu xanh mua về bạn cho chúng vào nước ngâm cho mềm rồi vớt ra để ráo nước. Sau đó, bạn cho đậu xanh vào nồi cùng với 1 lít nước lọc rồi nấu cho đến khi đậu chín mềm. Trong quá trình nấu, bạn nên thường xuyên vớt bọt cho đậu được sạch. Sau khi đậu chín, bạn vớt đậu rồi cho vào máy xay sinh tố và xay cho đậu nhuyễn và mịn. Sên đậu xanh: Bạn cho một cái chảo chống dính lên bếp ở mức lửa lớn để cho chảo được nóng đều. Sau đó, bạn chỉnh lửa ở mức vừa rồi cho đậu xanh đã xay nhuyễn vào chảo cùng với 180gr đường rồi xào đều. Trong quá trình sên đậu, bạn nên cho dầu ăn vào chảo nhiều lần. Bạn sên cho đến khi đậu có độ dẻo và sệt thì bạn tiếp tục cho 200gr sầu riêng xay nhuyễn và 100gr mỡ đường vào xào cùng. Sau khi bạn sên thấy hỗn hợp đã trong, dẻo và không dính vào chảo nữa thì bạn cho 15gr mạch nha vào rồi trộn đều hỗn hợp và tắt bếp. Bạn để cho hỗn hợp được nguội rồi chia làm 12 phần bằng nhau, mỗi phần bạn bọc 1 lòng đỏ trứng muối vài vo thành viên tròn.'),
(76, 'en', 'Rolling and Wrapping the Banh Pia Place one dough ball from step 1 on a clean flat surface and roll it thin, then place one dough ball from step 2 inside it, wrap it completely, and roll into a ball. Continue by rolling the dough into a long diamond shape about 0.3cm thick, then use your hands to roll it tightly lengthwise. Next, roll the rolled dough into a thin circle, sized just enough to wrap the filling ball with a little excess. Note: You should roll it so that the center of the dough is thicker while the outer edges gradually become thinner to make wrapping easier. Continue by placing the filling ball in the center of the wrapper dough, use your hands to wrap it completely covering the filling, and gently shape around the edges to form an even spherical shape. You should wrap the dough layer closely adhering to the filling ball so that the filling does not leak out. Use your hand to pinch the excess dough tightly and position that pinched part as the base of the pastry. After shaping the pastry, place it on a baking tray lined with non-stick parchment paper, then use your hand to press it slightly flat, but ensure the surface remains even.'),
(76, 'vi', 'Cách cán và gói bánh pía Bạn đặt 1 viên bột ở bước 1 ra một mặt phẳng sạch rồi cán mỏng, sau đó bạn tiếp tục đặt 1 viên bột ở bước 2 vào trong rồi bọc kín và vo tròn. Tiếp tục, bạn cán bột tạo thành một hình thoi dài với độ dày khoảng 0,3cm rồi dùng tay cuộn chặt lại theo chiều dọc. Kế tiếp, bạn cán cuộn bột tạo thành hình tròn mỏng, có độ lớn vừa đủ để bọc lấy viên nhân bánh và dư ra một chút. Lưu ý: Bạn nên cán sao cho ở giữa miếng bột thì dày còn các mép bên ngoài mỏng dần để dễ gói bánh. Tiếp tục, bạn đặt viên nhân bánh vào giữa bột vỏ, dùng tay gói lại cho phủ kín nhân và nắn nhẹ xung quanh tạo được hình khối cầu đều. Bạn nên gói lớp vỏ bánh bám sát vào viên nhân bánh, sao cho nhân không bị hở ra ngoài. Bạn dùng tay túm chặt phần bột dư lại rồi để phần túm bột làm đế bánh. Sau khi nặn bánh xong, bạn đặt bánh lên khay nướng có lót giấy nến chống dính rồi bạn dùng tay đè bánh hơi dẹt xuống một chút nhưng đảm bảo bề mặt bánh vẫn bằng phẳng.'),
(77, 'en', 'Decorate the cake Use 2-3 cotton pads and place them on a clean plate. Then, dissolve 3-4 drops of red food coloring with a little water and pour it onto the cotton pad. Next, use your hand to lightly press the printed image onto the cotton pad and then print it onto the cake.'),
(77, 'vi', 'Trang trí bánh Bạn dùng 2 – 3 miếng bông tẩy trang rồi đặt chúng lên một cái đĩa sạch. Sau đó, bạn hòa tan 3 – 4 giọt màu đỏ thực phẩm cùng với một ít nước rồi đổ lên miếng bông. Kế tiếp, bạn dùng tay ấn nhẹ miếng in hình lên mặt bông rồi in lên mặt bánh.'),
(78, 'en', 'Baking Pia Cake Before baking, turn the cake upside down so that it does not puff up when baked. You adjust the oven to 200 degrees Celsius. Then, you put the baking tray in the oven for 15 - 20 minutes until you see the cake crust is slightly opaque and begins to puff up, then you take the cake out. Next, you use a toothpick to poke a few holes on the surface of the cake so that the cake has air holes. Then, you use 1 egg yolk beaten with a little water to create a mixture, you use a brush to soak the mixture and then brush it evenly on the cake. Continue, you put the baking tray in the oven at 180 degrees Celsius and bake for another 15 minutes until the cake is cooked and golden brown.'),
(78, 'vi', ' Nướng bánh pía Trước khi nướng, bạn lật úp bánh lại để khi nướng bánh không bị phồng lên. Bạn điều chỉnh lò nướng ở 200 độ C. Sau đó, bạn cho khay bánh vào nướng trong 15 – 20 phút cho đến khi bạn thấy vỏ bánh hơi đục và bắt đầu nở xốp thì bạn lấy bánh ra. Kế tiếp, bạn dùng tăm xăm vài lỗ trên mặt bánh để bánh có lỗ thoát khí. Sau đó, bạn dùng 1 lòng đỏ trứng gà đánh tan với 1 ít nước tạo thành hỗn hợp, bạn cho chổi thấm qua hỗn hợp rồi quét đều lên bánh. Tiếp tục, bạn để khay bánh vào lò ở nhiệt độ 180 độ C và nướng thêm trong 15 phút cho đến khi bánh chín có màu vàng đều là được.'),
(79, 'en', 'Prepare the ingredients Dần tiêu, you put in the pork with 10g of sugar, a little salt, a little pepper, minced onion and 1 teaspoon of wine in a bowl and mix well. Then, you wash the sticky rice, mung beans and spinach. Then, you cut the vegetables into small pieces, put them in a bowl with 500ml of water and start pureeing. Then, you filter the mixture through a sieve, keep the vegetable juice and skim off the foam on top. Next, you soak the washed sticky rice in 300ml of vegetable water for about 2 hours to create a beautiful green color for the cake. As for the mung beans, you also soak them for about 2 hours.'),
(79, 'vi', ' Sơ chế nguyên liệu Đần tiêu, bạn cho vào thịt heo cùng 10g đường, một ít muối, ít tiêu, hành băm và 1 muỗng cà phê rượu vào một cái tô vàtrộn đều. Sau đó, bạn đem nếp, đậu xanh và rau bina rửa sạch. Xong thì bạn cắt rau thành các khúc nhỏ, bỏ vào tô cùng 500ml nước và bắt đầu xay nhuyễn. Sau đó, bạn lọc hỗn hợp qua rây, giữ phần nước cốt rau và hớt bỏ bọt phía trên. Tiếp theo, bạn cho nếp đã rửa vào ngâm trong 300ml nước rau khoảng 2 tiếng để tạo màu xanh đẹp mắt cho bánh. Còn đậu xanh bạn cũng đem ngâm tầm 2 tiếng luôn nha.');
INSERT INTO `instruction_translations` (`instruction_id`, `language_code`, `description`) VALUES
(80, 'en', 'Cook the meat Put 150ml of water and 70ml of sake in a pan, when the mixture boils, add the marinated pork. Cover and cook until the water is gone. When finished, take the meat out and put it on a plate.'),
(80, 'vi', 'Nấu thịt Bạn cho 150ml nước và 70ml rượu sake lên chảo, khi hỗn hợp sôi thì cho thịt heo đã ướp vào. Đậy nắp và nấu đến khi cạn nước là được. Xong thì bạn gắp thịt ra dĩa.'),
(81, 'en', 'Coconut milk Put 250ml of coconut milk in the pan, when the mixture boils, use a spoon to stir well and reduce the heat to low. Continue stirring until the oil comes out and the mixture turns golden white, then turn off the heat.'),
(81, 'vi', 'Thắng nước cốt Bạn bắc 250ml nước cốt dừa vào chảo, khi hỗn hợp sôi lên thì bạn dùng giá khuấy đều và hạ lửa nhỏ xuống. Bạn tiếp tục đảo đều đến khi ra dầu và cái chuyển sang màu trắng vàng thì tắt lửa.'),
(82, 'en', 'Cook sticky rice and mung beans Put the soaked sticky rice in a heat-resistant bowl, pour the melted coconut on top, mix well and spread evenly. Then, pour 300ml of spinach juice into the bowl of sticky rice, then cover it with plastic wrap. Then, put it in the microwave and cook for 10 minutes at 500W. Similarly, put the soaked mung beans in a heat-resistant bowl, then pour in 170ml of water. Next, put the bowl of beans in the microwave and cook for 8 minutes at 500W. This is an important step to help the cake boil faster.'),
(82, 'vi', 'Nấu nếp và đậu xanh Bạn cho nếp đã ngâm vào tô chịu nhiệt, đổ dừa thắng lên trên, trộn đều và dàn đều ra. Sau đó, bạn đổ 300ml nước cốt rau bina vào tô nếp, rồi dùng màng bọc thực phẩm bọc kín lại. Xong thì bạn đem bỏ vào lò vi sóng, nấu trong 10 phút ở 500W. Tương tự như vậy, bạn cũng cho đậu xanh đã ngâm vào tô chịu nhiệt, rồi rót thêm 170ml nước vào. Tiếp đến, bạn đặt tô đậu vào lò vi sóng, nấu trong 8 phút ở 500W. Đây là bước quan trọng tạo điều kiện để việc luộc bánh được diễn ra nhanh hơn đó. '),
(83, 'en', 'Wrapping the cake Divide the cooked sticky rice and beans into 6 equal parts. Then, spread the plastic wrap and wax paper on the table. Then, scoop out 1 portion of sticky rice and spread it thinly on the wax paper, then spread 1 portion of beans on top and place the boiled meat on top. Next, add 1 portion of beans on top of the meat, then add 1 portion of sticky rice on top and roll it up. Then, wrap another layer of wax paper on the outside, then use string to tie the cake.'),
(83, 'vi', 'Gói bánh Bạn chia nếp và đậu đã nấu thành 6 phần bằng nhau. Sau đó, bạn lần lượt trải màng bọc thực phẩm và giấy nến lên bàn. Xong thì bạn múc 1 phần nếp dàn mỏng trên tờ giấy nến, rồi tới dàn 1 phần đậu lên và đặt miếng thịt luộc lên trên cùng. Tiếp đến, bạn lại cho thêm 1 phần đậu lên trên miếng thịt, rồi thêm 1 phần nếp lên trên cùng và cuộn tròn lại. Xong thì bạn gói thêm một lớp giấy nến bên ngoài, rồi mới dùng dây buộc bánh lại.'),
(84, 'en', 'Cook the cake You fill the pressure cooker about half way with water and bring to a boil. When the water boils, you put the cake in, put a plate on top to keep the cake in the water. Then boil for 20 minutes. Finally, when the cake is done, you can cut it into slices and enjoy.'),
(84, 'vi', 'Nấu bánh Bạn cho nước vào khoảng nửa nồi áp suất và đun sôi. Khi nước sôi thì bạn cho bánh vào, đặt dĩa lên trên để giữ cho bánh luôn nằm trong nước. Xong thì bạn hãy luộc trong vòng 20 phút nhé. Cuối cùng, khi bánh chín, bạn có thể cắt thành từng khoanh và thưởng thức thôi nào.'),
(85, 'vi', 'Thành phẩm Bánh sau khi được luộc trong nồi áp suất xong thì vô cùng thơm luôn. Bánh có màu xanh tươi rất đẹp mắt, gần giống với bánh gói bằng lá vậy. Khi thưởng thức, bạn sẽ cảm nhận được từng hạt nếp dẻo mềm, không bị nhão hay bị sượng gì cả. Trong đó, còn có vị bùi bùi của đậu xanh, beo béo từ nước cốt dừa và thịt heo thơm ngon, đậm vị nữa. Phải nói là rất tuyệt luôn.'),
(86, 'en', 'Prepare the ingredients After buying the minced meat, stir-fry it with pepper until cooked, no need to add any spices! Slice the sausages thinly so that when grilled, they will stick to the rice paper more easily. Finely chop the green onions to enhance the flavor.'),
(86, 'vi', 'Sơ chế nguyên liệu Thịt bằm sau khi mua về các bạn xào qua với tiêu cho chín, không cần nêm thêm gia vị nào đâu bạn nhé! Xúc xích các bạn thái lát mỏng để khi nướng xúc xích dễ bám vào bánh tráng hơn. Hành lá thì bạn cắt nhuyễn để tăng thêm hương vị.'),
(87, 'en', 'Grilling rice paper Choose a non-stick pan with a pan large enough to fit the rice paper. Heat the pan and put the rice paper in. Then, quickly spread butter on the surface of the cake. Continue to add 1 spoon of stir-fried meat, 1 spoon of dried shrimp, 1 spoon of green onion to the surface of the cake, add half a spoon of satay sauce and 1 egg, mix well to combine the ingredients and spread evenly on the surface of the cake. Avoid spreading it close to the edge of the rice paper because it will make the cake shrink and not look good anymore!'),
(87, 'vi', 'Nướng bánh tráng Bạn chọn một chiếc chảo không dính có lòng chảo để vừa bánh tráng. Làm nóng chảo rồi cho bánh tráng vào. Sau đó, bạn nhanh tay phết bơ lên mặt bánh. Tiếp tục cho 1 thìa thịt xào, 1 thìa tép khô, 1 thìa hành lá vào mặt bánh, thêm nửa thìa sa tế và 1 quả trứng gà rồi trộn đều cho các nguyên liệu hòa lẫn với nhau rồi dàn đều trên mặt bánh. Bạn tránh dàn sát rìa bánh tráng vì sẽ làm bánh bị co dúm, không đẹp nữa nhé!'),
(88, 'en', 'Finished product Turn on high heat, grill until the eggs are almost set, then add the sliced ​​sausages. When the rice paper is golden brown and peels off the pan, add the chili sauce and mayonnaise on top. Our grilled rice paper is done!'),
(88, 'vi', 'Thành phẩm Mở lửa lớn, nướng đến khi trứng gần đông lại thì bạn cho xúc xích cắt lát vào. Khi bánh tráng đã chín vàng và bong khỏi mặt chảo, bạn cho tương ớt và mayonnaise lên trên. Vậy là món bánh tráng nướng của chúng ta đã hoàn thành rồi!'),
(89, 'en', 'Prepare the ingredients After buying the shrimp, wash it, cut off the whiskers, then marinate it with 1 teaspoon of salt, 1 teaspoon of crushed ginger for 15-20 minutes. Wash the pork with salt then slice it thinly. Marinate the pork with 1 tablespoon of fish sauce, 1 teaspoon of MSG, ½ teaspoon of pepper and leave it for 15-20 minutes for the meat to absorb the spices. Wash and chop the green onions, onions, bean sprouts and other vegetables.'),
(89, 'vi', 'Sơ chế nguyên liệu Tôm sau khi mua về rửa sạch, cắt râu, sau đó ướp tôm với một muỗng cà phê muối, 1 muỗng cà phê gừng giã ra trong 15-20 phút. Thịt heo rửa sạch với muối sau đó đem thái mỏng. Ướp thịt heo với 1 muỗng canh nước mắm, 1 muỗng cà phê bột ngọt, ½ muỗng cà phê tiêu và để trong 15-20 phút cho thịt thấm gia vị. Rửa sạch và cắt nhỏ hành lá, hành tây, giá và các loại rau.'),
(90, 'en', 'Make the pancake crust and stir-fry the filling To mix the pancake batter, mix 200g of rice flour, 10g of turmeric powder, 250ml of water, 100ml of beer, 1 teaspoon of salt with chopped green onions, stir the batter well until the flour is completely dissolved. You can add a little cooking oil to the batter, when you pour the pancake, the pancake will be easier to peel and look more beautiful. Put the pan on the stove and add 2 tablespoons of cooking oil, fry the shallots until fragrant. Then, add the shrimp, meat, and shiitake mushrooms and stir-fry until they are firm, add the onions and stir-fry well. When the onions change color slightly, season to taste and turn off the stove.'),
(90, 'vi', ' Làm vỏ bánh xèo và xào nhân bánh Để pha bột làm bánh xèo, bạn trộn 200gr bột gạo, 10gr bột nghệ, 250ml nước lọc, 100ml bia, 1 muỗng cà phê muối với hành lá băm lại, khuấy bột cho thật đều tay để bột tan hết. Bạn có thể cho thêm vào bột bánh một chút dầu ăn, khi bạn đổ bánh xèo, bánh sẽ dễ tróc ra và đẹp hơn. Bắc chảo dầu lên bếp và cho vào 2 muỗng dầu ăn, phi hành tím cho thơm. Sau đó, cho tôm, thịt, nấm hương vào xào cho đến khi săn lại, cho thêm hành tây vào đảo đều. Khi hành tây hơi chuyển màu, bạn nêm nếm cho vừa ăn rồi tắt bếp.'),
(91, 'en', 'Pour the pancakes Place the pan on the stove and add a thin layer of oil. Once the oil is hot, scoop a tablespoon of batter and spread it evenly in the pan. Pour a layer of batter that is enough to cover the entire pan, but not too thick because a thick layer of batter will make the pancakes less crispy. Then, fry slowly over low heat so that the water in the batter evaporates, then our pancakes will be extremely crispy and delicious. Try to refer to the tips for making crispy pancakes! Then, add a little filling and bean sprouts. Keep the heat low, wait about 2 minutes for the crust to dry and crisp, then fold the pancake in half and let it dry a little more and put it on a plate.'),
(91, 'vi', 'Đổ bánh xèo Bắc chảo lên bếp và cho vào một lớp dầu mỏng. Sau khi dầu nóng, bạn múc muỗng canh bột vừa và tráng đều chảo. Hãy đổ một lớp bột vừa phải đủ để tráng hết mặt chảo nhưng đừng quá dày vì lớp bột dày làm bánh xèo không còn được giòn nữa. Sau đó, bạn chiên từ từ với lửa nhỏ để nước trong bột bốc hơi đi, thì bánh xèo của chúng ta sẽ giòn ngon vô cùng, hãy thử tham khảo mẹo làm bánh xèo giòn nhé! Sau đó, cho thêm một ít nhân và giá vào. Để lửa nhỏ, đợi khoảng 2 phút cho vỏ bánh khô giòn rồi bạn gấp đôi bánh lại hong thêm một chút và để bánh ra dĩa.'),
(92, 'en', 'Prepare ingredients Wash and crush ginger and lemongrass. Shallots, garlic, and a little chopped lemongrass Wash raw vegetables. Wash and thinly slice onions and soak in ice water to reduce the pungency. Scrape off the pig hair, remove the outer hooves, chop into bite-sized pieces, and wash. Cut the blood into pieces.'),
(92, 'vi', 'Sơ chế nguyên liệu Gừng, sả rửa sạch, đập dập. Hành tím, tỏi, một ít sả băm nhỏ Rau sống rửa sạch. Hành tây rửa sạch, thái mỏng ngâm nước đá cho bớt hăng. Giò heo cạo sạch lông, gỡ bỏ phần móng bên ngoài, chặt khúc sao cho vừa ăn rồi rửa sạch. Huyết cắt thành từng khúc.'),
(93, 'en', 'Beef and bone stew Boil a pot of water, add shrimp paste and stir well, boil, remove foam and turn off the stove, let cool, and collect the water. Put beef shank and beef shank, bones in the pot, 3 crushed lemongrass stalks, 1 tablespoon of salt, pour water so that it covers the meat by about 1 cm. Cover and boil, when the water boils, lower the heat, regularly remove foam from the surface of the water, boil for about 30 more minutes and turn off the stove. Leave for a while then open the lid, remove beef shank and beef shank and put them in a bowl of cold water.'),
(93, 'vi', 'Hầm thịt bò, xương Nấu một nồi nước, cho mắm ruốc vào khuấy đều, đun sôi, vớt bọt ra ngoài rồi tắt bếp, để nguội, lóng lấy nước. Cho nạm bò và bắp bò, xương vào nồi, 3 cây sả đã đập dập, 1 muỗng muối, đổ nước sao cho ngập mặt thịt khoảng chừng 1 cm. Đậy nắp rồi đun sôi, khi nước sôi thì hạ lửa, thường xuyên vớt bọt bên trên mặt nước, đun thêm khoảng 30 phút nữa rồi tắt bếp. Để một chút rồi mở nắp vớt bắp bò, nạm bò cho vào thau nước lạnh.'),
(94, 'en', 'Cashew Coloring Put cashews in a pan of oil and stir-fry until red, remove the cashews, add chopped onions and garlic and stir-fry until golden brown and fragrant, then turn off the heat.'),
(94, 'vi', ' Tạo màu hạt điều Cho hạt điều vào chảo dầu rồi xào cho tới khi có màu đỏ, vớt hạt ra, cho thêm hành và tỏi băm vào xào đến khi vàng thơm thì tắt bếp.'),
(95, 'en', 'Cook the beef noodle soup Pour the bone broth, beef shank, beef brisket, pork leg broth, lemongrass, and onion into a large pot, adding more water if it seems low. Add the annatto color mixture. Boil and season with seasoning: seasoning powder, sugar, salt, MSG, and a little fish sauce, add a little chili sauce for a spicy taste, adjust the seasoning to taste..'),
(95, 'vi', 'Nấu nước bún bò Đổ chung nước hầm xương với bắp bò, nạm bò, nước hầm giò heo, sả, hành tây vào một nồi lớn, thêm nước nếu thấy ít. Cho thêm hỗn hợp màu điều đã tạo vào. Đun sôi rồi nêm nếm gia vị: hạt nêm, đường, muối, bột ngọt và một ít nước mắm vào, cho một ít sa tế vào để có vị cay nhé, điều chỉnh gia vị sao cho vừa ăn.'),
(96, 'en', 'Finished product Blanch the noodles with boiling water, put them in a bowl, arrange the pork leg, beef shank, beef brisket, sausage, onion and scallion on top. Then, pour the broth into the bowl and you have finished cooking the pork leg beef noodle soup. There is nothing better than eating it with raw vegetables, lemon, and chili.'),
(96, 'vi', 'Thành phẩm Trụng bún với nước sôi, cho ra tô, xếp giò heo, bắp bò, nạm bò, chả, hành tây và hành lên. Sau đó, chan nước dùng vào tô là bạn đã hoàn thành xong cách nấu bún bò giò heo rồi. Ăn kèm với rau sống, chanh, ớt thì còn gì bằng.'),
(97, 'en', 'Boil the meat Wash the pork leg. Boil it in boiling water for about 2 minutes, take it out, and rinse it thoroughly with cold water. Put another pot of water on the stove and boil the meat until it is tender. Cut it into bite-sized pieces.'),
(97, 'vi', 'Luộc thịt Thịt chân giò mua về rửa sạch. Luộc sơ qua nước sôi khoảng 2 phút, vớt ra, rửa lại thật sạch với nước lạnh. Cho lên bếp một nồi nước khác, luộc thịt đến khi chín mềm là được. Cắt miếng nhỏ vừa ăn.'),
(98, 'en', 'Fried tofu Cut into bite-sized pieces, fry until golden brown on both sides, fragrant and crispy.'),
(98, 'vi', 'Chiên đậu hũ Cắt miếng vừa ăn, chiên vàng đều 2 mặt, vừa thơm vừa giòn là được.'),
(99, 'en', 'Pressing vermicelli The way to make vermicelli is very simple. To press vermicelli, after buying fresh vermicelli, you wash it, blanch it, then line it with banana leaves or use food wrap under the winnowing tray. Put the prepared vermicelli on top, cover it with another banana leaf or food wrap, then use a round cutting board, press hard on the vermicelli for about 2 hours, the vermicelli will be firm. Press the vermicelli in the mold, then cut it into small pieces to eat.'),
(99, 'vi', 'Ép bún Cách làm bún lá rất đơn giản. Để ép bún, bún tươi sau khi mua về bạn rửa sạch, trần sơ, sau đó lót lá chuối hoặc dùng giấy bọc thực phẩm dưới cái nia. Cho phần bún đã chuẩn bị lên trên phủ thêm một phần lá chuối hoặc giấy bọc thực phẩm lên mặt tiếp đến dùng một tấm thớt tròn, đè mạnh lên ép bún trong khoảng 2 tiếng, bún sẽ chắc nịch. Ép bún trong khuôn, sau đó cắt thành miếng nhỏ cho vừa ăn.'),
(100, 'en', 'Wash vegetables Soak in salt water, wash, arrange on a plate to look nice.'),
(100, 'vi', 'Rửa rau Ngâm nước muối, rửa sạch, sắp lên dĩa cho đẹp mắt.'),
(101, 'en', 'Mixing shrimp paste Shrimp paste is a very strong and salty, very strong-smelling fish sauce made from fermented shrimp and salt in the traditional way, often eaten with Hanoi famous vermicelli and bean curd dish. When mixed as a dipping sauce, it helps to bring out the most delicious flavors of the main dishes that go with it. In other words, eating vermicelli and bean curd must be accompanied by shrimp paste for the dish to be truly delicious and flavorful. Buy the shrimp paste, boil it, then add sugar to taste. When the shrimp paste cools, you can add kumquat, it will be more delicious.'),
(101, 'vi', 'Pha mắm tôm Mắm tôm là loại mắm có mùi rất đậm và mặn, rất nồng được ủ từ tôm và muối lên men theo cách làm truyền thống, thường được ăn kèm món bún đậu nổi tiếng của Hà Nội. Khi được pha chế lại như một nước chấm thì nó giúp phát huy hết mùi vị thơm ngon nhất của các món chính đi kèm. Hay nói cách khác, ăn bún đậu nhất định phải kèm theo mắm tôm thì món ăn mới thực sự thơm ngon và tròn vị. Mắm tôm mua về, đun sôi, sau đó nêm thêm đường cho vừa ăn. Khi mắm tôm nguội bạn có thể thêm tắc vào, sẽ thơm ngon hơn nhé.'),
(102, 'en', 'Finished product The banana leaf is very tasty, served with shrimp paste, tofu, pork leg, chả cốm, fresh herbs, bean sprouts, Vietnamese mint, perilla leaves, calamansi, lemon, and chili, there is nothing better than this.'),
(102, 'vi', 'Thành phẩm Bún đậu mắm tôm rất thơm ngon, ăn kèm với mắm tôm, đậu hũ, thịt chân giò, chả cốm, rau thơm, đậu phụ, kinh giới, tía tô, tắc, chanh, ớt thì còn gì bằng.'),
(109, 'en', 'Prepare basa fish Clean the fish by cutting off the fins, removing the organs, removing the gills, and scraping off the black membrane inside the fish belly. Then, use flour or tapioca starch to remove the slime on the fish and then use a clean towel to wipe from head to tail. Next, use ginger wine, salt or vinegar, lemon to rub on the fish body, both inside and outside to completely remove the fishy smell. Finally, rinse thoroughly with water. Use a knife to chop the fish into pieces about 5cm long and then marinate the fish in the ratio of 1 teaspoon of soy sauce, 1 teaspoon of salt, ½ teaspoon of pepper, 1 - 3 teaspoons of sugar, 3 tablespoons of fish sauce, 1 tablespoon of cooking oil and chopped chili. Remember to mix to let the spices soak in for 1 hour!'),
(109, 'vi', 'Sơ chế cá basa Bạn làm sạch cá bằng cách chặt bỏ vây, mổ bỏ nội tạng, tách bỏ mang, cạo sạch màng đen bên trong bụng cá. Sau đó, bạn dùng bột mì hoặc bột năng để loại bỏ lớp nhớt trên cá rồi lấy khăn sạch lau từ đầu xuống đuôi. Tiếp theo là dùng rượu gừng, muối hoặc giấm, chanh chà xát lên thân cá, cả bên trong và bên ngoài để khử mùi tanh triệt để. Cuối cùng là rửa lại thật sạch với nước. Bạn lấy dao chặt cá thành khúc khoảng 5cm rồi ướp cá theo tỷ lệ 1 thìa cà phê xì dầu, 1 thìa cà phê muối, ½ thìa cà phê tiêu, 1 - 3 thìa cà phê đường, 3 thìa canh nước mắm, 1 thìa canh dầu ăn và ớt băm. Bạn nhớ trộn để thấm gia vị trong 1 tiếng nhé!'),
(110, 'en', 'Prepare other ingredients Wash the pork belly, scrape off the skin and cut into squares. Wash the onions and dill and chop them finely. Take a bowl and mix 1 tablespoon of soy sauce, 1 tablespoon of fish sauce and pour in the coconut water.'),
(110, 'vi', 'Sơ chế các nguyên liệu khác Rửa sạch thịt ba rọi, cạo bì và thái miếng vuông. Bạn rửa hành, thì là và thái nhỏ. Lấy một tô khuấy tan đều hỗn hợp 1 muỗng canh xì dầu, 1 muỗng canh nước mắm và đổ cả nước dừa.'),
(111, 'en', 'Cooking the braised fish in a clay pot Put the pan on the stove, add cooking oil until hot, then add chopped onions, garlic, and chili and sauté until fragrant, then add the pork belly and stir-fry until almost cooked, then turn off the stove. Combining the fatty taste of the braised pork belly with the fish will increase the attractiveness of the dish. Arrange the fish pieces in a clay pot or pot, then put the pork belly layer on top. Remember to pour the marinade into the pot. Then pour the mixture of soy sauce, fish sauce, and coconut water on top, then cover the pot to cook.'),
(111, 'vi', 'Chế biến món cá kho tộ Bạn bắc chảo lên bếp, cho dầu ăn tới khi nóng thì cho hành, tỏi, ớt băm vào phi thật thơm rồi thêm thịt ba chỉ vào đảo đến khi gần chínthì tắt bếp. Kết hợp độ béo ngậy của thịt ba chỉ kho cùng cá sẽ tăng sự hấp dẫn của món ăn hơn. Xếp các khúc cá vào niêu đất hoặc nồi sau đó để lớp thịt chỉ phía trên. Bạn nhớ đổ cả phần nước ướp vào niêu. Sau đó bạn đổ hỗn hợp xì dầu, nước mắm và nước dừa trên rồi đậy nắp vung lại để nấu.'),
(112, 'en', 'Finished product Before turning off the stove, add green onions and dill on top and remove from the stove to enjoy with hot rice.'),
(112, 'vi', 'Thành phẩm Trước khi tắt bếp thì bạn cho hành lá và thì là lên phía trên bề mặt rồi nhấc xuống bếp là có thể thưởng thức ngay với cơm nóng.'),
(113, 'en', 'Prepare the ingredients First, clean the snakehead fish by removing the scales, gutting it, and washing it with diluted salt water and a little lemon juice to remove the fishy smell. Then, cut the fish into slices about 3cm thick so that when cooking the fish soup, it will not be crushed but still retain its natural sweetness. Next, you prepare the vegetables: wash the tomatoes, cut into wedges; peel the pineapple, remove the eyes, cut into bite-sized triangles. Cut the okra and mint diagonally into thin slices, and cut the chili peppers into slices to increase the mild spiciness. Peel the garlic, mince it. Chop the coriander and the om vegetable. Finally, squeeze the lime to get about 1 tablespoon of juice, filter out the seeds so that it is not bitter when seasoned.'),
(113, 'vi', 'Sơ chế nguyên liệu Trước tiên, làm sạch cá lóc bằng cách đánh vảy, bỏ ruột, rửa cá với nước muối pha loãng và một ít nước cốt chanh để khử mùi tanh. Sau đó, cắt cá thành từng lát dày khoảng 3cm để khi nấu canh cá không bị nát mà vẫn giữ được độ ngọt tự nhiên. Tiếp theo thì bạn sơ chế rau củ: cà chua rửa sạch, cắt thành múi cau; dứa gọt vỏ, bỏ mắt, cắt thành miếng tam giác vừa ăn. Đậu bắp và bạc hà cắt xéo thành từng lát mỏng, còn ớt sừng cắt lát để tăng độ cay nhẹ. Tỏi lột vỏ, băm nhuyễn. Ngò gai, rau om thì bạn cắt nhỏ. Cuối cùng, vắt tắc lấy khoảng 1 muỗng canhnước cốt, lọc bỏ hạt để khi nêm không bị đắng.'),
(114, 'en', 'Marinate the fish After preparing, marinate the fish to make it more flavorful when cooked. Put the fish in a large bowl, marinate with 1/3 tablespoon of seasoning powder, 1/2 tablespoon of fish sauce and 1 teaspoon of minced garlic. Use chopsticks to mix well so that the spices penetrate the fish, then let it sit for about 10 minutes.'),
(114, 'vi', 'Ướp cá Sau khi sơ chế xong, bạn tiến hành ướp cá để cá đậm đà hơn khi nấu. Cho cá vào một tô lớn, ướp với 1/3 muỗng canh hạt nêm, 1/2 muỗng canh nước mắm và 1 muỗng cà phê tỏi băm nhuyễn. Dùng đũa trộn đều để gia vị thấm vào cá, sau đó để yên trong khoảng 10 phút.'),
(115, 'en', 'Fry the fish Heat the pan, add a little cooking oil and fry the minced garlic until golden brown. Then, add each slice of fish to the pan and fry it over medium heat until the surface of the fish is firm, which will prevent the fish from breaking when cooking the soup. When the fish is firm, take it out and put it on a separate plate.'),
(115, 'vi', 'Chiên sơ cá Bạn làm nóng chảo, cho một ít dầu ăn vào và phi tỏi băm cho vàng thơm. Sau đó, gắp từng lát cá vào chảo, chiên sơ ở lửa vừa cho đến khi bề mặt cá săn lại, giúp cá không bị vỡ khi nấu canh. Khi cá vừa săn lại, bạn gắp ra đĩa để riêng.'),
(116, 'en', 'Cooking sour snakehead fish soup Put a large pot on the stove, pour in about 1.2 liters of water. When the water boils, add 1/2 tablespoon of salt, 1/2 tablespoon of sugar and 1/2 tablespoon of fish sauce, stir well to dissolve the spices. When the water boils, gently drop the fish into the pot, boil for about 5 minutes until the fish is cooked, then remove the fish. While cooking, use a ladle to skim off the foam to make the soup clearer. Then, add the pineapple, tomatoes and okra, continue to boil for another 3 minutes until the vegetables are cooked. Continue to add 1.5 tablespoons of sugar, 1 tablespoon of fish sauce and 1 tablespoon of lime juice to the pot. Use a spoon to stir gently to blend the spices, then taste and adjust to taste. When the pot of soup boils again, add mint and bean sprouts, add 1/2 tablespoon of fish sauce to enhance the flavor. Finally, add the braised vegetables, cilantro, sliced ​​chili peppers and fish to the pot, stir gently once and turn off the stove. To make the soup more fragrant, sprinkle some fried garlic on top before scooping it into a bowl.'),
(116, 'vi', 'Nấu canh chua cá lóc Bắc một nồi lớn lên bếp, đổ vào khoảng 1.2 lít nước. Khi nước sôi lăn tăn, bạn cho vào 1/2 muỗng canh muối, 1/2 muỗng canh đường và 1/2 muỗng canh nước mắm, khuấy đều cho tan gia vị. Khi nước sôi, bạn nhẹ nhàng thả cá vào nồi, đun sôi trong khoảng 5 phút cho cá chín thì vớt cá ra. Trong lúc nấu, dùng muôi vớt bọt để nước canh trong hơn. Sau đó, bạn cho dứa, cà chua và đậu bắp vào, tiếp tục đun thêm 3 phút để rau củ chín. Bạn tiếp tục cho vào nồi 1.5 muỗng canh đường, 1 muỗng canh nước mắm và 1 muỗng canh nước cốt tắc. Dùng muỗng khuấy nhẹ để các gia vị hòa quyện, sau đó nếm thử và điều chỉnh lại cho vừa miệng. Khi nồi canh sôi trở lại, bạn cho bạc hà và giá đỗ vào, thêm 1/2 muỗng canh nước mắm để tăng hương vị. Cuối cùng, bạn cho rau om, ngò rí, ớt sừng cắt lát và cá vào nồi, đảo nhẹ một lần rồi tắt bếp. Để món canh thêm thơm, bạn rắc một ít tỏi phi lên trên trước khi múc ra tô.'),
(117, 'en', 'Finished product Ladle the soup into a large bowl, arrange the snakehead fish in the middle, vegetables around, then sprinkle with fried onions, braised vegetables and a few slices of chili to make the dish more beautiful.'),
(117, 'vi', 'Thành phẩm Bạn múc canh ra tô lớn, xếp cá lóc ở giữa, rau củ xung quanh, rồi rắc thêm hành phi, rau om và vài lát ớt sừng để món ăn thêm đẹp mắt.'),
(118, 'en', 'Prepare ingredients Wash green onions, bean sprouts, and herbs. Chop green onions. Peel and cut ginger into pieces. Wash pork bones, cut into pieces, blanch in boiling water to remove dirt, then wash again. Put bones and sliced ​​shallots in a pot to cook together, skimming off foam regularly.'),
(118, 'vi', 'Sơ chế nguyên liệu Hành lá, giá, rau thơm rửa sạch. Hành lá cắt nhỏ. Gừng gọt vỏ, cắt miếng. Rửa sạch xương heo, chặt miếng, chần sơ qua nước sôi cho hết chất bẩn, đem rửa sạch lại. Cho xương và hành tím cắt lát vào nồi nấu chung, thường xuyên vớt bọt.'),
(119, 'en', 'Clean and boil pig intestines, heart, liver, and tongue Wash the heart, liver, tongue, and intestines with salt and lemon several times to remove the odor. Boil until cooked, then remove and put in an ice bowl, squeeze a little lemon juice to make the intestines white and crispy. Then remove the intestines to a plate and cut into bite-sized pieces. Cut the pig intestines into 2 equal parts.'),
(119, 'vi', ' Làm sạch và luộc lòng heo, tim, gan, lưỡi heo Tim, gan, lưỡi heo và lòng non rửa sạch với muối và chanh nhiều lần để hết mùi hôi. Đem luộc chín rồi vớt ra cho vào tô đá, vắt thêm ít chanh để cho lòng được trắng giòn. Sau đó vớt lòng ra dĩa và cắt miếng vừa ăn. Lòng heo cắt chia làm 2 phần như nhau.'),
(120, 'en', 'How to cook porridge Soak the rice for 20 minutes, then wash or roast the rice until fragrant. When the broth is sweet enough, add the rice and cook until the porridge is soft, stirring constantly to avoid burning the bottom. When the porridge is soft, add the pig blood and cook together, it will have the characteristic brown color of porridge. Finally, add half of the pre-cut pig intestines and ginger and cook together. Cook for about 15 more minutes, then turn off the stove and sprinkle green onions on top.'),
(120, 'vi', 'Cách nấu cháo lòng Ngâm gạo trong vòng 20 phút rồi đem vo sạch hoặc rang gạo thơm. Khi nước dùng đủ ngọt, cho gạo vào nấu tới khi cháo nhừ, liên tục khuấy cháo để khỏi bị cháy dưới đáy. Khi cháo nhừ, bỏ huyết heo vào nấu chung, sẽ có màu nâu đặc trưng của cháo lòng. Sau cùng cho thêm một nữa lòng heo đã cắt sẵn và gừng nấu chung. Nấu thêm khoảng 15 phút nữa thì tắt bếp, rắc thêm hành lá lên trên.'),
(121, 'en', 'Finished product Ladle the porridge into a bowl, add some pieces of pork intestines, green onions, bean sprouts, herbs, and pepper on top to make it more attractive. Next to it is a plate of pre-cut pork intestines.'),
(121, 'vi', 'Thành phẩm Múc cháo ra tô, cho thêm mấy miếng lòng heo, hành lá, giá, rau thơm, tiêu lên trên sao cho hấp dẫn. Bên cạnh là dĩa lòng heo đã cắt sẵn. '),
(122, 'en', 'Cook rice Wash the broken rice 2-3 times and cook in a rice cooker as usual.'),
(122, 'vi', 'Nấu cơm Gạo tấm mua về vo sạch qua 2 - 3 lần và nấu trong nồi cơm điện như bình thường.'),
(123, 'en', 'Making the grilled pork chops Wash the pork chops and pat dry with a towel. Next, use a meat hammer to make the meat thinner and softer (If you don not have a meat hammer, you can also use a normal pestle). Marinate the meat according to the recipe: 5 crushed lemongrass stalks, ½ teaspoon MSG, 1 teaspoon seasoning powder, 1 teaspoon honey, 2 tablespoons oyster sauce, 1 teaspoon fish sauce, ¼ teaspoon ground pepper, 1 teaspoon minced shallot, 1 teaspoon minced garlic and Cook rice for the soft broken rice dish. Mix well and marinate the meat for 1 hour. Grill each piece of meat on a charcoal stove until both sides are golden brown. If you grill in an oven or air fryer, you can set the temperature to 180 degrees Celsius for 30 - 45 minutes.'),
(123, 'vi', 'Làm phần sườn cốt lết nướng Thịt cốt lết mua về rửa sạch và dùng khăn thấm cho ráo. Tiếp đến, dùng búa đập thịt để làm thịt mỏng và mềm hơn (Nếu không có búa đập thịt bạn cũng có thể dùng chày giã bình thường). Ướp thịt theo công thức: 5 cây sả đập dập, ½ muỗng bột ngọt, 1 muỗng hạt nêm, 1 muỗng mật ong, 2 muỗng dầu hào, 1 muỗng nước mắm, ¼ muỗng tiêu xay, 1 muỗng hành tím băm, 1 muỗng tỏi băm và Nấu cơm cho món cơm tấm nhuyễn. Trộn đều và ướp thịt trong 1 tiếng. Nướng từng miếng thịt trên bếp than đến khi chín vàng đều hai mặt. Nếu bạn nướng bằng lò nướng hoặc nồi chiên không dầu có thể chỉnh nhiệt độ 180 độ C từ 30 - 45 phút.'),
(124, 'en', 'Making steamed egg patties Soak the dried mushrooms in warm water for 20 minutes to bloom, then wash, cut off the stem and chop finely. Soak the vermicelli for 10 minutes and also chop finely. Mix the minced pork, wood ear mushrooms and chopped vermicelli. Add 2 eggs and 1 egg white (the remaining yolk is for coloring the surface layer). Then season with 2 tablespoons of salt, 1 tablespoon of sugar, 1 tablespoon of fish sauce and 1 tablespoon of chopped shallots. Mix well so that the ingredients are evenly seasoned. Steam the egg patties for 30 minutes. Then add the remaining egg yolk on the surface and steam for another 10 minutes to complete.'),
(124, 'vi', ' Làm chả trứng hấp Ngâm nấm mèo khô trong nước ấm 20 phút cho nở, sau đó rửa sạch, cắt bỏ phần chân và băm nhỏ. Miến ngâm trong 10 phút và cũng mang đi xắt nhỏ. Trộn đều thịt nạc heo xay, mộc nhĩ và miến đã xắt nhỏ. Đập thêm vào 2 quả trứng gà và 1 lòng trắng (1 lòng đỏ còn lại để tạo màu cho lớp bề mặt). Sau đó nêm với 2 muỗng muối, 1 muỗng đường, 1 muỗng nước mắm và 1 muỗng hành tím băm. Trộn đều để các nguyên liệu thấm đều gia vị. Cho phần chả trứng vào hấp cách thủy trong 30 phút. Sau đó cho lòng đỏ trứng còn lại lên bề mặt và hấp thêm 10 phút là hoàn tất.'),
(125, 'en', 'Making pork skin Wash the pork skin and boil it quickly for 15 minutes to keep it chewy. After removing it, immediately put the pork skin in ice water to keep it crispy. Soak the pork skin for 5 minutes and remove it to drain. Thinly slice the pork skin. Making rice powder: Roast 60g of white rice until it turns golden brown. Let the rice cool completely and put it in a blender. This is one of the ways to make broken rice skin or how to mix delicious broken rice skin that you cannot miss.'),
(125, 'vi', '  Làm bì heo Bì heo mua về rửa sạch và mang đi luộc nhanh trong 15 phút để bì giữ được độ dai. Sau khi vớt ra cho ngay bì heo vào nước đá để giữ được độ giòn. Ngâm bì heo trong 5 phút và vớt ra để ráo. Xắt mỏng phần bì heo. Làm thính: Rang 60g gạo trắng đến khi chuyển sang màu vàng nâu. Để gạo cho nguội hoàn toàn và bỏ vào máy xay nhuyễn. Đây là một trong những cách làm bì cơm tấm hay cách trộn bì cơm tấm ngon mà bạn không thể bỏ qua.'),
(126, 'en', 'Wash the white radish and carrots, peel them and shred them into thin strips. Mix 100ml vinegar, 3 tablespoons sugar and half a teaspoon salt and pour it into the shredded radish. Mix well and soak for 1 hour. After 1 hour of soaking, the pickles can be taken out and eaten immediately.'),
(126, 'vi', ' Củ cải trắng và cà rốt mua về rửa sạch, gọt vỏ và bào thành sợi nhỏ. Pha 100ml giấm, 3 muỗng đường và nửa muỗng muối và đổ vào phần củ đã thái sợi. Trộn đều và ngâm trong 1 tiếng là được. Đồ chua sau khi ngâm 1 tiếng có thể gắp ra và dùng ngay.'),
(127, 'en', 'Make the scallion oil Slice the scallions finely, add ¼ teaspoon salt, ¼ teaspoon sugar and mix well. Boil the cooking oil and add it to the prepared scallions. Mix until the scallions are cooked and done.'),
(127, 'vi', ' Làm phần mỡ hành Hành lá xắt nhuyễn cho thêm ¼ muỗng muối, ¼ muỗng đường và trộn đều. Dầu ăn nấu sôi và chế vào phần hành lá đã chuẩn bị. Trộn cho phần hành lá chín hết là hoàn thành.'),
(128, 'en', 'Prepare the fish sauce Boil and stir well the mixture of 3 tablespoons of fish sauce, 3 tablespoons of sugar, 3 tablespoons of warm water and 1 tablespoon of vinegar. Let the mixture cool, then add ½ tablespoon of fish sauce and ½ tablespoon of vinegar, season to taste. Wash the chili, pour enough cold water over the chili and boil until the chili is soft. Use a spoon to crush the chili into small pieces. Heat 1 tablespoon of cooking oil, add 1 tablespoon of garlic and sauté until fragrant, then add the crushed chili. Add 1 tablespoon of sugar, 1 tablespoon of vinegar, boil for about 5 minutes, turn off the heat to cool, then add the chili mixture with the cooked fish sauce.'),
(128, 'vi', ' Pha chế nước mắm Đun sôi và khuấy đều hỗn hợp 3 muỗng nước mắm, 3 muỗng đường, 3 muỗng nước ấm và 1 muỗng giấm. Để hỗn hợp nguội, sau đó thêm ½ muỗng mắm và ½ muỗng giấm vào, nêm vừa miệng. Ớt trái rửa sạch, đổ nước lạnh vừa đủ qua mặt ớt và đun sôi đến khi ớt mềm. Dùng thìa dầm ớt nhỏ ra. Đun nóng 1 muỗng dầu ăn, cho 1 muỗng tỏi vào phi thơm, sau đó cho phần ớt đã dầm nhuyễn vào. Thêm vào 1 muỗng đường, 1 muỗng giấm, đun sôi khoảng 5 phút, tắt bếp để nguội rồi cho hỗn hợp ớt vào cùng phần nước mắm đã nấu.'),
(129, 'en', 'Prepare vegetables Wash lettuce, herbs, bean sprouts, chives, cucumbers and let them drain. Cut cucumbers lengthwise.'),
(129, 'vi', 'Sơ chế rau Rau xà lách, rau thơm, giá, hẹ, dưa leo rửa sạch rồi để ráo nước. Dưa leo cắt dọc theo chiều dài.'),
(130, 'en', 'Boil the pork Shave the pork clean, then rub salt on the pork and rinse with warm water. This will make the pork cleaner. Put the pot of water on the stove, add the onion and a little salt and boil with the meat for about 30 minutes. Once the meat is cooked, remove it to a bowl of cold water to make it whiter and crispier. Then cut the meat into thin, bite-sized pieces and arrange on a plate.'),
(130, 'vi', 'Luộc thịt heo Thịt heo cạo lông sạch sau đó lấy muối chà xát lên thịt heo rồi rửa lại với nước ấm, làm cách này thì thịt heo sẽ sạch hơn. Cho nồi nước lên bếp rồi cho củ hành và một ít muối luộc chung với thịt trongkhoảng 30 phút. Sau khi thịt chín, vớt thịt ra thau nước lạnh để thịt trắng và giòn hơn. Sau đó cắt thịt thành miếng mỏng vừa ăn và bày ra đĩa.'),
(131, 'en', 'Boil the shrimp Wash the shrimp, put the pan on the stove and add the shrimp with a little salt and no need to add water because the shrimp will secrete water. Cover the lid and boil the shrimp, when the shrimp turns red, take the shrimp out. Peel the shrimp, remove the back vein. Arrange on a plate to look nice.'),
(131, 'vi', 'Luộc tôm Tôm rửa sạch, cho chảo lên bếp rồi cho tôm vào cùngmột ít muối và không cần thêm nước vì tôm tự tiết ra nước. Đậy nắp lại và luộc tôm, khi tôm chuyển sang màu đỏ thì vớt tôm ra. Lột vỏ tôm, bỏ chỉ lưng. Bày ra đĩa cho đẹp mắt.'),
(132, 'en', 'Spring Roll Use a little water to wet the rice paper, then place it on a plate or cutting board. Take some lettuce, herbs, bean sprouts, cucumber and 1 chive and place it on the rice paper. Then, add some vermicelli, meat and start rolling. When you have rolled 1 round, add 2 shrimp and fold the 2 edges of the rice paper on both sides. Finally, just roll tightly until the rice paper is finished.'),
(132, 'vi', ' Cuốn gỏi cuốn Bạn lấy ít nước để làm ướt bánh tráng, sau đó đặt bánh tráng lên 1 cái dĩa hoặc thớt. Lấy một ít rau xà lách, rau thơm, giá, dưa leo và 1 cọng hẹ đặt lên bánh tráng. Sau đó, cho một ít bún, thịt và bắt đầu cuốn lại. Khi cuốn được 1 vòng, bạn cho thêm 2 con tôm rồi gấp 2 mép bánh tráng ở 2 bên lại. Cuối cùng, chỉ cần cuộn chặt tay đến khi hết miếng bánh tráng là xong.'),
(133, 'en', 'Add fish sauce, sugar and hot water to a bowl, stir well to dissolve the sugar. Add 1 tablespoon of garlic, 1 tablespoon of minced chili and 1 tablespoon of lemon juice, stir well again and you have completed the delicious fish sauce to dip spring rolls.'),
(133, 'vi', ' Bạn cho nước mắm, đường và nước nóng vào chén, khuấy đều cho tan đường. Cho thêm 1 muỗng canh tỏi, 1 muỗng canh ớt băm và 1 muỗng canh nước cốt chanh vào khuấy đều lần nữa là đã hoàn thành nước mắm ngon chấm gỏi cuốn rồi nhé.'),
(134, 'en', 'Prepare ingredients Peel and mince garlic and shallots, peel and cut onions into wedges.'),
(134, 'vi', 'Sơ chế nguyên liệu Tỏi, hành tím lột vỏ rồi băm nhuyễn, hành tây lột vỏ rồi cắt múi cau.'),
(135, 'en', 'Chicken breast Filter the meat from the chicken breast and use the bones to make broth.'),
(135, 'vi', 'ơ chế gà Ức gà lọc phần thịt, phần xương dùng nấu nước dùng.'),
(136, 'en', 'Cook the broth Wash the pork and chicken bones, blanch them in boiling water, then rinse with cold water. Heat a pot of water and add the pork bones, chicken bones, onions, 1/2 teaspoon salt, 1 tablespoon seasoning powder and boil for 30 minutes to make the broth.'),
(136, 'vi', ' Nấu nước dùng Xương heo và xương gà rửa sạch đem chần qua nước sôi rồi rửa lại bằng nước lạnh. Bắt một nồi nước rồi cho xương heo, xương gà, hành tây, 1/2 muỗng cà phê muối, 1 muỗng canh hạt nêm vào đun trong 30 phút để làm nước dùng.'),
(137, 'en', 'Marinate the shrimp and prepare the eggs Peel the shrimp, remove the heads and marinate with 1 teaspoon of seasoning powder and 1/2 teaspoon of pepper. Boil the eggs, peel and cut into pieces.'),
(137, 'vi', 'Ướp tôm và sơ chế trứng Tôm bóc vỏ, bỏ đầu rồi ướp với 1 muỗng cà phê hạt nêm, 1/2 muỗng cà phê tiêu. Trứng gà luộc chín, bóc vỏ rồi cắt miếng.'),
(138, 'en', 'Marinate pork belly and chicken Wash pork belly and chicken, cut into bite-sized pieces, marinate with minced onion and garlic, 2 tablespoons fish sauce, 1.5 tablespoons seasoning powder, 1 tablespoon sugar, 1/2 tablespoon oyster sauce, 2 teaspoons turmeric powder, 1 teaspoon chili powder, 1 teaspoon pepper for 15 minutes to let the meat absorb the spices.'),
(138, 'vi', ' Ướp thịt ba chỉ và thịt gà Thịt ba chỉ và thịt gà rửa sạch rồi cắt miếng vừa ăn, ướp thịt với hành tỏi băm, 2 muỗng canh nước mắm, 1.5 muỗng canh hạt nêm, 1 muỗng canh đường, 1/2 muỗng canh dầu hào, 2 muỗng cà phê bột nghệ, 1 muỗng cà phê ớt bột, 1 muỗng cà phê tiêu trong 15 phút cho thịt ngấm gia vị. '),
(139, 'en', 'Finished product Put the pan on the stove, add 2 tablespoons of annatto oil and then add minced garlic and sauté until fragrant, then add the marinated meat and stir-fry until cooked. After the meat is cooked, continue to pour the broth into the pan where the meat is being stir-fried, then add the eggs and shrimp, continue to cook for another 20 minutes and then turn off the stove.'),
(139, 'vi', ' Thành phẩm Bắt chảo lên bếp, cho 2 muỗng canh dầu màu điều vào rồi cho tỏi băm vào phi thơm, sau đó cho phần thịt vừa ướp vào xào cho chín. Sau khi thịt chín thì tiếp tục đổ nước dùng vào chảo đang xào thịt rồi cho luôn trứng gà, tôm vào, tiếp tục nấu thêm 20 phút thì tắt bếp.'),
(140, 'en', 'Prepare ingredients Wash the pork skin, boil it, remove it and soak it in ice water for about 10 minutes, wash it and drain it. Then cut it into small, short strips. Peel the garlic, slice it thinly with the chili. Wash the fig leaves, cut them into small rectangular pieces. Wash the banana leaves thoroughly on both sides, dry them in the sun until they are slightly wilted.'),
(140, 'vi', 'Sơ chế nguyên liệu Bì heo rửa sạch, luộc chín, vớt ra ngâm vào nước đá lạnh khoảng 10 phút, đem rửa sạch và để ráo nước. Sau đó thái sợi nhỏ, ngắn. Tỏi bóc vỏ, thái lát mỏng với ớt. Lá sung rửa sạch, cắt thành từng miếng chữ nhật nhỏ. Lá chuối rửa kỹ hai mặt, phơi qua nắng cho hơi héo.'),
(141, 'en', 'Processing meat for spring rolls Wash the lean pork, cut into small pieces, then grind it. Mix the lean meat with rice bran and borax, 1 teaspoon of seasoning powder, 1 teaspoon of sugar, a little pepper, 2 teaspoons of fish sauce, garlic, chili. Then add the pork skin and mix well with the meat.'),
(141, 'vi', 'Chế biến thịt gói nem Thịt heo nạc rửa sạch, thái miếng nhỏ, sau đó xay nhuyễn. Trộn thịt nạc với thính gạo và hàn the, 1 thìa cà phê hạt nêm, 1 thìa cà phê đường, một ít hạt tiêu, 2 thìa cà phê nước mắm, tỏi, ớt. Sau đó cho bì lợn vào trộn thật đều với thịt.'),
(142, 'en', 'Wrapping the spring rolls Lay the banana leaves on a clean flat surface, add the fig leaves, then spread a layer of meat on top, then the garlic and chili. Roll the banana leaves tightly to cover the spring rolls, then fold the two ends down and tie them tightly with a rubber band.'),
(142, 'vi', 'Gói nem Trải lá chuối ra mặt phẳng sạch, cho lá sung vào, tiếp đến trải đều một lớp thịt lên, sau đó đến tỏi, ớt. Cuộn lá chuối thật chặt bọc kín lấy phần nem chua, sau đó bẻ 2 đầu lá xuống và lấy dây thun buộc chặt.'),
(143, 'en', 'Finished product Leave the nem chua in a cool place for 3-5 days to ferment and then eat. Nem chua has a light banana leaf aroma, is chewy and crispy, has just the right amount of seasoning, is rich, and has a bit of chili, pepper, and garlic, which will definitely make you eat it forever.'),
(143, 'vi', ' Thành phẩm Để nem chua ở nơi thoáng mát từ 3 - 5 ngày để nem lên men là ăn được. Nem chua thơm nhẹ mùi lá chuối, dai giòn đặc trưng, gia vị nêm nếm vừa đủ, đậm đà, hơi the the của ớt, tiêu, tỏi chắc chắn sẽ khiến bạn ăn mãi không ngừng đấy.'),
(144, 'en', 'Prepare the ingredients Wash the beef bones thoroughly. Soak the beef bones in water for about 30 minutes, add a little salt mixed with lemon to reduce the beef smell. Next, blanch the bones in boiling water and then wash them thoroughly again. After washing the onions, drain them. And grill the onions over low heat until fragrant. Next, wash the beef fillet thoroughly. Cut the beef fillet into thin slices, easy to eat, to arrange on top of the pho. Finely chop the onions.'),
(144, 'vi', 'Sơ chế nguyên liệu Xương bò mua về rửa thật sạch. Ngâm xương bò trong nước khoảng 30 phút, pha thêm một ít muối hột hòa với chanh để đỡ mùi hôi của bò. Tiếp theo, chần xương qua nước sôi sau đó rửa thật sạch lại một lần nữa. Hành tây sau khi rửa sạch, để ráo nước. Và đem hành tây nướng trên lửa nhỏ, khi có mùi thơm là được. Tiếp theo, phi lê bò rửa thật sạch. Cắt phi lê bò thành lát mỏng, vừa ăn để sắp lên trên phở. Hành là cắt nhuyễn.'),
(145, 'en', 'Cook the broth Then put the bones in the pot, add 1 liter of water, 1 tablespoon of salt, and the roasted onions and start stewing. If you have a pressure cooker, use the pressure cooker to stew faster. After stewing the bones for about 30 minutes, add 1.5 liters of water. Continue to add the beef balls and finally add the cloves, cardamom, cinnamon and star anise to the pot. We cook over medium heat and remember not to cover the lid, regularly skim off the foam to make the broth clearer and more delicious. After 30 minutes of stewing, we remove all the beef bones and aromatic spices. Next, we will season this broth, add a tablespoon of coarse salt, a tablespoon of rock sugar, a tablespoon of MSG and stir well to dissolve the spices.'),
(145, 'vi', 'Nấu nước dùng Sau đó cho xương vào nồi, thêm 1 lít nước, 1 muỗng canh muối, và hành tây đã nướng và bắt đầu hầm, nếu có nồi áp suất thì dùng nồi áp suất sẽ hầm nhanh hơn. Sau khi hầm xương khoảng 30 phút, cho vào thêm 1.5 lít nước. Tiếp tục cho bò viên và cuối cùng cho đinh hương, thảo quả, quế chi và hoa hồi vào nồi. Chúng ta nấu lửa vừa và lưu ý không đậy nắp, thường xuyên vớt bọt để nước dùng trong và thơm ngon hơn. Sau 30 phút hầm, chúng ta vớt hết xương bò và những gia vị thơm ra. Tiếp theo sẽ nêm phần nước dùng này, cho vào một muỗng canh muối hột, một muỗng canh đường phèn, một muỗng canh bột ngọt và khuấy đều để gia vị được hòa tan.'),
(146, 'en', 'Finished product Put some pho noodles in a bowl. Arrange the beef fillet slices on top and sprinkle with onions. Pour in the broth and it is ready to enjoy.'),
(146, 'vi', 'Thành phẩm Cho một ít bánh phở vào tô. Xếp những lát bò phi lê lên trên mặt và rắt thêm hành. Chế nước dùng vào, đã sẵn sàng cho bạn thưởng thức rồi nhé.'),
(147, 'en', 'Preliminary processing of ingredients Rinse mung beans and sticky rice with water 1-2 times to remove dust. Grind turmeric and squeeze to get the juice. Separate corn kernels, then soak in water for 15 minutes.'),
(147, 'vi', 'Sơ chế nguyên liệu Đậu xanh và nếp vo sơ với nước 1-2 lần cho sạch bụi. Nghệ xay nhuyễn vắt lấy nước. Ngô tách lấy hạt, sau đó ngâm trong nước vô trong 15 phút.'),
(148, 'en', 'soaking green beans and sticky rice After washing the green beans, pour in enough water to cover the beans and soak for 6 hours. Mix the freshly squeezed turmeric juice with water, then add the sticky rice and soak for 6 hours. Using turmeric to soak the sticky rice will help the sticky rice soften faster and become more fragrant.'),
(148, 'vi', 'Ngâm đậu xanh và nếp Đậu xanh sau khi vo thì đổ nước vừa ngập đậu và ngâm trong 6 tiếng. Pha nước nghệ vừa vắt với nước, rồi cho nếp vào ngâm 6 tiếng. Dùng nghệ ngâm nếp sẽ giúp nếp mau mềm và thơm hơn.'),
(149, 'en', 'Steam and grind green beans Rinse green beans and sticky rice with water 1-2 times to remove dust. Grind turmeric and squeeze out the water. Separate the corn kernels, then soak in water for 15 minutes. After soaking for 6 hours, take out the beans and steam. Put the green beans in a steamer and steam for 15 minutes until the beans are cooked. Put the steamed green beans in a mortar and pound them with a pestle. You can knead them into large lumps or leave them as separate pieces. If kneaded into lumps, cut them into small pieces after kneading.'),
(149, 'vi', 'Hấp và nghiền đậu xanh Đậu xanh và nếp vo sơ với nước 1-2 lần cho sạch bụi. Nghệ xay nhuyễn vắt lấy nước. Ngô tách lấy hạt, sau đó ngâm trong nước vô trong 15 phút. Sau khi ngâm 6 tiếng thì vớt đậu ra và tiến hành hấp. Cho đậu xanh vào xửng hấp và hấp trong 15 phút là đậu chín. Cho đậu xanh vừa hấp vào cối rồi dùng chày giã nhuyễn. Có thể vò thành cục to hoặc để rời cũng được. Nếu vò thành cục thì vò xong cắt thành từng miếng nhỏ.'),
(150, 'en', 'Steamed Corn After soaking the corn in lime water, rinse it 2-3 times with water to remove the lime smell. Next, put the corn in a steamer and steam for 20 minutes.'),
(150, 'vi', ' Hấp ngô Ngô ngâm nước vôi trong xong thì rửa 2-3 lần với nước cho hết mùi vôi. Tiếp theo cho ngô vào xửng và hấp trong 20 phút.'),
(151, 'en', 'Steamed Sticky Rice Wash the soaked sticky rice with water and drain. Add the cooked corn to the sticky rice and add a little salt, mix well and steam for 25 minutes. After 25 minutes of steaming, open the lid and add 1 tablespoon of cooking oil and mix well. If you have pork fat or chicken fat, it will be more delicious and fragrant than using cooking oil. Continue cooking for another 2 minutes so that the oil is absorbed into the sticky rice and then turn off the stove. The sticky rice is now cooked.'),
(151, 'vi', ' Hấp nếp Rửa sạch nếp đã ngâm với nước và để ráo. Phần ngô hấp chín rồi thì cho vô chung với nếp và thêm ít muối sau đó trộn đều rồi cho vào xửng tiến hành hấp trong 25 phút. Hấp được 25 phút thì mở nắp và cho 1 muỗng dầu ăn và trộn đều. Nếu có mỡ heo hay mỡ gà thì sẽ ngon và thơm hơn so với dùng dầu ăn. Tiếp tục nấu trong 2 phút nữa để dầu được thấm đều vào xôi rồi tắt bếp. Lúc này xôi đã chín rồi đấy.'),
(152, 'en', 'Finished product So the sticky rice with corn is done, take the sticky rice out on a plate, put the green beans on top and add some fried onions on top and enjoy.'),
(152, 'vi', ' Thành phẩm Vậy là món xôi xéo ngô đã hoàn thành rồi, lấy xôi ra đĩa rồi cho phần đậu xanh lên trên và cho thêm ít hành phi lên mặt và thưởng thức thôi nào.');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `shopping_lists`
--

CREATE TABLE `shopping_lists` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT 'Danh sách mua sắm',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `shopping_lists`
--

INSERT INTO `shopping_lists` (`id`, `user_id`, `name`, `created_at`, `updated_at`) VALUES
(14, 3, 'Broken Rice', '2025-11-26 13:39:03', '2025-11-26 13:54:01');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `shopping_list_items`
--

CREATE TABLE `shopping_list_items` (
  `id` int NOT NULL,
  `list_id` int NOT NULL,
  `ingredient_id` int DEFAULT NULL,
  `ingredient_name` varchar(255) DEFAULT NULL,
  `quantity` varchar(100) NOT NULL DEFAULT '',
  `is_checked` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `shopping_list_items`
--

INSERT INTO `shopping_list_items` (`id`, `list_id`, `ingredient_id`, `ingredient_name`, `quantity`, `is_checked`, `created_at`) VALUES
(183, 14, 4, 'Hành lá', ' ', 1, '2025-11-26 13:39:03'),
(184, 14, 8, 'Nước mắm', ' ', 0, '2025-11-26 13:39:03'),
(185, 14, 9, 'Đường', ' ', 0, '2025-11-26 13:39:03'),
(186, 14, 10, 'Muối', ' ', 0, '2025-11-26 13:39:03'),
(187, 14, 15, 'Tỏi băm', ' ', 0, '2025-11-26 13:39:03'),
(188, 14, 25, 'Hành tím băm', ' ', 0, '2025-11-26 13:39:03'),
(189, 14, 26, 'Ớt băm', ' ', 0, '2025-11-26 13:39:03'),
(190, 14, 28, 'Giấm', ' ', 0, '2025-11-26 13:39:03'),
(191, 14, 166, 'Bì heo', '100g', 0, '2025-11-26 13:39:03'),
(192, 14, 168, 'Dưa leo', ' ', 0, '2025-11-26 13:39:03'),
(193, 14, 201, 'Trứng gà', '3', 0, '2025-11-26 13:39:03'),
(194, 14, 269, 'Bột ngọt', ' ', 0, '2025-11-26 13:39:03'),
(195, 14, 316, 'Cà chua', ' ', 0, '2025-11-26 13:39:03'),
(196, 14, 341, 'Sườn cốt lết heo', '4', 0, '2025-11-26 13:39:03'),
(197, 14, 342, 'Gạo tấm', '300g', 0, '2025-11-26 13:39:03'),
(198, 14, 343, 'Gạo trắng (làm thính)', '60g', 0, '2025-11-26 13:39:03'),
(199, 14, 344, 'Thịt nạc heo xay', '50g', 0, '2025-11-26 13:39:03'),
(200, 14, 345, 'Miến', '50g', 0, '2025-11-26 13:39:03'),
(201, 14, 346, 'Nấm mèo khô', ' ', 0, '2025-11-26 13:39:03'),
(202, 14, 347, 'Sả nhỏ', '5 ', 0, '2025-11-26 13:39:03'),
(203, 14, 348, 'Cà rốt', ' ', 0, '2025-11-26 13:39:03'),
(204, 14, 349, 'Củ cải trắng', ' ', 0, '2025-11-26 13:39:03'),
(205, 14, 350, 'Mật ong', ' ', 0, '2025-11-26 13:39:03'),
(206, 14, 351, 'Dầu hào', ' ', 0, '2025-11-26 13:39:03'),
(207, 14, 352, 'Tiêu xay', ' ', 0, '2025-11-26 13:39:03');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `hashed_password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `username`, `hashed_password`, `created_at`) VALUES
(1, 'dinhbinh', '$2b$12$Pnm9pqTJAAkEkkjj6wxuf.0NrdqlOlivLnuC1SzUbu.fV6RAgriE.', '2025-11-23 09:03:05'),
(2, 'caindan', '$2b$12$daarAcT5OqEa./wVHl11PeBXTLiKXbIRrZIIsgj6gNJ6D6w4MhIOq', '2025-11-23 09:42:52'),
(3, 'dangkhanh', '$2b$12$MEN0TfsM/RRXpEiLkHHKAeD2NKBJ//pbYslt4GBMCCjI.CkdYpKVC', '2025-11-26 12:42:29');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `dishes`
--
ALTER TABLE `dishes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `class_id` (`class_id`);

--
-- Chỉ mục cho bảng `dish_ingredients`
--
ALTER TABLE `dish_ingredients`
  ADD PRIMARY KEY (`dish_id`,`ingredient_id`),
  ADD KEY `ingredient_id` (`ingredient_id`);

--
-- Chỉ mục cho bảng `dish_translations`
--
ALTER TABLE `dish_translations`
  ADD PRIMARY KEY (`dish_id`,`language_code`);

--
-- Chỉ mục cho bảng `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_dish` (`user_id`,`dish_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_dish_id` (`dish_id`);

--
-- Chỉ mục cho bảng `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `dish_id` (`dish_id`);

--
-- Chỉ mục cho bảng `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_key` (`name_key`);

--
-- Chỉ mục cho bảng `ingredient_translations`
--
ALTER TABLE `ingredient_translations`
  ADD PRIMARY KEY (`ingredient_id`,`language_code`);

--
-- Chỉ mục cho bảng `instructions`
--
ALTER TABLE `instructions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dish_id` (`dish_id`);

--
-- Chỉ mục cho bảng `instruction_translations`
--
ALTER TABLE `instruction_translations`
  ADD PRIMARY KEY (`instruction_id`,`language_code`);

--
-- Chỉ mục cho bảng `shopping_lists`
--
ALTER TABLE `shopping_lists`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- Chỉ mục cho bảng `shopping_list_items`
--
ALTER TABLE `shopping_list_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_list_id` (`list_id`),
  ADD KEY `idx_ingredient_id` (`ingredient_id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `dishes`
--
ALTER TABLE `dishes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT cho bảng `favorites`
--
ALTER TABLE `favorites`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT cho bảng `history`
--
ALTER TABLE `history`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `ingredients`
--
ALTER TABLE `ingredients`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=438;

--
-- AUTO_INCREMENT cho bảng `instructions`
--
ALTER TABLE `instructions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=153;

--
-- AUTO_INCREMENT cho bảng `shopping_lists`
--
ALTER TABLE `shopping_lists`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT cho bảng `shopping_list_items`
--
ALTER TABLE `shopping_list_items`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=312;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `dish_ingredients`
--
ALTER TABLE `dish_ingredients`
  ADD CONSTRAINT `dish_ingredients_ibfk_1` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `dish_ingredients_ibfk_2` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `dish_translations`
--
ALTER TABLE `dish_translations`
  ADD CONSTRAINT `dish_translations_ibfk_1` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `favorites`
--
ALTER TABLE `favorites`
  ADD CONSTRAINT `favorites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `favorites_ibfk_2` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `history`
--
ALTER TABLE `history`
  ADD CONSTRAINT `history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `history_ibfk_2` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`id`);

--
-- Các ràng buộc cho bảng `ingredient_translations`
--
ALTER TABLE `ingredient_translations`
  ADD CONSTRAINT `ingredient_translations_ibfk_1` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `instructions`
--
ALTER TABLE `instructions`
  ADD CONSTRAINT `instructions_ibfk_1` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `instruction_translations`
--
ALTER TABLE `instruction_translations`
  ADD CONSTRAINT `instruction_translations_ibfk_1` FOREIGN KEY (`instruction_id`) REFERENCES `instructions` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `shopping_lists`
--
ALTER TABLE `shopping_lists`
  ADD CONSTRAINT `shopping_lists_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `shopping_list_items`
--
ALTER TABLE `shopping_list_items`
  ADD CONSTRAINT `shopping_list_items_ibfk_1` FOREIGN KEY (`list_id`) REFERENCES `shopping_lists` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `shopping_list_items_ibfk_2` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
