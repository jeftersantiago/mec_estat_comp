reset
set terminal epslatex standalone size 10cm, 10cm
set output "benchmarking1.tex"

set ylabel "$t(N)$ (s)"
set xlabel "$N$"

set style line 1 lc rgb "blue"  lw 2
plot "tarefa-5/output-benchmarking.dat" using 1:2 w linespoint pt 7 pointsize 0.5 notitle

reset
set terminal epslatex standalone size 10cm, 10cm
set output "benchmarking2.tex"

set ylabel "$t(N)$ (s)"
set xlabel "$N$"

f(x) = a * x**2 + b*x + c

fit f(x) "tarefa-5/output-benchmarking.dat" using 1:2 via a, b, c

plot "tarefa-5/output-benchmarking.dat" using 1:2 w points pt 5 pointsize 2 notitle,\
     f(x) title "$O(N) = N^2 $"


