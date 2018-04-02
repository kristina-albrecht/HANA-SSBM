#!/bin/bash
source ./hdbsql.bash
source ./all_benchmarks.bash

# Settings
repetitions=250


hdb_ask $1

hdb_init_log

# General Information
hdb_log_start_attribute "General"
hdb_log_start_map
hdb_log_set_attribute "Repetitions:" "$repetitions"
hdb_log_end_map
hdb_log_end_attribute

# Run column benchmark
printf "Importing column data\n"
hdb_run_file_lite ./sql/schemaCol.sql
hdb_run_file_lite ./sql/import.sql
printf "Column data imported\n"

#switch_to "column"

hdb_start_benchmark "column_benchmark_no_index"
run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

#hdb_start_benchmark "column_benchmark_no_index_olap"
#run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

printf "Adding Basic Indizes\n"
hdb_run_file_lite ./sql/addBasicIndizes.sql
printf "Indizes added\n"

hdb_start_benchmark "column_benchmark_index"
run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

#hdb_start_benchmark "column_benchmark_index_olap"
#run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark
#printf "Adding Advanced Indizes\n"
#hdb_run_file_lite ./sql/advancedIndizes.sql
#printf "Indizes added\n"

#hdb_start_benchmark "column_benchmark_index_adv"
#run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#printf "Adding Further Indizes\n"
#hdb_run_file_lite ./sql/furtherIndizes.sql
#printf "Indizes added\n"

#hdb_start_benchmark "column_benchmark_index_further"
#run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

# Run row benchmark
printf "Importing row data\n"
hdb_run_file_lite ./sql/schemaRow.sql
hdb_run_file_lite ./sql/import.sql
printf "Row data imported\n"

hdb_start_benchmark "row_benchmark_no_index"
run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

#hdb_start_benchmark "row_benchmark_no_index_olap"
#run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

printf "Adding Indizes\n"
hdb_run_file_lite ./sql/addBasicIndizes.sql
printf "Indizes added\n"

hdb_start_benchmark "row_benchmark_index"
run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

#hdb_start_benchmark "row_benchmark_index_olap"
#run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#printf "Adding Advanced Indizes\n"
#hdb_run_file_lite ./sql/advancedIndizes.sql
#printf "Indizes added\n"

#hdb_start_benchmark "row_benchmark_index_adv"
#run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#printf "Adding Further Indizes\n"
#hdb_run_file_lite ./sql/furtherIndizes.sql
#printf "Indizes added\n"

#hdb_start_benchmark "row_benchmark_index_further"
#run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark


hdb_finish_log
