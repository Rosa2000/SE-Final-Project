# SE-Final-Project

- Google Drive - Student account (Source code and documents): https://drive.google.com/drive/folders/1KqSxjSAI6pwWSOaoy-GfzUCpkBf49iEJ?usp=sharing
- Google Drive - Personal account (Backup): https://drive.google.com/drive/folders/1D-Lhf7-u-JW1DmpDy1_dDz33Liwar0tO?usp=sharing
- Youtube (Demo videos): https://youtube.com/playlist?list=PLjPxNmh4AaF4CbBOZSQcc2nLy_2gRaEtP
- Github: https://github.com/Rosa2000/SE-Final-Project.git

---------------------------------------------------------------------------
1. Set up SSMS
	- Open Microsoft SQL Server Management Studio
	- Select server name: {YourServer}\SQLEXPRESS
	- Select Authentication: SQL Server Authentication
		- Login: sa
		- Password: {Your password}
	- Create Database name "Supplement Facts"
	- Open provided data file "SupplementFacts.sql" and Execute.

2. Set up WinformsApp and WebApp
	- Right-click on the Solution
	- Select Add -> New Item -> ADO.NET Entity Data Model -> EF Designer from database
		 -> New Connection -> Data Souce = Microsoft SQL Server (SqlClient)
		 -> Server name = {YourServer}\SQLEXPRESS -> Select Authentication: SQL Server Authentication
		 -> Login: sa,Password: {Your password} -> Select database name "Supplement Facts" -> Finish
	- Open "Model1.edmx" and modify follow model image in Report.pdf

	**Winform: install Syncfusion.Pdf.WinForm in NugetPackage
	**Note: If the project has error, find file "Model1.Context.cs" and fix (ex: Goods1 -> Goods)

3. Set up Spring MVC SQL Server Connection
	- In file "application.properties":

		spring.datasource.driver-class-name=com.microsoft.sqlserver.jdbc.SQLServerDriver

		spring.datasource.url=jdbc:sqlserver://{YourServer}\\SQLEXPRESS:1433; databaseName=SupplementFacts;encrypt=true; trustServerCertificate = true
		spring.datasource.username=sa
		spring.datasource.password={Your password}
	
		spring.jpa.show-sql=true
		spring.jpa.hibernate.ddl-auto=update
		spring.jpa.properties.hibernate.format_sql=true
		spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.SQLServerDialect

		server.port = 8055

	- Run project as Spring Boot Application