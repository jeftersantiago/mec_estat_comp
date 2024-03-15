set terminal epslatex standalone size 10cm, 10cm
set output "inv-dft.tex"
reset
set title ""
set xlabel "Tempo (s)"
set ylabel "Sinal"
unset grid

set linestyle 1 lt 2 lw 2 dashtype 3 lc rgb "black"
set linestyle 2 lt 3 lw 1 lc rgb "red"

# set multiplot layout 1,2 \

plot "output-signal1.dat" w l ls 1 t "Sinal original",\
     "output-inv-dft.dat" w l ls 2 t "Transformada inversa",\
     

