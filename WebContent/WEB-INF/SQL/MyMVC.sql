-- 카테고리

CREATE TABLE product_category(
   category_id         VARCHAR2(10) NOT NULL
  ,category_name       VARCHAR(25) NOT NULL
  ,category_seq        NUMBER  NOT NULL
  ,constraint PK_product_category primary key(category_id)
);

create sequence category_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


INSERT INTO product_category(category_id,category_name,category_seq) VALUES ('d_cb','콜드 브루 커피',category_seq.nextval);
INSERT INTO product_category(category_id,category_name,category_seq) VALUES ('d_br','브루드 커피',category_seq.nextval);
INSERT INTO product_category(category_id,category_name,category_seq) VALUES ('d_es','에스프레소',category_seq.nextval);
INSERT INTO product_category(category_id,category_name,category_seq) VALUES ('d_fp','프라푸치노' ,category_seq.nextval);
INSERT INTO product_category(category_id,category_name,category_seq) VALUES ('d_bl','블렌디드' ,category_seq.nextval);
INSERT INTO product_category(category_id,category_name,category_seq) VALUES ('d_te','티',category_seq.nextval);
INSERT INTO product_category(category_id,category_name,category_seq) VALUES ('d_nc','기타 제조 음료' ,category_seq.nextval);

INSERT INTO product_category(category_id,category_name,category_seq) VALUES ('f_bk','베이커리' ,category_seq.nextval);
INSERT INTO product_category(category_id,category_name,category_seq) VALUES ('f_ca','케이크' ,category_seq.nextval);
INSERT INTO product_category(category_id,category_name,category_seq) VALUES ('f_ss','샌드위치 샐러드' ,category_seq.nextval);
INSERT INTO product_category(category_id,category_name,category_seq) VALUES ('f_wf','따뜻한 푸드' ,category_seq.nextval);
INSERT INTO product_category(category_id,category_name,category_seq) VALUES ('f_fy','과일 요거트' ,category_seq.nextval);

select * from product_category;

commit;



-- 드링크

 CREATE TABLE drink(
   id            VARCHAR2(10) NOT NULL
  ,category_id   VARCHAR2(10) NOT NULL
  ,drink_seq     NUMBER(10) NOT NULL
  ,name          VARCHAR(50) NOT NULL
  ,name_eng      VARCHAR2(50) NOT NULL
  ,description   VARCHAR2(200) NOT NULL
  ,price         NUMBER(4) NOT NULL
  ,img           VARCHAR2(20) NOT NULL
  ,shot         NUMBER(1) NOT NULL
  ,syrup         VARCHAR2(30) NOT NULL
  ,whipped_cream VARCHAR2(10) NOT NULL
  ,temperature   VARCHAR2(10) NOT NULL
  ,caffein       NUMBER(3)  NOT NULL
  ,base          VARCHAR2(30) NOT NULL
  ,constraint  PK_drink_id primary key(id)
  ,constraint  FK_drink_id foreign key(id) references nutrition(product_id)
  ,constraint  FK_drink_category_code foreign key(category_id) references product_category(category_id)
);

drop table drink purge;

create sequence drink_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select * from product_category;

select *
from drink;

-- cold brew
INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d001','d_cb',drink_seq.nextval,'나이트로 바닐라크림','Nitro Vanilla Cream','부드러운 목넘김의 나이트로 커피와 바닐라 크림의 매력을 한번에 느껴보세요!',5900,'d001.jpg',0,'없음','none','non-iced',245, '물');

INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d002','d_cb', drink_seq.nextval,'나이트로 쇼콜라 클라우드','Nitro Chocolat Cloud','초콜릿과 견과류의 풍미, 초콜릿 파우더 토핑의 부드럽고 달콤한 나이트로 콜드 브루',6100,'d002.jpg',0,'초콜릿시럽','none','non-iced',245, '없음');

INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d003','d_cb',drink_seq.nextval,'나이트로 콜드 브루','Nitro Cold Brew','나이트로 커피 정통의 캐스케이딩과 부드러운 콜드 크레마!',5800,'d003.jpg',0,'없음','none','non-iced',245,'없음');

INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d004','d_cb',drink_seq.nextval,'돌체 콜드 브루','Dolce Cold Brew','동남아 휴가지에서 즐기는 커피를 떠오르게 하는 돌체 콜드 브루',5800,'d004.jpg',0,'돌체시럽','none','iced',150,'우유');

INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d005','d_cb',drink_seq.nextval,'바닐라 크림 콜드 브루','Vanilla Cream Cold Brew','콜드 브루에 더해진 바닐라 크림으로 깔끔하면서 달콤한 콜드 브루를 새롭게 즐길 수 있는 음료입니다.',5500,'d005.jpg',0,'바닐라시럽','none','iced',150,'바닐라크림베이스');

INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d006','d_cb',drink_seq.nextval,'콜드 브루','Cold Brew','스타벅스 바리스타의 정성으로 탄생한 콜드 브루!',4500,'d006.jpg',0,'없음','none','iced',150, '물');

 
 -- brewed coffee
 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d007','d_br',drink_seq.nextval,'아이스 커피','Iced Coffee','깔끔하고 상큼함이 특징인 시원한 아이스 커피',4100,'d007.jpg',0,'없음','none','iced',140, '물');
 
 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d008','d_br',drink_seq.nextval,'오늘의 커피','Brewed Coffee','신선하게 브루드(Brewed)되어 원두의 다양함이 살아있는 커피',3800,'d008.jpg',0,'없음','none','non-iced',260, '물');

