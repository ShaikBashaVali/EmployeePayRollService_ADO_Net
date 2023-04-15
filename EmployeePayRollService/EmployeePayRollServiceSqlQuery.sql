--UC1 Ability to create a payroll service database
create database payroll_service;
use payroll_service;

--UC2 Ability to create a employee payroll table in the payroll service database 
create table  employee_payroll(Id int Identity(1,1)Primary Key, Name varchar(100), Salary float, StartDate date);

--UC3 Insert employee data into employee_payroll table
Insert into employee_payroll values ('Shaik', 25000, '2019-11-13'), ('Basha', 30000, '2020-05-21'), ('Vali', 35000, '2018-01-03'), ('ShaikBashaVali', 40000, '2018-01-03');

--UC4 Ability to retrieve all the employee payroll data that is added to payroll service database
select * from employee_payroll;

--UC5 Ability to retrieve salary data for a particular employee as well as all employees who have joined in a particular data range from the payroll service database
select * from employee_payroll where Name= 'Basha';
select * from employee_payroll where StartDate between cast('2018-01-01' as date ) AND GETDATE();

--UC6 Ability to add Gender to Employee Payroll Table and Update the Rows
alter table employee_payroll add Gender varchar(10)
update employee_payroll set Gender ='M' where Name='Shaik' or Name='Basha' or Name='Vali' or Name='ShaikBashaVali' ;
update employee_payroll set Gender ='F' where name='Vali' ;

--UC7 Ability to find sum, average, min, max and number of male and female employees (using aggregate functions)
select sum(Salary) as Total_Salary_Of_Male from employee_payroll where Gender='M' Group By Gender;
select Sum(Salary) as Total_Salary_Of_Female from employee_payroll where Gender = 'F' Group BY Gender;
select sum(Salary) as Total_Salary_Of_Male_And_Female from employee_payroll;

select Avg(Salary) as Average_Salary_Of_Male from employee_payroll where Gender='M' Group By Gender;
select Avg(Salary) as Average_Salary_Of_Female from employee_payroll where Gender='F' Group By Gender;
select Avg(Salary) as Average_Salary_Of_Male_And_Female from employee_payroll ;

select Max(Salary) as Max_Salary_Of_Male from employee_payroll where Gender='M' Group By Gender;
select Max(Salary) as Max_Salary_Of_Female from employee_payroll where Gender='F' Group By Gender;
select Max(Salary) as Max_Salary_Of_Male_And_Female from employee_payroll;

select Min(Salary) as Min_Salary_Of_Male from employee_payroll where Gender='M' Group By Gender;
select Min(Salary) as Min_Salary_Of_Female from employee_payroll where Gender='F' Group By Gender;
select Min(Salary) as Min_Salary_Of_Male_And_Female from employee_payroll;

select Count(Salary) as Total_Count_Salary_Of_Male from employee_payroll where Gender='M' Group By Gender;
select Count(Salary) as Total_Count_Salary_Of_Female from employee_payroll where Gender='F' Group By Gender;
select Count(Salary) as Total_Count_Salary_Of_Male_And_Female from employee_payroll;

--UC8 Extend employee_payroll data to store employee information like employee phone, address and department
alter table employee_payroll add Phone_Number bigint, Address varchar(200), Department varchar(100) NOT NULL default 'Test';
update employee_payroll set Phone_Number=1111111111, Address='Chennaik', Department='Account' where Name='Vali';
update employee_payroll set Phone_Number=2222222222, Address='Banglore', Department='HR' where Name='Shaik';
update employee_payroll set Phone_Number=3333333333, Address='Hyderabad', Department='IT' where Name='Basha';
update employee_payroll set Phone_Number=4444444444, Address='Mumbai', Department='Developer' where Name='ShaikBashaVali';

--UC9 Ability to extend employee_payroll table to have Basic Pay, Deductions, Taxable Pay, Income Tax, Net Pay
alter table employee_payroll add Basic_Pay float, Deductions float, Taxable_Pay float, Income_Tax float, Net_Pay float ;
update employee_payroll set Basic_Pay=60000, Deductions=25000, Taxable_Pay=3000,Income_Tax=1500,Net_Pay=45000000 where Name='Vali';
update employee_payroll set Basic_Pay=50000, Deductions=5000, Taxable_Pay=2000,Income_Tax=1800,Net_Pay=5000000 where Name='Shaik';
update employee_payroll set Basic_Pay=65000, Deductions=2000, Taxable_Pay=3500,Income_Tax=2500,Net_Pay=55000000 where Name='Basha';
update employee_payroll set Basic_Pay=70000, Deductions=35000, Taxable_Pay=4000,Income_Tax=4500,Net_Pay=75000000 where Name='ShaikBashaVali';

exec SpAddEmployeeDetails 'Vali','9876543210','Street No.1','Computer Science','M',100000,9000,11000,2000,79000,'2023-05-05'
Alter procedure [dbo].[SpAddEmployeeDetails]
(
@EmployeeName varchar(255),
@PhoneNumber varchar(255),
@Address varchar(255),
@Department varchar(255),
@Gender char(1),
@BasicPay float,
@Deductions float,
@TaxablePay float,
@Tax float,
@NetPay float,
@StartDate Date
)
as
begin
insert into employee_payroll values
(
@EmployeeName,@BasicPay,@StartDate,@Gender,@PhoneNumber,@Address,@Department,@BasicPay,@Deductions,@TaxablePay,@Tax,@NetPay
)
end
GO
