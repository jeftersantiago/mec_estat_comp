unset grid

reset
set terminal epslatex standalone size 10cm, 10cm
set output "output-dft-A.tex"

set xlabel "Frequência" #  $\\cdot 2 \\cdot \\pi$"
set ylabel "Amplitude"


set style line 1 lc rgb "blue"  lw 2
# set linetype 10
# set style line 2 lc rgb "yellow" lw 3 pointsize 8.5 pointtype 7
# set style line 3 lc rgb "blue" lw 3 pointsize 2.5 pointtype 7
# set multiplot layout 2, 1 \

plot "output-dft-A.dat" using 1:2 w linespoint pt 7 pointsize 0.5 t "cosseno",\
     "output-dft-A.dat" using 1:3 w linespoint pt 5 pointsize 0.5 t "seno"



unset grid

reset
set terminal epslatex standalone size 10cm, 10cm
set output "output-dft-B.tex"

set xlabel "Frequência" #  $\\cdot 2 \\cdot \\pi$"
set ylabel "Amplitude"


set style line 1 lc rgb "blue"  lw 2
# set linetype 10
# set style line 2 lc rgb "yellow" lw 3 pointsize 8.5 pointtype 7
# set style line 3 lc rgb "blue" lw 3 pointsize 2.5 pointtype 7
# set multiplot layout 2, 1 \

plot "output-dft-B.dat" using 1:2 w linespoint pt 7 pointsize 0.5 t "cosseno",\
     "output-dft-B.dat" using 1:3 w linespoint pt 5 pointsize 0.5 t "seno"



unset grid

reset
set terminal epslatex standalone size 10cm, 10cm
set output "output-dft-C.tex"

set xlabel "Frequência" #  $\\cdot 2 \\cdot \\pi$"
set ylabel "Amplitude"


set style line 1 lc rgb "blue"  lw 2
# set linetype 10
# set style line 2 lc rgb "yellow" lw 3 pointsize 8.5 pointtype 7
# set style line 3 lc rgb "blue" lw 3 pointsize 2.5 pointtype 7
# set multiplot layout 2, 1 \

plot "output-dft-C.dat" using 1:2 w linespoint pt 7 pointsize 0.5 t "cosseno",\
     "output-dft-C.dat" using 1:3 w linespoint pt 5 pointsize 0.5 t "seno"



unset grid

reset
set terminal epslatex standalone size 10cm, 10cm
set output "output-dft-D.tex"

set xlabel "Frequência" #  $\\cdot 2 \\cdot \\pi$"
set ylabel "Amplitude"


set style line 1 lc rgb "blue"  lw 2
# set linetype 10
# set style line 2 lc rgb "yellow" lw 3 pointsize 8.5 pointtype 7
# set style line 3 lc rgb "blue" lw 3 pointsize 2.5 pointtype 7
# set multiplot layout 2, 1 \

plot "output-dft-D.dat" using 1:2 w linespoint pt 7 pointsize 0.5 t "cosseno",\
     "output-dft-D.dat" using 1:3 w linespoint pt 5 pointsize 0.5 t "seno"



unset grid

reset
set terminal epslatex standalone size 10cm, 10cm
set output "output-dft-E.tex"

set xlabel "Frequência" #  $\\cdot 2 \\cdot \\pi$"
set ylabel "Amplitude"


set style line 1 lc rgb "blue"  lw 2

set multiplot
set origin 0, 0
set size 1, 1
plot "output-dft-E.dat" using 1:2 w linespoint pt 7 pointsize 0.5 t "cosseno",\
     "output-dft-E.dat" using 1:3 w linespoint pt 5 pointsize 0.5 t "seno"

set nokey

set origin 0.3, 0.12
set size 0.5, 0.45

set xrange[0:0.5]
set yrange[-100:200]

unset xlabel
unset ylabel

replot

unset multiplot



unset grid

reset
set terminal epslatex standalone size 10cm, 10cm
set output "output-dft-F.tex"

set xlabel "Frequência" #  $\\cdot 2 \\cdot \\pi$"
set ylabel "Amplitude"


set style line 1 lc rgb "blue"  lw 2
# set linetype 10
# set style line 2 lc rgb "yellow" lw 3 pointsize 8.5 pointtype 7
# set style line 3 lc rgb "blue" lw 3 pointsize 2.5 pointtype 7
# set multiplot layout 2, 1 \

plot "output-dft-F.dat" using 1:2 w linespoint pt 7 pointsize 0.5 t "cosseno",\
     "output-dft-F.dat" using 1:3 w linespoint pt 5 pointsize 0.5 t "seno"
