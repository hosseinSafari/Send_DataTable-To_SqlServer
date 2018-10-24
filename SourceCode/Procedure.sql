--Create insert procedure for your table(here it's name is tblInformation).
CREATE PROCEDURE InsertTable
@Name NVARCHAR(50),@LastName NVARCHAR(50),@age INT
AS

BEGIN
	
	INSERT INTO tblInformation
                  (Name, LastName, age)
	VALUES        (@Name,@LastName,@age)
END

--===========================================================================================================================
--===========================================================================================================================

--Create this procedure for receive dataTable from C# and insert dataTable into your Table(here it's name is tblInformation).
CREATE PROCEDURE contactNewInsert
@dt AS ContactData READONLY
AS
	
DECLARE @Name NVARCHAR(50)
DECLARE @LastName NVARCHAR(50)
DECLARE @Age INT

BEGIN
set @Name = (SELECT TOP 1 Name FROM  @dt)
set @LastName = (SELECT TOP 1 LastName FROM  @dt)
set @Age = (SELECT TOP 1 Age FROM  @dt)

DECLARE CUR CURSOR FAST_FORWARD READ_ONLY FOR 
SELECT a.Name,a.LastName,a.Age FROM 
(SELECT Name,LastName,Age FROM @dt) AS a
OPEN CUR
FETCH NEXT FROM cur INTO @Name,@LastName,@Age
WHILE (@@FETCH_STATUS = 0)
BEGIN
	INSERT INTO tblInformation 
	(Name, LastName, Age)
	VALUES (@Name,@LastName,@Age)
	FETCH NEXT FROM cur INTO @Name,@LastName,@Age
END
CLOSE CUR
DEALLOCATE CUR
END