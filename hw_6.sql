create table students(
student_id serial primary key unique, 
student_name varchar(15)  not null unique ,
username varchar(30) not null check(username ilike '@%'),
bio varchar(30) ,
mobile varchar(30) unique check(mobile~ '^[0-9]{9}$'),
has_picture boolean not null )

insert into students(student_name, username, bio, mobile, has_picture)
values ('Munira', '@krb_munira', 'stars/sun', 907999777, true),
('Alexandra', '@Alexandraleshaya', 'Amor fati', null, true),
('Sadriddin', '@khojazodas', '.',null ,true),
('Behzod', '@behzod_31',null,559009474, true),
('Hakim', '@hakim25753', null, 502055054, false)

select * from lessons

create table lessons(
lesson_id serial primary key unique, 
lesson_name varchar(50)  not null unique ,
created_date timestamp not null,
attendance boolean not null )

insert into lessons(lesson_name, created_date, attendance)
values ('SQL знакомство', '18.10.2024' ,true), 
('Операторы выборки, фильтрации и агрегации данных','18.10.2024' , true),
('Работа с текстом и датой', '21.10.2024',true),
('Создание, редактирование и удаление таблиц', '23.10.2024', true)



create table scores(
score_id serial primary key unique, 
user_id serial  not null ,
lesson_id serial not null,
score integer )

insert into scores(user_id, lesson_id, score)
values (1, 1, 100),
(2, 2, 95),
(3, 3, 90),  
(4, 4, 85),  
(5, 4, NULL); 

   
alter table scores 
add FOREIGN KEY (user_id) REFERENCES students(student_id);

alter table scores 
add FOREIGN KEY (lesson_id) REFERENCES lessons(lesson_id);


create index i on students(username)


create view my_results as
select 
    s.student_id,
    s.student_name,
    s.username,
    s.mobile,
    count(l.lesson_id) as lessons_attended,
    avg(sc.score) as avg_score
from students s
left join scores sc on s.student_id = sc.user_id
left join lessons l on sc.lesson_id = l.lesson_id and l.attendance = true
group by s.student_id, s.student_name, s.username, s.mobile;


select * from my_results

