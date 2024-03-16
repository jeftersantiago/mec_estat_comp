set terminal epslatex standalone size 20cm, 20cm
set output "signal1.tex"
reset
set title ""
set xlabel "Tempo (s)"
set ylabel "Signal"
set grid

set linestyle 1 lt 3 lw 3 lc rgb "gray"

# set multiplot layout 1,2 \
# 
set size square
set xrange[0:2.5*pi]


plot "output-signal1.dat" w linespoints ls 1 t "$a_1 = 2, a_2 = 4\\ \\omega_1 = 4\\pi(Hz), \\omega_2=2.5\\pi(Hz)$"
# plot "output-signal2.dat" w l ls 1 notitle,\
#       "output-signal2.dat" w p pt 7 pointsize 1 notitle
# 
# unset multiplot 

reset

set terminal epslatex standalone size 10cm, 10cm
set output "signal2.tex"
set title ""
set xlabel "Tempo (s)"
set ylabel "Signal"
set grid

set multiplot layout 1,2 \

plot "output-signal3.dat" w l ls 1 notitle ,\
     "output-signal3.dat" w p pt 7 pointsize 2 notitle
plot "output-signal4.dat" w l ls 1 notitle,\
     "output-signal4.dat" w p pt 7 pointsize 2 notitle

unset multiplot

reset

set terminal epslatex standalone size 10cm, 10cm
set output "signal3.tex"
set title ""
set xlabel "Tempo (s)"
set ylabel "Signal"
set grid

set multiplot layout 1,2 \

plot "output-signal5.dat" w l ls 1 notitle ,\
     "output-signal5.dat" w p pt 7 pointsize 2 notitle
plot "output-signal6.dat" w l ls 1 notitle,\
     "output-signal6.dat" w p pt 7 pointsize 2 notitle

unset multiplot
