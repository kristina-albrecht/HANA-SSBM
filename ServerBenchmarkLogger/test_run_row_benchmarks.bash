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

hdb_start_benchmark "row_benchmark_fk" false "FK" "none"
run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

hdb_start_benchmark "row_benchmark_fk_noolap" false "FK" "NO_USE_OLAP_PLAN"
run_all_benchmarks_no_olap "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

hdb_start_benchmark "row_benchmark_fk_olap" false "FK" "USE_OLAP_PLAN"
run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

printf "Adding More Indices (Fact Table)\n"
hdb_run_file_lite ./sql/addFaktenIndizes.sql
printf "Indices added\n"

hdb_start_benchmark "row_benchmark_ft" false "FT" "none"
run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

hdb_start_benchmark "row_benchmark_ft_noolap" false "FT" "NO_USE_OLAP_PLAN"
run_all_benchmarks_no_olap "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

hdb_start_benchmark "row_benchmark_ft_olap" false "FT" "USE_OLAP_PLAN"
run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

printf "Adding Dimension Indices\n"
hdb_run_file_lite ./sql/addDimIndizes.sql
printf "Indices added\n"

hdb_start_benchmark "row_benchmark_dim" false "Dimension" "none"
run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

hdb_start_benchmark "row_benchmark_dim_noolap" false "Dimension" "NO_USE_OLAP_PLAN"
run_all_benchmarks_no_olap "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

hdb_start_benchmark "row_benchmark_dim_olap" false "Dimension" "USE_OLAP_PLAN"
run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

printf "Adding Dimension Indices (Restrictive)\n"
hdb_run_file_lite ./sql/addDimSmallIndizes.sql
printf "Indices added\n"

hdb_start_benchmark "row_benchmark_dim" false "RestrDim" "none"
run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

hdb_start_benchmark "row_benchmark_dim_noolap" false "RestrDim" "NO_USE_OLAP_PLAN"
run_all_benchmarks_no_olap "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

hdb_start_benchmark "row_benchmark_dim_olap" false "RestrDim" "USE_OLAP_PLAN"
run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

printf "Dimension Indices Only\n"
hdb_run_file_lite ./sql/killFaktenIndizes.sql
hdb_run_file_lite ./sql/killFkIndizes.sql
printf "Indices added\n"

hdb_start_benchmark "row_benchmark_dimonly" false "DimOnly" "none"
run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

hdb_start_benchmark "row_benchmark_dimonly_noolap" false "DimOnly" "NO_USE_OLAP_PLAN"
run_all_benchmarks_no_olap "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

hdb_start_benchmark "row_benchmark_dimonly_olap" false "DimOnly" "USE_OLAP_PLAN"
run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

printf "Remove Indices\n"
hdb_run_file_lite ./sql/killDimSmallIndizes.sql
hdb_run_file_lite ./sql/killDimIndizes.sql
printf "Indices removed\n"

## Original indices
#hdb_start_benchmark "row_benchmark_no_index" false "none" "none"
#run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#hdb_start_benchmark "row_benchmark_no_index_noolap" false "none" "NO_USE_OLAP_PLAN"
#run_all_benchmarks_no_olap "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#hdb_start_benchmark "row_benchmark_no_index_olap" false "none" "USE_OLAP_PLAN"
#run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#printf "Adding Basic Indizes\n"
#hdb_run_file_lite ./sql/addBasicIndizes.sql
#printf "Indizes added\n"

#hdb_start_benchmark "row_benchmark_index" false "basic" "none"
#run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#hdb_start_benchmark "row_benchmark_index_noolap" false "basic" "NO_USE_OLAP_PLAN"
#run_all_benchmarks_no_olap "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#hdb_start_benchmark "row_benchmark_index_olap" false "basic" "USE_OLAP_PLAN"
#run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#printf "Adding Advanced Indizes\n"
#hdb_run_file_lite ./sql/advancedIndizes.sql
#printf "Indizes added\n"

#hdb_start_benchmark "row_benchmark_index_adv" false "advanced" "none"
#run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#hdb_start_benchmark "row_benchmark_index_adv_noolap" false "advanced" "NO_USE_OLAP_PLAN"
#run_all_benchmarks_no_olap "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#hdb_start_benchmark "row_benchmark_index_adv_olap" false "advanced" "USE_OLAP_PLAN"
#run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#printf "Adding Further Indizes\n"
#hdb_run_file_lite ./sql/furtherIndizes.sql
#printf "Indizes added\n"

#hdb_start_benchmark "row_benchmark_index_further"
#run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

hdb_finish_log
