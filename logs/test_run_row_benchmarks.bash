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
hdb_log_set_non_str_attribute "ScalingFactor" 1
#hdb_log_set_attribute "CPU" 4
#hdb_log_set_attribute "Threads" 8
hdb_log_end_map
hdb_log_end_attribute

ht=1
column=true

cpuNum=(0,1,3)

#cpuNum=(3)

local i

for i in "${cpuNum[@]}"
do
	sudo chcpu -e "0-$i"
	if [[ $ht -eq 2 ]]; then
		sudo chcpu -e "4-$((i+4))"
	fi
	printf "Number of CPUs $i"

	## Run column benchmark
	printf "Adding Foreign Key Indices\n"
	hdb_run_file_lite ./sql/addFkIndizes.sql
	printf "Indices added\n"

	hdb_start_benchmark "benchmark_fk_""$i"_"$ht" $column "FK" "none"
	run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
	hdb_end_benchmark

	hdb_start_benchmark "benchmark_fk_noolap_""$i"_"$ht" $column "FK" "NO_USE_OLAP_PLAN"
	run_all_benchmarks_no_olap "/usr/sap/HXE/HDB90/work" $repetitions
	hdb_end_benchmark

	hdb_start_benchmark "benchmark_fk_olap_""$i"_"$ht" $column "FK" "USE_OLAP_PLAN"
	run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
	hdb_end_benchmark
done

sudo chcpu -d 1-7

printf "Adding More Indices (Fact Table)\n"
hdb_run_file_lite ./sql/addFaktenIndizes.sql
printf "Indices added\n"

for i in "${cpuNum[@]}"
do
	sudo chcpu -e "0-$i"
	sudo chcpu -e "4-$((i+4))"

	hdb_start_benchmark "benchmark_fk_""$i"_"$ht" $column "FT" "none"
	run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
	hdb_end_benchmark

	hdb_start_benchmark "benchmark_fk_noolap_""$i"_"$ht" $column "FT" "NO_USE_OLAP_PLAN"
	run_all_benchmarks_no_olap "/usr/sap/HXE/HDB90/work" $repetitions
	hdb_end_benchmark

	hdb_start_benchmark "benchmark_fk_olap_""$i"_"$ht" $column "FT" "USE_OLAP_PLAN"
	run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
	hdb_end_benchmark

done

sudo chcpu -d 1-7

printf "Adding Dimension Indices\n"
hdb_run_file_lite ./sql/addDimIndizes.sql
printf "Indices added\n"

for i in "${cpuNum[@]}"
do
	sudo chcpu -e "0-$i"
	sudo chcpu -e "4-$((i+4))"
	printf "Number of CPUs $i"

	hdb_start_benchmark "benchmark_fk_""$i"_"$ht" $column "Dimension" "none"
	run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
	hdb_end_benchmark

	hdb_start_benchmark "benchmark_fk_noolap_""$i"_"$ht" $column "Dimension" "NO_USE_OLAP_PLAN"
	run_all_benchmarks_no_olap "/usr/sap/HXE/HDB90/work" $repetitions
	hdb_end_benchmark

	hdb_start_benchmark "benchmark_fk_olap_""$i"_"$ht" $column "Dimension" "USE_OLAP_PLAN"
	run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
	hdb_end_benchmark

done

sudo chcpu -d 1-7
	
printf "Adding Dimension Indices (Restrictive)\n"
hdb_run_file_lite ./sql/addDimSmallIndizes.sql
printf "Indices added\n"

for i in "${cpuNum[@]}"
do
	sudo chcpu -e "0-$i"
	sudo chcpu -e "4-$((i+4))"
	printf "Number of CPUs $i"

	hdb_start_benchmark "benchmark_fk_""$i"_"$ht" $column "RestrDim" "none"
	run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
	hdb_end_benchmark

	hdb_start_benchmark "benchmark_fk_noolap_""$i"_"$ht" $column "RestrDim" "NO_USE_OLAP_PLAN"
	run_all_benchmarks_no_olap "/usr/sap/HXE/HDB90/work" $repetitions
	hdb_end_benchmark

	hdb_start_benchmark "benchmark_fk_olap_""$i"_"$ht" $column "RestrDim" "USE_OLAP_PLAN"
	run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
	hdb_end_benchmark

done

sudo chcpu -d 1-7
	
	
printf "Dimension Indices Only\n"
hdb_run_file_lite ./sql/killFaktenIndizes.sql
hdb_run_file_lite ./sql/killFkIndizes.sql
printf "Indices added\n"

sleep 60

for i in "${cpuNum[@]}"
do
	sudo chcpu -e "0-$i"
	if [[ $ht -eq 2 ]]; then
		sudo chcpu -e "4-$((i+4))"
	fi
	printf "Number of CPUs $i"

	hdb_start_benchmark "benchmark_fk_""$i"_"$ht" $column "DimOnly" "none"
	run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
	hdb_end_benchmark

	hdb_start_benchmark "benchmark_fk_noolap_""$i"_"$ht" $column "DimOnly" "NO_USE_OLAP_PLAN"
	run_all_benchmarks_no_olap "/usr/sap/HXE/HDB90/work" $repetitions
	hdb_end_benchmark

	hdb_start_benchmark "benchmark_fk_olap_""$i"_"$ht" $column "DimOnly" "USE_OLAP_PLAN"
	run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
	hdb_end_benchmark

done

sudo chcpu -e 1-7
	
printf "Remove Indices\n"
hdb_run_file_lite ./sql/killDimSmallIndizes.sql
hdb_run_file_lite ./sql/killDimIndizes.sql
printf "Indices removed\n"

## Original indices
#hdb_start_benchmark "$org_benchmark_no_index" false "none" "none"
#run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#hdb_start_benchmark "$org_benchmark_no_index_noolap" false "none" "NO_USE_OLAP_PLAN"
#run_all_benchmarks_no_olap "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#hdb_start_benchmark "$org_benchmark_no_index_olap" false "none" "USE_OLAP_PLAN"
#run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#printf "Adding Basic Indizes\n"
#hdb_run_file_lite ./sql/addBasicIndizes.sql
#printf "Indizes added\n"

#hdb_start_benchmark "$org_benchmark_index" false "basic" "none"
#run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#hdb_start_benchmark "$org_benchmark_index_noolap" false "basic" "NO_USE_OLAP_PLAN"
#run_all_benchmarks_no_olap "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#hdb_start_benchmark "$org_benchmark_index_olap" false "basic" "USE_OLAP_PLAN"
#run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#printf "Adding Advanced Indizes\n"
#hdb_run_file_lite ./sql/advancedIndizes.sql
#printf "Indizes added\n"

#hdb_start_benchmark "$org_benchmark_index_adv" false "advanced" "none"
#run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#hdb_start_benchmark "$org_benchmark_index_adv_noolap" false "advanced" "NO_USE_OLAP_PLAN"
#run_all_benchmarks_no_olap "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#hdb_start_benchmark "$org_benchmark_index_adv_olap" false "advanced" "USE_OLAP_PLAN"
#run_all_benchmarks_olap "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

#printf "Adding Further Indizes\n"
#hdb_run_file_lite ./sql/furtherIndizes.sql
#printf "Indizes added\n"

#hdb_start_benchmark "$org_benchmark_index_further"
#run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
#hdb_end_benchmark

hdb_finish_log
