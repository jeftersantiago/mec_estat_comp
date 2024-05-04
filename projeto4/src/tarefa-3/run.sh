#!/bin/bash
exe="./tarefa-3.exe"
output_dir="../saidas/tarefa-3/"
seed_values=(51 255 729)
for seed in "${seed_values[@]}"; do
    echo "Running for R = $R"
    echo "$seed" | $exe
    mv "saida-dla.dat" "$output_dir/DLA_3D-$seed.dat"
    mv "saida-contagem.dat" "$output_dir/DLA_3D-$seed-dimensao.dat"
done
