use btnguyen;
delete from Monitor where true;
delete from Test_info where true;
delete from Expert_of where true;
delete from Technician where true;
delete from Test where true;
delete from Plane where true;
delete from Manager where true;
delete from Model where true;
delete from Dependents where true;
delete from Traffic_Control where true;
delete from Employees where true;

-- Employees Table
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
insert into Dependents (dname, relationships, date_of_birth, dependssn)
values ("Batman", "Brother", "1985-01-02", 0);
insert into Dependents (dname, relationships, date_of_birth, dependssn)
values ("Robin", "Nephew", "1990-11-04", 2);
insert into Dependents (dname, relationships, date_of_birth, dependssn)
values ("Superman", "Dad", "1870-10-05", 1);
insert into Dependents (dname, relationships, date_of_birth, dependssn)
values ("Wonder Woman", "Mom", "2000-02-05", 3);

-- Traffic_Control Table
insert into Traffic_Control (exam_date, traffic_ssn)
values ("2011-02-03", 0);
insert into Traffic_Control (exam_date, traffic_ssn)
values ("2000-02-04", 1);
insert into Traffic_Control (exam_date, traffic_ssn)
values ("2020-05-30", 2);
insert into Traffic_Control (exam_date, traffic_ssn)
values ("2010-05-02", 3);

-- Model Table
insert into Model (model_no, capacity, weight)
values (0, 50, 10000);
insert into Model (model_no, capacity, weight)
values (1, 2, 1000);
insert into Model (model_no, capacity, weight)
values (2, 1, 500);
insert into Model (model_no, capacity, weight)
values (3, 1000, 1000000);

-- Manager Table
insert into Manager (department, manager_ssn)
values ("Chicago", 4);
insert into Manager (department, manager_ssn)
values ("Mississippi", 5);
insert into Manager (department, manager_ssn)
values ("Des Moines", 6);
insert into Manager (department, manager_ssn)
values ("Ames", 7);

-- Plane Table
insert into Plane (reg_no, pname, ptype)
values (0, "Blackbird", 0);
insert into Plane (reg_no, pname, ptype)
values (1, "Starscream", 0);
insert into Plane (reg_no, pname, ptype)
values (2, "Thunderclap", 1);
insert into Plane (reg_no, pname, ptype)
values (3, "Bomber", 3);

-- Test Table
insert into Test (FAA_no, score, tname)
values (0, 10, "Landing");
insert into Test (FAA_no, score, tname)
values (1, 9, "Nose Dive");
insert into Test (FAA_no, score, tname)
values (2, 7, "Barrel Roll");
insert into Test (FAA_no, score, tname)
values (3, 4, "Liftoff");

-- Technician Table
insert into Technician (security_clearance, us_passport_no, tech_ssn)
values ("no clearance", 4999, 8);
insert into Technician (security_clearance, us_passport_no, tech_ssn)
values ("level 1 clearance", 1923333, 9);
insert into Technician (security_clearance, us_passport_no, tech_ssn)
values ("super secret access", 12372138, 10);
insert into Technician (security_clearance, us_passport_no, tech_ssn)
values ("all access", 123747, 11);

-- Expert_of Table
insert into Expert_of (model_no, t_ssn)
values (0, 8);
insert into Expert_of (model_no, t_ssn)
values (1, 9);
insert into Expert_of (model_no, t_ssn)
values (2, 10);
insert into Expert_of (model_no, t_ssn)
values (3, 11);

-- Test_info Table
insert into Test_info (hours, score, tdate, tech_ssn, reg_no, FAA_no)
values (40, 10, "2010-01-02", 8, 0, 0);
insert into Test_info (hours, score, tdate, tech_ssn, reg_no, FAA_no)
values (1, 1, "2000-02-19", 9, 1, 1);
insert into Test_info (hours, score, tdate, tech_ssn, reg_no, FAA_no)
values (10, 4, "2020-04-19", 10, 2, 2);
insert into Test_info (hours, score, tdate, tech_ssn, reg_no, FAA_no)
values (2, 8, "2021-05-01", 11, 3, 3);

-- Monitor Table
insert into Monitor (most_recent_date, manager_ssn, tech_ssn, reg_no, FAA_no)
values ("2020-02-10", 4, 8, 0, 0);
insert into Monitor (most_recent_date, manager_ssn, tech_ssn, reg_no, FAA_no)
values ("2020-03-05", 5, 9, 1, 1);
insert into Monitor (most_recent_date, manager_ssn, tech_ssn, reg_no, FAA_no)
values ("2020-10-10", 6, 10, 2, 2);
insert into Monitor (most_recent_date, manager_ssn, tech_ssn, reg_no, FAA_no)
values ("2020-12-25", 7, 11, 3, 3);

