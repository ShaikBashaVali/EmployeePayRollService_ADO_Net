using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace EmployeePayRollService
{

    public class EmployeeRepo
    {
        public static string connectionString = "Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=payroll_service;Integrated Security=true";
         SqlConnection connection = new SqlConnection(connectionString);

        public void GetAllEmployee()
        {
            try
            {
                EmployeeModel model = new EmployeeModel();
                using (this.connection)
                {
                    string query = @"Select * from payroll_service;";
                    SqlCommand cmd = new SqlCommand(query, this.connection);
                    this.connection.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            //model.EmployeeID = dr.GetInt32(0);
                            model.EmployeeName = dr.GetString(0);
                            model.BasicPay = dr.GetDecimal(1);
                            model.StartDate = dr.GetDateTime(2);
                            model.Gender = Convert.ToChar(dr.GetString(3));
                            //model.PhoneNumber=dr.GetString(4);
                            model.Address = dr.GetString(5);
                            //model.Department = dr.GetString(6);
                            //model.Deductions=dr.GetDouble(7);
                            //model.TaxablePay = dr.GetDouble(8);
                            //model.Tax = dr.GetDouble(9);
                            //model.NetPay = dr.GetDouble(10);
                            System.Console.WriteLine(model.EmployeeName + "" + model.BasicPay + "" + model.StartDate + "" + model.Gender + "" + model.PhoneNumber
                                + "" + model.Address + "" + model.Department + "" + model.Deductions + "" + model.TaxablePay
                                + "" + model.Tax + "" + model.NetPay);
                        }
                    }
                    else
                    {
                        System.Console.WriteLine("No data found");
                    }
                }
            }
            catch (Exception e)
            {
                System.Console.WriteLine(e.Message);
            }
        }

        public bool AddEmployee(EmployeeModel model)
        {
            try
            {
                using (this.connection)
                {
                    //var query=values()
                    SqlCommand command = new SqlCommand("SpAddEmployeeDetails", this.connection);
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@EmployeeName", model.EmployeeName);
                    command.Parameters.AddWithValue("@PhoneNumber", model.PhoneNumber);
                    command.Parameters.AddWithValue("@Address", model.Address);
                    command.Parameters.AddWithValue("@Department", model.Department);
                    command.Parameters.AddWithValue("@Gender", model.Gender);
                    command.Parameters.AddWithValue("@BasicPay", model.BasicPay);
                    command.Parameters.AddWithValue("@Deductions", model.Deductions);
                    command.Parameters.AddWithValue("@TaxablePay", model.TaxablePay);
                    command.Parameters.AddWithValue("@Tax", model.Tax);
                    command.Parameters.AddWithValue("@NetPay", model.NetPay);
                    command.Parameters.AddWithValue("@StartDate", model.StartDate);
                    //command.Parameters.AddWithValue("@City", model.City);
                    //command.Parameters.AddWithValue("@Country", model.Country);
                    this.connection.Open();
                    var result = command.ExecuteNonQuery();
                    this.connection.Close();
                    if (result != 0)
                    {
                        return true;
                    }
                    return false;
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            finally
            {
                this.connection.Close();
            }
            return false;
        }
    }
}
