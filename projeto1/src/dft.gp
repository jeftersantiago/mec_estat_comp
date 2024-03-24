set grid

reset
set terminal epslatex standalone size 10cm, 10cm
set output "output-dft-A.tex"
set xlabel "Frequência" #  $\\cdot 2 \\cdot \\pi$"
set ylabel "Amplitude/$100$"
set style line 1 lc rgb "blue"  lw 2
set grid

# set xrange[0:12.5]
set yrange[-4:4]
plot "tarefa-1/output-dft-A.dat" using 1:($2/100) w points pt 7 pointsize 1.2 t "cosseno",\
     "tarefa-1/output-dft-A.dat" using 1:($3/100) w points pt 5 pointsize 1.2 t "seno"
reset
set terminal epslatex standalone size 10cm, 10cm
set output "output-dft-B.tex"

set xlabel "Frequência" #  $\\cdot 2 \\cdot \\pi$"
set ylabel "Amplitude/$100$"


set style line 1 lc rgb "blue"  lw 2
set grid
# set xrange[0:12.5]
set yrange[-4:4]
plot "tarefa-1/output-dft-B.dat" using 1:($2/100) w points pt 7 pointsize 1.2 t "cosseno",\
     "tarefa-1/output-dft-B.dat" using 1:($3/100) w points pt 5 pointsize 1.2 t "seno"

reset
set terminal epslatex standalone size 10cm, 10cm
set output "output-dft-C.tex"

set xlabel "Frequência" #  $\\cdot 2 \\cdot \\pi$"
set ylabel "Amplitude/$100$"


set style line 1 lc rgb "blue"  lw 2
set grid

# set xrange[0:2*0.2*3.1415]
set yrange[-5:5]
plot "tarefa-1/output-dft-C.dat" using 1:($2/100) w points pt 7 pointsize 1.2 t "cosseno",\
     "tarefa-1/output-dft-C.dat" using 1:($3/100) w points pt 5 pointsize 1.2 t "seno"

set grid

reset
set terminal epslatex standalone size 10cm, 10cm
set output "output-dft-D.tex"

set xlabel "Frequência" #  $\\cdot 2 \\cdot \\pi$"
set ylabel "Amplitude/$100$"
set style line 1 lc rgb "blue"  lw 2
set grid
# set xrange[0:2*0.2*3.1415]
set yrange[-5:5]
plot "tarefa-1/output-dft-D.dat" using 1:($2/100) w points pt 7 pointsize 1.2 t "cosseno",\
     "tarefa-1/output-dft-D.dat" using 1:($3/100) w points pt 5 pointsize 1.2 t "seno"

reset
set terminal epslatex standalone size 10cm, 10cm
set output "output-dft-E.tex"

set xlabel "Frequência" #  $\\cdot 2 \\cdot \\pi$"
set ylabel "Amplitude/$100$"


set style line 1 lc rgb "blue"  lw 2

set multiplot
set origin 0, 0
set size 1, 1
set grid
# set xrange[0:13]
plot "tarefa-1/output-dft-E.dat" using 1:($2/100) w points pt 7 pointsize 1.2 t "cosseno",\
     "tarefa-1/output-dft-E.dat" using 1:($3/100) w points pt 5 pointsize 1.2 t "seno"
unset grid
set nokey

set origin 0.3, 0.12
set size 0.5, 0.45

set xrange[0:5]
set yrange[-1:2.5]

unset xlabel
unset ylabel

replot
unset multiplot
reset
set grid
set terminal epslatex standalone size 10cm, 10cm
set output "output-dft-F.tex"

set xlabel "Frequência" #  $\\cdot 2 \\cdot \\pi$"
set ylabel "Amplitude/$100$"

set style line 1 lc rgb "blue"  lw 2

set multiplot
set origin 0, 0
set size 1, 1
# set xrange[0:13]
plot "tarefa-1/output-dft-F.dat" using 1:($2/100) w points pt 7 pointsize 1.2 t "cosseno",\
     "tarefa-1/output-dft-F.dat" using 1:($3/100) w points pt 5 pointsize 1.2 t "seno"
set nokey
set origin 0.3, 0.12
set size 0.5, 0.45
set xrange[0:5]
set yrange[-1:2.5]
unset xlabel
unset ylabel
unset grid
replot
unset multiplot