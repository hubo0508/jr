/*
Navicat MySQL Data Transfer

Source Server         : jr
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : jr

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2014-01-10 19:16:15
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for about
-- ----------------------------
DROP TABLE IF EXISTS `about`;
CREATE TABLE `about` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `protocold` text,
  `company_description` text COMMENT '公司介绍',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='关于金嵘信息表';

-- ----------------------------
-- Records of about
-- ----------------------------
INSERT INTO `about` VALUES ('1', '<h4><span style=\"font-size: 12px;\">金嵘用户注册协议</span></h4><p><span style=\"font-size: 12px;\">本协议是您与金嵘网站（简称&quot;本站&quot;，网址：www.jd.com）所有者（以下简称为&quot;金嵘&quot;）之间就金嵘网站服务等相关事宜所订立的契约，请您仔细阅读本注册协议，您点击&quot;同意并继续&quot;按钮后，本协议即构成对双方有约束力的法律文件。</span></p><h5><span style=\"font-size: 12px;\">第1条 本站服务条款的确认和接纳</span></h5><p><span style=\"font-size: 12px;\"><strong>1.1</strong>本站的各项电子服务的所有权和运作权归金嵘所有。用户同意所有注册协议条款并完成注册程序，才能成为本站的正式用户。用户确认：本协议条款是处理双方权利义务的契约，始终有效，法律另有强制性规定或双方另有特别约定的，依其规定。</span></p><p><span style=\"font-size: 12px;\"><strong>1.2</strong>用户点击同意本协议的，即视为用户确认自己具有享受本站服务、下单购物等相应的权利能力和行为能力，能够独立承担法律责任。</span></p><p><span style=\"font-size: 12px;\"><strong>1.3</strong>如果您在18周岁以下，您只能在父母或监护人的监护参与下才能使用本站。</span></p><p><span style=\"font-size: 12px;\"><strong>1.4</strong>金嵘保留在中华人民共和国大陆地区法施行之法律允许的范围内独自决定拒绝服务、关闭用户账户、清除或编辑内容或取消订单的权利。</span></p><h5><span style=\"font-size: 12px;\">第2条 本站服务</span></h5><p><span style=\"font-size: 12px;\"><strong>2.1</strong>金嵘通过互联网依法为用户提供互联网信息等服务，用户在完全同意本协议及本站规定的情况下，方有权使用本站的相关服务。</span></p><p><span style=\"font-size: 12px;\"><strong>2.2</strong>用户必须自行准备如下设备和承担如下开支：（1）上网设备，包括并不限于电脑或者其他上网终端、调制解调器及其他必备的上网装置；（2）上网开支，包括并不限于网络接入费、上网设备租用费、手机流量费等。</span></p><h5><span style=\"font-size: 12px;\">第3条 用户信息</span></h5><p><span style=\"font-size: 12px;\"><strong>3.1</strong>用户应自行诚信向本站提供注册资料，用户同意其提供的注册资料真实、准确、完整、合法有效，用户注册资料如有变动的，应及时更新其注册资料。如果用户提供的注册资料不合法、不真实、不准确、不详尽的，用户需承担因此引起的相应责任及后果，并且金嵘保留终止用户使用金嵘各项服务的权利。</span></p><p><span style=\"font-size: 12px;\"><strong>3.2</strong>用户在本站进行浏览、下单购物等活动时，涉及用户真实姓名/名称、通信地址、联系电话、电子邮箱等隐私信息的，本站将予以严格保密，除非得到用户的授权或法律另有规定，本站不会向外界披露用户隐私信息。</span></p><p><span style=\"font-size: 12px;\"><strong>3.3</strong>用户注册成功后，将产生用户名和密码等账户信息，您可以根据本站规定改变您的密码。用户应谨慎合理的保存、使用其用户名和密码。用户若发现任何非法使用用户账号或存在安全漏洞的情况，请立即通知本站并向公安机关报案。</span></p><p><span style=\"font-size: 12px;\"><strong>3.4</strong><strong>用户同意，金嵘拥有通过邮件、短信电话等形式，向在本站注册、购物用户、收货人发送订单信息、促销活动等告知信息的权利。</strong></span></p><p><span style=\"font-size: 12px;\"><strong>3.5</strong><strong>用户不得将在本站注册获得的账户借给他人使用，否则用户应承担由此产生的全部责任，并与实际使用人承担连带责任。</strong></span></p><p><span style=\"font-size: 12px;\"><strong>3.6</strong><strong>用户同意，金嵘有权使用用户的注册信息、用户名、密码等信息，登陆进入用户的注册账户，进行证据保全，包括但不限于公证、见证等。</strong></span></p><h5><span style=\"font-size: 12px;\">第4条 用户依法言行义务</span></h5><p><span style=\"font-size: 12px;\">本协议依据国家相关法律法规规章制定，用户同意严格遵守以下义务：</span></p><p><span style=\"font-size: 12px;\"><strong>（1）</strong>不得传输或发表：煽动抗拒、破坏宪法和法律、行政法规实施的言论，煽动颠覆国家政权，推翻社会主义制度的言论，煽动分裂国家、破坏国家统一的的言论，煽动民族仇恨、民族歧视、破坏民族团结的言论；</span></p><p><span style=\"font-size: 12px;\"><strong>（2）</strong>从中国大陆向境外传输资料信息时必须符合中国有关法规；</span></p><p><span style=\"font-size: 12px;\"><strong>（3）</strong>不得利用本站从事洗钱、窃取商业秘密、窃取个人信息等违法犯罪活动；</span></p><p><span style=\"font-size: 12px;\"><strong>（4）</strong>不得干扰本站的正常运转，不得侵入本站及国家计算机信息系统；</span></p><p><span style=\"font-size: 12px;\"><strong>（5）</strong>不得传输或发表任何违法犯罪的、骚扰性的、中伤他人的、辱骂性的、恐吓性的、伤害性的、庸俗的，淫秽的、不文明的等信息资料；</span></p><p><span style=\"font-size: 12px;\"><strong>（6）</strong>不得传输或发表损害国家社会公共利益和涉及国家安全的信息资料或言论；</span></p><p><span style=\"font-size: 12px;\"><strong>（7）</strong>不得教唆他人从事本条所禁止的行为；</span></p><p><span style=\"font-size: 12px;\"><strong>（8）</strong>不得利用在本站注册的账户进行牟利性经营活动；</span></p><p><span style=\"font-size: 12px;\"><strong>（9）</strong>不得发布任何侵犯他人著作权、商标权等知识产权或合法权利的内容；</span></p><p><span style=\"font-size: 12px;\">用户应不时关注并遵守本站不时公布或修改的各类合法规则规定。</span></p><p><span style=\"font-size: 12px;\"><strong>本站保有删除站内各类不符合法律政策或不真实的信息内容而无须通知用户的权利。</strong></span></p><p><span style=\"font-size: 12px;\"><strong>若用户未遵守以上规定的，本站有权作出独立判断并采取暂停或关闭用户帐号等措施。</strong>用户须对自己在网上的言论和行为承担法律责任。</span></p><h5><span style=\"font-size: 12px;\">第5条 商品信息</span></h5><p><span style=\"font-size: 12px;\">本站上的商品价格、数量、是否有货等商品信息随时都有可能发生变动，本站不作特别通知。由于网站上商品信息的数量极其庞大，虽然本站会尽最大努力保证您所浏览商品信息的准确性，但由于众所周知的互联网技术因素等客观原因存在，本站网页显示的信息可能会有一定的滞后性或差错，对此情形您知悉并理解；金嵘欢迎纠错，并会视情况给予纠错者一定的奖励。</span></p><p><span style=\"font-size: 12px;\">为表述便利，商品和服务简称为&quot;商品&quot;或&quot;货物&quot;。</span></p><h5><span style=\"font-size: 12px;\">第6条 订单</span></h5><p><span style=\"font-size: 12px;\"><strong>6.1</strong>在您下订单时，请您仔细确认所购商品的名称、价格、数量、型号、规格、尺寸、联系地址、电话、收货人等信息。收货人与用户本人不一致的，收货人的行为和意思表示视为用户的行为和意思表示，用户应对收货人的行为及意思表示的法律后果承担连带责任。</span></p><p><span style=\"font-size: 12px;\"><strong>6.2</strong><strong>除法律另有强制性规定外，双方约定如下：本站上销售方展示的商品和价格等信息仅仅是要约邀请，您下单时须填写您希望购买的商品数量、价款及支付方式、收货人、联系方式、收货地址（合同履行地点）、合同履行方式等内容；系统生成的订单信息是计算机信息系统根据您填写的内容自动生成的数据，仅是您向销售方发出的合同要约；销售方收到您的订单信息后，只有在销售方将您在订单中订购的商品从仓库实际直接向您发出时（ 以商品出库为标志），方视为您与销售方之间就实际直接向您发出的商品建立了合同关系；如果您在一份订单里订购了多种商品并且销售方只给您发出了部分商品时，您与销售方之间仅就实际直接向您发出的商品建立了合同关系；只有在销售方实际直接向您发出了订单中订购的其他商品时，您和销售方之间就订单中该其他已实际直接向您发出的商品才成立合同关系。您可以随时登陆您在本站注册的账户，查询您的订单状态。</strong></span></p><p><span style=\"font-size: 12px;\"><strong>6.3</strong><strong>由于市场变化及各种以合理商业努力难以控制的因素的影响，本站无法保证您提交的订单信息中希望购买的商品都会有货；如您拟购买的商品，发生缺货，您有权取消订单。</strong></span></p><h5><span style=\"font-size: 12px;\">第7条 配送</span></h5><p><span style=\"font-size: 12px;\"><strong>7.1</strong>销售方将会把商品（货物）送到您所指定的收货地址，所有在本站上列出的送货时间为参考时间，参考时间的计算是根据库存状况、正常的处理过程和送货时间、送货地点的基础上估计得出的。</span></p><p><span style=\"font-size: 12px;\"><strong>7.2</strong>因如下情况造成订单延迟或无法配送等，销售方不承担延迟配送的责任：</span></p><p><span style=\"font-size: 12px;\"><strong>（1）</strong>用户提供的信息错误、地址不详细等原因导致的；</span></p><p><span style=\"font-size: 12px;\"><strong>（2）</strong>货物送达后无人签收，导致无法配送或延迟配送的；</span></p><p><span style=\"font-size: 12px;\"><strong>（3）</strong>情势变更因素导致的；</span></p><p><span style=\"font-size: 12px;\"><strong>（4）</strong>不可抗力因素导致的，例如：自然灾害、交通戒严、突发战争等。</span></p><h5><span style=\"font-size: 12px;\">第8条 所有权及知识产权条款</span></h5><p><span style=\"font-size: 12px;\"><strong>8.1</strong><strong>用户一旦接受本协议，即表明该用户主动将其在任何时间段在本站发表的任何形式的信息内容（包括但不限于客户评价、客户咨询、各类话题文章等信息内容）的财产性权利等任何可转让的权利，如著作权财产权（包括并不限于：复制权、发行权、出租权、展览权、表演权、放映权、广播权、信息网络传播权、摄制权、改编权、翻译权、汇编权以及应当由著作权人享有的其他可转让权利），全部独家且不可撤销地转让给金嵘所有，用户同意金嵘有权就任何主体侵权而单独提起诉讼。</strong></span></p><p><span style=\"font-size: 12px;\"><strong>8.2</strong><strong>本协议已经构成《中华人民共和国著作权法》第二十五条（条文序号依照2011年版著作权法确定）及相关法律规定的著作财产权等权利转让书面协议，其效力及于用户在金嵘网站上发布的任何受著作权法保护的作品内容，无论该等内容形成于本协议订立前还是本协议订立后。</strong></span></p><p><span style=\"font-size: 12px;\"><strong>8.3</strong><strong>用户同意并已充分了解本协议的条款，承诺不将已发表于本站的信息，以任何形式发布或授权其它主体以任何方式使用（包括但限于在各类网站、媒体上使用）。</strong></span></p><p><span style=\"font-size: 12px;\"><strong>8.4</strong><strong>金嵘是本站的制作者,拥有此网站内容及资源的著作权等合法权利,受国家法律保护,有权不时地对本协议及本站的内容进行修改，并在本站张贴，无须另行通知用户。在法律允许的最大限度范围内，金嵘对本协议及本站内容拥有解释权。</strong></span></p><p><span style=\"font-size: 12px;\"><strong>8.5</strong><strong>除法律另有强制性规定外，未经金嵘明确的特别书面许可,任何单位或个人不得以任何方式非法地全部或部分复制、转载、引用、链接、抓取或以其他方式使用本站的信息内容，否则，金嵘有权追究其法律责任。</strong></span></p><p><span style=\"font-size: 12px;\"><strong>8.6</strong>本站所刊登的资料信息（诸如文字、图表、标识、按钮图标、图像、声音文件片段、数字下载、数据编辑和软件），均是金嵘或其内容提供者的财产，受中国和国际版权法的保护。本站上所有内容的汇编是金嵘的排他财产，受中国和国际版权法的保护。本站上所有软件都是金嵘或其关联公司或其软件供应商的财产，受中国和国际版权法的保护。</span></p><h5><span style=\"font-size: 12px;\">第9条 责任限制及不承诺担保</span></h5><p><span style=\"font-size: 12px;\"><strong>除非另有明确的书面说明,本站及其所包含的或以其它方式通过本站提供给您的全部信息、内容、材料、产品（包括软件）和服务，均是在&quot;按现状&quot;和&quot;按现有&quot;的基础上提供的。</strong></span></p><p><span style=\"font-size: 12px;\"><strong>除非另有明确的书面说明,金嵘不对本站的运营及其包含在本网站上的信息、内容、材料、产品（包括软件）或服务作任何形式的、明示或默示的声明或担保（根据中华人民共和国法律另有规定的以外）。</strong></span></p><p><span style=\"font-size: 12px;\"><strong>金嵘不担保本站所包含的或以其它方式通过本站提供给您的全部信息、内容、材料、产品（包括软件）和服务、其服务器或从本站发出的电子信件、信息没有病毒或其他有害成分。</strong></span></p><p><span style=\"font-size: 12px;\"><strong>如因不可抗力或其它本站无法控制的原因使本站销售系统崩溃或无法正常使用导致网上交易无法完成或丢失有关的信息、记录等，金嵘会合理地尽力协助处理善后事宜。</strong></span></p><h5><span style=\"font-size: 12px;\">第10条 协议更新及用户关注义务</span></h5><p><span style=\"font-size: 12px;\">根据国家法律法规变化及网站运营需要，金嵘有权对本协议条款不时地进行修改，修改后的协议一旦被张贴在本站上即生效，并代替原来的协议。用户可随时登陆查阅最新协议；<strong><em>用户有义务不时关注并阅读最新版的协议及网站公告。如用户不同意更新后的协议，可以且应立即停止接受金嵘网站依据本协议提供的服务；如用户继续使用本网站提供的服务的，即视为同意更新后的协议。金嵘建议您在使用本站之前阅读本协议及本站的公告。</em></strong>&nbsp;如果本协议中任何一条被视为废止、无效或因任何理由不可执行，该条应视为可分的且并不影响任何其余条款的有效性和可执行性。</span></p><h5><span style=\"font-size: 12px;\">第11条 法律管辖和适用</span></h5><p><span style=\"font-size: 12px;\">本协议的订立、执行和解释及争议的解决均应适用在中华人民共和国大陆地区适用之有效法律（但不包括其冲突法规则）。 如发生本协议与适用之法律相抵触时，则这些条款将完全按法律规定重新解释，而其它有效条款继续有效。 如缔约方就本协议内容或其执行发生任何争议，双方应尽力友好协商解决；协商不成时，任何一方均可向有管辖权的中华人民共和国大陆地区法院提起诉讼。</span></p><h5><span style=\"font-size: 12px;\">第12条 其他</span></h5><p><span style=\"font-size: 12px;\"><strong>12.1</strong>金嵘网站所有者是指在政府部门依法许可或备案的金嵘网站经营主体。</span></p><p><span style=\"font-size: 12px;\"><strong>12.2</strong>金嵘尊重用户和消费者的合法权利，本协议及本网站上发布的各类规则、声明等其他内容，均是为了更好的、更加便利的为用户和消费者提供服务。本站欢迎用户和社会各界提出意见和建议，金嵘将虚心接受并适时修改本协议及本站上的各类规则。</span></p><p><span style=\"font-size: 12px;\"><strong>12.3</strong>本协议内容中以黑体、加粗、下划线、斜体等方式显著标识的条款，请用户着重阅读。</span></p><p><span style=\"font-size: 12px;\"><strong>12.4</strong>您点击本协议下方的&quot;同意并继续&quot;按钮即视为您完全接受本协议，在点击之前请您再次确认已知悉并完全理解本协议的全部内容。</span></p><p><br/></p><p><br/></p>', '<p style=\"line-height: 3em;\"><span style=\"font-size: 14px; font-family: 宋体, SimSun; \"><span style=\"font-family: 宋体,SimSun; font-size: 13px;\"></span>成都金鑫厨房设备维修服务有限公司于2011年5月11日在成都正式成立，原为2001年9月在重庆成立的重庆金鑫厨房设备有限公司成都技术服务中心。 因业务发展需要，2012年1月成都公司升为公司总部，重庆公司变为分公司；2012年10月设立云南分公司（昆明厨友厨房设备有限公司）；现正筹备贵州分公司，预计2013年4月开始以技术服务中心方式运行，6月之前分公司挂牌。&nbsp; d <br/></span></p>');

-- ----------------------------
-- Table structure for company
-- ----------------------------
DROP TABLE IF EXISTS `company`;
CREATE TABLE `company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cname` varchar(100) DEFAULT NULL COMMENT '公司名称',
  `ctype` int(11) DEFAULT NULL COMMENT '公司类型(总、子)',
  `caddress` varchar(255) DEFAULT NULL COMMENT '公司地址',
  `caddress_image_url` varchar(100) DEFAULT NULL COMMENT '公司地址图片',
  `cphone` varchar(50) DEFAULT NULL COMMENT '公司电话',
  `cfax` varchar(50) DEFAULT NULL COMMENT '公司传真',
  `product_service` int(11) DEFAULT NULL COMMENT '产品服务中心',
  `fitting_service` int(11) DEFAULT NULL COMMENT '配件服务中心',
  `kitchen_fitting_service` int(11) DEFAULT NULL COMMENT '厨房配件服务中心',
  `rental_service` int(11) DEFAULT NULL COMMENT '租凭服务中心',
  `cimage_url` varchar(100) DEFAULT NULL COMMENT '公司图片',
  `sales_qq` int(11) DEFAULT NULL COMMENT '销售服务QQ',
  `customer_qq` int(11) DEFAULT NULL COMMENT '客户服务QQ',
  `leasing_qq` int(11) DEFAULT NULL COMMENT '租赁服务QQ',
  `area_name` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `complaints_qq` int(11) DEFAULT NULL COMMENT '投诉服务qq',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of company
-- ----------------------------
INSERT INTO `company` VALUES ('3', '成都金嵘厨房设备维修服务有限公司', '0', '成都市青羊区锦屏南路18号', '../../jrdir/-6807940684955301107_.png', '028-87372786', '028-87372786', null, null, null, null, '../../jrdir/-5225632222817205625_.png', '531490465', '805240453', '657261109', '成都区域', 'jr@email.com', '657261109');
INSERT INTO `company` VALUES ('4', '重庆金嵘厨房设备维修服务有限公司', '1', '重庆市大渡口区翠柏路78号', '../../jrdir/4695299553735559420_.png', '028-87372786', '028-87372786', null, null, null, null, '../../jrdir/-3212118906295401414_.png', '0', '0', '0', '重庆区域', null, '0');

-- ----------------------------
-- Table structure for company_team
-- ----------------------------
DROP TABLE IF EXISTS `company_team`;
CREATE TABLE `company_team` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(100) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL COMMENT '姓名',
  `job_desc` varchar(100) DEFAULT NULL COMMENT '职位描述',
  `custom_sort` int(11) DEFAULT NULL,
  `job_info` text COMMENT '详细描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='公司团队信息表';

-- ----------------------------
-- Records of company_team
-- ----------------------------
INSERT INTO `company_team` VALUES ('1', '../../jrdir/3904355900641134082_.jpg', '杜嵘', '金嵘创始人', '1', 'xx先生于1999年加入xx行业，先后服于xxx等公司，从事过市场，产品，销售等方面的管理工作；在创立xx前，xxx曾任xxx副总裁，全程参与xxx的设立，发展，负责媒体运营以及广告等方面的工作，于2010年创办xx。');
INSERT INTO `company_team` VALUES ('2', '', '程钧', '制冷与空调作业、焊接与热切割作业和电工作业专业技术人员', '2', 'xx先生于1999年加入xx行业，先后服于xxx等公司，从事过市场，产品，销售等方面的管理工作；在创立xx前，xxx曾任xxx副总裁，全程参与xxx的设立，发展，负责媒体运营以及广告等方面的工作，于2010年创办xx。');

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(100) DEFAULT NULL COMMENT '客户名字',
  `image_url` varchar(100) DEFAULT NULL COMMENT '图片路径',
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='产品客户关联信息表';

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES ('3', '冰雪皇后', '/../jrdir/-7066841626416166429_.png', 'ASD');
INSERT INTO `customer` VALUES ('4', '哈根哒斯', '/../jrdir/2904194773635124180_.png', 'ASD');
INSERT INTO `customer` VALUES ('5', '好利来', '/../jrdir/-773179043233181732_.png', 'sd');
INSERT INTO `customer` VALUES ('6', '德克士', '/../jrdir/2036407380483067095_.png', 'SD');
INSERT INTO `customer` VALUES ('7', '仁和春天', '/../jrdir/2426962575298412920_.png', 'sd');

-- ----------------------------
-- Table structure for device_type
-- ----------------------------
DROP TABLE IF EXISTS `device_type`;
CREATE TABLE `device_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fitting_use` varchar(30) DEFAULT NULL COMMENT '配件用途分类',
  `fitting_use_desc` varchar(255) DEFAULT NULL COMMENT '配件用途分类描述',
  `fitting_category` varchar(30) DEFAULT NULL COMMENT '配件归类分类',
  `fitting_category_desc` varchar(255) DEFAULT NULL COMMENT '配件归类分类描述',
  `product_use` varchar(30) DEFAULT NULL COMMENT '产品自定义分类',
  `product_use_desc` varchar(255) DEFAULT NULL COMMENT '产品用途分类描述',
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_use_unique` (`product_use`),
  UNIQUE KEY `fitting_category_unique` (`fitting_category`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='设备类型信息表';

-- ----------------------------
-- Records of device_type
-- ----------------------------
INSERT INTO `device_type` VALUES ('1', null, null, null, null, '专业意式咖啡机11', '');
INSERT INTO `device_type` VALUES ('2', null, null, null, null, '小型全自动咖啡机', null);
INSERT INTO `device_type` VALUES ('3', null, null, null, null, '大型全自动咖啡机', null);
INSERT INTO `device_type` VALUES ('4', null, null, null, null, '磨豆机', null);
INSERT INTO `device_type` VALUES ('5', null, null, null, null, '美式滴滤机', null);
INSERT INTO `device_type` VALUES ('6', null, null, null, null, '西餐炉具', null);
INSERT INTO `device_type` VALUES ('7', null, null, null, null, '烤箱', null);
INSERT INTO `device_type` VALUES ('8', null, null, null, null, '制冰机和制冷设备', null);
INSERT INTO `device_type` VALUES ('9', null, null, null, null, '洗碗机', null);
INSERT INTO `device_type` VALUES ('10', null, null, null, null, '酒吧设备', null);
INSERT INTO `device_type` VALUES ('11', null, null, null, null, '面包房和烘焙设备', null);
INSERT INTO `device_type` VALUES ('12', null, null, null, null, '洗衣房设备', null);
INSERT INTO `device_type` VALUES ('13', null, null, null, null, '食品加工设备', '');
INSERT INTO `device_type` VALUES ('14', null, null, null, null, '快餐设备', null);
INSERT INTO `device_type` VALUES ('15', null, null, null, null, '保温展示设备', null);
INSERT INTO `device_type` VALUES ('16', null, null, '压缩机及其附件', '类别描述类别描述类别描述', null, null);
INSERT INTO `device_type` VALUES ('17', null, null, '门中柱', '', null, null);
INSERT INTO `device_type` VALUES ('18', null, null, '门封条', '', null, null);
INSERT INTO `device_type` VALUES ('19', null, null, '控制器及其附件', '', null, null);
INSERT INTO `device_type` VALUES ('20', null, null, '加热管（丝）', '', null, null);
INSERT INTO `device_type` VALUES ('24', null, null, '	其他零件', '', null, null);

-- ----------------------------
-- Table structure for document_library
-- ----------------------------
DROP TABLE IF EXISTS `document_library`;
CREATE TABLE `document_library` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `major_category_id` int(11) DEFAULT NULL,
  `small_category_id` int(11) DEFAULT NULL,
  `file_name` varchar(50) DEFAULT NULL,
  `file_type` varchar(5) DEFAULT NULL,
  `file_url` varchar(100) DEFAULT NULL,
  `video_name` varchar(50) DEFAULT NULL,
  `video_desc` varchar(255) DEFAULT NULL,
  `video_url` varchar(100) DEFAULT NULL,
  `video_type` varchar(5) DEFAULT NULL,
  `save_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COMMENT='文档库信息表';

-- ----------------------------
-- Records of document_library
-- ----------------------------
INSERT INTO `document_library` VALUES ('20', '6', '11', 'Starbacks成都财富中心店咖啡机维护保养报告', '.swf', '../../jrdir/4874965020840379790_.swf', '-2247301418093427096_', '', '../../jrdir/4552173633035323282_.flv', '.flv', '2013-12-20 11:53:03');
INSERT INTO `document_library` VALUES ('25', '6', '11', 'Starbacks成都倍特店咖啡机维护保养报告', '.swf', '../../jrdir/8366194528249269813_.swf', '', '', '', '', '2013-12-29 00:04:00');
INSERT INTO `document_library` VALUES ('26', '6', '11', 'Starbacks成都财富中心店咖啡机维护保养报告', '.swf', '../../jrdir/-6661110337254568370_.swf', '', '', '', '', '2013-12-29 00:04:18');
INSERT INTO `document_library` VALUES ('27', '6', '10', 'Starbacks成都东御店咖啡机维护保养报告', '.swf', '../../jrdir/1247186809313641058_.swf', '', '', '', '', '2013-12-29 00:05:00');
INSERT INTO `document_library` VALUES ('28', '6', '10', 'Starbacks成都广场店咖啡机维护保养报告', '.swf', '../../jrdir/-2239040117788294239_.swf', '', '', '', '', '2013-12-29 00:05:16');
INSERT INTO `document_library` VALUES ('29', '6', '11', 'Starbacks成都财富中心店咖啡机维护保养报告', '.swf', '../../jrdir/3138069988266952828_.swf', '', '', '', '', '2013-12-29 00:05:30');
INSERT INTO `document_library` VALUES ('30', '6', '11', 'Starbacks成都威斯顿店咖啡机维护保养报告', '.swf', '../../jrdir/-4905926048497120025_.swf', '', '', '', '', '2013-12-29 00:05:59');
INSERT INTO `document_library` VALUES ('31', '5', '11', '德克士X店设备年度维护保养报告', '.swf', '../../jrdir/-5050019726377398523_.swf', '', '', '', '', '2013-12-29 01:32:54');
INSERT INTO `document_library` VALUES ('32', '5', '10', '德克士成都XX店设备维护保养报告', '.swf', '../../jrdir/-5259311493253675398_.swf', '', '', '', '', '2013-12-29 01:33:10');
INSERT INTO `document_library` VALUES ('33', '5', '11', 'Manitowoc制冰机年度维护保养检查表', '.swf', '../../jrdir/-5521848899151968625_.swf', '', '', '', '', '2013-12-29 01:33:33');
INSERT INTO `document_library` VALUES ('34', '5', '11', 'SANYO冷冻、冷藏冰箱年度维护保养检查表-1', '.swf', '../../jrdir/-3153082300790258285_.swf', '', '', '', '', '2013-12-29 01:33:48');
INSERT INTO `document_library` VALUES ('35', '5', '11', 'SANYO冷冻、冷藏冰箱年度维护保养检查表-2', '.swf', '../../jrdir/9220966280411695521_.swf', '', '', '', '', '2013-12-29 01:34:01');
INSERT INTO `document_library` VALUES ('36', '5', '11', 'SANYO冷冻、冷藏冰箱年度维护保养检查表-3', '.swf', '../../jrdir/-5231369376906588206_.swf', '', '', '', '', '2013-12-29 01:34:48');
INSERT INTO `document_library` VALUES ('37', '5', '10', 'SANYO蔬果冷藏冰箱年度维护保养检查表', '.swf', '../../jrdir/5320644997627201414_.swf', '', '', '', '', '2013-12-29 01:35:01');
INSERT INTO `document_library` VALUES ('38', '5', '11', 'Taylor圣代机年度维护保养检查表', '.swf', '../../jrdir/4342114785993704783_.swf', '', '', '', '', '2013-12-29 01:35:17');
INSERT INTO `document_library` VALUES ('39', '5', '11', 'Starb煎板系列年度维护保养检查表', '.swf', '../../jrdir/-6971454524852584040_.swf', '', '', '', '', '2013-12-29 01:35:30');
INSERT INTO `document_library` VALUES ('40', '5', '11', '冷冻库年度维护保养检查表', '.swf', '../../jrdir/4511905683644565719_.swf', '', '', '', '', '2013-12-29 01:35:46');
INSERT INTO `document_library` VALUES ('41', '5', '11', 'Starb薯条冷冻冰箱年维护保养养检查表', '.swf', '../../jrdir/-1341897311499499391_.swf', '', '', '', '', '2013-12-29 01:36:02');
INSERT INTO `document_library` VALUES ('42', '4', '11', '炸锅系列年度维护保养检查表-22', '.swf', '../../jrdir/8589575102853107441_.swf', '', '', '', '', '2013-12-29 01:36:19');
INSERT INTO `document_library` VALUES ('43', '4', '11', '德克士成都总府店设备年度维护保养报告', '.swf', '../../jrdir/2860787605435272742_.swf', '', '', '', '', '2013-12-29 01:36:52');
INSERT INTO `document_library` VALUES ('44', '3', '12', '测试', '.swf', '../../jrdir/-7462075033064092310_.swf', '', '', '', '', '2013-12-29 15:24:48');
INSERT INTO `document_library` VALUES ('53', '4', '11', 'Starbacks成都财富中心店咖啡机维护保养报告0.', '.swf', 'uploadfile/e01b3ef5eb7501e06952c831de90b8d4.swf', '测试视频', '', 'uploadfile/24a071ef284bb24f1959f9252afb98f0.flv', '.flv', '2014-01-07 23:02:10');

-- ----------------------------
-- Table structure for document_type
-- ----------------------------
DROP TABLE IF EXISTS `document_type`;
CREATE TABLE `document_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `major_category` varchar(50) DEFAULT NULL,
  `major_category_desc` varchar(255) DEFAULT NULL,
  `small_category` varchar(50) DEFAULT NULL,
  `small_category_desc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `major_category_unique` (`major_category`),
  UNIQUE KEY `small_category_unique` (`small_category`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='文档库类型信息表';

-- ----------------------------
-- Records of document_type
-- ----------------------------
INSERT INTO `document_type` VALUES ('1', '煎炸设备', '煎炸设备_desc', null, null);
INSERT INTO `document_type` VALUES ('2', '烘焙设备', '烘焙设备_desc\nasdf', null, null);
INSERT INTO `document_type` VALUES ('3', '制冷设备', '制冷设备_desc\n', null, null);
INSERT INTO `document_type` VALUES ('4', '热饮设备', '', null, null);
INSERT INTO `document_type` VALUES ('5', '咖啡设备', '', null, null);
INSERT INTO `document_type` VALUES ('6', '配套设备', '', null, null);
INSERT INTO `document_type` VALUES ('10', null, null, '产品说明书', '产品说明书-sadf\n');
INSERT INTO `document_type` VALUES ('11', null, null, '维护保养手册', '维护保养手册');
INSERT INTO `document_type` VALUES ('12', null, null, '测试', '');

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `users_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL COMMENT '所属公司',
  `ename` varchar(20) DEFAULT NULL COMMENT '员工姓名',
  `ephone` varchar(50) DEFAULT NULL COMMENT '员工手机',
  `ejob` varchar(50) DEFAULT NULL COMMENT '职位',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='员工信息表';

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES ('1', '1', null, '超级管理员', '', '');
INSERT INTO `employee` VALUES ('2', '3', null, '朱彬', '15828019062', 'wdgf');
INSERT INTO `employee` VALUES ('3', '4', null, '蔡勇军', '15828019022', 'xx');
INSERT INTO `employee` VALUES ('6', '7', null, '杜嵘', '', '');
INSERT INTO `employee` VALUES ('7', '8', null, '蒋宇', '', '');

-- ----------------------------
-- Table structure for fitting
-- ----------------------------
DROP TABLE IF EXISTS `fitting`;
CREATE TABLE `fitting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_user` int(11) DEFAULT NULL,
  `fitting_name` varchar(50) DEFAULT NULL COMMENT '配件名称',
  `device_type_use_id` int(11) DEFAULT NULL COMMENT '配件用途分类',
  `device_type_sort_id` int(11) DEFAULT NULL COMMENT '配件归类分类',
  `brand` varchar(50) DEFAULT NULL COMMENT '品牌',
  `fitting_number` varchar(50) DEFAULT NULL COMMENT '配件编号',
  `specification_desc` varchar(255) DEFAULT NULL COMMENT '规格描述',
  `models` varchar(255) DEFAULT NULL COMMENT '适用型号',
  `image_url` varchar(100) DEFAULT NULL COMMENT '图片路径',
  `fitting_desc` text COMMENT '配件描述',
  `sale_protection` text COMMENT '售后保障',
  `stock` int(11) DEFAULT NULL COMMENT '库存',
  `taobao_links` varchar(255) DEFAULT NULL COMMENT '淘宝链接',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fitting_name_unique` (`fitting_name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='配件信息表';

-- ----------------------------
-- Records of fitting
-- ----------------------------
INSERT INTO `fitting` VALUES ('4', null, '配件名称2', '10', '17', '品牌3', '配件编号4', '规格描述23', '适用型号5', '/../jrdir/4886537856275926017_.png', '<p><span style=\"font-size: 13px;\"><strong>服务承诺：</strong><br/>\n	京东商城向您保证所售商品均为正品行货，京东自营商品开具机打发票及电子发票。凭质保证书及京东商城发票，可享受全国联保服务（奢侈品、钟表除外；奢侈\n品、钟表由京东联系保修，享受法定三包售后服务），与您亲临商场选购的商品享受相同的质量保证。京东商城还为您提供具有竞争力的商品价格和</span><a style=\"font-size: 13px; text-decoration: underline;\" href=\"http://www.jd.com/help/kdexpress.aspx\" target=\"_blank\"><span style=\"font-size: 13px;\">运费政策</span></a><span style=\"font-size: 13px;\">，请您放心购买！	<br/><br/>\n	注：因厂家会在没有任何提前通知的情况下更改产品包装、产地或者一些附件，本司不能确保客户收到的货物与商城图片、产地、附件说明完全一致。只能确保为原厂正货！并且保证与当时市场上同样主流新品一致。若本商城没有及时更新，请大家谅解！</span></p><p><span style=\"font-size: 13px;\"><strong>权利声明：</strong><br/>京东商城上的所有商品信息、客户评价、商品咨询、网友讨论等内容，是京东商城重要的经营资源，未经许可，禁止非法转载使用。	</span></p><p><span style=\"font-size: 13px;\"><strong>注：</strong>本站商品信息均来自于厂商，其真实性、准确性和合法性由信息拥有者（厂商）负责。本站不提供任何保证，并不承担任何法律责任。</span></p><p><br/></p>', '<p><span style=\"font-size: 13px;\">本产品质保期为：<br/></span></p><p><br/></p><p><span style=\"font-size: 13px;\"><strong>服务承诺：</strong><br/>\n	京东商城向您保证所售商品均为正品行货，京东自营商品开具机打发票及电子发票。凭质保证书及京东商城发票，可享受全国联保服务（奢侈品、钟表除外；奢侈\n品、钟表由京东联系保修，享受法定三包售后服务），与您亲临商场选购的商品享受相同的质量保证。京东商城还为您提供具有竞争力的商品价格和</span><a style=\"font-size: 13px; text-decoration: underline;\" href=\"http://www.jd.com/help/kdexpress.aspx\" target=\"_blank\"><span style=\"font-size: 13px;\">运费政策</span></a><span style=\"font-size: 13px;\">，请您放心购买！	<br/><br/>\n	注：因厂家会在没有任何提前通知的情况下更改产品包装、产地或者一些附件，本司不能确保客户收到的货物与商城图片、产地、附件说明完全一致。只能确保为原厂正货！并且保证与当时市场上同样主流新品一致。若本商城没有及时更新，请大家谅解！</span></p><p><span style=\"font-size: 13px;\"><strong>权利声明：</strong><br/>京东商城上的所有商品信息、客户评价、商品咨询、网友讨论等内容，是京东商城重要的经营资源，未经许可，禁止非法转载使用。	</span></p><p><span style=\"font-size: 13px;\"><strong>注：</strong>本站商品信息均来自于厂商，其真实性、准确性和合法性由信息拥有者（厂商）负责。本站不提供任何保证，并不承担任何法律责任。</span></p><p><br/></p>', '12', 'http://localhost:8980/jrplatform/system/index');
INSERT INTO `fitting` VALUES ('7', null, 'asdf', '14', '16', '品牌', '配件编号', '85', '232323ads', '/../jrdir/2926131047009045975_.png', '<p>asdf<br/></p>', '<p>sdf<br/></p>', '32', 'http://localhost:8980/jrplatform/system/index');
INSERT INTO `fitting` VALUES ('8', null, '测试配件', '15', '19', '1', '', '', 'FAM-DS199HM;FAM-DS199HM;', '', '', '', '22', '');

-- ----------------------------
-- Table structure for fitting_page
-- ----------------------------
DROP TABLE IF EXISTS `fitting_page`;
CREATE TABLE `fitting_page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text,
  `image_url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='配件主页数据信息表';

-- ----------------------------
-- Records of fitting_page
-- ----------------------------
INSERT INTO `fitting_page` VALUES ('1', '<p class=\"pro_desc_p\" style=\"line-height: 25px; color: rgb(102, 102, 102); font-family: &#39;Microsoft YaHei&#39;, &#39;Segoe UI&#39;, Helvetica, Arial, sans-serif, simsun; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255); \">如果你自己维修设备，那么你需要有一个稳定的配件供应资源。我们专注于原厂配件， 库存超过600万美元的原厂零件，能够确保在您需要配件的时候，可以当天发货。 我们知道，反应时间对您来说很重要，所以通常来说，我们当天发货！</p><p>我 们 的 服 务 理 念 是：</p><p><em><strong>诚信经营 务实服务</strong></em></p><p><em><strong><br/></strong></em></p><p><br/></p>', null);

-- ----------------------------
-- Table structure for growing_process
-- ----------------------------
DROP TABLE IF EXISTS `growing_process`;
CREATE TABLE `growing_process` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `about_id` int(11) DEFAULT NULL COMMENT '关于金嵘信息表',
  `month_date` int(11) DEFAULT NULL,
  `year_date` int(11) DEFAULT NULL COMMENT '日期',
  `stage_desc` varchar(255) DEFAULT NULL COMMENT '简要描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='公司发展历程信息表';

-- ----------------------------
-- Records of growing_process
-- ----------------------------
INSERT INTO `growing_process` VALUES ('4', null, '9', '2001', '成立重庆金鑫厨房设备有限公司成都技术服务中心');
INSERT INTO `growing_process` VALUES ('5', null, '5', '2011', '成立成都金鑫厨房设备维修服务有限公司');
INSERT INTO `growing_process` VALUES ('6', null, '1', '2012', '2012年1月成都公司升为公司总部，重庆公司变为分公司');
INSERT INTO `growing_process` VALUES ('7', null, '10', '2012', '设立云南分公司（昆明厨友厨房设备有限公司）');
INSERT INTO `growing_process` VALUES ('8', null, '10', '2013', '现正筹备贵州分公司，预计2013年4月开始以技术服务中心方式运行，6月之前分公司挂牌现正筹备贵州分公司，预计2013年4月开始以技术服务中心方式运行，6月之前分公司');

-- ----------------------------
-- Table structure for lease_page
-- ----------------------------
DROP TABLE IF EXISTS `lease_page`;
CREATE TABLE `lease_page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text,
  `contract_name` varchar(50) DEFAULT NULL,
  `contract_url` varchar(100) DEFAULT NULL,
  `image_url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='配件主页数据信息表';

-- ----------------------------
-- Records of lease_page
-- ----------------------------
INSERT INTO `lease_page` VALUES ('2', '<ul style=\"list-style-type: square;\" class=\" list-paddingleft-2\"><li><p><span style=\"font-size: 12px; \">成都区域租凭服务中心</span></p></li><ul style=\"list-style-type: circle;\" class=\" list-paddingleft-2\"><li><p><span style=\"font-size: 12px; \">15828019062/028-87372786（市场部经理：周云）</span></p></li></ul><li><p><span style=\"font-size: 12px; \">昆明区域租凭服务中心</span></p></li><ul style=\"list-style-type: circle;\" class=\" list-paddingleft-2\"><li><p><span style=\"font-size: 12px; \">15828019062/028-87372786（市场部经理：周云）</span></p></li></ul><li><p><span style=\"font-size: 12px; \">重庆区域租凭服务中心</span></p></li><ul style=\"list-style-type: circle;\" class=\" list-paddingleft-2\"><li><p><span style=\"font-size: 12px; \">15828019062/028-87372786（市场部经理：周云）</span></p></li></ul></ul>', '资源云存储接口-协议1.0.doc', 'uploadfile/src/a182beb65e4c93d67b0d466436046541.doc', null);

-- ----------------------------
-- Table structure for maintenance_category
-- ----------------------------
DROP TABLE IF EXISTS `maintenance_category`;
CREATE TABLE `maintenance_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `repair_service_id` int(11) DEFAULT NULL COMMENT '维修服务信息表',
  `title` varchar(50) DEFAULT NULL COMMENT '标题',
  `content` varchar(255) DEFAULT NULL COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='维修设备种信息表';

-- ----------------------------
-- Records of maintenance_category
-- ----------------------------
INSERT INTO `maintenance_category` VALUES ('3', null, '煎炸设备', '电炸炉(锅)，如Frymaster、Toastmaster、Pitco\n各种煎板，如Toastmaster、Sater、Nayati\n');
INSERT INTO `maintenance_category` VALUES ('4', null, '烘焙设备', '烤箱，如Middleby Marshall、Rational、Houno\n各种烤面包机');
INSERT INTO `maintenance_category` VALUES ('5', null, '制冷设备', '制冰机，如Scotsman、Hoshizaki、Manitowoc(万利多)\n圣代机，如Carpigiani、Taylor\n冰箱(柜) ，如Sanyo、Hoshizaki、Willians\n果汁机，如Crathco、Jetspray');
INSERT INTO `maintenance_category` VALUES ('6', null, '热饮设备', '各种开水机，如BUNN、A.O史密斯、JUNNUO\n各种热饮机');
INSERT INTO `maintenance_category` VALUES ('7', null, '咖啡设备', '咖啡机，如LaMarzocco、Columbia、BUNN-O-MATIC、SM（圣马可）\n各种咖啡磨豆机，如Grindmaster、Mazzer');
INSERT INTO `maintenance_category` VALUES ('8', null, '配套设备', '各种过虑水系统，如EVERPURE\n厨房空调系统\n冻库设备，如Sanyo\n');

-- ----------------------------
-- Table structure for maintenance_report_card
-- ----------------------------
DROP TABLE IF EXISTS `maintenance_report_card`;
CREATE TABLE `maintenance_report_card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(50) DEFAULT NULL COMMENT '文件名称',
  `file_url` varchar(100) DEFAULT NULL COMMENT '文件类型',
  `file_type` varchar(5) DEFAULT NULL COMMENT '文件类型',
  `file_desc` varchar(255) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='维修报告单信息表';

-- ----------------------------
-- Records of maintenance_report_card
-- ----------------------------

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `content` text COMMENT '内容',
  `publish_time` datetime DEFAULT NULL COMMENT '发表时间',
  `count` int(11) DEFAULT NULL COMMENT '查看次数',
  `image_url` varchar(50) DEFAULT NULL COMMENT '图片URL',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='新闻资讯信息表';

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES ('4', '私家车停占消防通道多日车身被刮花(图)', '<p style=\"margin-top: 15px; margin-bottom: 15px; padding: 0px; font-size: 14px; line-height: 23px; color: rgb(51, 51, 51); font-family: 宋体; white-space: normal; background-color: rgb(255, 255, 255);\">南宁市青山路一小区内，一辆名贵跑车占用消防通道停放多天，居民车辆经过不便，同时也带来消防隐患。12月14日，车主终于出现，但取车时其发现车辆被刮花，于是与小区物业理论。</p><p style=\"margin-top: 15px; margin-bottom: 15px; padding: 0px; font-size: 14px; line-height: 23px; color: rgb(51, 51, 51); font-family: 宋体; white-space: normal; background-color: rgb(255, 255, 255);\">　　“跑车从12月10日开进来，停在小区消防通道上有4天了，占了半边车道，其他小车经过都要小心翼翼才行。”住户陈女士称，她每天回家必经这条通道。这几天，一到上下班时间，通道均有阻塞现象，原因与这辆跑车乱停放有关。当日下午，记者赶到小区时，车主已经把车从消防通道上开走，但事情并没有了结，车主又将车堵在小区物业处门口。</p><p style=\"margin-top: 15px; margin-bottom: 15px; padding: 0px; font-size: 14px; line-height: 23px; color: rgb(51, 51, 51); font-family: 宋体; white-space: normal; background-color: rgb(255, 255, 255);\">　　在小区物业门口，记者看到了这辆黄色名贵跑车。车身贴着物业公司开的违章停车单，车头挂有外地车牌号，而车后的车牌已掉落，整个车身多处有被刮伤的痕迹。物业门前也是一条小区过道，跑车这么一停，同样占道影响到车辆经过。</p><p style=\"margin-top: 15px; margin-bottom: 15px; padding: 0px; font-size: 14px; line-height: 23px; color: rgb(51, 51, 51); font-family: 宋体; white-space: normal; background-color: rgb(255, 255, 255);\">　　“车主把车堵在门口后，还没能与物业协商下来，车主就丢车离开了。”有知情人称，车主来取车发现车身受损后，认为自己的车违章乱停可以接受处理，但车莫名被刮花，让人难接受。车主认为跑车是停在小区后遭人为所致，于是想讨个说法。</p><p style=\"margin-top: 15px; margin-bottom: 15px; padding: 0px; font-size: 14px; line-height: 23px; color: rgb(51, 51, 51); font-family: 宋体; white-space: normal; background-color: rgb(255, 255, 255);\">　　“我们在小区消防通道都立有提醒牌，可有些车主却视而不见。发现乱停车后，我们寻找车主也比较难。”物业人员说，之前他们一直找不到车主，本想“实在找不到，就考虑报警，让民警来处理了”。</p><p style=\"margin-top: 15px; margin-bottom: 15px; padding: 0px; font-size: 14px; line-height: 23px; color: rgb(51, 51, 51); font-family: 宋体; white-space: normal; background-color: rgb(255, 255, 255);\">　　12月14日，物业人员终于盼来跑车车主，但没想到又要与车主处理车辆受损的问题。一小区物业人员称，跑车到底是不是在小区被刮，现在还没有定论，且当天报警后民警也过来调查了，不过结果还没有出来。(《南国早报》记者 何定坚)</p><p><br/></p>', '2013-12-17 00:04:08', '25', '../../jrdir/3733663888532260060_.jpg');
INSERT INTO `news` VALUES ('5', '男子26元存款55年后想取遭拒 银行称他要倒给钱', '<p style=\"margin-top: 15px; margin-bottom: 15px; padding: 0px; font-size: 14px; line-height: 23px; color: rgb(51, 51, 51); font-family: 宋体; white-space: normal; background-color: rgb(255, 255, 255);\">　红网长沙县站12月16日讯(分站记者 陈登辉) 1958年在农村信用合作社存了26元钱，时隔55年后，这钱还取得出来么？长沙县春华镇松元村的龙孟雄觉得，自己叔父留下的这笔跨越半个世纪的存款，应该要兑现，而且是本息一起；而已经“改头换面”的信用社———湖南星沙农村商业银行春华分行的相关负责人则表示，这存款无法兑付。</p><p style=\"margin-top: 15px; margin-bottom: 15px; padding: 0px; font-size: 14px; line-height: 23px; color: rgb(51, 51, 51); font-family: 宋体; white-space: normal; background-color: rgb(255, 255, 255);\">　　<strong>纠结：想取存款却屡屡遭拒</strong></p><p style=\"margin-top: 15px; margin-bottom: 15px; padding: 0px; font-size: 14px; line-height: 23px; color: rgb(51, 51, 51); font-family: 宋体; white-space: normal; background-color: rgb(255, 255, 255);\">　　上周五，记者来到春华镇松元村，见到了龙孟雄。传说中跨越半个多世纪的存款单，被他小心翼翼地折在烟盒里，随身携带着。</p><p style=\"margin-top: 15px; margin-bottom: 15px; padding: 0px; font-size: 14px; line-height: 23px; color: rgb(51, 51, 51); font-family: 宋体; white-space: normal; background-color: rgb(255, 255, 255);\">　　记者看到，三张存款单上的户名均为龙汉湘。“他是我叔父，以前也住这个村，后来搬到株洲去了。”龙孟雄告诉记者，叔父前两年过世后，婶婶在清理其遗物时，意外地发现了这三张1958年的存款单，便将单子给了仍居住在松元村的龙孟雄。</p><p style=\"margin-top: 15px; margin-bottom: 15px; padding: 0px; font-size: 14px; line-height: 23px; color: rgb(51, 51, 51); font-family: 宋体; white-space: normal; background-color: rgb(255, 255, 255);\">　　这三张存款有两张的字迹清晰，且为繁体字，可以看到存款日期分别是1958年的4月20日、5月14日和8月16日，金额为13元、7元和6元，有两张单据上写着存款为3个月定期。单子上还印有“长沙县九木乡天河信用合作社”的公章。</p><p style=\"margin-top: 15px; margin-bottom: 15px; padding: 0px; font-size: 14px; line-height: 23px; color: rgb(51, 51, 51); font-family: 宋体; white-space: normal; background-color: rgb(255, 255, 255);\">　　“去年我拿到单子后，就去找了信用社，现在已改成银行。”龙孟雄称，他第一次去取钱时，是一位蒋姓大堂经理接待了他。然而该经理表示，存款无法兑付。不甘心的龙孟雄随后又找到了该分行的周行长。“他跟我说，这些钱是当时的土粪钱(当时老百姓可以将自家饲养家禽所产生的粪便，送去生产队当肥料，换取一定收益)，只能给我退个本金，也就是那26元。”龙孟雄告诉记者。</p><p style=\"margin-top: 15px; margin-bottom: 15px; padding: 0px; font-size: 14px; line-height: 23px; color: rgb(51, 51, 51); font-family: 宋体; white-space: normal; background-color: rgb(255, 255, 255);\">　　<strong>答复：得先查了历史账再说</strong></p><p style=\"margin-top: 15px; margin-bottom: 15px; padding: 0px; font-size: 14px; line-height: 23px; color: rgb(51, 51, 51); font-family: 宋体; white-space: normal; background-color: rgb(255, 255, 255);\">　　龙孟雄的叔父，在1958年存钱的那家农村合作信用社，如今已改为湖南星沙农村商业银行春华分行。该银行的周行长表示，已经跟龙孟雄解释过这26元存款无法兑现的相关政策，龙孟雄还去找过他们总行，而总行也曾答复过。他还表示，其他的具体问题，要咨询总行。</p><p style=\"margin-top: 15px; margin-bottom: 15px; padding: 0px; font-size: 14px; line-height: 23px; color: rgb(51, 51, 51); font-family: 宋体; white-space: normal; background-color: rgb(255, 255, 255);\">　　该行总行的工作人员则表示，因为年代久远，且他们经历了多次改制，如果龙孟雄一定要取出这26元钱，还得先查历史账户再说。</p><p style=\"margin-top: 15px; margin-bottom: 15px; padding: 0px; font-size: 14px; line-height: 23px; color: rgb(51, 51, 51); font-family: 宋体; white-space: normal; background-color: rgb(255, 255, 255);\">　　记者了解到，龙孟雄这55年存款难兑现的事情，上周经市里媒体报道后，分行的这位周行长曾再次找到他，称存款肯定取不出。“我觉得这钱是应该算数的，就算取不出，也应该给我一个说法。”龙孟雄说道。</p><p style=\"margin-top: 15px; margin-bottom: 15px; padding: 0px; font-size: 14px; line-height: 23px; color: rgb(51, 51, 51); font-family: 宋体; white-space: normal; background-color: rgb(255, 255, 255);\">　　<strong>算账：存单本息合计约为31.5元？</strong></p><p style=\"margin-top: 15px; margin-bottom: 15px; padding: 0px; font-size: 14px; line-height: 23px; color: rgb(51, 51, 51); font-family: 宋体; white-space: normal; background-color: rgb(255, 255, 255);\">　　其实，龙孟雄看中的，并不是这26元存款，而是55年来，利滚利的利息，“我算了一下，大概有2万多天，利息应该有七八万元。”</p><p style=\"margin-top: 15px; margin-bottom: 15px; padding: 0px; font-size: 14px; line-height: 23px; color: rgb(51, 51, 51); font-family: 宋体; white-space: normal; background-color: rgb(255, 255, 255);\">　　然而，这存了55年的26元钱，真的有这么多利息么？星沙某银行的工作人表示，那时的定期存款是不计复利的，也不自动转存的，按存期及存单标明利率计算定期利息，超期部分至取款日一律按取款日活期挂牌利率计息。所以，这三张存单只能按3个月的定期利率计利息，其余54年左右的时间，是现在活期利率计息。</p><p style=\"margin-top: 15px; margin-bottom: 15px; padding: 0px; font-size: 14px; line-height: 23px; color: rgb(51, 51, 51); font-family: 宋体; white-space: normal; background-color: rgb(255, 255, 255);\">　　该工作人员帮记者算了一下，以现在的利率来计算，目前这三张存单本息合计约为31.5元。“如果银行找他收取小额不动户管理费的话，他还要倒给银行不少钱。”</p><p style=\"margin-top: 15px; margin-bottom: 15px; padding: 0px; font-size: 14px; line-height: 23px; color: rgb(51, 51, 51); font-family: 宋体; white-space: normal; background-color: rgb(255, 255, 255);\">　　<strong>相关新闻</strong></p><p style=\"margin-top: 15px; margin-bottom: 15px; padding: 0px; font-size: 14px; line-height: 23px; color: rgb(51, 51, 51); font-family: 宋体; white-space: normal; background-color: rgb(255, 255, 255);\">　　1958年存的80元，信用社“不予兑付”2011年时曾有媒体报道，株洲有一位叫倪树松的老人在1958年将80元存入信用合作社。2009年，倪树松发现存折后，去信用社兑付，不料遭到拒绝。</p><p style=\"margin-top: 15px; margin-bottom: 15px; padding: 0px; font-size: 14px; line-height: 23px; color: rgb(51, 51, 51); font-family: 宋体; white-space: normal; background-color: rgb(255, 255, 255);\">　　当时，该信用联社曾向老人给出的一份答复函称，根据湖南省信用合作管理办公室《关于我省农村信用社一九六一年以前社员老存单(折)能否兑付问题的函》(湘信管办函【2003】006号)和中国人民银行湖南省分行《关于信用社原投资转存款问题的批复》((68)人银信合便字第15号)文件精神，不能兑付。</p><p style=\"margin-top: 15px; margin-bottom: 15px; padding: 0px; font-size: 14px; line-height: 23px; color: rgb(51, 51, 51); font-family: 宋体; white-space: normal; background-color: rgb(255, 255, 255);\">　　<strong>延伸阅读</strong></p><p style=\"margin-top: 15px; margin-bottom: 15px; padding: 0px; font-size: 14px; line-height: 23px; color: rgb(51, 51, 51); font-family: 宋体; white-space: normal; background-color: rgb(255, 255, 255);\">　　1958年的26元，在当时是个什么水平呢？据《扬子晚报》去年10月1日的一篇报道《无锡老人记录50余年开销：油条比1958年涨32倍》中的贺星允老人介绍，1958年，无锡的一副大饼油条只要4分钱，肉是5毛多一斤……当年，她家全年收入为971.2元，支出为798.26元。另据了解，50年代实行的工资制度有两种：一是行政事业单位的24级工资制度；二是企业的8级工资制度。以1959年福建省属煤炭企业工人工资标准为例，当时普通工人每月的工资水平最低为31元(井下33元)，最高为八级的93元(井下105.6元)。</p><p style=\"text-align:right;margin-top: 15px; margin-bottom: 15px; padding: 0px; font-size: 14px; line-height: 23px; color: rgb(51, 51, 51); font-family: 宋体; white-space: normal; background-color: rgb(255, 255, 255);\">(原标题：26元存款55年后想取遭拒 银行：他还要倒给银行不少钱)</p><p><br/></p>', '2013-12-17 00:05:18', '5', '');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_user` int(11) DEFAULT NULL,
  `rental_scroll_mark` int(11) DEFAULT '0' COMMENT '租凭滚动标记',
  `device_type_id` int(11) DEFAULT NULL COMMENT '产品用途分类',
  `product_category` varchar(50) DEFAULT NULL COMMENT '产品分类',
  `product_name` varchar(50) DEFAULT NULL COMMENT '产品名称',
  `brand` varchar(50) DEFAULT NULL COMMENT '品牌',
  `place_origin` varchar(50) DEFAULT NULL COMMENT '产地',
  `model` varchar(50) DEFAULT NULL COMMENT '型号',
  `material` varchar(50) DEFAULT NULL COMMENT '材质',
  `exterior_size` varchar(50) DEFAULT NULL COMMENT '外观尺寸',
  `effective_volume` varchar(50) DEFAULT NULL COMMENT '有效容积',
  `product_weight` varchar(50) DEFAULT NULL COMMENT '产品重量',
  `voltage` varchar(50) DEFAULT NULL COMMENT '电压',
  `electric_current` varchar(50) DEFAULT NULL COMMENT '电流',
  `power` varchar(50) DEFAULT NULL COMMENT '功率',
  `energy` varchar(50) DEFAULT NULL COMMENT '能耗',
  `temperature_range` varchar(50) DEFAULT NULL COMMENT '温度范围',
  `coolant` varchar(50) DEFAULT NULL COMMENT '冷却剂',
  `work_mode` varchar(50) DEFAULT NULL COMMENT '工作方式',
  `capacity` varchar(50) DEFAULT NULL COMMENT '产能',
  `image_url` varchar(100) DEFAULT NULL COMMENT '图片路径',
  `scroll_mark` int(11) DEFAULT '0' COMMENT '产品滚动标记',
  `stock` int(11) DEFAULT NULL COMMENT '库存',
  `taobao_links` varchar(255) DEFAULT NULL COMMENT '淘宝链接',
  `service_range` text COMMENT '服务范围',
  `features` text COMMENT '产品特性',
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_name_unique` (`product_name`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='产品信息表';

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('26', null, '1', '15', '', '四层保温柜', 'SOLIS', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '/../jrdir/446363568935420035_.gif', '1', '1', '', '', '');
INSERT INTO `product` VALUES ('27', null, '1', '12', '', '三合一保温柜（德克士款）', 'GAGGIA', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '/../jrdir/-4718509409014428564_.jpg', '1', '22', '', '<p><span style=\"font-size: 13px;\">本产品质保期为：<br/>\n						\n						</span></p><p>\n			</p><p><span style=\"font-size: 13px;\"><strong>服务承诺：</strong><br/>\n	京东商城向您保证所售商品均为正品行货，京东自营商品开具机打发票及电子发票。凭质保证书及京东商城发票，可享受全国联保服务（奢侈品、钟表除外；奢侈\n品、钟表由京东联系保修，享受法定三包售后服务），与您亲临商场选购的商品享受相同的质量保证。京东商城还为您提供具有竞争力的商品价格和</span><a style=\"font-size: 13px; text-decoration: underline;\" href=\"http://www.jd.com/help/kdexpress.aspx\" target=\"_blank\"><span style=\"font-size: 13px;\">运费政策</span></a><span style=\"font-size: 13px;\">，请您放心购买！	<br/><br/>\n	注：因厂家会在没有任何提前通知的情况下更改产品包装、产地或者一些附件，本司不能确保客户收到的货物与商城图片、产地、附件说明完全一致。只能确保为原厂正货！并且保证与当时市场上同样主流新品一致。若本商城没有及时更新，请大家谅解！</span></p><p><span style=\"font-size: 13px;\"><strong>权利声明：</strong><br/>京东商城上的所有商品信息、客户评价、商品咨询、网友讨论等内容，是京东商城重要的经营资源，未经许可，禁止非法转载使用。	</span></p><p><span style=\"font-size: 13px;\"><strong>注：</strong>本站商品信息均来自于厂商，其真实性、准确性和合法性由信息拥有者（厂商）负责。本站不提供任何保证，并不承担任何法律责任。</span></p><p><br/></p>', '<p><span style=\"font-size: 13px;\">\n					如果您发现商品信息不准确，</span><a style=\"text-decoration: underline; font-size: 13px;\" href=\"http://club.360buy.com/jdvote/skucheck.aspx?skuid=1002941635&cid1=1620&cid2=1621&cid3=1626\" target=\"_blank\"><span style=\"font-size: 13px;\">欢迎纠错</span></a>\n				</p><table class=\"Ptable\" cellpadding=\"0\" cellspacing=\"1\" width=\"100%\"><tbody><tr class=\"firstRow\"><th class=\"tdTitle\" colspan=\"2\"><span style=\"font-size: 13px;\">主体</span></th></tr><tr><td><br/></td><td><br/></td></tr><tr><td class=\"tdTitle\"><span style=\"font-size: 13px;\">类型</span></td><td><span style=\"font-size: 13px;\">十件套</span></td></tr><tr><td class=\"tdTitle\"><span style=\"font-size: 13px;\">适用床品规格</span></td><td><span style=\"font-size: 13px;\">超大双人(1.8m床)</span></td></tr><tr><td class=\"tdTitle\"><span style=\"font-size: 13px;\">床品版式</span></td><td><span style=\"font-size: 13px;\">AB版</span></td></tr><tr><td class=\"tdTitle\"><span style=\"font-size: 13px;\">面料支数</span></td><td><span style=\"font-size: 13px;\">40支</span></td></tr><tr><td class=\"tdTitle\"><span style=\"font-size: 13px;\">床品款式</span></td><td><span style=\"font-size: 13px;\">床单式</span></td></tr></tbody></table><p>\n			</p><p><span style=\"font-size: 13px;\"><strong>服务承诺：</strong><br/>\n	京东商城向您保证所售商品均为正品行货，京东自营商品开具机打发票及电子发票。凭质保证书及京东商城发票，可享受全国联保服务（奢侈品、钟表除外；奢侈\n品、钟表由京东联系保修，享受法定三包售后服务），与您亲临商场选购的商品享受相同的质量保证。京东商城还为您提供具有竞争力的商品价格和</span><a style=\"text-decoration: underline; font-size: 13px;\" href=\"http://www.jd.com/help/kdexpress.aspx\" target=\"_blank\"><span style=\"font-size: 13px;\">运费政策</span></a><span style=\"font-size: 13px;\">，请您放心购买！	<br/><br/>\n	注：因厂家会在没有任何提前通知的情况下更改产品包装、产地或者一些附件，本司不能确保客户收到的货物与商城图片、产地、附件说明完全一致。只能确保为原厂正货！并且保证与当时市场上同样主流新品一致。若本商城没有及时更新，请大家谅解！</span></p><p><span style=\"font-size: 13px;\"><strong>权利声明：</strong><br/>京东商城上的所有商品信息、客户评价、商品咨询、网友讨论等内容，是京东商城重要的经营资源，未经许可，禁止非法转载使用。</span></p><p><br/></p>');
INSERT INTO `product` VALUES ('28', null, '1', '10', '', '迷你型双槽冷饮机', 'CARIMALI', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '/../jrdir/-5639360494080998241_.jpg', '1', '22', '', '', '');
INSERT INTO `product` VALUES ('29', null, '1', '7', '', '电脑自动升降油炸机', 'CARIMALI', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '/../jrdir/6180183383869702821_.jpg', '1', '2', '', '', '');
INSERT INTO `product` VALUES ('30', null, '1', '9', '', '电脑计时双面煎板', 'CONTI', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '/../jrdir/-272344982003891472_.jpg', '1', '22', '', '', '');
INSERT INTO `product` VALUES ('31', null, '1', '4', '', '德克士最新款4层保温柜', 'BUNN', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '/../jrdir/6250361214566811533_.gif', '0', '23', '', '', '');

-- ----------------------------
-- Table structure for product_page
-- ----------------------------
DROP TABLE IF EXISTS `product_page`;
CREATE TABLE `product_page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='产品主页数据信息表';

-- ----------------------------
-- Records of product_page
-- ----------------------------
INSERT INTO `product_page` VALUES ('1', '<p class=\"pro_desc_p\" style=\"line-height: 25px; color: rgb(102, 102, 102); font-family: &#39;Microsoft YaHei&#39;, &#39;Segoe UI&#39;, Helvetica, Arial, sans-serif, simsun; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255); \">金嵘厨房是众多国际、国内知名企业授权服务商，如美国SANYO、manitowoc、TAYLOR和德国SIMONELLI为我们供应：&nbsp;<span style=\"padding: 3px 8px 3px 5px; cursor: pointer; color: rgb(0, 90, 160);\">专业意式咖啡机</span>&nbsp;、<span style=\"padding: 3px 8px 3px 5px; cursor: pointer; color: rgb(0, 90, 160);\">小型全自动咖啡机</span>、<span style=\"padding: 3px 8px 3px 5px; cursor: pointer; color: rgb(0, 90, 160);\">大型全自动咖啡机</span>、<span style=\"padding: 3px 8px 3px 5px; cursor: pointer; color: rgb(0, 90, 160);\">磨豆机</span>、<span style=\"padding: 3px 8px 3px 5px; cursor: pointer; color: rgb(0, 90, 160);\">美式滴滤机</span>、<span style=\"padding: 3px 8px 3px 5px; cursor: pointer; color: rgb(0, 90, 160);\">西餐炉具</span>、<span style=\"padding: 3px 8px 3px 5px; cursor: pointer; color: rgb(0, 90, 160);\">烤箱</span>、<span style=\"padding: 3px 8px 3px 5px; cursor: pointer; color: rgb(0, 90, 160);\">制冰机和制冷设备</span>、<span style=\"padding: 3px 8px 3px 5px; cursor: pointer; color: rgb(0, 90, 160);\">洗碗机</span>、<span style=\"padding: 3px 8px 3px 5px; cursor: pointer; color: rgb(0, 90, 160);\">酒吧设备</span>、<span style=\"padding: 3px 8px 3px 5px; cursor: pointer; color: rgb(0, 90, 160);\">面包房和烘焙设备</span>、<span style=\"padding: 3px 8px 3px 5px; cursor: pointer; color: rgb(0, 90, 160);\">洗衣房设备</span>、<span style=\"padding: 3px 8px 3px 5px; cursor: pointer; color: rgb(0, 90, 160);\">食品加工设备</span>、<span style=\"padding: 3px 8px 3px 5px; cursor: pointer; color: rgb(0, 90, 160);\">快餐设备</span>、<span style=\"padding: 3px 8px 3px 5px; cursor: pointer; color: rgb(0, 90, 160);\">保温展示设备</span>、<span style=\"padding: 3px 8px 3px 5px; cursor: pointer; color: rgb(0, 90, 160);\">商用微波炉</span>和<span style=\"padding: 3px 8px 3px 5px; cursor: pointer; color: rgb(0, 90, 160);\">真空包装机</span>，服务您的咖啡馆，酒吧和餐馆。</p><p>我 们 的 服 务 理 念 是：</p><p><em><strong>诚信经营 务实服务</strong></em></p><p><br style=\"font-family: &#39;Microsoft YaHei&#39;, &#39;Segoe UI&#39;, Helvetica, Arial, sans-serif, simsun; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255); \"/></p><p>我 们 的 产 品 理 念 是：</p><p><em><strong>为您提供专业的厨房设备，和专业的售后服务！</strong></em></p><p><em><strong><br/></strong></em></p><p><br/></p>');

-- ----------------------------
-- Table structure for rental_service
-- ----------------------------
DROP TABLE IF EXISTS `rental_service`;
CREATE TABLE `rental_service` (
  `id` int(11) NOT NULL,
  `description` text COMMENT '租赁描述',
  `contact` text COMMENT '租赁联系方式',
  `contract` varchar(30) DEFAULT NULL COMMENT '租赁合同名称',
  `contract_type` varchar(8) DEFAULT NULL COMMENT '租赁合同类型',
  `contract_url` varchar(50) DEFAULT NULL COMMENT '租赁合同URL',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='租凭服务信息表';

-- ----------------------------
-- Records of rental_service
-- ----------------------------

-- ----------------------------
-- Table structure for repair_service
-- ----------------------------
DROP TABLE IF EXISTS `repair_service`;
CREATE TABLE `repair_service` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pledge` text COMMENT '服务承诺',
  `ranges` text COMMENT '务服范围',
  `mode` text COMMENT '服务方式',
  `nav_image_url` varchar(50) DEFAULT NULL COMMENT '导航图片',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='维修服务信息表';

-- ----------------------------
-- Records of repair_service
-- ----------------------------
INSERT INTO `repair_service` VALUES ('1', '<p style=\"line-height: 1.75em;\"><span style=\"font-size: 14px; \">金荣厨房向您保证所售商品均为正品行货，京东自营商品自带机打发票，与商品一起寄送。凭质保证书及金荣厨房发票，可享受全国联保服务（奢侈品、钟表除外；奢侈品、钟表由京东联系保修，享受法定三包售后服务），与您亲临商场选购的商品享受相同的质量保证。金荣厨房还为您提供具有竞争力的商品价格和运费政策，请您放心购买！</span></p>', '<ul class=\" list-paddingleft-2\" style=\"list-style-type: square;\"><li><p><span style=\"font-size: 14px;\">冷柜、制冰机、圣代等制冷设备安装、维修及保养</span></p></li><li><p><span style=\"font-size: 14px;\">炸锅、煎板、热水器等设备安装、 维修及保养</span></p></li><li><p><span style=\"font-size: 14px;\">冷库设计、安装及售后服务</span></p></li><li><p><span style=\"font-size: 14px;\">厨房其他机电设备安装、 维修及保养</span></p></li><li><p><span style=\"font-size: 14px;\">旧设备翻新、改造及销售</span></p></li><li><p><span style=\"font-size: 14px;\">厨房设备规划设计咨询及厨房机电设备维护保养培训</span></p></li></ul>', '<table data-sort=\"sortDisabled\" align=\"center\" style=\"\"><tbody><tr class=\"firstRow\"><td valign=\"middle\" rowspan=\"3\" colspan=\"1\" align=\"center\" style=\"border: 1px solid rgb(127, 127, 127); word-break: break-all; \" width=\"66\"><span style=\"font-size: 14px; \">维修服务</span></td><td valign=\"middle\" align=\"center\" style=\"border: 1px solid rgb(127, 127, 127); word-break: break-all; \" width=\"317\"><span style=\"font-size: 14px; \">售后（保固）维修</span></td><td valign=\"middle\" align=\"center\" style=\"border: 1px solid rgb(127, 127, 127); word-break: break-all; \"><span style=\"font-size: 14px; \">按销售合同执行</span></td></tr><tr><td valign=\"middle\" align=\"center\" style=\"border: 1px solid rgb(127, 127, 127); word-break: break-all; \" width=\"389\"><span style=\"font-size: 14px; \">叫修</span></td><td valign=\"middle\" align=\"center\" style=\"border: 1px solid rgb(127, 127, 127); word-break: break-all; \" width=\"196\"><span style=\"font-size: 14px; \">依次计费</span></td></tr><tr><td valign=\"middle\" align=\"center\" style=\"border: 1px solid rgb(127, 127, 127); word-break: break-all; \" width=\"389\"><span style=\"font-size: 14px; \">委托协议</span></td><td valign=\"middle\" align=\"center\" rowspan=\"3\" colspan=\"1\" style=\"border: 1px solid rgb(127, 127, 127); word-break: break-all; \" width=\"196\"><span style=\"font-size: 14px; \">按协议价格执行</span></td></tr><tr><td valign=\"middle\" rowspan=\"1\" colspan=\"2\" align=\"center\" style=\"border: 1px solid rgb(127, 127, 127); word-break: break-all; \"><span style=\"font-size: 14px; \">综合协议维修保养服务</span></td></tr><tr><td valign=\"middle\" rowspan=\"2\" colspan=\"1\" align=\"center\" style=\"border: 1px solid rgb(127, 127, 127); word-break: break-all; \" width=\"57\"><span style=\"font-size: 14px; \">维护保养服务</span></td><td valign=\"middle\" align=\"center\" style=\"border: 1px solid rgb(127, 127, 127); word-break: break-all; \" width=\"317\"><span style=\"font-size: 14px; \">客户多设备协议维护保养</span></td></tr><tr><td valign=\"middle\" align=\"center\" style=\"border: 1px solid rgb(127, 127, 127); word-break: break-all; \" width=\"389\"><span style=\"font-size: 14px; \">单机维护保养</span></td><td valign=\"middle\" align=\"center\" style=\"border: 1px solid rgb(127, 127, 127); word-break: break-all; \" width=\"196\"><span style=\"font-size: 14px; \">按单机价格执行</span></td></tr></tbody></table><p><br/></p>', null);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `role_admin` int(11) DEFAULT '1',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(20) DEFAULT NULL COMMENT '级别名称',
  `roleremark` varchar(100) DEFAULT NULL COMMENT '级别描述',
  `roletype` int(11) DEFAULT NULL COMMENT '0：内部角色，1：外部角色',
  `video_play` int(11) DEFAULT NULL COMMENT '0：可播放视频，1：无可播放视频',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='角色信息表';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '3', '市场部经理', '1、产品中心只读权限；\n2、配件中心只读权限；\n3、产品中心和租赁服务产品滚动读写权限。', '0', null);
INSERT INTO `role` VALUES ('1', '4', '高级会员', '可查看所有文档与播放视频', '1', '0');
INSERT INTO `role` VALUES ('1', '5', '公司普通员工', '只能查看产品与配件信息。', '0', null);
INSERT INTO `role` VALUES ('1', '6', '管理员_杜', '所有数据只读权限。', '0', null);
INSERT INTO `role` VALUES ('1', '7', '中级会员', '可查看设备维护文档，以及播放视频', '1', '0');
INSERT INTO `role` VALUES ('1', '8', '低级会员', '只可查看设备安装说明书', '1', '1');
INSERT INTO `role` VALUES ('0', '9', '超级管理员', '所有数据读写权限', '0', null);

-- ----------------------------
-- Table structure for role_documenttype
-- ----------------------------
DROP TABLE IF EXISTS `role_documenttype`;
CREATE TABLE `role_documenttype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL COMMENT '用户级别信息表',
  `document_type_id` int(11) DEFAULT NULL COMMENT '文档库类型信息表',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COMMENT='角色与文档库中间信息表';

-- ----------------------------
-- Records of role_documenttype
-- ----------------------------
INSERT INTO `role_documenttype` VALUES ('36', '7', '11');
INSERT INTO `role_documenttype` VALUES ('37', '7', '10');
INSERT INTO `role_documenttype` VALUES ('39', '4', '12');
INSERT INTO `role_documenttype` VALUES ('40', '4', '11');
INSERT INTO `role_documenttype` VALUES ('41', '4', '10');
INSERT INTO `role_documenttype` VALUES ('43', '8', '10');

-- ----------------------------
-- Table structure for role_menu
-- ----------------------------
DROP TABLE IF EXISTS `role_menu`;
CREATE TABLE `role_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL COMMENT '角色信息表',
  `menu_id` int(11) DEFAULT NULL COMMENT '菜单信息表',
  `rw` varchar(1) DEFAULT 'r',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=410 DEFAULT CHARSET=utf8 COMMENT='角色和菜单中间表';

-- ----------------------------
-- Records of role_menu
-- ----------------------------
INSERT INTO `role_menu` VALUES ('348', '5', '1', 'r');
INSERT INTO `role_menu` VALUES ('349', '5', '2', 'r');
INSERT INTO `role_menu` VALUES ('350', '5', '8', 'r');
INSERT INTO `role_menu` VALUES ('351', '5', '9', 'r');
INSERT INTO `role_menu` VALUES ('352', '5', '53', 'r');
INSERT INTO `role_menu` VALUES ('353', '5', '54', 'r');
INSERT INTO `role_menu` VALUES ('354', '6', '36', 'r');
INSERT INTO `role_menu` VALUES ('355', '6', '37', 'r');
INSERT INTO `role_menu` VALUES ('356', '6', '39', 'w');
INSERT INTO `role_menu` VALUES ('357', '6', '41', 'w');
INSERT INTO `role_menu` VALUES ('358', '6', '42', 'w');
INSERT INTO `role_menu` VALUES ('359', '6', '43', 'w');
INSERT INTO `role_menu` VALUES ('360', '6', '53', 'r');
INSERT INTO `role_menu` VALUES ('361', '6', '54', 'w');
INSERT INTO `role_menu` VALUES ('362', '9', '1', 'r');
INSERT INTO `role_menu` VALUES ('363', '9', '2', 'r');
INSERT INTO `role_menu` VALUES ('364', '9', '4', 'r');
INSERT INTO `role_menu` VALUES ('365', '9', '5', 'r');
INSERT INTO `role_menu` VALUES ('366', '9', '6', 'r');
INSERT INTO `role_menu` VALUES ('367', '9', '8', 'r');
INSERT INTO `role_menu` VALUES ('368', '9', '9', 'r');
INSERT INTO `role_menu` VALUES ('369', '9', '11', 'r');
INSERT INTO `role_menu` VALUES ('370', '9', '13', 'r');
INSERT INTO `role_menu` VALUES ('371', '9', '14', 'r');
INSERT INTO `role_menu` VALUES ('372', '9', '16', 'r');
INSERT INTO `role_menu` VALUES ('373', '9', '17', 'r');
INSERT INTO `role_menu` VALUES ('374', '9', '19', 'r');
INSERT INTO `role_menu` VALUES ('375', '9', '21', 'r');
INSERT INTO `role_menu` VALUES ('376', '9', '22', 'r');
INSERT INTO `role_menu` VALUES ('377', '9', '23', 'r');
INSERT INTO `role_menu` VALUES ('378', '9', '24', 'r');
INSERT INTO `role_menu` VALUES ('379', '9', '25', 'r');
INSERT INTO `role_menu` VALUES ('380', '9', '26', 'r');
INSERT INTO `role_menu` VALUES ('381', '9', '28', 'r');
INSERT INTO `role_menu` VALUES ('382', '9', '29', 'r');
INSERT INTO `role_menu` VALUES ('383', '9', '30', 'r');
INSERT INTO `role_menu` VALUES ('384', '9', '31', 'r');
INSERT INTO `role_menu` VALUES ('385', '9', '32', 'r');
INSERT INTO `role_menu` VALUES ('386', '9', '33', 'r');
INSERT INTO `role_menu` VALUES ('387', '9', '36', 'r');
INSERT INTO `role_menu` VALUES ('388', '9', '37', 'r');
INSERT INTO `role_menu` VALUES ('389', '9', '39', 'r');
INSERT INTO `role_menu` VALUES ('390', '9', '41', 'r');
INSERT INTO `role_menu` VALUES ('391', '9', '42', 'r');
INSERT INTO `role_menu` VALUES ('392', '9', '43', 'r');
INSERT INTO `role_menu` VALUES ('393', '9', '52', 'r');
INSERT INTO `role_menu` VALUES ('394', '9', '55', 'r');
INSERT INTO `role_menu` VALUES ('395', '9', '45', 'r');
INSERT INTO `role_menu` VALUES ('396', '9', '46', 'r');
INSERT INTO `role_menu` VALUES ('397', '9', '47', 'r');
INSERT INTO `role_menu` VALUES ('398', '9', '48', 'r');
INSERT INTO `role_menu` VALUES ('399', '9', '49', 'r');
INSERT INTO `role_menu` VALUES ('400', '9', '50', 'r');
INSERT INTO `role_menu` VALUES ('401', '9', '51', 'r');
INSERT INTO `role_menu` VALUES ('402', '9', '53', 'r');
INSERT INTO `role_menu` VALUES ('403', '9', '54', 'r');
INSERT INTO `role_menu` VALUES ('404', '3', '1', 'r');
INSERT INTO `role_menu` VALUES ('405', '3', '6', 'r');
INSERT INTO `role_menu` VALUES ('406', '3', '16', 'r');
INSERT INTO `role_menu` VALUES ('407', '3', '17', 'r');
INSERT INTO `role_menu` VALUES ('408', '3', '53', 'r');
INSERT INTO `role_menu` VALUES ('409', '3', '54', 'r');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  `menu_sort` int(11) DEFAULT NULL,
  `show_mark` int(11) DEFAULT '0' COMMENT '0：显示，1：不显示',
  `parent_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COMMENT='菜单信息表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '产品管理', null, '1', '0', null);
INSERT INTO `sys_menu` VALUES ('2', '产品中心', '/product/productJump', '1', '0', '1');
INSERT INTO `sys_menu` VALUES ('4', '自定义类别', '/productCategory/productCategoryJump', '2', '0', '1');
INSERT INTO `sys_menu` VALUES ('5', '产品中心简介', '/productPage/productDescJump', '3', '0', '1');
INSERT INTO `sys_menu` VALUES ('6', '产品滚动管理', '/product/productScrollListJump', '4', '0', '1');
INSERT INTO `sys_menu` VALUES ('8', '配件管理', null, '2', '0', null);
INSERT INTO `sys_menu` VALUES ('9', '配件中心', '/fitting/fittingJump', '1', '0', '8');
INSERT INTO `sys_menu` VALUES ('11', '配件中心简介', '/fittingPage/fittingPageDescJump', '4', '0', '8');
INSERT INTO `sys_menu` VALUES ('13', '自定义类别', '/productCategory/productCategoryJump', '2', '0', '8');
INSERT INTO `sys_menu` VALUES ('14', '配件专业类别', '/fittingSpecialtyCate/fittingSpecialtyJump', '3', '0', '8');
INSERT INTO `sys_menu` VALUES ('16', '租赁服务', null, '3', '0', null);
INSERT INTO `sys_menu` VALUES ('17', '产品滚动管理', '/lease/scrollListJump', '1', '0', '16');
INSERT INTO `sys_menu` VALUES ('19', '租赁服务简介', '/lease/leaseDescJump', '2', '0', '16');
INSERT INTO `sys_menu` VALUES ('21', '维修服务', null, '4', '0', null);
INSERT INTO `sys_menu` VALUES ('22', '服务承诺', '/service/pledgeJump', '1', '0', '21');
INSERT INTO `sys_menu` VALUES ('23', '服务方式', '/service/modeJump', '2', '0', '21');
INSERT INTO `sys_menu` VALUES ('24', '服务范围', '/service/rangeJump', '3', '0', '21');
INSERT INTO `sys_menu` VALUES ('25', '维修设备种类', '/service/categoryJump', '4', '0', '21');
INSERT INTO `sys_menu` VALUES ('26', '维修报告单', '/service/reportJump', '5', '0', '21');
INSERT INTO `sys_menu` VALUES ('28', '新闻资讯', null, '5', '0', null);
INSERT INTO `sys_menu` VALUES ('29', '新闻资讯', '/news/newsJump', '1', '0', '28');
INSERT INTO `sys_menu` VALUES ('30', '学习中心', null, '6', '0', null);
INSERT INTO `sys_menu` VALUES ('31', '维护文档库', '/learn/learnJump', '1', '0', '30');
INSERT INTO `sys_menu` VALUES ('32', '维护类别', '/majorCategory/majorJump', '2', '0', '30');
INSERT INTO `sys_menu` VALUES ('33', '文档类别', '/smallCategory/smallJump', '3', '0', '30');
INSERT INTO `sys_menu` VALUES ('36', '金嵘管理', null, '7', '0', '');
INSERT INTO `sys_menu` VALUES ('37', '公司信息', '/company/companyJump', '6', '0', '36');
INSERT INTO `sys_menu` VALUES ('39', '客户目录', '/customerController/customerJump', '2', '0', '36');
INSERT INTO `sys_menu` VALUES ('41', '关于金嵘', '/aboutdesc/aboutdescJump', '5', '0', '36');
INSERT INTO `sys_menu` VALUES ('42', '发展历程', '/growingProcess/growingProcessJump', '4', '0', '36');
INSERT INTO `sys_menu` VALUES ('43', '金嵘团队', '/team/teamJump', '3', '0', '36');
INSERT INTO `sys_menu` VALUES ('45', '系统管理', null, '9', '0', null);
INSERT INTO `sys_menu` VALUES ('46', '角色管理', '/role/roleJump', '1', '0', '45');
INSERT INTO `sys_menu` VALUES ('47', '角色菜单', '/rolemenu/rolemenuJump', '3', '0', '45');
INSERT INTO `sys_menu` VALUES ('48', '角色读写', '/rolemenu/rolerwJump', '2', '0', '45');
INSERT INTO `sys_menu` VALUES ('49', '会员管理', null, '8', '0', null);
INSERT INTO `sys_menu` VALUES ('50', '文档权限管理', '/roleDocument/roledocJump', '2', '0', '49');
INSERT INTO `sys_menu` VALUES ('51', '会员管理', '/member/memberJump', '1', '0', '49');
INSERT INTO `sys_menu` VALUES ('52', '员工管理', '/employee/employeeJump', '1', '0', '36');
INSERT INTO `sys_menu` VALUES ('53', '个人自助', '', '0', '0', null);
INSERT INTO `sys_menu` VALUES ('54', '修改密码', '/user/updatepasswordJump', '1', '0', '53');
INSERT INTO `sys_menu` VALUES ('55', '用户协议', '/aboutdesc/protocoldescJump', '7', '0', '36');

-- ----------------------------
-- Table structure for third_part_users
-- ----------------------------
DROP TABLE IF EXISTS `third_part_users`;
CREATE TABLE `third_part_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `users_id` int(11) DEFAULT NULL,
  `company_name` varchar(100) DEFAULT NULL COMMENT '公司名称',
  `company_address` varchar(100) DEFAULT NULL COMMENT '公司地址',
  `contact` varchar(50) DEFAULT NULL COMMENT '联系人',
  `where_department` varchar(50) DEFAULT NULL COMMENT '所在部门',
  `fixed_telephone` varchar(20) DEFAULT NULL COMMENT '固定电话',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机',
  `contact_email` varchar(50) DEFAULT NULL COMMENT '联系人邮箱',
  `company_nature` varchar(150) DEFAULT NULL COMMENT '公司性质',
  `business_areas` varchar(150) DEFAULT NULL COMMENT '经营领域',
  `registration_time` datetime DEFAULT NULL COMMENT '注册时间',
  `status` int(11) DEFAULT NULL COMMENT '0：账户活动，1：账户冻结',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='第三方用户信息表';

-- ----------------------------
-- Records of third_part_users
-- ----------------------------
INSERT INTO `third_part_users` VALUES ('17', '34', '公司名称', '公司地址', '联系人', '所在部门', '座机号', '手机号', '657261109@qq.com', '维修公司/工程师,', '快餐设备,', null, null);
INSERT INTO `third_part_users` VALUES ('18', '35', '公司名称', '公司地址', '联系人', '所在部门', '座机号', '手机号', '657261109@qq.com', '维修公司/工程师,', '制冰机,', null, null);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `registration_time` datetime DEFAULT NULL COMMENT '注册时间',
  `user_type` int(11) DEFAULT NULL COMMENT '0：公司员工，1：第三方用户',
  `login_count` int(11) DEFAULT NULL COMMENT '用户登录次数',
  `last_login_time` datetime DEFAULT NULL COMMENT '用户最后登录时间',
  `status` int(11) DEFAULT '1' COMMENT '0帐号可用，1帐号不可用',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_unique` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', '9', 'admin', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '2013-12-06 23:07:59', '0', '148', '2014-01-09 22:08:09', '0');
INSERT INTO `users` VALUES ('3', '3', 'zhubin', '4344e42460d361b0b38439fac5b52cdb694a3589', '2013-12-14 00:00:00', '0', null, null, '1');
INSERT INTO `users` VALUES ('7', '6', 'durong', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '2013-12-14 00:00:00', '0', '1', '2014-01-05 18:04:40', '0');
INSERT INTO `users` VALUES ('8', '3', 'jinagyu', '947c5658e57238571d8a4a396d5a33f269bcdb96', '2013-12-14 00:00:00', '0', '1', '2013-12-29 15:26:52', '0');
INSERT INTO `users` VALUES ('34', '4', 'hubo', '7c4a8d09ca3762af61e59520943dc26494f8941b', '2014-01-01 00:00:00', '1', '5', '2014-01-01 20:20:45', '0');
INSERT INTO `users` VALUES ('35', '7', 'test', '7c4a8d09ca3762af61e59520943dc26494f8941b', '2014-01-03 00:00:00', '1', '2', '2014-01-03 11:34:34', '0');
