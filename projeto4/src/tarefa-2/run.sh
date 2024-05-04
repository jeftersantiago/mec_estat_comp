#!/bin/bash
exe="./tarefa-4.exe"
output_dir="../saidas/tarefa-4/"
seed_values=(229 337 957)
for seed in "${seed_values[@]}"; do
    echo "Running for R = $R"
    echo "$seed" | $exe
    mv "saida-dla.dat" "$output_dir/efeito-corona-$seed.dat"
done
