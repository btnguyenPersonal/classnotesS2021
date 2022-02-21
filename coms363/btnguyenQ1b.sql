use btnguyen;

-- Employees Table
delete from Employees where true;
insert into Employees (essn, ename, eaddress, esalary, ephone_num, union_mem_num)
values (0, "Ben", "1732 46th street", 1000000, "1234561234", 1);
insert into Employees (essn, ename, eaddress, esalary, ephone_num, union_mem_num)
values (1, "Josh", "100 49th street", 2000000, "8484848484", 2);
insert into Employees (essn, ename, eaddress, esalary, ephone_num, union_mem_num)
values (2, "Selma", "202 2nd street", 500000, "9999999999", 3);
insert into Employees (essn, ename, eaddress, esalary, ephone_num, union_mem_num)
values (3, "Coby", "355 lincoln way", 4000, "3334441234", 4);
insert into Employees (essn, ename, eaddress, esalary, ephone_num, union_mem_num)
values (4, "Zack", "400 lincoln way", 44999995, "2374677777", 5);
insert into Employees (essn, ename, eaddress, esalary, ephone_num, union_mem_num)
values (5, "Levy", "520 Mortenson Road", 4000, "3333848484", 6);
insert into Employees (essn, ename, eaddress, esalary, ephone_num, union_mem_num)
values (6, "Magnus", "2222 Central Road", 188428, "2312344599", 7);
insert into Employees (essn, ename, eaddress, esalary, ephone_num, union_mem_num)
values (7, "Hikaru", "1 1st street", 199999999, "2312311234", 8);
insert into Employees (essn, ename, eaddress, esalary, ephone_num, union_mem_num)
values (8, "Ding", "400 120th street", 57777, "2388282824", 9);
insert into Employees (essn, ename, eaddress, esalary, ephone_num, union_mem_num)
values (9, "Cher", "1234 1234th street", 499928, "2366663535", 10);
insert into Employees (essn, ename, eaddress, esalary, ephone_num, union_mem_num)
values (10, "Travis", "14 winner's street", 5000, "8888888888", 11);
insert into Employees (essn, ename, eaddress, esalary, ephone_num, union_mem_num)
values (11, "Dylan", "100 Freddy Court", 10, "1923812377", 12);

-- Dependents Table
delete from Dependents where true;
insert into Dependents (dname, relationships, date_of_birth, dependssn)
values ("Batman", "Brother", "1985-01-02", 0);
insert into Dependents (dname, relationships, date_of_birth, dependssn)
values ("Robin", "Nephew", "1990-11-04", 2);
insert into Dependents (dname, relationships, date_of_birth, dependssn)
values ("Superman", "Dad", "1870-10-05", 1);
insert into Dependents (dname, relationships, date_of_birth, dependssn)
values ("Wonder Woman", "Mom", "2000-02-05", 3);

-- Traffic_Control Table
delete from Traffic_Control where true;
insert into Traffic_Control (exam_date, traffic_ssn)
values ("2011-02-03", 0);
insert into Traffic_Control (exam_date, traffic_ssn)
values ("2000-02-04", 1);
insert into Traffic_Control (exam_date, traffic_ssn)
values ("2020-05-30", 2);
insert into Traffic_Control (exam_date, traffic_ssn)
values ("2010-05-02", 3);

-- Model Table
delete from Model where true;
insert into Model (model_no, capacity, weight)
values (0, 50, 10000);
insert into Model (model_no, capacity, weight)
values (1, 2, 1000);
insert into Model (model_no, capacity, weight)
values (2, 1, 500);
insert into Model (model_no, capacity, weight)
values (3, 1000, 1000000);

-- Manager Table
delete from Manager where true;
insert into Manager (department, manager_ssn)
values ("Chicago", 4);
insert into Manager (department, manager_ssn)
values ("Mississippi", 5);
insert into Manager (department, manager_ssn)
values ("Des Moines", 6);
insert into Manager (department, manager_ssn)
values ("Ames", 7);

-- Plane Table
delete from Plane where true;
insert into Plane (reg_no, pname, ptype)
values (0, "Blackbird", 0);
insert into Plane (reg_no, pname, ptype)
values (1, "Starscream", 0);
insert into Plane (reg_no, pname, ptype)
values (2, "Thunderclap", 1);
insert into Plane (reg_no, pname, ptype)
values (3, "Bomber", 3);

-- Test Table
delete from Test where true;
insert into Test (FAA_no, score, tname)
values (0, 10, "Landing");
insert into Test (FAA_no, score, tname)
values (1, 9, "Nose Dive");
insert into Test (FAA_no, score, tname)
values (2, 7, "Barrel Roll");
insert into Test (FAA_no, score, tname)
values (3, 4, "Liftoff");

-- Test_info Table
delete from Test_info where true;
insert into Test_info (FAA_no, score, tname)
values (0, 10, "Landing");
insert into Test_info (FAA_no, score, tname)
values (1, 9, "Nose Dive");
insert into Test_info (FAA_no, score, tname)
values (2, 7, "Barrel Roll");
insert into Test_info (FAA_no, score, tname)
values (3, 4, "Liftoff");

-- Technician Table
delete from Technician where true;
insert into Technician (FAA_no, score, tname)
values (0, 10, "Landing");
insert into Technician (FAA_no, score, tname)
values (1, 9, "Nose Dive");
insert into Technician (FAA_no, score, tname)
values (2, 7, "Barrel Roll");
insert into Technician (FAA_no, score, tname)
values (3, 4, "Liftoff");

-- Monitor Table
delete from Monitor where true;
insert into Monitor (FAA_no, score, tname)
values (0, 10, "Landing");
insert into Monitor (FAA_no, score, tname)
values (1, 9, "Nose Dive");
insert into Monitor (FAA_no, score, tname)
values (2, 7, "Barrel Roll");
insert into Monitor (FAA_no, score, tname)
values (3, 4, "Liftoff");

-- Expert_of Table
delete from Expert_of where true;
insert into Expert_of (FAA_no, score, tname)
values (0, 10, "Landing");
insert into Expert_of (FAA_no, score, tname)
values (1, 9, "Nose Dive");
insert into Expert_of (FAA_no, score, tname)
values (2, 7, "Barrel Roll");
insert into Expert_of (FAA_no, score, tname)
values (3, 4, "Liftoff");
