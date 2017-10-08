SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

USE `tarallo`;

SET NAMES utf8mb4;

TRUNCATE `Codes`;
INSERT INTO `Codes` (`Prefix`, `Integer`) VALUES
('M',	3),
('T',	2);

TRUNCATE `Feature`;
INSERT INTO `Feature` (`FeatureID`, `FeatureName`, `FeatureType`) VALUES
(1,	'brand',	0),
(2,	'model',	0),
(3,	'owner',	0),
(4,	'sn',	0),
(5,	'mac',	0),
(6,	'type',	2),
(7,	'working',	2),
(8,	'capacity-byte',	1),
(9,	'frequency-hz',	1),
(10,	'diameter-mm',	1),
(11,	'diagonal-inch',	1),
(12,	'has-gpu',	2),
(13,	'color',	2),
(14,	'motherboard-form-factor',	2),
(15,	'notes',	0);

TRUNCATE `FeatureValue`;
INSERT INTO `FeatureValue` (`FeatureID`, `ValueEnum`, `ValueText`) VALUES
(6,	0,	'location'),
(6,	1,	'case'),
(6,	2,	'motherboard'),
(6,	3,	'cpu'),
(6,	4,	'gpu'),
(6,	5,	'ram'),
(6,	6,	'hdd'),
(6,	7,	'odd'),
(6,	8,	'psu'),
(6,	9,	'audio-card'),
(6,	10,	'network-card'),
(6,	11,	'monitor'),
(6,	12,	'mouse'),
(6,	13,	'keyboard'),
(6,	14,	'inventory-sticker-polito'),
(6,	15,	'inventory-sticker-polito-old'),
(6,	16,	'inventory-sticker-disat'),
(6,	17,	'windows-sticker'),
(7,	0,	'no'),
(7,	1,	'yes'),
(7,	2,	'cant-tell'),
(12,	0,	'no'),
(12,	1,	'yes'),
(13,	0,	'black'),
(13,	1,	'white'),
(13,	2,	'green'),
(13,	3,	'yellow'),
(13,	4,	'red'),
(13,	5,	'blue'),
(13,	6,	'grey'),
(13,	7,	'sip-brown'),
(14,	0,	'atx'),
(14,	1,	'miniatx'),
(14,	2,	'microatx'),
(14,	3,	'miniitx'),
(14,	4,	'proprietary');

TRUNCATE `Item`;
INSERT INTO `Item` (`ItemID`, `Code`, `IsDefault`, `Default`) VALUES
(1,	'CHERNOBYL',	0,	NULL),
(2,	'TAVOLONE',	0,	NULL),
(3,	'SCHIFOMACCHINA',	0,	NULL),
(4,	'ROSETTA',	0,	NULL),
(5,	'RAM-3342',	0,	NULL),
(6,	'RAM-2452',	0,	NULL),
(7,	'PC-TI',	0,	NULL),
(8,	'RAM-22',	0,	NULL),
(9,	'RAM-23',	0,	NULL),
(10,	'PC-TI-MOBO',	0,	NULL),
(11,	'PC-TI-CPU',	0,	NULL),
(12,	'ArmadioL',	0,	NULL),
(13,	'ArmadioR',	0,	NULL),
(14,	'ZonaBlu',	0,	NULL),
(19,	'asd',	0,	NULL),
(20,	'DELETED',	0,	NULL),
(29,	'M1',	0,	NULL),
(30,	'M2',	0,	NULL),
(31,	'M3',	0,	NULL);

TRUNCATE `ItemFeature`;
INSERT INTO `ItemFeature` (`FeatureID`, `ItemID`, `Value`, `ValueEnum`, `ValueText`) VALUES
(1,	3,	NULL,	NULL,	'eMac'),
(1,	4,	NULL,	NULL,	'pH'),
(1,	7,	NULL,	NULL,	'TI'),
(1,	11,	NULL,	NULL,	'Intel-lighenzia'),
(1,	20,	NULL,	NULL,	'asd'),
(1,	30,	NULL,	NULL,	'Boh'),
(2,	3,	NULL,	NULL,	'EZ1600'),
(2,	4,	NULL,	NULL,	'ReliaPro MLG555'),
(2,	11,	NULL,	NULL,	'Atomic 5L0W-NE55'),
(6,	1,	NULL,	0,	NULL),
(6,	2,	NULL,	0,	NULL),
(6,	3,	NULL,	1,	NULL),
(6,	4,	NULL,	1,	NULL),
(6,	5,	NULL,	5,	NULL),
(6,	6,	NULL,	5,	NULL),
(6,	7,	NULL,	1,	NULL),
(6,	8,	NULL,	5,	NULL),
(6,	9,	NULL,	5,	NULL),
(6,	10,	NULL,	2,	NULL),
(6,	11,	NULL,	3,	NULL),
(6,	12,	NULL,	0,	NULL),
(6,	13,	NULL,	0,	NULL),
(6,	14,	NULL,	0,	NULL),
(6,	29,	NULL,	12,	NULL),
(6,	30,	NULL,	12,	NULL),
(6,	31,	NULL,	12,	NULL),
(8,	5,	1073741824,	NULL,	NULL),
(8,	6,	1073741824,	NULL,	NULL),
(8,	8,	32,	NULL,	NULL),
(8,	9,	32,	NULL,	NULL),
(9,	11,	42,	NULL,	NULL),
(9,	20,	666,	NULL,	NULL),
(13,	3,	NULL,	1,	NULL),
(13,	4,	NULL,	6,	NULL),
(13,	7,	NULL,	1,	NULL),
(13,	10,	NULL,	2,	NULL),
(13,	19,	NULL,	3,	NULL),
(13,	29,	NULL,	1,	NULL),
(13,	30,	NULL,	3,	NULL),
(14,	3,	NULL,	3,	NULL),
(14,	4,	NULL,	0,	NULL),
(14,	7,	NULL,	3,	NULL);

