CREATE DATABASE  IF NOT EXISTS `ucms` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `ucms`;
-- MySQL dump 10.13  Distrib 5.6.17, for Win32 (x86)
--
-- Host: localhost    Database: ucms
-- ------------------------------------------------------
-- Server version	5.5.16

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `assignment`
--

DROP TABLE IF EXISTS `assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assignment` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CONTENT` varchar(10000) DEFAULT NULL,
  `DUEDATE` date DEFAULT NULL,
  `TITLE` varchar(255) DEFAULT NULL,
  `course_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_ASSIGNMENT_course_ID` (`course_ID`),
  CONSTRAINT `FK_ASSIGNMENT_course_ID` FOREIGN KEY (`course_ID`) REFERENCES `course` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignment`
--

LOCK TABLES `assignment` WRITE;
/*!40000 ALTER TABLE `assignment` DISABLE KEYS */;
INSERT INTO `assignment` VALUES (1,'This exercise is based on Exercise 100 in HtDP/2e. As in that exercise, you are to design a set of functions that illustrate the workings of a finite-state machine for accepting strings that exactly match the regular expression\n(a | b)* (c | d)* e\nHowever, rather than having a graphical illustration, do the following: First, perform an information analysis and design the data representation for the states of your machine. You may wish to write down a state-transition diagram (like the ones here) to illustrate the meaning of your state. Keep your diagram as simple as possible. You should submit your state-transition diagram either as ascii art in your solution file, or as a jpg or pdf, created in your favorite graphics program.\nKeyEvents of length greater than 1 should be ignored, that is, any such KeyEvent should leave the machine\'s state unchanged. If the machine encounters a bad letter or a letter out of sequence, it should go to an error state. Once the machine is in an error state, it stays there on any input.\n\nDesign the following functions and provide them in a file named regexp.rkt\ninitial-state : Number -> State\nGIVEN: a number\nRETURNS: a representation of the initial state\nof your machine.  The given number is ignored.\n\nnext-state : State KeyEvent -> State\nGIVEN: a state of the machine and a key event.\nRETURNS: the state that should follow the given key event.  A key\nevent that is to be discarded should leave the state unchanged.\n\naccepting-state? : State -> Boolean\nGIVEN: a state of the machine\nRETURNS: true iff the given state is a final (accepting) state\n\nerror-state? : State -> Boolean\nGIVEN: a state of the machine\nRETURNS: true iff the string seen so far does not match the specified\nregular expression and cannot possibly be extended to do so.\nYou will need to provide a data definition for State. Be sure to write an interpretation for each state. For our purposes, we will consider KeyEvent to be a scalar data type, which can be decomposed using the Cases strategy.\n\nAs with the other questions in this problem set, we will be doing automated testing of your solution. In order to see whether you have correctly provided the indicated functions, load a copy of ps01-regexp-tests.rkt into your directory and run it. This file tests only that you have provided all the functions you are supposed to. Make sure your solution passes those tests before you turn in your problem set.','2014-09-14','Problem Set 1',1),(2,'(Draggable Rectangle) Write a universe program rectangle.rkt that displays a selectable, draggable rectangle. More specifically:\nYour program should start by displaying a solid green rectangle 100 pixels wide and 60 pixels high on a 400 x 300 scene.\nDepressing the mouse button within the rectangle causes the rectangle to be \"selected\". This is shown visually by replacing the solid green rectangle by a green outline rectangle. The location where the mouse grabbed the rectangle should be indicated by a solid red circle of radius 5 pixels. Simply pressing the mouse button, without moving the mouse, should not cause the rectangle to move on the canvas.\nOnce the rectangle has been grabbed, you should be able to drag it around the Universe canvas with the mouse. As you drag it, the position of the mouse within the rectangle (as indicated by the red circle), should not change. When the mouse button is released, the rectangle should go back to its unselected state (solid green) in its new location.\nWe refer to this behavior as \"smooth dragging.\" We will be implementing other objects with this behavior in future problem sets.\n\nHere\'s a small demo. The little rings are a video effect, and are not created by the program you are to create.\n\nProvide the following functions:\n\nrun : Any -> World\nGIVEN: any value\nEFFECT: ignores its argument and starts the interactive program.\nRETURNS: the final state of the world.\n\ninitial-world : Any -> World\nGIVEN: any value\nRETURNS: the initial world.\nIgnores its argument.\n\nworld-x : World -> Integer\nworld-y : World -> Integer\nRETURNS: the coordinates of the center of the rectangle\nNOTE: if these are part of the world struct, you don\'t need to\nwrite any deliverables for these functions.\n\nworld-selected? : World -> Boolean\nGIVEN a world\nRETURNS: true iff the rectangle is selected.\nNOTE: if selected? is part of the world struct, you don\'t need to\nwrite any deliverables for this function\n\nworld-after-mouse-event : World Integer Integer MouseEvent -> World\nRETURNS: the world that follows the given mouse event.\nFor what it\'s worth, my solution to this problem was 268 lines, and the median time for students on this problem was between 8 and 10 hours.\n\nBefore you turn in your solution, make sure it passes the tests in ps02-rectangle-qualification.rkt. As before, download this file, save it in your set02 directory, and run it to qualify your program for grading.','2014-09-28','Problem Set 2',1),(3,'Consider an online IDE (Integrated Development Environment) that allows developers create online Web applications. A developer has username, password, email, first and last name. Applications have a name, date created, and are described as a collection of things or entities, e.g., a blogging application might have users, posts, comments, etc. an address book might have contacts, addresses, phone numbers, etc. Entities describe real things in terms of attributes, e.g., a user might have attributes username, password, first name, etc., a blog post might have attributes title, content, date posted, etc. Attributes can be of various types such as number, string, date and long string, e.g., a first name attribute might be of type string, a blog post might be of type long string, a date posted attribute might be of type date. Attributes can also be of type collection to denote that the attribute represents a collection of other entities, e.g., in a blogging application, a user entity might have collection attribute blog posts which is a collection of blog post entities; and in turn a blog post entity might have collection attribute comments which is a collection of comment entities. If an attribute is of type collection, the attribute further keeps track of the entity the collection is made up of. Entities are further described by scripts that execute when a new entity is created, when an entity is deleted, or when an entity is updated. Scripts are made up of statements that are described by a title, short description, and type.\nApplications developed by developers can be executed by users which also have username, password, email, first and last name. Users can purchase any number of applications, and an application can be used by users. Even though different users can use the same application, the application data is stored separately for every user, i.e., user1 using app1 can not see the data for user2 using the same app1\nCreate a UML class diagram for the application described above. Develop the diagram using any UML tool but submit your diagram as PDF.\nCreate a class diagram following the techniques described in class. \n(10pts) List nouns that are candidate classes (except trivial nouns)\n(10pts) List verbs as candidate relations between classes (except trivial verbs)\n(10pts) Generalization (inheritance) (if applicable, explain)\n(10pts) Aggregation or Composition (1 to * or 1 to 1..*) (if applicable, explain)\n(10pts) Classes Vs. Attributes analysis\n(10pts) Correct Data Types, e.g., Date, String, Integer, List, Array, Enumeration, etc.\n(10pts) Cardinality\n(10pts) Remove any inadequate relationships (if applicable, explain)\n(10pts) Reify (if applicable, explain)\n(10pts) Prose\n','2014-09-22','UML Class Diagrams',2),(4,'The Database Design Process\nDevelop a schema to manage a set of Web forms composed of several Web input fields: text field, text area, select, radio, check boxes, date, and time. Each Web form is created by a developer for a particular Web application and is intended to be filled in by a particular user. Anonymous users can fill in Web forms as well. All fields have a name and can have several values. Text fields can be configured to have a type of number, string, URL, or email. Text fields also have a max size. The default type is string. This is used for validation purposes. Text area can have a number of rows and columns and a maximum number of characters. Date and time fields can have a min and max or no limitations at all. Select, radio and check boxes require a set of values and labels from which a user can chose. The labels are used to display the values in human readable prose. The user can select a single value from radio fields, but can choose several values from select and check box fields. The fields can be arranged in a particular order. Fields have associated descriptive labels that appear next to the field, and tooltips that appear when users hover over the field for help. The database is used to render the forms to be filled by a user. When the user fills in and submits the form, the data is stored in such a way that groups the application, form, user, date submitted, fields, and values. Submissions are used to generate reports in the form of Excel spreadsheets.\nCreate a class diagram that captures the data described above. Apply the data analysis techniques that were discussed in class. Clearly annotate your class diagram using classes, attributes, cardinality, associations, the name of the relationship, aggregation, composition, and generalizations. Apply the techniques described in class to convert the class diagram to a relational model and write the equivalent SQL create statements. Argument, and defend your choices as you apply the analysis.\nGrading\n(40pts) Class Diagram\n(10pts) Generalization, Aggregation or Composition (1 to * or 1 to 1..*) (if applicable, explain)\n(10pts) Correct Data Types, e.g., Date, String, Integer, List, Array, Enumeration, etc.\n(10pts) Cardinality\n(10pts) Reify: revise Weak-Weak and strong-strong relationships (if applicable, explain)\n(50pts) Schema\n(10pts) Primary Keys, required, artificial keys vs. natural keys\n(10pts) Foreign Keys\n(10pts) Primary Keys that are also Foreign Keys (if applicable, explain)\n(10pts) Delete Cascade (if applicable, explain)\n(10pts) Correct Data Types, e.g., DATE, VARCHAR, etc.\n(10pts) Prose: defend your assumptions and how they guided your decisions\n','2014-10-04','UML2SQL',2),(5,'Consider the following relational schema to answer the questions that follow:\nCREATE TABLE Developer (\n	Id	INT          IDENTITY (1, 1) NOT NULL,\n	firstName VARCHAR (50) NULL,\n	lastName VARCHAR (50) NULL,\n	PRIMARY KEY (Id ASC)\n);\n\nCREATE TABLE ApplicationCategory (\n	category VARCHAR (25) NOT NULL,\n	PRIMARY KEY (category ASC)\n);\n\nINSERT INTO ApplicationCategory (category) VALUES (\'GAMES\')\nINSERT INTO ApplicationCategory (category) VALUES (\'PRODUCTIVITY\')\n\nCREATE TABLE Application (\n	Id	INT	IDENTITY (1, 1) NOT NULL,\n	name	VARCHAR (50) DEFAULT (\'Application\') NULL,\n	created  DATE	DEFAULT (getdate()) NULL,\n	category VARCHAR (25) NULL,\n	PRIMARY KEY (Id ASC),\n	FOREIGN KEY (category) REFERENCES ApplicationCategory (category)\n);\n\nCREATE TABLE Sales (\n	applicationId	INT,\n	developerId	INT,\n	sold	DATE NULL,\n	quantity	INT,\n	FOREIGN KEY (applicationId) REFERENCES Application (Id),\n	FOREIGN KEY (developerId) REFERENCES Developer   (Id)\n);\n\nCREATE TABLE DesktopApplication (\n	Id               INT          NOT NULL,\n	downloads   INT NULL,\n	os               VARCHAR (50) NULL,\n	pricePerDownload FLOAT (53)   NULL,\n	PRIMARY KEY (Id ASC),\n	FOREIGN KEY (Id) REFERENCES Application (Id) ON DELETE CASCADE\n);\n\nCREATE TABLE WebApplication (\n	Id      INT           NOT NULL,\n	url     VARCHAR (100) DEFAULT (\'http://cnn.com\') NULL,\n	price   FLOAT (53)    DEFAULT ((0.99)) NULL,\n	subscribers INT NULL,\n	browser VARCHAR (50)  NULL,\n	PRIMARY KEY (Id ASC),\n	FOREIGN KEY (Id) REFERENCES Application (Id) ON DELETE CASCADE\n);\n\nCREATE TABLE MobileApplication (\n	Id           INT          NOT NULL,\n	os           VARCHAR (50) NULL,\n	installCount INT          NULL,\n	price        FLOAT (53)   NULL,\n	PRIMARY KEY (Id ASC),\n	FOREIGN KEY (Id) REFERENCES Application (Id) ON DELETE CASCADE\n);\n\nCREATE TABLE RoleType (\n	type VARCHAR (50) NOT NULL,\n	PRIMARY KEY (type ASC)\n);\n\nINSERT INTO RoleType (type) VALUES (\'ARCHITECT\')\nINSERT INTO RoleType (type) VALUES (\'BUSINESS ANALYST\')\nINSERT INTO RoleType (type) VALUES (\'DEVELOPER\')\nINSERT INTO RoleType (type) VALUES (\'PROJECT MANAGER\')\nINSERT INTO RoleType (type) VALUES (\'PRODUCT MANAGER\')\nINSERT INTO RoleType (type) VALUES (\'USER EXPERIENCE\')\nINSERT INTO RoleType (type) VALUES (\'DIRECTOR\')\n\nCREATE TABLE Role (\n	Id          INT          IDENTITY (1, 1) NOT NULL,\n	application INT          NULL,\n	developer   INT          NULL,\n	role        VARCHAR (50) NULL,\n	PRIMARY KEY (Id ASC),\n	UNIQUE (developer ASC, application ASC, role ASC),\n	FOREIGN KEY (application) REFERENCES Application (Id),\n	FOREIGN KEY (developer) REFERENCES Developer (Id),\n	FOREIGN KEY (role) REFERENCES RoleType (type)\n);\n\nCREATE TABLE PrivilegeEnum (\n	privilege VARCHAR (20) NOT NULL,\n	PRIMARY KEY (privilege ASC)\n);\n\nINSERT INTO PrivilegeEnum (privilege) VALUES (\'ALL\')\nINSERT INTO PrivilegeEnum (privilege) VALUES (\'CREATE\')\nINSERT INTO PrivilegeEnum (privilege) VALUES (\'DELETE\')\nINSERT INTO PrivilegeEnum (privilege) VALUES (\'READ\')\nINSERT INTO PrivilegeEnum (privilege) VALUES (\'UPDATE\')\n\nCREATE TABLE AssetType (\n	type VARCHAR (20) NOT NULL,\n	PRIMARY KEY (type ASC)\n);\n\nINSERT INTO AssetType (type) VALUES (\'APPLICATION\')\nINSERT INTO AssetType (type) VALUES (\'DATA\')\nINSERT INTO AssetType (type) VALUES (\'MODEL\')\nINSERT INTO AssetType (type) VALUES (\'LOGIC\')\nINSERT INTO AssetType (type) VALUES (\'PAGE\')\nINSERT INTO AssetType (type) VALUES (\'PRESENTATION\')\nINSERT INTO AssetType (type) VALUES (\'SCRIPT\')\nINSERT INTO AssetType (type) VALUES (\'CONTROLLER\')\nINSERT INTO AssetType (type) VALUES (\'VIEW\')\n\nCREATE TABLE Privilege (\n	applicationId INT          NULL,\n	developerId  INT          NULL,\n	privilege     VARCHAR (20) NULL,\n	assetType     VARCHAR (20) NULL,\n	FOREIGN KEY (applicationId) REFERENCES Application (Id),\n	FOREIGN KEY (developerId) REFERENCES Developer (Id),\n	FOREIGN KEY (privilege) REFERENCES PrivilegeEnum (privilege),\n	FOREIGN KEY (assetType) REFERENCES AssetType (type)\n);\n\n\nCREATE TABLE Asset ( \nID int PRIMARY KEY, \nname VARCHAR(50) NOT NULL, \ntype VARCHAR(20) references AssetType(type), \napplicationID int references Application (Id) \n);\n\nGiven the relational model above, write SQL statements that will accomplish the following:\n(5pts) Create Productivity applications: Keynote, Pages, Outlook, Word, PowerPoint, and Numbers\n(5pts) Create Game applications: Minecraft, Asteroids, Space Invaders, Galaga, and Centipide\n(10pts) Create the following Developers with the following roles in the specified Application categories:\n<First Name> <Last Name>, <Role>, <Application Category>\nAlice Wonderland, Architect, Games\nBob Marley, User Experience, Games\nCharly Garcia, Developer, Games\nFrank Herbert, Project Manager, Productivity\nGregory Peck, Product Manager, Games\nEdward Norton, User Experience, Productivity\n(10pts) Give the following developers the privileges listed below\n<First Name> <Last Name>, <Privilege>, <Application>, <Asset> \nCharly Garcia, All, Centipede, Views\nEdward Norton, Update, Outlook, Scripts\n(10pts) Change Frank Herbert\'s role as a Project Manager to Product Manager of all his applications\n(10pts) Promote Gregory Peck\'s role to Director of all Web Applications\n(10pts) Revoke Edward Norton’s Update privileges on Scripts on Productivity application Outlook\n(10pts) Remove Productivity application PowerPoint and all associated assets\n(10pts) List all views of Web applications that had a decline in sales of at least 10% from the previous month for each Product Manager\n(10pts) List all controllers associated to an application where Alice Wonderland is a Developer\n(10pts) What is the highest grossing application category of all time?\n(10pts) Which developer sold most mobile applications this month?\n','2014-10-19','SQL',2),(6,'what is 1 + 2','2014-11-09','Problem Set 3',1);
/*!40000 ALTER TABLE `assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `COURSENAME` varchar(255) DEFAULT NULL,
  `COURSEPIC` varchar(255) DEFAULT NULL,
  `DETAILS` varchar(1500) DEFAULT NULL,
  `major_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_COURSE_major_ID` (`major_ID`),
  CONSTRAINT `FK_COURSE_major_ID` FOREIGN KEY (`major_ID`) REFERENCES `major` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,'Program Design Paradigm','img/pdp.jpg','Globally integrate one-to-one deliverables without team building quality vectors. Synergistically unleash client-focused supply chains with transparent solutions. Completely reintermediate extensive meta-services via customer directed core competencies. Continually streamline end-to-end potentialities after collaborative growth strategies. Authoritatively integrate long-term high-impact quality vectors before holistic vortals.',1),(2,'Introduction to Database Management Systems','img/dbms.jpg','Globally integrate one-to-one deliverables without team building quality vectors. Synergistically unleash client-focused supply chains with transparent solutions. Completely reintermediate extensive meta-services via customer directed core competencies. Continually streamline end-to-end potentialities after collaborative growth strategies. Authoritatively integrate long-term high-impact quality vectors before holistic vortals.',1),(3,'Web Development','img/web-dev.jpg','Globally integrate one-to-one deliverables without team building quality vectors. Synergistically unleash client-focused supply chains with transparent solutions. Completely reintermediate extensive meta-services via customer directed core competencies. Continually streamline end-to-end potentialities after collaborative growth strategies. Authoritatively integrate long-term high-impact quality vectors before holistic vortals.',1);
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enroll`
--

DROP TABLE IF EXISTS `enroll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enroll` (
  `COURSE_ID` int(11) NOT NULL,
  `PERSON_ID` int(11) NOT NULL,
  `SEMESTER_ID` int(11) NOT NULL,
  PRIMARY KEY (`COURSE_ID`,`PERSON_ID`,`SEMESTER_ID`),
  KEY `FK_ENROLL_SEMESTER_ID` (`SEMESTER_ID`),
  KEY `FK_ENROLL_PERSON_ID` (`PERSON_ID`),
  CONSTRAINT `FK_ENROLL_PERSON_ID` FOREIGN KEY (`PERSON_ID`) REFERENCES `person` (`ID`),
  CONSTRAINT `FK_ENROLL_COURSE_ID` FOREIGN KEY (`COURSE_ID`) REFERENCES `course` (`ID`),
  CONSTRAINT `FK_ENROLL_SEMESTER_ID` FOREIGN KEY (`SEMESTER_ID`) REFERENCES `semester` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enroll`
--

LOCK TABLES `enroll` WRITE;
/*!40000 ALTER TABLE `enroll` DISABLE KEYS */;
INSERT INTO `enroll` VALUES (1,3,1),(3,3,1),(1,1,2),(1,2,2),(1,5,2),(2,1,2),(2,2,2),(2,3,2),(2,4,2),(3,4,2);
/*!40000 ALTER TABLE `enroll` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DATE` date DEFAULT NULL,
  `DESCRIPTION` varchar(1500) DEFAULT NULL,
  `EVENTNAME` varchar(255) DEFAULT NULL,
  `course_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_EVENT_course_ID` (`course_ID`),
  CONSTRAINT `FK_EVENT_course_ID` FOREIGN KEY (`course_ID`) REFERENCES `course` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,'2014-12-11','The TA\'s will conduct a session to help students set up Dr Racket and their Github accounts.','PDP - Set up Dr Racket',1),(2,'2014-12-11','Date:             12/8, 12/9, 12/10, 12/11\nTimes:           6-9 pm EST\nRoom:           241 RI\nSeattle folks: we are going to use Google Hangout. We will send invitations to those folks that registered for that day at that time. Be ready to accept and join the hangout.','Project Presentations',2),(3,'2014-12-11','11/28/14 10:59 AM\nHere\'s the rubric for the project\n \nhttps://docs.google.com/spreadsheets/d/1_Uej31LX80TiknoyQdDD5AqpWP6Y8F1YvbUTXQzVAdo/edit?usp=sharing\n \nIf you are using NodeJS and MongoDB, we\'ll use the equivalent terminology, e.g., instead of JWS Web services, we will consider Express Web Services, data model might have been implemented using Mongoose instead of Java classes, etc....','Project Rubric',2),(4,'2014-12-11','lorem ipsum','PDP- do your homwork',1);
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `major`
--

DROP TABLE IF EXISTS `major`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `major` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `major`
--

LOCK TABLES `major` WRITE;
/*!40000 ALTER TABLE `major` DISABLE KEYS */;
INSERT INTO `major` VALUES (1,'Computer Science'),(2,'Information Assurance');
/*!40000 ALTER TABLE `major` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DTYPE` varchar(31) DEFAULT NULL,
  `DETAILS` varchar(2000) DEFAULT NULL,
  `EMAIL` varchar(255) DEFAULT NULL,
  `FIRSTNAME` varchar(255) DEFAULT NULL,
  `LASTNAME` varchar(255) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `PROFILEPIC` varchar(255) DEFAULT NULL,
  `USERNAME` varchar(255) DEFAULT NULL,
  `major_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `USERNAME` (`USERNAME`),
  KEY `FK_PERSON_major_ID` (`major_ID`),
  CONSTRAINT `FK_PERSON_major_ID` FOREIGN KEY (`major_ID`) REFERENCES `major` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (1,'Student','Enthusiastically generate premium paradigms rather than web-enabled experiences. Energistically harness empowered data and bricks-and-clicks methods of empowerment. Holisticly evolve principle-centered deliverables after synergistic manufactured products. Compellingly e-enable state of the art catalysts for change and user friendly services. Conveniently reinvent team driven systems vis-a-vis mission-critical information.','abhisek@ccs.neu.edu','Abhisek','Agrawal','password','img/abhisek.jpg','abhi',1),(2,'Student','Enthusiastically generate premium paradigms rather than web-enabled experiences. Energistically harness empowered data and bricks-and-clicks methods of empowerment. Holisticly evolve principle-centered deliverables after synergistic manufactured products. Compellingly e-enable state of the art catalysts for change and user friendly services. Conveniently reinvent team driven systems vis-a-vis mission-critical information.','sujith@ccs.neu.edu','Sujith','Mahendrakar','password','img/sujith.jpg','sujith',1),(3,'Student','Enthusiastically generate premium paradigms rather than web-enabled experiences. Energistically harness empowered data and bricks-and-clicks methods of empowerment. Holisticly evolve principle-centered deliverables after synergistic manufactured products. Compellingly e-enable state of the art catalysts for change and user friendly services. Conveniently reinvent team driven systems vis-a-vis mission-critical information.','muthana@ccs.neu.edu','Muthana','Chittiappa','password','img/muthana.jpg','muthana',1),(4,'Professor','Enthusiastically generate premium paradigms rather than web-enabled experiences. Energistically harness empowered data and bricks-and-clicks methods of empowerment. Holisticly evolve principle-centered deliverables after synergistic manufactured products. Compellingly e-enable state of the art catalysts for change and user friendly services. Conveniently reinvent team driven systems vis-a-vis mission-critical information.','jannunzi@gmail.com','Jose','Annunziato','password','img/jose.jpg','jose',NULL),(5,'Professor','Intrinsicly reconceptualize multidisciplinary processes with functionalized channels. Appropriately parallel task world-class ROI whereas interoperable strategic theme areas. Globally promote cross-unit leadership after bleeding-edge processes. Enthusiastically reinvent functionalized imperatives after robust quality vectors. Monotonectally engineer parallel outsourcing without wireless collaboration and idea-sharing.','mitchell-wand@gmail.com','Mitchell','Wand','password','img/mitchell.jpg','mitchell',NULL);
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `COMMENT` varchar(1337) DEFAULT NULL,
  `RATING` int(11) DEFAULT NULL,
  `TITLE` varchar(255) DEFAULT NULL,
  `course_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_REVIEW_course_ID` (`course_ID`),
  CONSTRAINT `FK_REVIEW_course_ID` FOREIGN KEY (`course_ID`) REFERENCES `course` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,'Not a fan!!!',1,'Bad Grading',1),(2,'What a waste of money!!',3,'The Best Course EVER!!!',1),(3,'Loved the course. Learnt loads!! Highly recommended!',5,'AMAZING!!!',2),(4,'The best course I\'ve taken so far at Northeastern University. Brilliant!!',5,'Awesome!!!',2),(5,'Professor was very helpful. Helped in whatever possible way he could.\nLoved the live coding in classes.\nI am definitely taking his Web Development class.',5,'A complete course.',2),(6,'joking',1,'best course ever!!',1);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `semester`
--

DROP TABLE IF EXISTS `semester`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `semester` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DATE` date DEFAULT NULL,
  `SEMESTER` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semester`
--

LOCK TABLES `semester` WRITE;
/*!40000 ALTER TABLE `semester` DISABLE KEYS */;
INSERT INTO `semester` VALUES (1,'2014-01-06','Spring 2014'),(2,'2014-09-01','Fall 2014');
/*!40000 ALTER TABLE `semester` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submission`
--

DROP TABLE IF EXISTS `submission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submission` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CONTENT` varchar(10000) DEFAULT NULL,
  `GRADE` int(11) DEFAULT NULL,
  `SUBDATE` date DEFAULT NULL,
  `assignment_ID` int(11) DEFAULT NULL,
  `person_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_SUBMISSION_assignment_ID` (`assignment_ID`),
  KEY `FK_SUBMISSION_person_ID` (`person_ID`),
  CONSTRAINT `FK_SUBMISSION_person_ID` FOREIGN KEY (`person_ID`) REFERENCES `person` (`ID`),
  CONSTRAINT `FK_SUBMISSION_assignment_ID` FOREIGN KEY (`assignment_ID`) REFERENCES `assignment` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submission`
--

LOCK TABLES `submission` WRITE;
/*!40000 ALTER TABLE `submission` DISABLE KEYS */;
INSERT INTO `submission` VALUES (2,'2',100,'2014-12-11',6,1);
/*!40000 ALTER TABLE `submission` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-12-11 21:57:57
