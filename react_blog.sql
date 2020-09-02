-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- 主机： 127.0.0.1
-- 生成日期： 2020-09-02 02:01:49
-- 服务器版本： 10.4.11-MariaDB
-- PHP 版本： 7.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `react_blog`
--

-- --------------------------------------------------------

--
-- 表的结构 `article`
--

CREATE TABLE `article` (
  `id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `article_content` text NOT NULL,
  `introduce` text DEFAULT NULL,
  `create_time` int(11) NOT NULL,
  `view_count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `article`
--

INSERT INTO `article` (`id`, `type_id`, `title`, `article_content`, `introduce`, `create_time`, `view_count`) VALUES
(1, 1, 'React服务端渲染框架Next.js入门(共12集)', '\r\n## 1、什么是跨越？\r\n一个网页向另一个不同域名/不同协议/不同端口的网页请求资源，这就是跨域。\r\n\r\n## 2、为什么会产生跨域请求？\r\n因为浏览器使用了同源策略\r\n\r\n## 3、什么是同源策略？\r\n同源策略是Netscape提出的一个著名的安全策略，现在所有支持JavaScript的浏览器都会使用这个策略。同源策略是浏览器最核心也最基本的安全功能，如果缺少同源策略，浏览器的正常功能可能受到影响。可以说web是构建在同源策略的基础之上的，浏览器只是针对同源策略的一种实现。\r\n\r\n## 4、为什么浏览器要使用同源策略？\r\n是为了保证用户的信息安全，防止恶意网站窃取数据，如果网页之间不满足同源要求，将不能:\r\n- 1、共享Cookie、LocalStorage、IndexDB\r\n- 2、获取DOM\r\n- 3、AJAX请求不能发送\r\n\r\n同源策略的非绝对性：\r\n```html\r\n    <script></script>\r\n    <img/>\r\n    <iframe/>\r\n    <link/>\r\n    <video/>\r\n    <audio/>\r\n```\r\n等带有src属性的标签可以从不同的域加载和执行资源。其他插件的同源策略：flash、java applet、silverlight、googlegears等浏览器加载的第三方插件也有各自的同源策略，只是这些同源策略不属于浏览器原生的同源策略，如果有漏洞则可能被黑客利用，从而留下XSS攻击的后患\r\n\r\n 所谓的同源指：域名、网络协议、端口号相同，三条有一条不同就会产生跨域。 例如：你用浏览器打开http://baidu.com，浏览器执行JavaScript脚本时发现脚本向http://cloud.baidu.com域名发请求，这时浏览器就会报错，这就是跨域报错。\r\n实现跨域请求的方式有许多种，今天讲的是w3c的标准CORS。\r\n\r\n## 5、什么是CORS？\r\n\r\nCORS是w3c的标准，全称是跨域资源请求，CORS是一种机制，它使用额外的HTTP头来告诉浏览器，让运行在一个origin(domain)上的Web应用允许请求不同源服务器上指定的资源。换言之，它允许浏览器向声明了 CORS 的跨域服务器，发出 XMLHttpReuest 请求，从而克服 Ajax 只能同源使用的限制。\r\n\r\n## 6、设置允许跨域\r\n浏览器收到响应报文后会根据响应头部字段 Access-Control-Allow-Origin 进行判断，这个字段值为服务端允许跨域请求的源，其中通配符“*”表示允许所有跨域请求。如果头部信息没有包含 Access-Control-Allow-Origin 字段或者响应的头部字段 Access-Control-Allow-Origin 不允许当前源的请求，则会抛出错误。\r\n\r\n\r\n**使用axios跨域post json数据时，发现请求头的 Request Method ：POST 变成了 Request Method ：OPTIONS，还报了个请求错误，原因有两个：**\r\n\r\n- 1、后台没开放 OPTIONS 请求方法；\r\n- 2、后台不允许跨域；\r\n\r\n**请求头的请求方法由 POST 变成 OPTIONS 是因为 POST 的是 json 数据，\r\nCORS跨域发送的HTTP请求分为简单请求与非简单请求，对于非简单请求，要求必须首先使用 OPTIONS 方法发起一个预检请求到服务器，以获知服务器是否允许该实际请求。所以把请求方式改成简单请求就不会发送OPTIONS请求了**\r\n\r\n## 7、发送简单请求\r\n把发送的json格式的数据改成发送表单数据即OK了\r\n```js\r\nexport const post = (url, params) => {\r\n  return axios({\r\n    url: url,\r\n    method: \"post\",\r\n    data: params,\r\n    headers: {\r\n      \"Content-Type\": \"application/x-www-form-urlencoded\"\r\n    }\r\n  })\r\n}\r\n```\r\n## 8、简单请求符合下面 2 个特征\r\n\r\n请求方法为 GET、POST、HEAD。\r\n\r\n请求头只能使用下面的字段：Accept（浏览器能够接受的响应内容类型）、Accept-Language（浏览器能够接受的自然语言列表）、Content-Type （请求对应的类型，只限于 text/plain、multipart/form-data、application/x-www-form-urlencoded）、Content-Language（浏览器希望采用的自然语言）、Save-Data（浏览器是否希望减少数据传输量）。\r\n\r\n任意一条要求不符合的即为非简单请求。\r\n\r\n对于简单请求与非简单请求的详细资料可阅读\r\n[HTTP访问控制（CORS）](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Access_control_CORS)\r\n\r\n\r\n--------------------------------\r\n作者：ken_ljq\r\n链接：https://www.jianshu.com/p/f880878c1398\r\n参考：简书、百度百科\r\n', '50元跟着胖哥学一年，掌握程序人的学习方法。 也许你刚步入IT行业，也许你遇到了成长瓶颈，也许你不知道该学习什么知识，也许你不会融入团队，也许...........有些时候你陷入彷徨。 你需要一个强力的队友，你需要一个资深老手，你需要一个随时可以帮助你的人，你更需要一个陪你加速前行的。 我在这个行业走了12年，从后端、前端到移动端都从事过，从中走了很多坑，但我有一套适合程序员的学习方法。 如果你愿意，我将带着你在这个程序行业加速奔跑。分享我学习的方法，所学的内容和一切我的资料。 你遇到的职业问题，我也会第一时间给你解答。我需要先感谢一直帮助我的小伙伴，这个博客能产出300多集免费视频，其中有他们的鼎力支持，如果没有他们的支持和鼓励，我可能早都放弃了。 原来我博客只是录制免费视频，然后求30元的打赏。 每次打赏我都会觉得内疚，因为我并没有给你特殊的照顾，也没能从实质上帮助过你。 直到朋友给我介绍了知识星球，它可以专享加入，可以分享知识，可以解答问题，所以我如获珍宝，决定把打赏环节改为知识服务。我定价50元每年，为什么是50元每年？因为这是知识星球允许的最低收费了。', 1598783440, 1),
(2, 2, '50元加入小密圈 胖哥带你学一年', '\r\n## 1、什么是跨越？\r\n一个网页向另一个不同域名/不同协议/不同端口的网页请求资源，这就是跨域。\r\n\r\n## 2、为什么会产生跨域请求？\r\n因为浏览器使用了同源策略\r\n\r\n## 3、什么是同源策略？\r\n同源策略是Netscape提出的一个著名的安全策略，现在所有支持JavaScript的浏览器都会使用这个策略。同源策略是浏览器最核心也最基本的安全功能，如果缺少同源策略，浏览器的正常功能可能受到影响。可以说web是构建在同源策略的基础之上的，浏览器只是针对同源策略的一种实现。\r\n\r\n## 4、为什么浏览器要使用同源策略？\r\n是为了保证用户的信息安全，防止恶意网站窃取数据，如果网页之间不满足同源要求，将不能:\r\n- 1、共享Cookie、LocalStorage、IndexDB\r\n- 2、获取DOM\r\n- 3、AJAX请求不能发送\r\n\r\n同源策略的非绝对性：\r\n```html\r\n    <script></script>\r\n    <img/>\r\n    <iframe/>\r\n    <link/>\r\n    <video/>\r\n    <audio/>\r\n```\r\n等带有src属性的标签可以从不同的域加载和执行资源。其他插件的同源策略：flash、java applet、silverlight、googlegears等浏览器加载的第三方插件也有各自的同源策略，只是这些同源策略不属于浏览器原生的同源策略，如果有漏洞则可能被黑客利用，从而留下XSS攻击的后患\r\n\r\n 所谓的同源指：域名、网络协议、端口号相同，三条有一条不同就会产生跨域。 例如：你用浏览器打开http://baidu.com，浏览器执行JavaScript脚本时发现脚本向http://cloud.baidu.com域名发请求，这时浏览器就会报错，这就是跨域报错。\r\n实现跨域请求的方式有许多种，今天讲的是w3c的标准CORS。\r\n\r\n## 5、什么是CORS？\r\n\r\nCORS是w3c的标准，全称是跨域资源请求，CORS是一种机制，它使用额外的HTTP头来告诉浏览器，让运行在一个origin(domain)上的Web应用允许请求不同源服务器上指定的资源。换言之，它允许浏览器向声明了 CORS 的跨域服务器，发出 XMLHttpReuest 请求，从而克服 Ajax 只能同源使用的限制。\r\n\r\n## 6、设置允许跨域\r\n浏览器收到响应报文后会根据响应头部字段 Access-Control-Allow-Origin 进行判断，这个字段值为服务端允许跨域请求的源，其中通配符“*”表示允许所有跨域请求。如果头部信息没有包含 Access-Control-Allow-Origin 字段或者响应的头部字段 Access-Control-Allow-Origin 不允许当前源的请求，则会抛出错误。\r\n\r\n\r\n**使用axios跨域post json数据时，发现请求头的 Request Method ：POST 变成了 Request Method ：OPTIONS，还报了个请求错误，原因有两个：**\r\n\r\n- 1、后台没开放 OPTIONS 请求方法；\r\n- 2、后台不允许跨域；\r\n\r\n**请求头的请求方法由 POST 变成 OPTIONS 是因为 POST 的是 json 数据，\r\nCORS跨域发送的HTTP请求分为简单请求与非简单请求，对于非简单请求，要求必须首先使用 OPTIONS 方法发起一个预检请求到服务器，以获知服务器是否允许该实际请求。所以把请求方式改成简单请求就不会发送OPTIONS请求了**\r\n\r\n## 7、发送简单请求\r\n把发送的json格式的数据改成发送表单数据即OK了\r\n```js\r\nexport const post = (url, params) => {\r\n  return axios({\r\n    url: url,\r\n    method: \"post\",\r\n    data: params,\r\n    headers: {\r\n      \"Content-Type\": \"application/x-www-form-urlencoded\"\r\n    }\r\n  })\r\n}\r\n```\r\n## 8、简单请求符合下面 2 个特征\r\n\r\n请求方法为 GET、POST、HEAD。\r\n\r\n请求头只能使用下面的字段：Accept（浏览器能够接受的响应内容类型）、Accept-Language（浏览器能够接受的自然语言列表）、Content-Type （请求对应的类型，只限于 text/plain、multipart/form-data、application/x-www-form-urlencoded）、Content-Language（浏览器希望采用的自然语言）、Save-Data（浏览器是否希望减少数据传输量）。\r\n\r\n任意一条要求不符合的即为非简单请求。\r\n\r\n对于简单请求与非简单请求的详细资料可阅读\r\n[HTTP访问控制（CORS）](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Access_control_CORS)\r\n\r\n\r\n--------------------------------\r\n作者：ken_ljq\r\n链接：https://www.jianshu.com/p/f880878c1398\r\n参考：简书、百度百科\r\n', '50元跟着胖哥学一年，掌握程序人的学习方法。 也许你刚步入IT行业，也许你遇到了成长瓶颈，也许你不知道该学习什么知识，也许你不会融入团队，也许...........有些时候你陷入彷徨。 你需要一个强力的队友，你需要一个资深老手，你需要一个随时可以帮助你的人，你更需要一个陪你加速前行的。 我在这个行业走了12年，从后端、前端到移动端都从事过，从中走了很多坑，但我有一套适合程序员的学习方法。 如果你愿意，我将带着你在这个程序行业加速奔跑。分享我学习的方法，所学的内容和一切我的资料。 你遇到的职业问题，我也会第一时间给你解答。我需要先感谢一直帮助我的小伙伴，这个博客能产出300多集免费视频，其中有他们的鼎力支持，如果没有他们的支持和鼓励，我可能早都放弃了。 原来我博客只是录制免费视频，然后求30元的打赏。 每次打赏我都会觉得内疚，因为我并没有给你特殊的照顾，也没能从实质上帮助过你。 直到朋友给我介绍了知识星球，它可以专享加入，可以分享知识，可以解答问题，所以我如获珍宝，决定把打赏环节改为知识服务。我定价50元每年，为什么是50元每年？因为这是知识星球允许的最低收费了。', 1598783440, 1),
(3, 1, 'React实战视频教程-技术胖Blog开发(更新04集)', '\r\n## 1、什么是跨越？\r\n一个网页向另一个不同域名/不同协议/不同端口的网页请求资源，这就是跨域。\r\n\r\n## 2、为什么会产生跨域请求？\r\n因为浏览器使用了同源策略\r\n\r\n## 3、什么是同源策略？\r\n同源策略是Netscape提出的一个著名的安全策略，现在所有支持JavaScript的浏览器都会使用这个策略。同源策略是浏览器最核心也最基本的安全功能，如果缺少同源策略，浏览器的正常功能可能受到影响。可以说web是构建在同源策略的基础之上的，浏览器只是针对同源策略的一种实现。\r\n\r\n## 4、为什么浏览器要使用同源策略？\r\n是为了保证用户的信息安全，防止恶意网站窃取数据，如果网页之间不满足同源要求，将不能:\r\n- 1、共享Cookie、LocalStorage、IndexDB\r\n- 2、获取DOM\r\n- 3、AJAX请求不能发送\r\n\r\n同源策略的非绝对性：\r\n```html\r\n    <script></script>\r\n    <img/>\r\n    <iframe/>\r\n    <link/>\r\n    <video/>\r\n    <audio/>\r\n```\r\n等带有src属性的标签可以从不同的域加载和执行资源。其他插件的同源策略：flash、java applet、silverlight、googlegears等浏览器加载的第三方插件也有各自的同源策略，只是这些同源策略不属于浏览器原生的同源策略，如果有漏洞则可能被黑客利用，从而留下XSS攻击的后患\r\n\r\n 所谓的同源指：域名、网络协议、端口号相同，三条有一条不同就会产生跨域。 例如：你用浏览器打开http://baidu.com，浏览器执行JavaScript脚本时发现脚本向http://cloud.baidu.com域名发请求，这时浏览器就会报错，这就是跨域报错。\r\n实现跨域请求的方式有许多种，今天讲的是w3c的标准CORS。\r\n\r\n## 5、什么是CORS？\r\n\r\nCORS是w3c的标准，全称是跨域资源请求，CORS是一种机制，它使用额外的HTTP头来告诉浏览器，让运行在一个origin(domain)上的Web应用允许请求不同源服务器上指定的资源。换言之，它允许浏览器向声明了 CORS 的跨域服务器，发出 XMLHttpReuest 请求，从而克服 Ajax 只能同源使用的限制。\r\n\r\n## 6、设置允许跨域\r\n浏览器收到响应报文后会根据响应头部字段 Access-Control-Allow-Origin 进行判断，这个字段值为服务端允许跨域请求的源，其中通配符“*”表示允许所有跨域请求。如果头部信息没有包含 Access-Control-Allow-Origin 字段或者响应的头部字段 Access-Control-Allow-Origin 不允许当前源的请求，则会抛出错误。\r\n\r\n\r\n**使用axios跨域post json数据时，发现请求头的 Request Method ：POST 变成了 Request Method ：OPTIONS，还报了个请求错误，原因有两个：**\r\n\r\n- 1、后台没开放 OPTIONS 请求方法；\r\n- 2、后台不允许跨域；\r\n\r\n**请求头的请求方法由 POST 变成 OPTIONS 是因为 POST 的是 json 数据，\r\nCORS跨域发送的HTTP请求分为简单请求与非简单请求，对于非简单请求，要求必须首先使用 OPTIONS 方法发起一个预检请求到服务器，以获知服务器是否允许该实际请求。所以把请求方式改成简单请求就不会发送OPTIONS请求了**\r\n\r\n## 7、发送简单请求\r\n把发送的json格式的数据改成发送表单数据即OK了\r\n```js\r\nexport const post = (url, params) => {\r\n  return axios({\r\n    url: url,\r\n    method: \"post\",\r\n    data: params,\r\n    headers: {\r\n      \"Content-Type\": \"application/x-www-form-urlencoded\"\r\n    }\r\n  })\r\n}\r\n```\r\n## 8、简单请求符合下面 2 个特征\r\n\r\n请求方法为 GET、POST、HEAD。\r\n\r\n请求头只能使用下面的字段：Accept（浏览器能够接受的响应内容类型）、Accept-Language（浏览器能够接受的自然语言列表）、Content-Type （请求对应的类型，只限于 text/plain、multipart/form-data、application/x-www-form-urlencoded）、Content-Language（浏览器希望采用的自然语言）、Save-Data（浏览器是否希望减少数据传输量）。\r\n\r\n任意一条要求不符合的即为非简单请求。\r\n\r\n对于简单请求与非简单请求的详细资料可阅读\r\n[HTTP访问控制（CORS）](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Access_control_CORS)\r\n\r\n\r\n--------------------------------\r\n作者：ken_ljq\r\n链接：https://www.jianshu.com/p/f880878c1398\r\n参考：简书、百度百科\r\n', '50元跟着胖哥学一年，掌握程序人的学习方法。 也许你刚步入IT行业，也许你遇到了成长瓶颈，也许你不知道该学习什么知识，也许你不会融入团队，也许...........有些时候你陷入彷徨。 你需要一个强力的队友，你需要一个资深老手，你需要一个随时可以帮助你的人，你更需要一个陪你加速前行的。 我在这个行业走了12年，从后端、前端到移动端都从事过，从中走了很多坑，但我有一套适合程序员的学习方法。 如果你愿意，我将带着你在这个程序行业加速奔跑。分享我学习的方法，所学的内容和一切我的资料。 你遇到的职业问题，我也会第一时间给你解答。我需要先感谢一直帮助我的小伙伴，这个博客能产出300多集免费视频，其中有他们的鼎力支持，如果没有他们的支持和鼓励，我可能早都放弃了。 原来我博客只是录制免费视频，然后求30元的打赏。 每次打赏我都会觉得内疚，因为我并没有给你特殊的照顾，也没能从实质上帮助过你。 直到朋友给我介绍了知识星球，它可以专享加入，可以分享知识，可以解答问题，所以我如获珍宝，决定把打赏环节改为知识服务。我定价50元每年，为什么是50元每年？因为这是知识星球允许的最低收费了。', 1598783440, 2);

-- --------------------------------------------------------

--
-- 表的结构 `article_type`
--

CREATE TABLE `article_type` (
  `id` int(11) NOT NULL,
  `type_name` varchar(255) NOT NULL,
  `order_num` int(11) NOT NULL,
  `icon_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `article_type`
--

INSERT INTO `article_type` (`id`, `type_name`, `order_num`, `icon_name`) VALUES
(1, '技术分享', 1, 'YoutubeOutlined'),
(2, '生活分享', 2, 'SmileOutlined'),
(3, '毒鸡汤', 3, 'LikeOutlined');

--
-- 转储表的索引
--

--
-- 表的索引 `article`
--
ALTER TABLE `article`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `article_type`
--
ALTER TABLE `article_type`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `article`
--
ALTER TABLE `article`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- 使用表AUTO_INCREMENT `article_type`
--
ALTER TABLE `article_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
