
--clients
CREATE TABLE dbo.clients (
	clientID int not null identity(1,1)
	, clientName varchar(100) not null
	, dateCreated dateTime not null default (getDate())
	, CONSTRAINT PK__clients PRIMARY KEY (clientID)
	, CONSTRAINT UQ__clients_clientName UNIQUE (clientName)
)

--users
CREATE TABLE dbo.users (
	userID int not null identity(1,1)
	, username_e varchar(100) not null
	, pwd_e varchar(25) not null
	, firstName varchar(50) not null
	, lastName varchar(50) not null
	, clientID int not null
	, dateCreated dateTime not null default (getDate())
	, CONSTRAINT PK__users PRIMARY KEY (userID)
	, CONSTRAINT UQ__users_username_e UNIQUE (username_e)
	, CONSTRAINT FK__users_clientID FOREIGN KEY (clientID) REFERENCES dbo.clients (clientID)
)

--problems
CREATE TABLE dbo.problems (
	problemID int not null
	, userID int not null
	, dateCreated int not null
	, CONSTRAINT PK__problems PRIMARY KEY (problemID)
	, CONSTRAINT FK__problems_userID FOREIGN KEY (userID) REFERENCES dbo.users (userID)
)

--featureTypes
CREATE TABLE dbo.featureTypes (
	featureTypeID int not null identity(1,1)
	, featureTypeName varchar(50) not null
	, dateCreated dateTime not null default (getDate())
	, CONSTRAINT PK__featureTypes PRIMARY KEY (featureTypeID)
)

--problemFeatures
CREATE TABLE dbo.problemFeatures (
	problemID int not null
	, featureID int not null
	, featureName varchar(50) not null
	, featureType int not null
	, dateCreated dateTime not null default (getDate())
	, CONSTRAINT PK__problemFeatures PRIMARY KEY (problemID, featureID)
	, CONSTRAINT UQ__problemFeatures_problemID_featureName UNIQUE (problemID, featureName)
	, CONSTRAINT FK__problemFeatures_problemID FOREIGN KEY (problemID) REFERENCES problems (problemID)
	, CONSTRAINT FK__problemFeatures_featureType FOREIGN KEY (featureType) REFERENCES featureTypes (featureTypeID)
)

--problemData
CREATE TABLE dbo.problemData (
	problemID int not null
	, featureID int not null
	, observationID int not null
	, value float not null
	, dateCreated dateTime not null default (getDate())
	, CONSTRAINT PK__problemData PRIMARY KEY (problemID, observationID, featureID)
	, CONSTRAINT FK__problemData_problemID_featureID REFERENCES dbo.problemFeatures (problemID, featureID)
)

--algos
CREATE TABLE dbo.algos (
	algoID int not null
	, algoName varchar(100) not null
	, className varchar(50) not null
	, dateCreated dateTime not null default (getDate())
	, CONSTRAINT PK__algos PRIMARY KEY (algoID)
	, CONSTRAINT UQ__algos_algoName UNIQUE (algoName)
	, CONSTRAINT UQ__algos_className UNIQUE (className)
)

--models
CREATE TABLE dbo.models (
	modelID int not null identity(1,1)
	, problemID int not null
	, algoID int not null
	, dateCreated dateTime not null default (getDate())	
	, CONSTRAINT PK__models
	-- YOU ARE HERE
)

--jobqueue