-- espresso

 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d009','d_es',drink_seq.nextval,'아이스 카페 아메리카노','Iced Caffe Americano','강렬한 에스프레소 샷에 시원한 물의 조화',4100,'d009.jpg',2,'없음','none','iced',150,'물');

 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d010','d_es',drink_seq.nextval,'카페 아메리카노','Caffe Americano','강렬한 에스프레소 샷에 뜨거운 물의 조화',4100,'d010.jpg',2,'없음','none','non-iced',150,'물');

 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d011','d_es',drink_seq.nextval,'아이스 카라멜 마키아또','Iced Caramel Macchiato','바닐라 시럽, 시원한 우유에 얼음과 에스프레소 샷, 카라멜 드리즐이 어우러진 음료',5600,'d011.jpg',1,'카라멜시럽','none','iced',75,'우유');

 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d012','d_es',drink_seq.nextval,'카라멜 마키아또','Caramel Macchiato','바닐라 시럽과 우유, 그리고 그 위에 얹어진 에스프레소 샷과 달콤한 카라멜 드리즐의 조화',5600,'d012.jpg',1,'카라멜시럽','none','non-iced',75,'우유');

 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d013','d_es',drink_seq.nextval,'아이스 카푸치노','Iced Cappuccino','에스프레소 샷과 시원한 우유에 부드러운 우유 거품이 얹어진 시원한 음료.',4600,'d013.jpg',1,'없음','none','iced',75,'우유');
 
 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d014','d_es',drink_seq.nextval,'카푸치노','Cappuccino','에스프레소 샷과 시원한 우유에 부드러운 우유 거품이 얹어진 음료.',4600,'d014.jpg',1,'없음','none','non-iced',75,'우유');
 
 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d015','d_es',drink_seq.nextval,'아이스 카페 라떼','Iced Caffe Latte','에스프레소 샷과 시원한 우유와 얼음으로 고소한 음료.',4600,'d015.jpg',1,'없음','none','iced',75,'우유');
 
 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d016','d_es',drink_seq.nextval,'카페 라떼','Caffe Latte','에스프레소 샷과 따뜻한 우유로 고소한 음료',4600,'d016.jpg',1,'없음','none','non-iced',75,'우유');

 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d017','d_es',drink_seq.nextval,'아이스 카페 모카','Iced Caffe Mocha','모카시럽과 시원한 우유에 휘핑크림이 토핑된 에스프레소 음료.',4600,'d017.jpg',1,'모카시럽','regular','iced',95,'우유');
 
 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d018','d_es',drink_seq.nextval,'카페 모카','Caffe Mocha','모카시럽과 따뜻한 우유에 휘핑크림이 토핑된 에스프레소 음료.',4600,'d018.jpg',1,'모카시럽','regular','non-iced',95,'우유');

 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d019','d_es',drink_seq.nextval,'아이스 화이트 초콜릿 모카','Iced White Chocolate Mocha','화이트 초콜릿과 시원한 우유가 첨가된 에스프레소 음료.',4600,'d019.jpg',1,'화이트모카시럽','regular','iced',75,'우유');
 
 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d020','d_es',drink_seq.nextval,'화이트 초콜릿 모카','White Chocolate Mocha','화이트 초콜릿과 스팀밀크가 첨가된 에스프레소 음료.',4600,'d020.jpg',1,'화이트모카시럽','regular','non-iced',75,'우유');      
  
 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d021','d_es',drink_seq.nextval,'에스프레소','Espresso','스타벅스의 핵심인 강렬하고 카라멜향이 달콤한 음료',3600,'d021.jpg',1,'없음','none','non-iced',75,'없음');
 
 
 -- 프라푸치노
 
 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d022','d_fp',drink_seq.nextval,'더블 에스프레소 칩 프라푸치노','Double Espresso Chip Frappuccino','에스프레소 2샷과 에스프레소 칩이 어우러진 커피의 기본에 충실한 더블 에스프레소 칩 프라푸치노',6100,'d022.jpg',2,'프라푸치노시럽','regular','iced',130,'우유');      
  
 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d023','d_fp',drink_seq.nextval,'모카 프라푸치노','Mocha Frappuccino','초콜릿, 커피와 얼음이 갈린 음료에 휘핑크림이 토핑된 음료.',5600,'d023.jpg',2,'프라푸치노시럽','regular','iced',90,'우유');      

 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d024','d_fp',drink_seq.nextval,'에스프레소 프라푸치노','Espresso Frappuccino','에스프레소의 강렬함과 약간의 단맛을 시원하게 즐기는 프라푸치노.',5100,'d024.jpg',2,'프라푸치노시럽','regular','iced',120,'우유');      

 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d025','d_fp',drink_seq.nextval,'자바 칩 프라푸치노','Java Chip Frappuccino','커피 프라푸치노에 초콜릿, 초콜릿 칩이 첨가된 아이스 블렌드로 달콤 아삭한 음료.',6100,'d025.jpg',2,'프라푸치노시럽','regular','iced',100,'우유');      

 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d026','d_fp',drink_seq.nextval,'카라멜 프라푸치노','Caramel Frappuccino','카라멜 시럽이 더해진 커피 프라푸치노에 휘핑 크림, 카라멜이 장식된 음료.',5600,'d026.jpg',2,'프라푸치노시럽','regular','iced',85,'우유');      


 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d027','d_fp',drink_seq.nextval,'바닐라 크림 프라푸치노','Vanilla Cream Frappuccino','우유에 바닐라향이 조합된 아이스 블렌드로 휘핑크림이 토핑된 음료.',4800,'d027.jpg',0,'프라푸치노시럽','regular','iced',0,'우유');      

 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d028','d_fp',drink_seq.nextval,'초콜릿 크림 칩 프라푸치노','Chocolate Cream Chip Frappuccino','모카시럽과 자바칩이 혼합된 크림 프라푸치노로 휘핑크림, 초콜렛 드리즐된 음료.',5700,'d028.jpg',0,'프라푸치노시럽','regular','iced',0,'우유');      

 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d029','d_fp',drink_seq.nextval,'피스타치오 크림 프라푸치노','Pistachio Cream Frappuccino','젤라또를 먹는 듯한 크리미함과 고소함이 극에 달한 피스타치오 크림 프라푸치노를 만나보세요.',6300,'d029.jpg',0,'프라푸치노시럽','regular','iced',0,'우유');      
  
  
  commit;
  
  -- 블렌디드
  
   INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d030','d_bl',drink_seq.nextval,'애플망고 요거트 블렌디드','Apple Mango Yogurt Blended','말랑한 애플망고 과육과 부드러운 요거트가 산뜻하게 어우러진 애플망고 요거트 블렌디드',6300,'d030.jpg',0,'블렌디드시럽','none','iced',0,'우유');      

 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d031','d_bl',drink_seq.nextval,'피치레몬 블렌디드','Peach Lemon Blended','달콤한 복숭아와 새콤한 레몬, 말랑한 복숭아 젤리가 만난 피치 레몬 블렌디드',6100,'d031.jpg',0,'클래식시럽','none','iced',0,'레모네이드');      

 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d032','d_bl',drink_seq.nextval,'망고 패션 후르츠 블렌디드','Mango Passion Fruit Blended','진한 블랙 티에 망고 패션 후르츠 주스가 조합된 아이스 블렌드 음료',5000,'d032.jpg',0,'블렌디드시럽','none','iced',35,'블랙티');      
  
 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d033','d_bl',drink_seq.nextval,'딸기 요거트 블렌디드','Strawberry Yogurt Blended','딸기와 요거트의 상큼함이 가득 느껴지는 가벼운 컨셉의 블렌디드 음료',6100,'d033.jpg',0,'블렌디드시럽','none','iced',0,'우유');      

-- 티 

 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d034','d_te',drink_seq.nextval,'스타벅스 라임 모히토 티','Starbucks Lime Mojito Tea','라임과 사과 과즙이 팡팡 터지는 맑고 청량한 스타벅스 라임 모히토 티',6100,'d034.jpg',0,'없음','none','iced',11,'그린애플베이스');      
  
 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d035','d_te',drink_seq.nextval,'아이스 얼그레이티','Iced Earl Grey Tea','시원하게 즐기는 뜨거운 물에 우려내 라벤더 향의 블랙 티',4100,'d035.jpg',0,'없음','none','iced',50,'물');      

 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d036','d_te',drink_seq.nextval,'얼 그레이 티','Earl Grey Brewed Tea','뜨거운 물에 우려내 라벤더 향이 특징적인 향긋한 블랙 티',4100,'d036.jpg',0,'없음','none','non-iced',50,'물');      
  
 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d037','d_te',drink_seq.nextval,'아이스 차이 티','Iced Chai Brewed Tea','진저, 카르다몸, 이국적인 풍미의 시나몬 등이 블렌딩된 블랙 티.',4100,'d037.jpg',0,'없음','none','iced',45,'물');      

 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d038','d_te',drink_seq.nextval,'차이 티','Chai Brewed Tea','진저, 카르다몸, 이국적인 풍미의 시나몬 등이 블렌딩된 블랙 티.',4100,'d038.jpg',0,'없음','none','non-iced',45,'물');      

 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d039','d_te',drink_seq.nextval,'아이스 제주 유기 녹차','Iced Jeju Organic Green Tea','제주도 산 유기 녹차로만 이루어져 맑은 수색과 신선한 향, 맛이 뛰어난 녹차.',4100,'d039.jpg',0,'없음','none','iced',16,'물');      

 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d040','d_te',drink_seq.nextval,'제주 유기 녹차','Jeju Organic Green Tea','제주도 산 유기 녹차로만 이루어져 맑은 수색과 신선한 향, 맛이 뛰어난 녹차.',4100,'d040.jpg',0,'없음','none','non-iced',16,'물');      


 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d041','d_te',drink_seq.nextval,'아이스 제주 유기 말차 라떼','Iced Jeju Malcha Latte','깊고 진한 말차 본연의 맛과 향을 시원하고 부드럽게 즐길 수 있는 제주 유기농 말차 라떼',6100,'d041.jpg',0,'클래식시럽','none','iced',60,'우유');      
a

-- 기타 제조 음료

 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d045','d_nc',drink_seq.nextval,'시그니처 핫 초콜릿','Signature Hot Chocolate','유럽 스타일의 진한 핫 초콜릿으로 휘핑크림과 코코아 파우더가 토핑된 음료',5300,'d045.jpg',0,'없음','regular','non-iced',15,'우유');      

 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d046','d_nc',drink_seq.nextval,'아이스 시그니처 초콜릿','Iced Signature Chocolate','진한 초콜릿과 시원한 우유에 휘핑과 코코아 파우더가 얹어진 음료.',5300,'d046.jpg',0,'없음','regular','iced',15,'우유');      
  
  
   INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d047','d_nc',drink_seq.nextval,'스팀 우유','Steamed Milk','부드럽고 담백한 따뜻한 우유.',4100,'d047.jpg',0,'없음','none','non-iced',0,'우유');      

 INSERT INTO drink
