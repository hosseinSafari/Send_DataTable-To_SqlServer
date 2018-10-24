--Types / User_Defined Table Type

CREATE TYPE ContactData AS TABLE
(
	Name nvarchar(50), --column 0
	LastName  nvarchar(50),	--column 1
	Age int --column 2	
)