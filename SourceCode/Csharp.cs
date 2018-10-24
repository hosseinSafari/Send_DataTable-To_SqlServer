//Insert a button to WindowsForm and write the following Code:
private void btnSave_Click(object sender, EventArgs e)
{
	clsBusiness cls = new clsBusiness();
	if (dtAdd.Rows.Count > 0)
	{
		string[] parName = new string[3];
		parName[0] = "@Name";
		parName[1] = "@LastName";
		parName[2] = "@age";

		string[] parValue = new string[3];
		parValue[0] = txtName.Text;//Name NVARCHAR(50)
		parValue[1] = txtLastName.Text;//LastName NVARCHAR(50)
		parValue[2] = txtAge.Text;//age INT
		cls.executeWithDataTable("contactNewInsert", "@dt", dtAdd);
		MessageBox.Show("OK", "");
	}
}
	
//==============================================================================================================

//clsBusiness		
public int executeWithDataTable(string query, string dtName, DataTable dt)
{
	clsCore cls = new clsCore();
	return cls.executeDataTable(query, dtName, dt);
}

//==============================================================================================================

//clsCore
public int executeDataTable(string query, string DataTableName, DataTable dt, bool commandType = false)
{
	SqlCommand cmd = new SqlCommand(query, _con);
	if (commandType)
		cmd.CommandType = CommandType.Text;
	else
		cmd.CommandType = CommandType.StoredProcedure;
	cmd.Parameters.AddWithValue(DataTableName, dt);
	_con.Open();
	try
	{
		int result = cmd.ExecuteNonQuery();
		_con.Close();
		return result;
	}
	catch (SqlException ex)
	{
		_con.Close();
		return ex.Number * (-1);
	}
}