(id, category_id, drink_seq,name,name_eng,description,price,img,shot,syrup,whipped_cream,temperature,caffein,base) 
VALUES ('d048','d_nc',drink_seq.nextval,'우유','Milk','고소하고 담백한 신선한 우유.',4100,'d048.jpg',0,'없음','none','iced',0,'우유');      


--고객의소리 시퀀스
create sequence feedback_board_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

drop table feedback_post purge;

----고객의 소리 게시판-----
create table feedback_post
(
feedback_board_seq   number                    -- 고객의소리시퀀스
,store_id            varchar2(20)    not null  -- 매장아이디
,userid              varchar2(20)    not null  -- 아이디
,category            varchar2(10)    not null  -- 주제 (문의,칭찬,제안,불만)
,title               varchar2(100)   not null  -- 글제목  
,contents            varchar2(2500)  not null  -- 내용
,hp1                 varchar2(3)               -- 연락처
,hp2                 varchar2(200)             --         
,hp3                 varchar2(200)             --     
,file_attached       varchar2(100)             -- 첨부파일
,file_attached2       varchar2(100)             -- 첨부파일2
,hit                 number  default 0         -- 조회수
,username            varchar2(10)              -- 작성자
,write_day           date default sysdate      -- 작성일
,status              varchar2(10)              -- 상태(접수중,완료)
,constraint PK_feedback_post primary key(feedback_board_seq)
,constraint FK_feedback_post_store_id foreign key(store_id)
                            references shopping_map(storeID)
,constraint FK_feedback_post_userid foreign key(userid)
                            references starbucks_Member(userid)        
);


select *
from feedback_post;

insert into feedback_post (feedback_board_seq, store_id, userid, category, title, contents, hit, username, write_day, status)
values (seq_notice_post.nextval, 'store1', 'gpwjd1789', '문의', '종각점에 레디백 재고 있나요?', '답변빨리해주세요', default, '주혜정', sysdate, '접수중'); 

insert into feedback_post (feedback_board_seq, store_id, userid, category, title, contents, hit, username, write_day, status)
values (seq_notice_post.nextval, 'store2', 'gpwjd1789', '칭찬', '여기지점 맛있어요', '짱이에요', default, '주혜정', sysdate, '접수중'); 

insert into feedback_post (feedback_board_seq, store_id, userid, category, title, contents, hit, username, write_day, status)
values (seq_notice_post.nextval, 'store3', 'gpwjd1789', '불만', '여기지점 더러워요', '청결에 신경을 써주세요', default, '주혜정', sysdate, '접수중'); 

insert into feedback_post (feedback_board_seq, store_id, userid, category, title, contents, hp1, hp2, hp3, file_attached, hit, username, write_day, status)
values (seq_notice_post.nextval, 'store1', 'gpwjd1789', '문의', '종각점에 레디백 재고 있나요?', '답변빨리해주세요', '', '', '', '', default, '주혜정', sysdate, '접수중'); 

commit;

-- 나의 메뉴
create table favorite_menu
(userid          varchar2(20)    not null        -- 아이디
,product_id      varchar2(30)                    -- 제품아이디
,my_menu_seq     number                          -- 나의메뉴시퀀스
,product_name    varchar2(50)                    -- 제품명
,register_day    date default sysdate            -- 등록일
,section         number
,constraint FK_favorite_menu_userid foreign key (userid)
                                      references starbucks_member(userid)
,constraint FK_favorite_menu_proId foreign key (product_id)
                                      references nutrition(product_id)
);



-- 구매 상세
create table purchase_detail
(product_id             varchar2(20)                -- 제품아이디
,slip_num               varchar2(20)                -- 전표번호
,userid                 varchar2(20)   not null     -- 아이디
,store_id               varchar2(20)   not null     -- 매장아이디
,cnt                    number                      -- 주문수량
,price                  number                      -- 금액
,product_code           varchar2(20)                -- 제품코드
,purchase_detail_seq    number                      -- 구매상세시퀀스
,constraint FK_purchase_detail_proId foreign key (product_id)
                                      references nutrition(product_id)
,constraint FK_purchase_detail_slipNum foreign key (slip_num)
                                      references slip(slip_num)
,constraint FK_purchase_detail_userid foreign key (userid)
                                      references member(userid)
,constraint FK_purchase_detail_storeId foreign key (store_id)
                                      references store_location(store_id)
);


-- 전표
create table slip
(slip_num           varchar2(20)               -- 전표번호
,userid             varchar2(20)  not null     -- 아이디
,store_id           varchar2(20)  not null     -- 매장아이디
,purchase_day       date default sysdate       -- 판매일자
,slip_seq           number                     -- 전표시퀀스
,constraint PK_slip primary key(slip_num)
,constraint FK_slip foreign key (userid)
                            references starbucks_member(userid)
,constraint FK_slip_storeId foreign key (store_id)
                            references store_location(store_id)
);






select *
from starbucks_member;

update starbucks_member set point = '5000'
where userid = 'test';

commit;

show user;
-- USER이(가) "MYORAUSER"입니다.

-- /memberRegister.do 를 했을때 회원가입을 위한 테이블 생성 

create table mymvc_member
(userid     varchar2(20) not null
,passwd     varchar2(20) not null
,name       varchar2(20) not null
,email      varchar2(50) not null
,gender     varchar2(1) not null -- M 또는 F
,interest   varchar2(80) 
,registerday date default sysdate -- RR/MM/DD  to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss')
,constraint PK_mymvc_member primary key(userid)
,constraint UQ_mymvc_member_email unique(email) -- 이메일은 고유해야함
);


select *
from mymvc_member;


select userid, name, email, gender, interest,
       to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') AS registerday
from mymvc_member
where userid = 'Superman';

select userid, name, email, gender, interest,
       to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') AS registerday
from mymvc_member
order by registerday desc;


-- mvmvc_member 테이블에 가입인사(introduce) 칼럼 추가하기
alter table mymvc_member
add introduce varchar2(500);

select userid, name, email, gender, interest,
       to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') AS registerday,
       introduce
from mymvc_member
order by registerday desc;

delete mymvc_member
where userid = 'Rainism';

commit;

update mymvc_member set introduce = '<script>window.onload=function(){var arrBody = document.getElementsByTagName("body"); arrBody[0].style.backgroundColor="green"; }</script>'
where userid = 'Sunny';




------------------>>> 쇼핑몰 <<<------------------------

create table mymvc_main_image
(imgno           number not null
,imgfilename     varchar2(100) not null
,constraint PK_mymvc_main_image primary key(imgno)
);

create sequence seq_main_image
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into mymvc_main_image(imgno, imgfilename) values(seq_main_image.nextval, '미샤.png');  
insert into mymvc_main_image(imgno, imgfilename) values(seq_main_image.nextval, '원더플레이스.png'); 
insert into mymvc_main_image(imgno, imgfilename) values(seq_main_image.nextval, '레노보.png'); 
insert into mymvc_main_image(imgno, imgfilename) values(seq_main_image.nextval, '동원.png'); 

commit;

select imgno, imgfilename 
from mymvc_main_image
order by imgno asc;




-------------------------------------------------------
create table tbl_test
(userid     varchar2(20) not null
,name       varchar2(20) not null
,gender     varchar2(1) not null 
,constraint PK_tbl_test primary key(userid)
);

select *
from tbl_test;


--------------------------------------------------------



create table ncstest_member

(userId varchar2(20) not null

,userName varchar2(20) not null

,birthday varchar2(10) not null

,gender number(1) not null

,registerDay date default sysdate

,constraint PK_ncstest_member_userid primary key(userId)

,constraint CK_ncstest_member_gender check( gender in(1,2) )

);

select *
from ncstest_member;

------------------------------------------------시험

create table ncstest_member2
(userId varchar2(20) not null
,userName varchar2(20) not null
,birthday varchar2(10) not null
,gender number(1) not null
,registerDay date default sysdate
,constraint PK_ncstest_member2_userid primary key(userId)
,constraint CK_ncstest_member2_gender check( gender in(1,2) )
);

create table ncstest_member

(userId varchar2(20) not null

,userName varchar2(20) not null

,birthday varchar2(10) not null

,gender number(1) not null

,registerDay date default sysdate

,constraint PK_ncstest_member_userid primary key(userId)

,constraint CK_ncstest_member_gender check( gender in(1,2) )

);

