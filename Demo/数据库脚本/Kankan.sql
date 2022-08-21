create database if not exists Kankan default charset utf8mb4 collate utf8mb4_general_ci;


use Kankan;

create table user( 
	user_id VARCHAR(132) UNIQUE NOT NULL PRIMARY KEY, 
	password VARCHAR(20) NOT NULL, 
	nickname VARCHAR(140),
	headPortrait VARCHAR(100)
) DEFAULT CHARSET=utf8mb4 COMMENT="用户信息表";

create table manuscript( 
	manuscript_id VARCHAR(132) UNIQUE NOT NULL PRIMARY KEY,  
	description VARCHAR(100), 
	title VARCHAR(30) NOT NULL,  
	label VARCHAR(20), 
	subarea VARCHAR(20), 
	isOriginal boolean NOT NULL, 
	cover VARCHAR(250) NOT NULL,
	date VARCHAR(30) NOT NULL,
	user_id VARCHAR(132),
	FOREIGN KEY(user_id) REFERENCES user(user_id)
) DEFAULT CHARSET=utf8mb4 COMMENT="稿件信息表";

create table video(
	video_id VARCHAR(132) UNIQUE NOT NULL PRIMARY KEY,
	address VARCHAR(50) NOT NULL,
	manuscript_id VARCHAR(132),
	FOREIGN KEY(manuscript_id) REFERENCES manuscript(manuscript_id) on delete cascade
) DEFAULT CHARSET=utf8mb4 COMMENT="视频文件数据表";

create table comment(
	comment_id VARCHAR(132) UNIQUE NOT NULL PRIMARY KEY,
	text VARCHAR(100) NOT NULL,
	manuscript_id VARCHAR(132) NOT NULL,
	user_id VARCHAR(132) 
) DEFAULT CHARSET=utf8mb4 COMMENT="评论表";

create table fan( 
	user_id VARCHAR(132),
	user_nickname VARCHAR(20),
	fan_id VARCHAR(132),
	fan_nickname VARCHAR(20)
) DEFAULT CHARSET=utf8mb4 COMMENT="粉丝表";

create table follower( 
	user_id VARCHAR(132),
	user_nickname VARCHAR(20),	
	follower_id VARCHAR(132),
	follower_nickname VARCHAR(20)
) DEFAULT CHARSET=utf8mb4 COMMENT="关注者表";


insert into user values("ce20e992-2530-4d7f-abc0-801879c5d3cb", "zhuyoucheng", "zhuyoucheng", "https://img1.baidu.com/it/u=873106765,2587410047&fm=253&fmt=auto&app=138&f=JPEG?w=530&h=500");
insert into user values("b1bd76dd-bbd3-4687-80bc-2a828d7b62b4", "huchengxing", "huchenxing", "https://img1.baidu.com/it/u=873106765,2587410047&fm=253&fmt=auto&app=138&f=JPEG?w=530&h=500");
insert into user values("459e143b-773e-44b2-83b7-147d6ab99273", "quhu", "quhu", "https://img1.baidu.com/it/u=873106765,2587410047&fm=253&fmt=auto&app=138&f=JPEG?w=530&h=500");
insert into user values("b46bf5fd-6209-49e8-a9cb-279897085926", "zhangqingjun", "zhangqingjun", "https://img1.baidu.com/it/u=873106765,2587410047&fm=253&fmt=auto&app=138&f=JPEG?w=530&h=500");

insert into manuscript values("5659653c-45fa-4185-86ae-28ba3c46e5d0", "food_ismn", "CQNU", "food","food",true,"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Finews.gtimg.com%2Fnewsapp_bt%2F0%2F14123277880%2F641&refer=http%3A%2F%2Finews.gtimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1663464770&t=23c419643ab88a2662aa60d404366e2f", "2022-07-06", "b1bd76dd-bbd3-4687-80bc-2a828d7b62b4");
insert into manuscript values("959e8839-4301-45ed-8e9d-2f334077dc25", "bbbbbbbbb", "bb","school","school",false, "https://img1.baidu.com/it/u=848097428,2094753496&fm=253&fmt=auto&app=138&f=PNG?w=838&h=500", "2022-07-20", "ce20e992-2530-4d7f-abc0-801879c5d3cb");

insert into video values("2430cdc5-207f-4b46-88af-d6d8068a839f", "rtsp://10.252.173.31:8554/1.mkv", "5659653c-45fa-4185-86ae-28ba3c46e5d0");
insert into video values("5c8194b5-c6fc-4371-a9d7-058194cc40fc", "rtsp://10.252.173.31:8554/2.mpg", "959e8839-4301-45ed-8e9d-2f334077dc25");

insert into fan values("ce20e992-2530-4d7f-abc0-801879c5d3cb", "zhuyoucheng", "b1bd76dd-bbd3-4687-80bc-2a828d7b62b4", "huchenxing");
insert into fan values("ce20e992-2530-4d7f-abc0-801879c5d3cb", "zhuyoucheng", "459e143b-773e-44b2-83b7-147d6ab99273", "quhu");
insert into fan values("b1bd76dd-bbd3-4687-80bc-2a828d7b62b4", "huchenxing", "459e143b-773e-44b2-83b7-147d6ab99273", "quhu");
insert into fan values("459e143b-773e-44b2-83b7-147d6ab99273", "quhu", "ce20e992-2530-4d7f-abc0-801879c5d3cb", "zhuyoucheng");
insert into fan values("459e143b-773e-44b2-83b7-147d6ab99273", "quhu", "b46bf5fd-6209-49e8-a9cb-279897085926", "zhangqingjun");

insert into follower values("ce20e992-2530-4d7f-abc0-801879c5d3cb", "zhuyoucheng", "459e143b-773e-44b2-83b7-147d6ab99273", "quhu");
insert into follower values("b1bd76dd-bbd3-4687-80bc-2a828d7b62b4", "huchenxing", "ce20e992-2530-4d7f-abc0-801879c5d3cb", "zhuyoucheng");
insert into follower values("459e143b-773e-44b2-83b7-147d6ab99273", "quhu", "b1bd76dd-bbd3-4687-80bc-2a828d7b62b4", "huchenxing");
insert into follower values("459e143b-773e-44b2-83b7-147d6ab99273", "quhu", "ce20e992-2530-4d7f-abc0-801879c5d3cb", "zhuyoucheng");
insert into follower values("ce20e992-2530-4d7f-abc0-801879c5d3cb", "zhangqingjun", "459e143b-773e-44b2-83b7-147d6ab99273", "quhu");


insert into comment values("b9d84ff4-95e0-43ab-8d0c-c88b9edbfb7f", "aaaa,up", "5659653c-45fa-4185-86ae-28ba3c46e5d0", "ce20e992-2530-4d7f-abc0-801879c5d3cb");


