#!/bin/bash

#source hdbsql.bash
source cube_hdbsql.bash

function test {
	hdb_run_file $1 log
	hdb_log ','
	printf "."
}

function benchmark {
	test "./sql/benchmark/q1_bench/q1.sql"
	test "./sql/benchmark/q1_bench/q1.1.sql"
	test "./sql/benchmark/q1_bench/q1.2.sql"
	test "./sql/benchmark/q1_bench/q1.3.sql"
	test "./sql/benchmark/q2_bench/q2.sql"
	test "./sql/benchmark/q2_bench/q2.1.sql"
	test "./sql/benchmark/q2_bench/q2.2.sql"
	test "./sql/benchmark/q2_bench/q2.3.sql"
	test "./sql/benchmark/q3_bench/q3.sql"
	test "./sql/benchmark/q3_bench/q3.1.sql"
	test "./sql/benchmark/q3_bench/q3.2.sql"
	test "./sql/benchmark/q3_bench/q3.3.sql"
	test "./sql/benchmark/q3_bench/q3.4.sql"
	test "./sql/benchmark/q4_bench/q4.sql"
	test "./sql/benchmark/q4_bench/q4.1.sql"
	test "./sql/benchmark/q4_bench/q4.2.sql"
	test "./sql/benchmark/q4_bench/q4.3.sql"
	printf "\n"
}

function benchmark_10 {
	test "./sql/benchmark/q1_bench/q1_10.sql"
	test "./sql/benchmark/q1_bench/q1.1_10.sql"
	test "./sql/benchmark/q1_bench/q1.2_10.sql"
	test "./sql/benchmark/q1_bench/q1.3_10.sql"
	test "./sql/benchmark/q2_bench/q2_10.sql"
	test "./sql/benchmark/q2_bench/q2.1_10.sql"
	test "./sql/benchmark/q2_bench/q2.2_10.sql"
	test "./sql/benchmark/q2_bench/q2.3_10.sql"
	test "./sql/benchmark/q3_bench/q3_10.sql"	
	test "./sql/benchmark/q3_bench/q3.1_10.sql"
	test "./sql/benchmark/q3_bench/q3.2_10.sql"
	test "./sql/benchmark/q3_bench/q3.3_10.sql"
	test "./sql/benchmark/q3_bench/q3.4_10.sql"
	test "./sql/benchmark/q4_bench/q4_10.sql"
	test "./sql/benchmark/q4_bench/q4.1_10.sql"
	test "./sql/benchmark/q4_bench/q4.2_10.sql"
	test "./sql/benchmark/q4_bench/q4.3_10.sql"
	printf "\n"
}

function benchmark_100 {
	test "./sql/benchmark/q1_bench/q1_100.sql"
	test "./sql/benchmark/q1_bench/q1.1_100.sql"
	test "./sql/benchmark/q1_bench/q1.2_100.sql"
	test "./sql/benchmark/q1_bench/q1.3_100.sql"
	test "./sql/benchmark/q2_bench/q2_100.sql"
	test "./sql/benchmark/q2_bench/q2.1_100.sql"
	test "./sql/benchmark/q2_bench/q2.2_100.sql"
	test "./sql/benchmark/q2_bench/q2.3_100.sql"
	test "./sql/benchmark/q3_bench/q3_100.sql"
	test "./sql/benchmark/q3_bench/q3.1_100.sql"
	test "./sql/benchmark/q3_bench/q3.2_100.sql"
	test "./sql/benchmark/q3_bench/q3.3_100.sql"
	test "./sql/benchmark/q3_bench/q3.4_100.sql"
	test "./sql/benchmark/q4_bench/q4_100.sql"
	test "./sql/benchmark/q4_bench/q4.1_100.sql"
	test "./sql/benchmark/q4_bench/q4.2_100.sql"
	test "./sql/benchmark/q4_bench/q4.3_100.sql"
	printf "\n"
}


function benchmark_olap {
	test "./sql/benchmark_olap/q1_bench/q1.sql"
	test "./sql/benchmark_olap/q1_bench/q1.1.sql"
	test "./sql/benchmark_olap/q1_bench/q1.2.sql"
	test "./sql/benchmark_olap/q1_bench/q1.3.sql"
	test "./sql/benchmark_olap/q2_bench/q2.sql"
	test "./sql/benchmark_olap/q2_bench/q2.1.sql"
	test "./sql/benchmark_olap/q2_bench/q2.2.sql"
	test "./sql/benchmark_olap/q2_bench/q2.3.sql"
	test "./sql/benchmark_olap/q3_bench/q3.sql"
	test "./sql/benchmark_olap/q3_bench/q3.1.sql"
	test "./sql/benchmark_olap/q3_bench/q3.2.sql"
	test "./sql/benchmark_olap/q3_bench/q3.3.sql"
	test "./sql/benchmark_olap/q3_bench/q3.4.sql"
	test "./sql/benchmark_olap/q4_bench/q4.sql"
	test "./sql/benchmark_olap/q4_bench/q4.1.sql"
	test "./sql/benchmark_olap/q4_bench/q4.2.sql"
	test "./sql/benchmark_olap/q4_bench/q4.3.sql"
	printf "\n"
}