create table ncstest_member
(userId varchar2(20) not null
,userName varchar2(20) not null
,birthday varchar2(10) not null
,gender number(1) not null
,registerDay date default sysdate
,constraint PK_ncstest_member2_userid primary key(userId)
,constraint CK_ncstest_member2_gender check( gender in(1,2) )
);

select *
from ncstest_member2;

delete from ncstest_member2 where userid='tt';

select ceil(89.0), ceil(89.1), ceil(90)
from dual;


--*** (요구사항8) ***
--
--가입된 모든 회원정보가 보여지도록 ncs.memberList.model.NcsMemberDAO 클래스에서 메소드를 생성하는데 그 형태는 List<HashMap<String, String>> memberMapList() throws SQLException; 으로 한다.
--
--여기에 필요한 오라클 사용자 정의함수 func_age(varchar2)를 생성하시오.
--
--오라클 사용자 정의함수 func_age(p_birthday IN varchar2)는 아래와 같은 동작을 한다.
--
--생년월일('19950402') 값을 받아서 현재나이를 리턴시켜주는 사용자정의함수이다.
create or replace function func_age(p_birthday IN varchar2)
return number
is
    v_age number(3);
begin
    v_age := extract(year from sysdate) - to_number(substr(p_birthday,1,4)) + 1;
    return v_age;
end func_age;



--------------*** ajaxstudy 관련 ***--------------
create table test_ajaxnews
(seqtitleno   number not null
,title        varchar2(200) not null
,registerday  date default sysdate not null
,constraint PK_test_ajaxnews_seqtitleno primary key(seqtitleno)
);

