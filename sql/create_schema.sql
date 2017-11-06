/*
    @author Joe Williams
    Software Engineering : East Carolina University
    PirateNotes
*/

# CAREFUL THIS WILL DELETE ALL THE DATA IN THE DATABASE
drop database piratenotes;
create database piratenotes;

use piratenotes;

# user
create table user (
    id varchar(32) not null,
    email varchar(64) not null unique,
    password varchar(256) not null,
    firstname varchar(64) not null,
    lastname varchar(64) not null,
    profile_image mediumblob,
    profile_image_size int,
    profile_desc text,
    acc_type enum('general','moderator','admin') not null,
    acc_status enum('active','suspended','banned') not null,
    primary key(id)

);

# notification(user_id,time,message,checked) - a gets a notification
create table notification (
    id varchar(32) not null,
    user_id varchar(32) not null,
    n_time datetime,
    message text not null,
    checked boolean,
    primary key(id),
    foreign key (user_id) references user(id)
);

# department
create table department (
    id varchar(32) not null,
    dept_name varchar(256) not null unique,
    dept_abbr varchar(4) not null,
    primary key(id)
);

# course
create table course (
    id varchar(32) not null,
    dept_abbr varchar(4),
    course_name varchar(256),
    course_num varchar(4),
    primary key(id),
    foreign key(dept_abbr) references department(dept_abbr)
);

# post
create table post (
    id varchar(32) not null,
    user_id varchar(32) not null,
    course_id varchar(32) not null,
    post_text text not null,
    post_date datetime,
    post_status enum('pending','denied','allowed') not null,
    primary key(id),
    foreign key(user_id) references user(id),
    foreign key(course_id) references course(id)
);

# file
create table file (
    id varchar(32) not null,
    post_id varchar(32),
    file_name varchar(256),
    file_size int,
    file_type varchar(4),
    file_data mediumblob,
    primary key(id),
    foreign key(post_id) references post(id)
);

# likes(user_id,post_id) - a user likes a post
create table liked (
    user_id varchar(32) not null,
    post_id varchar(32) not null,
    primary key(user_id, post_id),
    foreign key (user_id) references user(id),
    foreign key (post_id) references post(id)
);

# saved(user_id,post_id) - a user saved a post
create table saved (
    user_id varchar(32) not null,
    post_id varchar(32) not null,
    primary key(user_id, post_id),
    foreign key (user_id) references user(id),
    foreign key (post_id) references post(id)
);

# followed(user_id,course_id) - a user is following a course
create table followed (
    user_id varchar(32) not null,
    course_id varchar(32) not null,
    primary key(user_id, course_id),
    foreign key (user_id) references user(id),
    foreign key (course_id) references course(id)
);

# reported_post(user_id,post_id,reason) - a user reports a post
create table reported_post (
    user_id varchar(32) not null,
    post_id varchar(32) not null,
    reason text not null,
    primary key(user_id, post_id),
    foreign key (user_id) references user(id),
    foreign key (post_id) references post(id)
);

# reported_user(user_id,user_id,reason) - a user reports a user
create table reported_user (
    user_id_1 varchar(32) not null,
    user_id_2 varchar(32) not null,
    reason text not null,
    primary key(user_id_1, user_id_2),
    foreign key (user_id_1) references user(id),
    foreign key (user_id_2) references user(id)
);