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



select ceil(89.0), ceil(89.1), ceil(90)
from dual;


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