TRUNCATE `ItemLocationModification`;
INSERT INTO `ItemLocationModification` (`ModificationID`, `ItemID`, `ParentTo`) VALUES
(55,	29,	12),
(56,	30,	12),
(57,	31,	12);

TRUNCATE `ItemModification`;

TRUNCATE `ItemModificationDelete`;
INSERT INTO `ItemModificationDelete` (`ModificationID`, `ItemID`) VALUES
(38,	20);

TRUNCATE `Modification`;
INSERT INTO `Modification` (`ModificationID`, `UserID`, `Date`, `Notes`) VALUES
(1,	1,	1495115170,	NULL),
(2,	1,	1495115170,	NULL),
(10,	1,	1504818205,	'Aggiunto l\'asd'),
(11,	1,	1504818207,	NULL),
(12,	1,	1504818208,	NULL),
(13,	1,	1504818208,	NULL),
(14,	1,	1504818208,	NULL),
(15,	1,	1504818208,	NULL),
(16,	1,	1504818209,	NULL),
(17,	1,	1504818209,	NULL),
(18,	1,	1504818209,	NULL),
(19,	1,	1504818222,	NULL),
(20,	1,	1504818223,	NULL),
(21,	1,	1504818229,	NULL),
(22,	1,	1504818241,	NULL),
(23,	1,	1504818251,	NULL),
(24,	1,	1504818445,	NULL),
(25,	1,	1504818462,	NULL),
(26,	1,	1504818518,	NULL),
(27,	1,	1504818538,	NULL),
(28,	1,	1504818789,	NULL),
(29,	1,	1505822364,	'Aggiunto item da rimuovere'),
(38,	1,	1505897221,	'Eliminato l\'oggetto eliminato'),
(40,	1,	1506465228,	NULL),
(41,	1,	1506467157,	NULL),
(42,	1,	1506519785,	NULL),
(43,	1,	1506519823,	NULL),
(45,	1,	1506520141,	NULL),
(46,	1,	1506520255,	NULL),
(55,	1,	1507412937,	'Un mouse'),
(56,	1,	1507413133,	NULL),
(57,	1,	1507413313,	'asd');

TRUNCATE `Tree`;
INSERT INTO `Tree` (`AncestorID`, `DescendantID`, `Depth`) VALUES
(1,	1,	0),
(1,	2,	1),
(1,	3,	2),
(1,	4,	2),
(1,	5,	3),
(1,	6,	3),
(1,	7,	2),
(1,	8,	3),
(1,	9,	3),
(1,	10,	3),
(1,	11,	3),
(1,	12,	1),
(1,	13,	1),
(1,	14,	1),
(1,	19,	1),
(1,	29,	2),
(1,	30,	2),
(1,	31,	2),
(2,	2,	0),
(2,	3,	1),
(2,	4,	1),
(2,	5,	2),
(2,	6,	2),
(3,	3,	0),
(4,	4,	0),
(4,	5,	1),
(4,	6,	1),
(5,	5,	0),
(6,	6,	0),
(7,	7,	0),
(7,	8,	1),
(7,	9,	1),
(7,	10,	1),
(7,	11,	1),
(8,	8,	0),
(9,	9,	0),
(10,	10,	0),
(11,	11,	0),
(12,	12,	0),
(12,	29,	1),
(12,	30,	1),
(12,	31,	1),
(13,	13,	0),
(14,	7,	1),
(14,	8,	2),
(14,	9,	2),
(14,	10,	2),
(14,	11,	2),
(14,	14,	0),
(19,	19,	0),
(29,	29,	0),
(30,	30,	0),
(31,	31,	0);

TRUNCATE `User`;
INSERT INTO `User` (`UserID`, `Name`, `Password`, `Session`, `SessionExpiry`, `Enabled`) VALUES
(1,	'asd',	'$2y$10$nrGjrh07hFNjzRDxCWrtfuo.Nug9.AdjcaYQuUMPQhVKRRrxz1Hsm',	'iR3YvecST9zvuSwyPohH4O8L4mWpj7Kk',	1507496724,	1),
(2,	'lel',	'$2y$10$nrGjrh07hFNjzRDxCWrtfuo.Nug9.AdjcaYQuUMPQhVKRRrxz1Hsm',	NULL,	NULL,	1),
(3,	'asdatore',	'$2y$10$nrGjrh07hFNjzRDxCWrtfuo.Nug9.AdjcaYQuUMPQhVKRRrxz1Hsm',	NULL,	NULL,	1),
(4,	'disattivato',	'$2y$10$nrGjrh07hFNjzRDxCWrtfuo.Nug9.AdjcaYQuUMPQhVKRRrxz1Hsm',	NULL,	NULL,	0);
