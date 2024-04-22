#!/bin/bash

# Set the path to your Fortran executable
exe="./all-rules.exe"
# Set the directory for renamed files
output_dir="../saidas/tarefa-1/all-the-rules/"

# Loop through R values from 0 to 255
for (( R=0; R<=255; R++ )); do
    echo "Running for R = $R"
    
    # Run the Fortran program, passing the value of R via stdin
    echo "$R" | $exe
    
    # Rename the output files
    mv "output-1.dat" "$output_dir/rule-$R-2.dat"
    mv "output-2.dat" "$output_dir/rule-$R-centered.dat"
    mv "output-3.dat" "$output_dir/rule-$R-last.dat"

done
