-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: login
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `absentee_records`
--

DROP TABLE IF EXISTS `absentee_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `absentee_records` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `schedule_id` int NOT NULL,
  `absentee_count` int DEFAULT '0',
  `reason` text,
  PRIMARY KEY (`record_id`),
  KEY `schedule_id` (`schedule_id`),
  CONSTRAINT `absentee_records_ibfk_1` FOREIGN KEY (`schedule_id`) REFERENCES `invigilation_schedule` (`schedule_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `absentee_records`
--

LOCK TABLES `absentee_records` WRITE;
/*!40000 ALTER TABLE `absentee_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `absentee_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adjustment_requests`
--

DROP TABLE IF EXISTS `adjustment_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adjustment_requests` (
  `request_id` int NOT NULL AUTO_INCREMENT,
  `original_schedule_id` int DEFAULT NULL,
  `requested_by` int DEFAULT NULL,
  `requested_to` int DEFAULT NULL,
  `reason` text,
  `status` enum('pending','accepted','rejected') DEFAULT 'pending',
  PRIMARY KEY (`request_id`),
  KEY `original_schedule_id` (`original_schedule_id`),
  KEY `requested_by` (`requested_by`),
  KEY `requested_to` (`requested_to`),
  CONSTRAINT `adjustment_requests_ibfk_1` FOREIGN KEY (`original_schedule_id`) REFERENCES `invigilation_schedule` (`schedule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `adjustment_requests_ibfk_2` FOREIGN KEY (`requested_by`) REFERENCES `faculty` (`faculty_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `adjustment_requests_ibfk_3` FOREIGN KEY (`requested_to`) REFERENCES `faculty` (`faculty_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adjustment_requests`
--

LOCK TABLES `adjustment_requests` WRITE;
/*!40000 ALTER TABLE `adjustment_requests` DISABLE KEYS */;
INSERT INTO `adjustment_requests` VALUES (44,65,45,46,'headache','accepted');
/*!40000 ALTER TABLE `adjustment_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `course_id` int NOT NULL AUTO_INCREMENT,
  `course_name` varchar(255) NOT NULL,
  `department_id` int DEFAULT NULL,
  PRIMARY KEY (`course_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (1,'Introduction to Programming',1),(2,'Circuit Analysis',2),(3,'Thermodynamics',3),(21,'BDA',21),(22,'machine learning',22),(23,'dbms',1),(24,'dld',2);
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `department_name` varchar(255) NOT NULL,
  `incharge_user_id` int DEFAULT NULL,
  PRIMARY KEY (`department_id`),
  KEY `incharge_user_id` (`incharge_user_id`),
  CONSTRAINT `departments_ibfk_1` FOREIGN KEY (`incharge_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'Computer Science',NULL),(2,'Electrical Engineering',NULL),(3,'Mechanical Engineering',34),(21,'Data science',NULL),(22,'aiml',NULL);
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculty`
--

DROP TABLE IF EXISTS `faculty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faculty` (
  `faculty_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `department_id` int DEFAULT NULL,
  `is_available` tinyint(1) DEFAULT '1',
  `course_id` int DEFAULT NULL,
  `max_duties` int DEFAULT '30',
  PRIMARY KEY (`faculty_id`),
  KEY `user_id` (`user_id`),
  KEY `department_id` (`department_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `faculty_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `faculty_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `faculty_ibfk_3` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculty`
--

LOCK TABLES `faculty` WRITE;
/*!40000 ALTER TABLE `faculty` DISABLE KEYS */;
INSERT INTO `faculty` VALUES (45,32,1,1,1,30),(46,33,22,1,22,30),(47,34,3,1,3,30);
/*!40000 ALTER TABLE `faculty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `feedback_id` int NOT NULL AUTO_INCREMENT,
  `faculty_id` int DEFAULT NULL,
  `feedback` text NOT NULL,
  `timestamp` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`feedback_id`),
  KEY `faculty_id` (`faculty_id`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invigilation_schedule`
--

DROP TABLE IF EXISTS `invigilation_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invigilation_schedule` (
  `schedule_id` int NOT NULL AUTO_INCREMENT,
  `faculty_id` int DEFAULT NULL,
  `course_id` int DEFAULT NULL,
  `room_id` int DEFAULT NULL,
  `date` date NOT NULL,
  `time_slot` varchar(255) NOT NULL,
  PRIMARY KEY (`schedule_id`),
  KEY `faculty_id` (`faculty_id`),
  KEY `course_id` (`course_id`),
  KEY `room_id` (`room_id`),
  CONSTRAINT `invigilation_schedule_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `invigilation_schedule_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `invigilation_schedule_ibfk_3` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invigilation_schedule`
--

LOCK TABLES `invigilation_schedule` WRITE;
/*!40000 ALTER TABLE `invigilation_schedule` DISABLE KEYS */;
INSERT INTO `invigilation_schedule` VALUES (65,45,1,1,'2024-04-11','1.00-4.00'),(66,46,21,1,'2024-04-13','1.00-4.00');
/*!40000 ALTER TABLE `invigilation_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms` (
  `room_id` int NOT NULL AUTO_INCREMENT,
  `room_number` varchar(255) NOT NULL,
  `is_available` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`room_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES (1,'101',1),(2,'102',1),(3,'103',1),(4,'104',1),(5,'105',1),(6,'106',1);
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('Admin','Department Incharge','Faculty') NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (23,'Chandu Gangavarapu','chandugangavarapu510@gmail.com','pbkdf2:sha256:600000$7Ki10II8Dllmrfl0$f3568eeb2315a62d5ed1fb8ff3bc7330a9c6b0a985d96abb370f2202df3f4dba','Admin'),(32,'bhaskar','dbsreddy3@gmail.com','pbkdf2:sha256:600000$VXMKObec1s2nuoEE$61e3d420d5196db8002cf4bd0cfffbb9d03e1453d5c4be5bf89c604f4860096e','Faculty'),(33,'praveen','20jk1a4223@gmail.com','pbkdf2:sha256:600000$fVonDq2MKUDT09pf$452214d21f75f9607ee7770302000093e8dfeb4d46337dd06da8ded0267e2c95','Faculty'),(34,'bittu','bodavamshikrishna30@gmail.com','pbkdf2:sha256:600000$dYmxcgUc9WJkAMu4$27c7af9a5cdeca985f2f29db3c60f429fa129f1f82439e5a437d2b6110116df6','Department Incharge');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-10 16:00:03
