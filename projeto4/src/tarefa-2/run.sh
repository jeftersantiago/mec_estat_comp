#!/bin/bash
exe="./tarefa-2.exe"
output_dir="../saidas/tarefa-2/"
seed_values=(169 255 954)
for seed in "${seed_values[@]}"; do
    echo "Running for R = $R"
    echo "$seed" | $exe
    mv "saida-dla.dat" "$output_dir/DLA_2D-$seed.dat"
    mv "saida-contagem.dat" "$output_dir/DLA_2D-$seed-dimensao.dat"
done