create sequence seq_test_ajaxnews_seqtitleno
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into test_ajaxnews(seqtitleno, title) values(seq_test_ajaxnews_seqtitleno.nextval, '''남달라'' 박성현 LPGA 투어 텍사스 클래식 우승, 시즌 첫 승' );
insert into test_ajaxnews(seqtitleno, title) values(seq_test_ajaxnews_seqtitleno.nextval, '뼈아픈 연패-전패, 아직 한번도 못 이겼다고?' );
insert into test_ajaxnews(seqtitleno, title) values(seq_test_ajaxnews_seqtitleno.nextval, '전설들과 어깨 나란히 한 김해림 "4연패도 노려봐야죠"');
insert into test_ajaxnews(seqtitleno, title) values(seq_test_ajaxnews_seqtitleno.nextval, '삼성·현대차 들쑤신 엘리엇, 이번엔 伊 최대통신사 삼켰다');
insert into test_ajaxnews(seqtitleno, title) values(seq_test_ajaxnews_seqtitleno.nextval, '"야구장, 어떤 음악으로 채우나" 응원단장들도 괴롭다');
insert into test_ajaxnews(seqtitleno, title) values(seq_test_ajaxnews_seqtitleno.nextval, '"공부 후 10분의 휴식, 기억력 높인다"');
insert into test_ajaxnews(seqtitleno, title) values(seq_test_ajaxnews_seqtitleno.nextval, '현대차, 쏘나타 ''익스트림 셀렉션'' 트림 출시… 사양과 가격은?');
insert into test_ajaxnews(seqtitleno, title) values(seq_test_ajaxnews_seqtitleno.nextval, '날씨무더위 계속…곳곳 강한 소나기');

commit;

select *
from test_ajaxnews;

select seqtitleno 
     , case when length(title) > 22 then substr(title, 1, 20)||'..'
       else title end AS title
     , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') AS registerday
from test_ajaxnews
order by seqtitleno desc;

create table test_ajaxnews_contents
(fk_seqtitleno  number not null
,newscontents   varchar2(4000) not null
,constraint PK_test_ajaxnews_contents primary key (fk_seqtitleno)
,constraint FK_test_ajaxnews_contents foreign key (fk_seqtitleno) 
                                      references test_ajaxnews(seqtitleno)on delete cascade
                                                                --기사를 없애면 내용도 사라져야하기 때문에
);

insert into test_ajaxnews_contents(fk_seqtitleno, newscontents)
values (1, '박성현 LPGA 투어 텍사스 클래식 우승, 시즌 첫 승');

insert into test_ajaxnews_contents(fk_seqtitleno, newscontents)
values (2, '뼈아픈 연패-전패, 아직 한번도 못 이겼다고?');

insert into test_ajaxnews_contents(fk_seqtitleno, newscontents)
values (3, '전설들과 어깨 나란히 한 김해림 "4연패도 노려봐야죠"');

insert into test_ajaxnews_contents(fk_seqtitleno, newscontents)
values (4, '삼성·현대차 들쑤신 엘리엇, 이번엔 伊 최대통신사 삼켰다');

insert into test_ajaxnews_contents(fk_seqtitleno, newscontents)
values (5, '"야구장, 어떤 음악으로 채우나" 응원단장들도 괴롭다');

insert into test_ajaxnews_contents(fk_seqtitleno, newscontents)
values (6, '"공부 후 10분의 휴식, 기억력 높인다"');

insert into test_ajaxnews_contents(fk_seqtitleno, newscontents)
values (7, '현대차, 쏘나타 트림 출시… 사양과 가격은?');

insert into test_ajaxnews_contents(fk_seqtitleno, newscontents)
values (8, '날씨무더위 계속…곳곳 강한 소나기');

commit;

select fk_seqtitleno, newscontents
from test_ajaxnews_contents
order by fk_seqtitleno desc;


select fk_seqtitleno, newscontents
from test_ajaxnews_contents
where fk_seqtitleno = 8;


select seq_test_ajaxnews_seqtitleno.nextval
from dual;



------------------------------------------------------------------------------------------------

---- GSON 관련

create table test_ajaxemp
(ename varchar2(20)
,jik   varchar2(10)
,tel   varchar2(20)
,email varchar2(30) unique not null
,birthday varchar2(20)
);

select ename, jik, tel, email, birthday 
from test_ajaxemp
order by ename;

create table exam_ajaxmember
(name varchar2(20)
,email varchar2(30) primary key );


select *
from exam_ajaxmember;

insert into exam_ajaxmember values ('곽짱', 'kwak@naver.com');

---------------------------------------------------------------------------------------------

--- *** 회원 테이블 생성 *** ---  
create table mymvc_shopping_member
(idx                number(10)     not null       -- 회원번호(시퀀스로 데이터가 들어온다)
,userid             varchar2(20)   not null       -- 회원아이디
,name               varchar2(30)   not null       -- 회원명
,pwd                varchar2(200)  not null       -- 비밀번호 (SHA-256 암호화 대상)
,email              varchar2(200)  not null       -- 이메일   (AES-256 암호화/복호화 대상)
,hp1                varchar2(3)                   -- 연락처
,hp2                varchar2(200)                 --         (AES-256 암호화/복호화 대상) 국번
,hp3                varchar2(200)                 --         (AES-256 암호화/복호화 대상) 자기 번호
,postcode           varchar2(5)                    -- 우편번호
,address            varchar2(200)                  -- 주소
,detailaddress      varchar2(200)                 -- 상세주소
,extraaddress       varchar2(200)                 -- 참고항목
,gender             varchar2(1)                    -- 성별     남자 : 1 / 여자 : 2
,birthday           varchar2(8)                   -- 생년월일 
,coin               number default 0              -- 코인액
,point              number default 0              -- 포인트 
,registerday        date default sysdate          -- 가입일자
,status             number(1) default 1           -- 회원탈퇴유무   1:사용가능(가입중) / 0:사용불능(탈퇴) 
,lastLoginDate      date default sysdate          -- 마지막으로 로그인 한 날짜시간 기록용
,lastPwdChangeDate  date default sysdate          -- 마지막으로 암호를 변경한 날짜시간 기록용
,clientip           varchar2(20)                  -- 클라이언트의 IP 주소
,constraint   PK_mymvc_shopping_member primary key(idx)
,constraint   UQ_mymvc_shopping_member unique(userid)
,constraint   CK_mymvc_shopping_member_gen check( gender in('1','2') ) 
,constraint   CK_mymvc_shopping_member_sta check( status in(0,1) ) 
);


create sequence seq_shopping_member
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from mymvc_shopping_member
order by idx desc;


select idx, userid, name, email, hp1, hp2, hp3, postcode, address, detailaddress, extraAddress, gender   
     , substr(birthday,1,4) AS birthyyyy, substr(birthday,5,2) AS birthmm, substr(birthday, 7) AS birthdd  
     , coin, point, to_char(registerday,'yyyy-mm-dd') AS registerday  
     , trunc( months_between(sysdate, lastPwdChangeDate) ) AS pwdchangegap  
     , trunc( months_between(sysdate, lastLoginDate) ) AS lastlogindategap 
from mymvc_shopping_member 
order by idx asc;

select idx, userid, name, email, hp1, hp2, hp3, postcode, address, detailaddress, extraAddress, gender   
     , substr(birthday,1,4) AS birthyyyy, substr(birthday,5,2) AS birthmm, substr(birthday, 7) AS birthdd  
     , coin, point, to_char(registerday,'yyyy-mm-dd') AS registerday  
     , trunc( months_between(sysdate, lastPwdChangeDate) ) AS pwdchangegap  
     , trunc( months_between(sysdate, lastLoginDate) ) AS lastlogindategap 
from mymvc_shopping_member 
where userid = 'test01' and pwd = '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382';


select userid, to_char (lastlogindate, 'yyyy-mm-dd hh24:mi:ss') as "마지막 로그인 시각"
from mymvc_shopping_member 
where userid = 'test01';

update mymvc_shopping_member set lastlogindate = add_months(lastlogindate, -13) -- 13개월 뺌
where userid = 'test01';

commit;

update mymvc_shopping_member set lastlogindate = sysdate
where userid = 'test01';

update mymvc_shopping_member set lastpwdchangedate = add_months(lastpwdchangedate, -4)
where userid = 'juju';

commit;


select userid, to_char (lastpwdchangedate, 'yyyy-mm-dd hh24:mi:ss') as "마지막 암호 변경 시각"
from mymvc_shopping_member 
where userid = 'juju';


select userid
from mymvc_shopping_member 
where status = 1 and
        name = '쥬쥬' and 
        trim(hp1) || trim(hp2) || trim(hp3) = '01023456789';
        
        
update mymvc_shopping_member  set pwd = ?
where userid = ? ;



select 10+20, 10+'20', 10+to_number('20')
from dual;

select *
from mymvc_shopping_member
where userid != 'admin';


create or replace procedure pcd_shopping_member_insert
(p_userid  IN  varchar2
,p_name    IN  varchar2
,p_gender  IN  char)
is
begin
    for i in 1..100 loop 
        insert into mymvc_shopping_member(idx, userid, name, pwd, email, hp1, hp2, hp3, postcode, address, detailAddress, extraAddress, gender, birthday, coin, point, registerday, status, lastlogindate, lastpwdchangedate, clientip) 
        values(seq_shopping_member.nextval, p_userid||i, p_name||i, '0208788aa2035cd5be6697efbd285df1afa881c8fd25e4bd5bbb247c29c58454', 'sxNpwOHUNLp91xhVQczFwhXeDJlgw9iDsy8fIyoyj+g=' , '010', 'lvQpJHHcv9BajDlHmcleFA==', 'xlSJbVV0F2KyPWzzhc+OaA==', '50234', '서울 송파구 오금로 95', '337동 708호', '오금동 현대아파트', p_gender, '19960920', default, default, default, default, default, default, '127.0.0.1');         
    end loop;
end pcd_shopping_member_insert;   
-- Procedure PCD_SHOPPING_MEMBER_INSERT이(가) 컴파일되었습니다.  

exec pcd_shopping_member_insert('TaeYeon', '김태연', '2');

exec pcd_shopping_member_insert('VIINI', '권현빈', '1');

drop table mymvc_shopping_member;

commit;

select *
from mymvc_shopping_member
order by idx desc;




------- ***** 페이징 처리하기 ***** -------

select rownum, idx, userid, name, email, gender
--      행번호
from mymvc_shopping_member
where rownum between 1 and 10 -- 1페이지
order by idx desc;

-- rownum은 where 절에 바로 사용할 수 없다. 11 and 20은 2페이지인데 써보면 결과 아무것도 안나옴.
-- 하지만 inline view를 쓰면 where절에서 사용할 수 있다.

select RNO, idx, userid, name, email, gender
from 
(
    select rownum AS RNO, idx, userid, name, email, gender
    from
    (
    select idx, userid, name, email, gender
    from mymvc_shopping_member
    order by idx desc
    ) V
) T
where T.RNO between 1 and 10; ------ 한페이지당 10개씩 보여주는 1 페이지 내용

select RNO, idx, userid, name, email, gender
from 
(
    select rownum AS RNO, idx, userid, name, email, gender
    from
    (
    select idx, userid, name, email, gender
    from mymvc_shopping_member
    order by idx desc
    ) V
) T
where T.RNO between 1 and 5; ------ 한페이지당 5개씩 보여주는 1 페이지 내용


select RNO, idx, userid, name, email, gender
from 
(
    select rownum AS RNO, idx, userid, name, email, gender
    from
    (
    select idx, userid, name, email, gender
    from mymvc_shopping_member
    order by idx desc
    ) V
) T
where T.RNO between 11 and 20; ------ 2 페이지 내용

select RNO, idx, userid, name, email, gender
from 
(
    select rownum AS RNO, idx, userid, name, email, gender
    from
    (
    select idx, userid, name, email, gender
    from mymvc_shopping_member
    order by idx desc
    ) V
) T
where T.RNO between 4 and 6; ------ 한 페이지당 3개씩 보여주는 2 페이지 내용

select RNO, idx, userid, name, email, gender
from 
(
    select rownum AS RNO, idx, userid, name, email, gender
    from
    (
    select idx, userid, name, email, gender
    from mymvc_shopping_member
    order by idx desc
    ) V
) T
where T.RNO between 21 and 30; ------ 3 페이지 내용

---  1 페이지당 10명(개)씩 보여주려면 총 페이지갯수는 얼마일까요?
select count(*)
from mymvc_shopping_member; -- 행 갯수

select (select count(*) from mymvc_shopping_member) / 10
from dual; -- 20.7
-- 1 2 3 4 5 ....... 18 19 20

select 20.70, 21, ceil(20.7), ceil(21)
from dual;

select ceil ((select count(*) from mymvc_shopping_member) / 10) AS 총페이지수
from dual; --21

select ceil (count(*)/10) AS 총페이지수
from mymvc_shopping_member; --21

select ceil ((select count(*) from mymvc_shopping_member) / 5) AS 총페이지수
from dual; --42

select ceil ((select count(*) from mymvc_shopping_member) / 3) AS 총페이지수
from dual;  --69




-----------------------------------------------------------------------------------

--- *** 검색된 결과물 페이징 처리하기 *** --- 
select RNO, idx, userid, name, email, gender
from 
(
    select rownum AS RNO, idx, userid, name, email, gender
    from
    (
    select idx, userid, name, email, gender
    from mymvc_shopping_member
    where name like '%' || '태' || '%' --- 이름에 '태'가 있는 사람
    order by idx desc
    ) V
) T
where T.RNO between 1 and 10; ------ 한페이지당 10개씩 보여주는 1 페이지 내용


select RNO, idx, userid, name, email, gender
from 
(
    select rownum AS RNO, idx, userid, name, email, gender
    from
    (
    select idx, userid, name, email, gender
    from mymvc_shopping_member
    where name like '%' || '태' || '%' --- 이름에 '태'가 있는 사람
    order by idx desc
    ) V
) T
where T.RNO between 1 and 5; ------ 한페이지당 5개씩 보여주는 1 페이지 내용


select RNO, idx, userid, name, email, gender
from 
(
    select rownum AS RNO, idx, userid, name, email, gender
    from
    (
    select idx, userid, name, email, gender
    from mymvc_shopping_member
    where name like '%' || '태' || '%' --- 이름에 '태'가 있는 사람
    order by idx desc
    ) V
) T
where T.RNO between 1 and 3; ------ 한페이지당 3개씩 보여주는 1 페이지 내용


---  검색된 결과물을 페이징 처리할때 1 페이지당 10명(개)씩 보여주려면 총 페이지갯수는 얼마일까요?
select count(*)
from mymvc_shopping_member
where name like '%' || '태' || '%'; -- 행 갯수 100

select ceil ( count(*)/ 10 ) AS 총페이지수
from mymvc_shopping_member
where name like '%' || '태' || '%'; -- 10

select ceil ( count(*)/ 5 ) AS 총페이지수
from mymvc_shopping_member
where name like '%' || '태' || '%'; -- 20

select ceil ( count(*)/ 3 ) AS 총페이지수
from mymvc_shopping_member
where name like '%' || '태' || '%'; -- 34




---------------------------------------------------------------------------------------------
/*
   카테고리 테이블명 : shopping_category

   컬럼정의 
     -- 카테고리 대분류 번호  : 시퀀스(seq_shopping_category_cnum)로 증가함.(Primary Key)
     -- 카테고리 코드(unique) : ex) 전자제품  '100000'
                                  의류      '200000'
                                  도서      '300000' 
     -- 카테고리명(not null)  : 전자제품, 의류, 도서           
  
*/ 
 
create table shopping_category
(cnum    number(8)     not null  -- 카테고리 대분류 번호
,code    varchar2(20)  not null  -- 카테고리 코드
,cname   varchar2(100) not null  -- 카테고리명
,constraint PK_shopping_category_cnum primary key(cnum)
,constraint UQ_shopping_category_code unique(code)
);

create sequence seq_shopping_category_cnum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into shopping_category values(seq_shopping_category_cnum.nextval, '100000', '전자제품');
insert into shopping_category values(seq_shopping_category_cnum.nextval, '200000', '의류');
insert into shopping_category values(seq_shopping_category_cnum.nextval, '300000', '도서');
commit;

-- 나중에 넣습니다.
--insert into shopping_category values(seq_shopping_category_cnum.nextval, '400000', '식품');
--commit;

insert into shopping_category values(seq_shopping_category_cnum.nextval, '500000', '신발');
commit;

delete from shopping_category 
where code = '500000';

select cnum, code, cname
from shopping_category
order by cnum asc;


create table shopping_spec
(snum    number(8)     not null  -- 스펙번호       
,sname   varchar2(100) not null  -- 스펙명         
,constraint PK_shopping_spec_snum primary key(snum)
,constraint UQ_shopping_spec_sname unique(sname)
);

create sequence seq_shopping_spec
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into shopping_spec(snum, sname) values(seq_shopping_spec.nextval, 'HIT');
insert into shopping_spec(snum, sname) values(seq_shopping_spec.nextval, 'NEW');
insert into shopping_spec(snum, sname) values(seq_shopping_spec.nextval, 'BEST');

commit;

select snum, sname
from shopping_spec
order by snum asc;

select *
from shopping_product
where to_char(pnum) = '1';

select *
from shopping_product
where to_char(pnum) = '사용자의 장난';

---- *** 제품 테이블 : shopping_product *** ----
create table shopping_product
(pnum           number(8) not null       -- 제품번호(Primary Key)
,pname          varchar2(100) not null   -- 제품명
,pcategory_fk   varchar2(20)             -- 카테고리코드(Foreign Key)
,pcompany       varchar2(50)             -- 제조회사명
,pimage1        varchar2(100) default 'noimage.png' -- 제품이미지1   이미지파일명
,pimage2        varchar2(100) default 'noimage.png' -- 제품이미지2   이미지파일명 
,pqty           number(8) default 0      -- 제품 재고량
,price          number(8) default 0      -- 제품 정가
,saleprice      number(8) default 0      -- 제품 판매가(할인해서 팔 것이므로)
,pspec          varchar2(20)             -- 'HIT', 'BEST', 'NEW' 등의 값을 가짐.
,pcontent       varchar2(4000)           -- 제품설명  varchar2는 varchar2(4000) 최대값이므로
                                         --          4000 byte 를 초과하는 경우 clob 를 사용한다.
                                         --          clob 는 최대 4GB 까지 지원한다.
                                         
,point          number(8) default 0      -- 포인트 점수                                         
,pinputdate     date default sysdate     -- 제품입고일자
,constraint  PK_shopping_product_pnum primary key(pnum)
,constraint  FK_shopping_product foreign key(pcategory_fk) references shopping_category(code)
);

create sequence seq_shopping_product_pnum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                             pimage1, pimage2, pqty, price, saleprice,
                             pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '스마트TV', '100000', '삼성',
       'tv_samsung_h450_1.png','tv_samsung_h450_2.png',
       100,1200000,800000,'HIT','42인치 스마트 TV. 기능 짱!!', 50);


insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                             pimage1, pimage2, pqty, price, saleprice,
                             pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북', '100000', '엘지',
       'notebook_lg_gt50k_1.png','notebook_lg_gt50k_2.png',
       150,900000,750000,'HIT','노트북. 기능 짱!!', 30);  
       

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                             pimage1, pimage2, pqty, price, saleprice,
                             pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '바지', '200000', 'S사',
       'cloth_canmart_1.png','cloth_canmart_2.png',
       20,12000,10000,'HIT','예뻐요!!', 5);       
       

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                             pimage1, pimage2, pqty, price, saleprice,
                             pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '남방', '200000', '버카루',
       'cloth_buckaroo_1.png','cloth_buckaroo_2.png',
       50,15000,13000,'HIT','멋져요!!', 10);       
       

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                             pimage1, pimage2, pqty, price, saleprice,
                             pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '세계탐험보물찾기시리즈', '300000', '아이세움',
       'book_bomul_1.png','book_bomul_2.png',
       100,35000,33000,'HIT','만화로 보는 세계여행', 20);       
       
       
insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                             pimage1, pimage2, pqty, price, saleprice,
                             pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '만화한국사', '300000', '녹색지팡이',
       'book_koreahistory_1.png','book_koreahistory_2.png',
       80,130000,120000,'HIT','만화로 보는 이야기 한국사 전집', 60);
       

-----------------------------------------------------------------------
insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북1', '100000', 'DELL',
       '1.jpg','2.jpg',
       100,1200000,1000000,'HIT','1번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북2', '100000', '에이서',
       '3.jpg','4.jpg',
       100,1200000,1000000,'HIT','2번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북3', '100000', 'LG전자',
       '5.jpg','6.jpg',
       100,1200000,1000000,'HIT','3번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북4', '100000', '레노버',
       '7.jpg','8.jpg',
       100,1200000,1000000,'HIT','4번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북5', '100000', '삼성전자',
       '9.jpg','10.jpg',
       100,1200000,1000000,'HIT','5번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북6', '100000', 'HP',
       '11.jpg','12.jpg',
       100,1200000,1000000,'HIT','6번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북7', '100000', '레노버',
       '13.jpg','14.jpg',
       100,1200000,1000000,'HIT','7번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북8', '100000', 'LG전자',
       '15.jpg','16.jpg',
       100,1200000,1000000,'HIT','8번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북9', '100000', '한성컴퓨터',
       '17.jpg','18.jpg',
       100,1200000,1000000,'HIT','9번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북10', '100000', 'MSI',
       '19.jpg','20.jpg',
       100,1200000,1000000,'HIT','10번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북11', '100000', 'LG전자',
       '21.jpg','22.jpg',
       100,1200000,1000000,'HIT','11번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북12', '100000', 'HP',
       '23.jpg','24.jpg',
       100,1200000,1000000,'HIT','12번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북13', '100000', '레노버',
       '25.jpg','26.jpg',
       100,1200000,1000000,'HIT','13번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북14', '100000', '레노버',
       '27.jpg','28.jpg',
       100,1200000,1000000,'HIT','14번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북15', '100000', '한성컴퓨터',
       '29.jpg','30.jpg',
       100,1200000,1000000,'HIT','15번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북16', '100000', '한성컴퓨터',
       '31.jpg','32.jpg',
       100,1200000,1000000,'HIT','16번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북17', '100000', '레노버',
       '33.jpg','34.jpg',
       100,1200000,1000000,'HIT','17번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북18', '100000', '레노버',
       '35.jpg','36.jpg',
       100,1200000,1000000,'HIT','18번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북19', '100000', 'LG전자',
       '37.jpg','38.jpg',
       100,1200000,1000000,'HIT','19번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북20', '100000', 'LG전자',
       '39.jpg','40.jpg',
       100,1200000,1000000,'HIT','20번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북21', '100000', '한성컴퓨터',
       '41.jpg','42.jpg',
       100,1200000,1000000,'HIT','21번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북22', '100000', '에이서',
       '43.jpg','44.jpg',
       100,1200000,1000000,'HIT','22번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북23', '100000', 'DELL',
       '45.jpg','46.jpg',
       100,1200000,1000000,'HIT','23번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북24', '100000', '한성컴퓨터',
       '47.jpg','48.jpg',
       100,1200000,1000000,'HIT','24번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북25', '100000', '삼성전자',
       '49.jpg','50.jpg',
       100,1200000,1000000,'HIT','25번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북26', '100000', 'MSI',
       '51.jpg','52.jpg',
       100,1200000,1000000,'HIT','26번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북27', '100000', '애플',
       '53.jpg','54.jpg',
       100,1200000,1000000,'HIT','27번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북28', '100000', '아수스',
       '55.jpg','56.jpg',
       100,1200000,1000000,'HIT','28번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북29', '100000', '레노버',
       '57.jpg','58.jpg',
       100,1200000,1000000,'HIT','29번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북30', '100000', '삼성전자',
       '59.jpg','60.jpg',
       100,1200000,1000000,'HIT','30번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북31', '100000', 'MSI',
       '61.jpg','62.jpg',
       100,1200000,1000000,'NEW','31번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북32', '100000', '삼성전자',
       '63.jpg','64.jpg',
       100,1200000,1000000,'NEW','32번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북33', '100000', '한성컴퓨터',
       '65.jpg','66.jpg',
       100,1200000,1000000,'NEW','33번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북34', '100000', 'HP',
       '67.jpg','68.jpg',
       100,1200000,1000000,'NEW','34번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북35', '100000', 'LG전자',
       '69.jpg','70.jpg',
       100,1200000,1000000,'NEW','35번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북36', '100000', '한성컴퓨터',
       '71.jpg','72.jpg',
       100,1200000,1000000,'NEW','36번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북37', '100000', '삼성전자',
       '73.jpg','74.jpg',
       100,1200000,1000000,'NEW','37번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북38', '100000', '레노버',
       '75.jpg','76.jpg',
       100,1200000,1000000,'NEW','38번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북39', '100000', 'MSI',
       '77.jpg','78.jpg',
       100,1200000,1000000,'NEW','39번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북40', '100000', '레노버',
       '79.jpg','80.jpg',
       100,1200000,1000000,'NEW','40번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북41', '100000', '레노버',
       '81.jpg','82.jpg',
       100,1200000,1000000,'NEW','41번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북42', '100000', '레노버',
       '83.jpg','84.jpg',
       100,1200000,1000000,'NEW','42번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북43', '100000', 'MSI',
       '85.jpg','86.jpg',
       100,1200000,1000000,'NEW','43번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북44', '100000', '한성컴퓨터',
       '87.jpg','88.jpg',
       100,1200000,1000000,'NEW','44번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북45', '100000', '애플',
       '89.jpg','90.jpg',
       100,1200000,1000000,'NEW','45번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북46', '100000', '아수스',
       '91.jpg','92.jpg',
       100,1200000,1000000,'NEW','46번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북47', '100000', '삼성전자',
       '93.jpg','94.jpg',
       100,1200000,1000000,'NEW','47번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북48', '100000', 'LG전자',
       '95.jpg','96.jpg',
       100,1200000,1000000,'NEW','48번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북49', '100000', '한성컴퓨터',
       '97.jpg','98.jpg',
       100,1200000,1000000,'NEW','49번 노트북', 60);

insert into shopping_product(pnum, pname, pcategory_fk, pcompany, 
                        pimage1, pimage2, pqty, price, saleprice,
                        pspec, pcontent, point)
values(seq_shopping_product_pnum.nextval, '노트북50', '100000', '레노버',
       '99.jpg','100.jpg',
       100,1200000,1000000,'NEW','50번 노트북', 60);


commit;

select pnum, pname, pcategory_fk, pcompany, pimage1, pimage2, pqty, price, saleprice, pspec, pcontent, point, pinputdate
from
(
select row_number () over(order by pnum asc) as RNO
     , pnum, pname, pcategory_fk, pcompany, pimage1, pimage2, pqty, price, saleprice, pspec, pcontent, point
     , to_char(pinputdate, 'yyyy-mm-dd') as pinputdate
from shopping_product 
where pspec = 'HIT'
)V
where RNO between 1 and 8;

------------------------------------------------------------------------
       
commit;     

select pnum, pname, pcategory_fk, pcompany, pimage1, pimage2, pqty, price, saleprice, pspec, pcontent, point
     , to_char(pinputdate, 'yyyy-mm-dd') as pinputdate
from shopping_product
where pspec = 'HIT'
order by pnum asc;

select cnum, code, cname
from shopping_category
order by cnum asc;



----- >>> 하나의 제품속에 여러개의 이미지 파일 넣어주기 <<< ------ 
select *
from shopping_product
order by pnum;  

create table shopping_product_imagefile
(imgfileno     number         not null   -- 시퀀스로 입력받음.
,fk_pnum       number(8)      not null   -- 제품번호(foreign key)
,imgfilename   varchar2(100)  not null   -- 제품이미지파일명
,constraint PK_shopping_product_imagefile primary key(imgfileno)
,constraint FK_shopping_product_imagefile foreign key(fk_pnum) references shopping_product(pnum)
);


create sequence seqImgfileno
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select imgfileno, fk_pnum, imgfilename
from shopping_product_imagefile
order by imgfileno desc;


select A.cname, pnum, pname, pcategory_fk, pcompany, pimage1, pimage2, pqty, price, saleprice, pspec, pcontent, point 
	 , to_char(pinputdate, 'yyyy-mm-dd') as pinputdate
from jsp_category A left join shopping_product B 
on A.code = B.pcategory_fk 
where A.code = '400000'
order by pnum desc;

select *
from shopping_product
where pnum = 'asfsdfsfsdfsdfsdfsdf';

select *
from shopping_product
where pnum = '3';
 
select *
from shopping_product
where to_char(pnum) = 'asfsdfsfsdfsdfsdfsdf'; 

select *
from shopping_product
where to_char(pnum) = '3'; 


------------------------------------------------------------
-------- **** 상품구매 후기 테이블 생성하기 **** ----------
create table shopping_purchase_reviews
(no                  number 
,fk_userid           varchar2(20)   not null   --  사용자ID       
,fk_pnum             number(8)      not null   -- 제품번호(foreign key)
,reviewsContents     varchar2(4000) not null
,writeDate           date default sysdate
,constraint PK_purchase_reviews primary key(no)
,constraint FK_purchase_reviews_userid foreign key(fk_userid) 
                                       references mymvc_shopping_member(userid)
,constraint FK_purchase_reviews_pnum foreign key(fk_pnum) 
                                     references shopping_product(pnum)
);

create sequence seq_purchase_reviews
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from shopping_purchase_reviews
order by no desc;

select no, name, fk_pnum, reviewsContents, to_char(writeDate, 'yyyy-mm-dd hh24:mi:ss') AS writeDate
from shopping_purchase_reviews A join mymvc_shopping_member B
on A.fk_userid = B.userid 
where fk_pnum = 1
order by no desc; 


-------- **** 장바구니 테이블 생성하기 **** ----------

 desc mymvc_shopping_member;
 desc shopping_product;

 create table shopping_cart
 (cartno     number               not null   --  장바구니 번호             
 ,fk_userid  varchar2(20)         not null   --  사용자ID            
 ,fk_pnum    number(8)            not null   --  제품번호                
 ,oqty       number(8) default 0  not null   --  주문량                   
 ,status     number(1) default 1             --  삭제유무
 ,constraint PK_shopping_cart_cartno primary key(cartno)
 ,constraint FK_shopping_cart_fk_userid foreign key(fk_userid)
                                        references mymvc_shopping_member(userid) 
 ,constraint FK_shopping_cart_fk_pnum foreign key(fk_pnum)
                                      references shopping_product(pnum)
 ,constraint CK_shopping_cart_status check( status in(0,1) ) 
 );

 create sequence seq_shopping_cart_cartno
 start with 1
 increment by 1
 nomaxvalue
 nominvalue
 nocycle
 nocache;

 comment on table shopping_cart
 is '장바구니 테이블';

 comment on column shopping_cart.cartno
 is '장바구니번호(시퀀스명 : seq_jsp_cart_cartno)';

 comment on column shopping_cart.fk_userid
 is '회원ID  jsp_member 테이블의 userid 컬럼을 참조한다.';

 comment on column shopping_cart.fk_pnum
 is '제품번호 shopping_product 테이블의 pnum 컬럼을 참조한다.';

 comment on column shopping_cart.oqty
 is '장바구니에 담을 제품의 주문량';

 comment on column shopping_cart.status
 is '장바구니에 담겨져 있으면 1, 장바구니에서 비우면 0';

 select *
 from user_tab_comments;

 select column_name, comments
 from user_col_comments
 where table_name = 'SHOPPING_CART';
 
 select cartno, fk_userid, fk_pnum, oqty, status
 from jsp_cart
 order by cartno asc;
  
 desc shopping_product;
 
 select A.cartno, A.fk_userid, A.fk_pnum, B.pname, B.pcategory_fk,
        B.pimage1, B.price, B.saleprice, B.point, A.oqty, A.status
 from shopping_cart A join shopping_product B
 on A.fk_pnum = B.pnum
 where A.status = 1 and A.fk_userid = 'jwjw'
 order by A.cartno desc;
 
 
 select A.cartno, A.fk_userid, A.fk_pnum, B.pname, B.pcategory_fk,
        B.pimage1, B.price, B.saleprice, B.point, A.oqty, A.status
 from shopping_cart A join shopping_product B
 on A.fk_pnum = B.pnum
 where A.status = 1 and A.fk_userid = 'jwjw'
 order by A.cartno desc;
 
 
 select cartno, fk_userid, fk_pnum, pname, pcategory_fk,
        pimage1, price, saleprice, point, oqty, status
 from 
 (
     select row_number() over (order by cartno desc) AS RNO,
            A.cartno, A.fk_userid, A.fk_pnum, B.pname, B.pcategory_fk,
            B.pimage1, B.price, B.saleprice, B.point, A.oqty, A.status
     from shopping_cart A join shopping_product B
     on A.fk_pnum = B.pnum
     where A.status = 1 and A.fk_userid = 'seoyh' 
 ) V 
 where RNO between 1 and 3;
 
 
 select cartno, fk_userid, fk_pnum, pname, pcategory_fk,
        pimage1, price, saleprice, point, oqty, status
 from 
 (
     select row_number() over (order by cartno desc) AS RNO,
            A.cartno, A.fk_userid, A.fk_pnum, B.pname, B.pcategory_fk,
            B.pimage1, B.price, B.saleprice, B.point, A.oqty, A.status
     from shopping_cart A join shopping_product B
     on A.fk_pnum = B.pnum
     where A.status = 1 and A.fk_userid = 'seoyh' 
 ) V 
 where RNO between 4 and 6;
 
 
 select cartno, fk_userid, fk_pnum, pname, pcategory_fk,
        pimage1, price, saleprice, point, oqty, status
 from 
 (
     select row_number() over (order by cartno desc) AS RNO,
            A.cartno, A.fk_userid, A.fk_pnum, B.pname, B.pcategory_fk,
            B.pimage1, B.price, B.saleprice, B.point, A.oqty, A.status
     from shopping_cart A join shopping_product B
     on A.fk_pnum = B.pnum
     where A.status = 1 and A.fk_userid = 'seoyh' 
 ) V 
 where RNO between 7 and 9;


select row_number() over(order by pnum desc) AS RNO
    , C.cname, pnum, pname, pimage1, price, saleprice, point
from shopping_category C LEFT JOIN shopping_product P 
on C.code = P.pcategory_fk
where C.code = 400000; 


select nvl(sum(oqty * saleprice), 0) AS SUMTOTALPRICE
     , nvl(sum(oqty * point), 0) AS SUMTOTALPOINT
from shopping_cart A join shopping_product B
on A.fk_pnum = B.pnum
where status = 1 and fk_userid = 'jwjw';


select nvl(sum(oqty * saleprice), 0) AS SUMTOTALPRICE
     , nvl(sum(oqty * point), 0) AS SUMTOTALPOINT
from shopping_cart A join shopping_product B
on A.fk_pnum = B.pnum
where status = 1 and fk_userid = 'jwjw';


select oqty, saleprice, point
from shopping_cart A join shopping_product B
on A.fk_pnum = B.pnum
where status = 1 and fk_userid = 'jwjw';

select oqty, saleprice, point, oqty*saleprice, oqty*point
from shopping_cart A join shopping_product B
on A.fk_pnum = B.pnum
where status = 1 and fk_userid = 'jwjw';



update shopping_cart set status = 1;
commit;

select cartno, fk_userid, fk_pnum, oqty, status
from shopping_cart
order by cartno asc;

update shopping_cart set status = 1;
commit;

update shopping_cart set oqty = oqty +

delete from shopping_cart 
where status = 0;

commit;



-------- **** 매장찾기(카카오지도) 테이블 생성하기 **** ----------
create table shopping_map 
(storeID       varchar2(20) not null   --  매장id
,storeName     varchar2(100) not null  --  매장명
,storeUrl      varchar2(200)            -- 매장 홈페이지(URL)주소
,storeImg      varchar2(200) not null   -- 매장소개 이미지파일명  
,storeAddress  varchar2(200) not null   -- 매장주소 및 매장전화번호
,lat           number not null          -- 위도
,lng           number not null          -- 경도 
,zindex        number not null          -- zindex 
,constraint PK_shopping_map primary key(storeID)
,constraint UQ_shopping_map_zindex unique(zindex)
);

create sequence seq_shopping_map_zindex
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into shopping_map(storeID, storeName, storeUrl, storeImg, storeAddress, lat, lng, zindex)
values('store1','롯데백화점 본점','https://place.map.kakao.com/7858517','lotte02.png','서울 중구 을지로 30 (T)02-771-2500',37.56511284953554,126.98187860455485,1);

insert into shopping_map(storeID, storeName, storeUrl, storeImg, storeAddress, lat, lng, zindex)
values('store2','KH정보교육원 종로지원','https://place.map.kakao.com/276378404','kh01.png','서울 중구 남대문로 120 대일빌딩 2,3층 (T)1544-9970',37.56800975043258,126.9832248918777,2);

insert into shopping_map(storeID, storeName, storeUrl, storeImg, storeAddress, lat, lng, zindex)
values('store3','미래에셋센터원빌딩','https://place.map.kakao.com/13057692','miraeeset.png','서울 중구 을지로5길 26 (T)02-6030-0100',37.567386065415086,126.98512381778167,3);

insert into shopping_map(storeID, storeName, storeUrl, storeImg, storeAddress, lat, lng, zindex)
values('store4','신세계백화점 본점','https://place.map.kakao.com/7969138','shinsegae.png','서울 중구 소공로 63 (T)1588-1234',37.56091181255155,126.98098265772731,4);

commit;

select storeID, storeName, storeUrl, storeImg, storeAddress, lat, lng, zindex
from shopping_map
order by zindex asc;








--------------------시험--------------------
create table ncstest_comments
(no                  number 
,commentContents     varchar2(4000) not null
,writeDate           date default sysdate
,constraint PK_ncstest_comments primary key(no)
);

create sequence seq_ncstest_comments
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from ncstest_comments;

insert into ncstest_comments(no, commentContents, writeDate)
values(1, '테스트', default)

insert into ncstest_comments(no, commentContents, writeDate)
values(seq_ncstest_comments.nextval, ?, default)


    
    
  
-- 음료+푸드 사진정보
(select N.parent_table, id, category_id, name, name_eng, description, price, img
from drink D, nutrition N
where D.id = N.product_id)
union all
(select N.parent_table, id, category_id, name, name_eng, description, price, img
from food F, nutrition N
where F.id = N.product_id);



commit;

-- 음료+푸드 영양정보
(select product_id,nutrition_Seq,kcal,sodium,cholesterol,sugar, protein,allergy_Triggers
from drink D, nutrition N
where D.id = N.product_id)
union all
(select product_id,nutrition_Seq,kcal,sodium,cholesterol,sugar, protein,allergy_Triggers
from food F, nutrition N
where F.id = N.product_id);  
    
 create sequence favorite_menu_seq
 start with 1
 increment by 1
 nomaxvalue
 nominvalue
 nocycle
 nocache;
 
select userid, 
       row_number() over(order by my_menu_seq asc) AS No, 
       my_menu_seq, product_name, section 
from favorite_menu;

 
 
select *
from starbucks_member;
