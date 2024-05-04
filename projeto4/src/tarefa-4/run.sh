#!/bin/bash
exe="./tarefa-4.exe"
output_dir="../saidas/tarefa-4/"
seed_values=(5429 2837 19238)
for seed in "${seed_values[@]}"; do
    echo "Running for R = $R"
    echo "$seed" | $exe
    mv "saida-dla.dat" "$output_dir/efeito-corona-$seed.dat"
done
