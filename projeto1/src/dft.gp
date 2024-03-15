set terminal epslatex standalone size 10cm, 10cm
set output "dft.tex"
reset
set title ""
set xlabel "Frequência" #  $\\cdot 2 \\cdot \\pi$"
set ylabel "Amplitude"
unset grid

set style line 1 lc rgb "blue"  lw 2
# set linetype 10
# set style line 2 lc rgb "yellow" lw 3 pointsize 8.5 pointtype 7
# set style line 3 lc rgb "blue" lw 3 pointsize 2.5 pointtype 7
# set multiplot layout 2, 1 \

# set yrange[-50:500]
# set xrange[0.0:12.0]

plot "output-dft.dat" using 1:2 w l pt 7 pointsize 0.5 t "cosseno",\
     "output-dft.dat" using 1:3 w l pt 5 pointsize 0.5 t "seno"
# unset multiplot