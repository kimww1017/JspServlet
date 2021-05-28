drop table membership;

create table membership 
(	
	user_id varchar2(30), 
	pass varchar2(30) not null, 
	name varchar2(30) not null, 
	gender char(3) not null, 
	birthday varchar2(20) not null, 
	zipcode char(5) not null, 
	address1 varchar2(50) not null, 
	address2 varchar2(100) not null, 
	email varchar2(100) not null, 
	mobile varchar2(13) not null, 
	tel varchar2(13) not null, 
	regidate date default sysdate not null  
) ;
/*
user_id, pass, name, gender, birthday, zipcode, address1, address2, 
email, mobile, tel, regidate
*/
alter table membership add constraint "membership_pk" primary key (user_id);
