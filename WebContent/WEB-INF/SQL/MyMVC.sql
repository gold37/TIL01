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
       
commit;     

select pnum, pname, pcategory_fk, pcompany, pimage1, pimage2, pqty, price, saleprice, pspec, pcontent, point
     , to_char(pinputdate, 'yyyy-mm-dd') as pinputdate
from shopping_product
where pspec = 'HIT'
order by pnum asc;

select cnum, code, cname
from shopping_category
order by cnum asc;


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
 where A.status = 1 and A.fk_userid = 'leess'
 order by A.cartno desc;
 
 
 select A.cartno, A.fk_userid, A.fk_pnum, B.pname, B.pcategory_fk,
        B.pimage1, B.price, B.saleprice, B.point, A.oqty, A.status
 from shopping_cart A join shopping_product B
 on A.fk_pnum = B.pnum
 where A.status = 1 and A.fk_userid = 'seoyh'
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
where status = 1 and fk_userid = 'seoyh';


select nvl(sum(oqty * saleprice), 0) AS SUMTOTALPRICE
     , nvl(sum(oqty * point), 0) AS SUMTOTALPOINT
from shopping_cart A join shopping_product B
on A.fk_pnum = B.pnum
where status = 1 and fk_userid = 'hongkd';

update shopping_cart set status = 1;
commit;

select cartno, fk_userid, fk_pnum, oqty, status
from shopping_cart
order by cartno asc;

delete from shopping_cart 
where status = 0;

commit;
