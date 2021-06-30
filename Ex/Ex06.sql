--webdb
create table book(
    book_id number(5),
    title varchar2(50),
    author varchar2(10),
    pub_date date
);


alter table book add(pubs varchar2(50));

alter table book modify(title varchar2(100));

alter table book rename column title to subject;

alter table book drop(author);

rename book to article;

create table author (
    author_id  number(10),
    author_name varchar2(100) not null,
    author_desc varchar2(500),
    primary key(author_id)
);

create table book (
    book_id number(10),
    title varchar2(100) not null,
    pubs varchar2(100),
    pub_date date,
    author_id number(10),
    primary key(book_id),
    constraint book_fk foreign key(author_id) 
    references author(author_id)
);


insert into author values(1, '박경리', '토지 작가');

select *
from author;

insert into author(author_id, author_name)
values (2, '이문열');

update author
set author_name = '기안94', 
    author_desc = '웹툰작가'
where author_id = 1;

rollback;

insert into author values(1, '박경리', '토지 작가');
commit;
insert into author values(2, '기안84', '웹툰작가');
insert into author values(3, '이문열', '인기작가');

update author
set author_desc = '나혼자산다 출연'
where author_id = 2; 

insert update delete;

rollback;

delete from author;
commit;

create SEQUENCE seq_author_id
INCREMENT by 1
START with 1
NOCACHE;

seq_author_id.nextval;

insert into author values(seq_author_id.nextval, '기안84', '웹툰작가');
insert into author values(seq_author_id.nextval, '이문열', '작가');
insert into author values(seq_author_id.nextval, '박경리', '작가');