function benchmark_no_olap {
	test "./sql/benchmark_noolap/q1_bench/q1.sql"
	test "./sql/benchmark_noolap/q1_bench/q1.1.sql"
	test "./sql/benchmark_noolap/q1_bench/q1.2.sql"
	test "./sql/benchmark_noolap/q1_bench/q1.3.sql"
	test "./sql/benchmark_noolap/q2_bench/q2.sql"
	test "./sql/benchmark_noolap/q2_bench/q2.1.sql"
	test "./sql/benchmark_noolap/q2_bench/q2.2.sql"
	test "./sql/benchmark_noolap/q2_bench/q2.3.sql"
	test "./sql/benchmark_noolap/q3_bench/q3.sql"
	test "./sql/benchmark_noolap/q3_bench/q3.1.sql"
	test "./sql/benchmark_noolap/q3_bench/q3.2.sql"
	test "./sql/benchmark_noolap/q3_bench/q3.3.sql"
	test "./sql/benchmark_noolap/q3_bench/q3.4.sql"
	test "./sql/benchmark_noolap/q4_bench/q4.sql"
	test "./sql/benchmark_noolap/q4_bench/q4.1.sql"
	test "./sql/benchmark_noolap/q4_bench/q4.2.sql"
	test "./sql/benchmark_noolap/q4_bench/q4.3.sql"
	printf "\n"
}

function benchmark_olap_10 {
	test "./sql/benchmark_olap/q1_bench/q1_10.sql"
	test "./sql/benchmark_olap/q1_bench/q1.1_10.sql"
	test "./sql/benchmark_olap/q1_bench/q1.2_10.sql"
	test "./sql/benchmark_olap/q1_bench/q1.3_10.sql"
	test "./sql/benchmark_olap/q2_bench/q2_10.sql"
	test "./sql/benchmark_olap/q2_bench/q2.1_10.sql"
	test "./sql/benchmark_olap/q2_bench/q2.2_10.sql"
	test "./sql/benchmark_olap/q2_bench/q2.3_10.sql"
	test "./sql/benchmark_olap/q3_bench/q3_10.sql"	
	test "./sql/benchmark_olap/q3_bench/q3.1_10.sql"
	test "./sql/benchmark_olap/q3_bench/q3.2_10.sql"
	test "./sql/benchmark_olap/q3_bench/q3.3_10.sql"
	test "./sql/benchmark_olap/q3_bench/q3.4_10.sql"
	test "./sql/benchmark_olap/q4_bench/q4_10.sql"
	test "./sql/benchmark_olap/q4_bench/q4.1_10.sql"
	test "./sql/benchmark_olap/q4_bench/q4.2_10.sql"
	test "./sql/benchmark_olap/q4_bench/q4.3_10.sql"
	printf "\n"
}

function switch_to {
	printf "Switching to $1.\n"
	if [[ $1 = "column" ]]; then
		hdb_run_file_lite ./sql/switch_to_col.sql
	elif [[ $1 = "row" ]]; then
		hdb_run_file_lite ./sql/switch_to_row.sql
	else
		printf "Cannot switch to $1."
	fi
}

function run_all_benchmarks {
	for i in `seq 1 ${2:-1}`; do
		printf "Running benchmark number $i"
		hdb_log_start_array
		benchmark $1
		hdb_log_end_array
		hdb_log ","
		printf "\n"
	done
}

function run_all_benchmarks_olap {
	for i in `seq 1 ${2:-1}`; do
		printf "Running benchmark number $i"
		hdb_log_start_array
		benchmark_olap $1
		hdb_log_end_array
		hdb_log ","
		printf "\n"
	done
}

function run_all_benchmarks_no_olap {
	for i in `seq 1 ${2:-1}`; do
		printf "Running benchmark number $i"
		hdb_log_start_array
		benchmark_no_olap $1
		hdb_log_end_array
		hdb_log ","
		printf "\n"
	done
}

function run_all_benchmarks_10 {
	for i in `seq 1 ${2:-1}`; do
		printf "Running benchmark number $i"
		hdb_log_start_array
		benchmark_10 $1
		hdb_log_end_array
		hdb_log ","
		printf "\n"
	done
}

function run_all_benchmarks_100 {
	for i in `seq 1 ${2:-1}`; do
		printf "Running benchmark number $i"
		hdb_log_start_array
		benchmark_100 $1
		hdb_log_end_array
		hdb_log ","
		printf "\n"
	done
}

function run_all_benchmarks_olap_10 {
	for i in `seq 1 ${2:-1}`; do
		printf "Running benchmark number $i"
		hdb_log_start_array
		benchmark_10 $1
		hdb_log_end_array
		hdb_log ","
		printf "\n"
	done
}
