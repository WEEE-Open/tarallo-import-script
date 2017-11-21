#!/usr/bin/php
<?php
$data = file_get_contents('tarallo-backend' . DIRECTORY_SEPARATOR . 'database-data.sql');
$lines = preg_split('/[\n\r]/', $data, -1, PREG_SPLIT_NO_EMPTY);
//$result = 'let features = new Map();'.PHP_EOL;
$result .= '// BEGIN GENERATED CODE'.PHP_EOL;

$block = 0;
$features = [];
echo 'Found ' . count($lines) . ' lines'.PHP_EOL;
foreach($lines as $line) {
	/** @noinspection SqlNoDataSourceInspection */
	$wut = 'INSERT INTO `Feature`';
	if(substr($line, 0, strlen($wut)) === $wut) {
		$block = 1;
		continue;
	}
	/** @noinspection SqlNoDataSourceInspection */
	$wut = 'INSERT INTO `FeatureValue`';
	if(substr($line, 0, strlen($wut)) === $wut) {
		$block = 2;
		continue;
	}
	if($block === 0) {
		continue;
	} else {
		$boom = explode( ',', $line );
		if(count($boom) < 3) {
			continue;
		}
		if ($block === 1) {
			$id      = substr($boom[0], 2);
			$feature = substr($boom[1], 2, strlen( $boom[1] ) - 3);
			$type    = substr($boom[2], 1, 1);

			if($type === '2') {
				$result .= 'Features.list.set(\''.$feature.'\', new Set({REPLACE'.$id.'}));'.PHP_EOL;
			} else {
				$result .= 'Features.list.set(\''.$feature.'\', null);'.PHP_EOL;
			}

			$features[$id] = [];

			echo 'Feature: ' . $id . ':' . $feature . ':' . $type . PHP_EOL;
		} else if($block === 2) {
			if(count($boom) === 3) {
				$distance = 5;
			} else {
				$distance = 4;
			}
			$id      = substr($boom[0], 2);
			$value = substr( $boom[2], 2, strlen( $boom[2] ) - $distance );

			$features[$id][] = $value;

			echo 'Value: ' . $id . ':' . $value . PHP_EOL;
		} else {
			echo 'Eh?' . PHP_EOL;
		}
	}
}

foreach($features as $id => $values) {
	$array = '[';
	foreach($values as $value) {
		$array .= '\'' . $value . '\', ';
	}
	$array = substr($array, 0, strlen($array) - 2);
	$array .= ']';
	$result = str_replace('{REPLACE'.$id.'}', $array, $result);
}
$result .= '// END GENERATED CODE'.PHP_EOL;

file_put_contents('features.generated.js', $result);
