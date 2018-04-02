#!/bin/bash
source ./cube_hdbsql.bash
source ./all_benchmarks.bash

# Settings
repetitions=100


hdb_ask $1

hdb_init_log

# General Information
hdb_log_start_attribute "General"
hdb_log_start_map
hdb_log_set_attribute "Repetitions" "$repetitions"
hdb_log_set_attribute "ScalingFactor" 1
hdb_log_set_attribute "CPU" 4
hdb_log_set_attribute "Threads" 8
hdb_log_end_map
hdb_log_end_attribute

## Run column benchmark
printf "Adding Foreign Key Indices\n"
hdb_run_file_lite ./sql/addFkIndizes.sql
printf "Indices added\n"

hdb_start_benchmark "column_benchmark_fk" true "FK" "none"
run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

hdb_start_benchmark "column_benchmark_fk_noolap" true "FK" "NO_USE_OLAP_PLAN"
run_all_benchmarks_no_olap "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

hdb_start_benchmark "column_benchmark_fk_olap" true "FK" "USE_OLAP_PLAN"
run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

printf "Adding More Indices (Fact Table)\n"
hdb_run_file_lite ./sql/addFaktenIndizes.sql
printf "Indices added\n"

hdb_start_benchmark "column_benchmark_ft" true "FT" "none"
run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

hdb_start_benchmark "column_benchmark_ft_noolap" true "FT" "NO_USE_OLAP_PLAN"
run_all_benchmarks_no_olap "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

hdb_start_benchmark "column_benchmark_ft_olap" true "FT" "USE_OLAP_PLAN"
run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

printf "Adding Dimension Indices\n"
hdb_run_file_lite ./sql/addDimIndizes.sql
printf "Indices added\n"

hdb_start_benchmark "column_benchmark_dim" true "Dimension" "none"
run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

hdb_start_benchmark "column_benchmark_dim_noolap" true "Dimension" "NO_USE_OLAP_PLAN"
run_all_benchmarks_no_olap "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

hdb_start_benchmark "column_benchmark_dim_olap" true "Dimension" "USE_OLAP_PLAN"
run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

printf "Adding Dimension Indices (Restrictive)\n"
hdb_run_file_lite ./sql/addDimSmallIndizes.sql
printf "Indices added\n"

hdb_start_benchmark "column_benchmark_dim" true "RestrDim" "none"
run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

hdb_start_benchmark "column_benchmark_dim_noolap" true "RestrDim" "NO_USE_OLAP_PLAN"
run_all_benchmarks_no_olap "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

hdb_start_benchmark "column_benchmark_dim_olap" true "RestrDim" "USE_OLAP_PLAN"
run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

printf "Dimension Indices Only\n"
hdb_run_file_lite ./sql/killFaktenIndizes.sql
hdb_run_file_lite ./sql/killFkIndizes.sql
printf "Indices added\n"

hdb_start_benchmark "column_benchmark_dimonly" true "DimOnly" "none"
run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

hdb_start_benchmark "column_benchmark_dimonly_noolap" true "DimOnly" "NO_USE_OLAP_PLAN"
run_all_benchmarks_no_olap "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

hdb_start_benchmark "column_benchmark_dimonly_olap" true "DimOnly" "USE_OLAP_PLAN"
run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

printf "Remove Indices\n"
hdb_run_file_lite ./sql/killDimSmallIndizes.sql
hdb_run_file_lite ./sql/killDimIndizes.sql
printf "Indices removed\n"

## Original indices
#hdb_start_benchmark "column_benchmark_no_index" true "none" "none"
#run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#hdb_start_benchmark "column_benchmark_no_index_noolap" true "none" "NO_USE_OLAP_PLAN"
#run_all_benchmarks_no_olap "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#hdb_start_benchmark "column_benchmark_no_index_olap" true "none" "USE_OLAP_PLAN"
#run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#printf "Adding Basic Indizes\n"
#hdb_run_file_lite ./sql/addBasicIndizes.sql
#printf "Indizes added\n"

#hdb_start_benchmark "column_benchmark_index" true "basic" "none"
#run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#hdb_start_benchmark "column_benchmark_index_noolap" true "basic" "NO_USE_OLAP_PLAN"
#run_all_benchmarks_no_olap "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#hdb_start_benchmark "column_benchmark_index_olap" true "basic" "USE_OLAP_PLAN"
#run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#printf "Adding Advanced Indizes\n"
#hdb_run_file_lite ./sql/advancedIndizes.sql
#printf "Indizes added\n"

#hdb_start_benchmark "column_benchmark_index_adv" true "advanced" "none"
#run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#hdb_start_benchmark "column_benchmark_index_adv_noolap" true "advanced" "NO_USE_OLAP_PLAN"
#run_all_benchmarks_no_olap "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#hdb_start_benchmark "column_benchmark_index_adv_olap" true "advanced" "USE_OLAP_PLAN"
#run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#printf "Adding Further Indizes\n"
#hdb_run_file_lite ./sql/furtherIndizes.sql
#printf "Indizes added\n"

#hdb_start_benchmark "column_benchmark_index_further"
#run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

hdb_finish_log
