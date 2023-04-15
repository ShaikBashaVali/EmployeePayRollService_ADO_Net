using EmployeePayRollService;
using Moq;

namespace EmployeePayrollServiceTest
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void TestMethod1()
        {
            EmployeeRepo repo = new EmployeeRepo();
            EmployeeModel employee = new EmployeeModel();
            employee.EmployeeName = "Mohan";
            employee.Department = "Tech1";
            employee.PhoneNumber = "987654321";
            employee.Address = "02-chennai";
            employee.Gender = 'M';
            employee.BasicPay = 1000.00M;
            employee.Deductions = 1500.0;
            employee.StartDate = Convert.ToDateTime("2020-11-03");
           // Mock<EmployeeRepo> mockObj = new Mock<EmployeeRepo>();
           // mockObj.Setup(t => t.AddEmployee(It.IsIn<EmployeeModel>)).returns(true);
            var result = repo.AddEmployee(employee);
            Assert.IsTrue(result);
        }

        [TestMethod]
        public void GetAllEmployeeShouldReturnListOfRecords() 
        {
            EmployeeRepo employeeRepo = new EmployeeRepo();
            employeeRepo.GetAllEmployee();
            //Assert.IsTrue(result)

        }
    }
}