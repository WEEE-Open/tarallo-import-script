#!/usr/bin/php
<?php
$data = file_get_contents('tarallo-backend' . DIRECTORY_SEPARATOR . 'database-data.sql');
$lines = preg_split('/[\n\r]/', $data, -1, PREG_SPLIT_NO_EMPTY);
$result = 'let features = new Map();'.PHP_EOL;

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
				$result .= 'features.set(\''.$feature.'\', new Set({REPLACE'.$id.'}));'.PHP_EOL;
			} else {
				$result .= 'features.set(\''.$feature.'\', null);'.PHP_EOL;
			}

			$features[$id] = [];

			echo 'Feature: ' . $id . ':' . $feature . ':' . $type . PHP_EOL;
		} else if($block === 2) {
			$id      = substr($boom[0], 2);

			$value   = substr($boom[2], 2, strlen( $boom[2] ) - 4);

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

file_put_contents('features.js', $result);
