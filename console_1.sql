CREATE TABLE `student-management`.`student1` (
    `id` int NOT NULL,
    `name` varchar(45) NOT NULL ,
    `age` int NOT NULL ,
    `country` varchar(45) NOT NULL ,
    PRIMARY KEY (`id`));
insert into `student-management`.student1(id, name, age, country)
VALUES (
    2, 'Trong', 25, 'VN');
select name from `student-management`.student1;

CREATE TABLE if not exists `student-management`.`Class` (
    `id` int NOT NULL ,
    `name` varchar(45)
);

CREATE TABLE if not exists `student-management`.`Teacher` (
    `id` int NOT NULL ,
    `name` varchar(45),
    `age` int NOT NULL,
    `country` varchar(45) NOT NULL
);


