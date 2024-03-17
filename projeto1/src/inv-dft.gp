reset
set terminal epslatex standalone size 10cm, 10cm
set output "inv-dft-A.tex"
set title ""
set xlabel "Tempo (s)"
set ylabel "Sinal"

unset grid

set linestyle 1 lt 2 lw 2 dashtype 3 lc rgb "black"
set linestyle 2 lt 3 lw 1 lc rgb "red"

# set multiplot layout 1,2 \


plot "output-signal-A.dat" w l ls 1 t "Sinal original",\
     "output-inv-dft-A.dat" w l ls 2 t "Transformada inversa"
     


reset
set terminal epslatex standalone size 10cm, 10cm
set output "inv-dft-B.tex"
set xlabel "Tempo (s)"
set ylabel "Sinal"
unset grid

set linestyle 1 lt 2 lw 2 dashtype 3 lc rgb "black"
set linestyle 2 lt 3 lw 1 lc rgb "red"

# set multiplot layout 1,2 \


plot "output-signal-B.dat" w l ls 1 t "Sinal original",\
     "output-inv-dft-B.dat" w l ls 2 t "Transformada inversa"

reset
set terminal epslatex standalone size 10cm, 10cm
set output "inv-dft-C.tex"
set xlabel "Tempo (s)"
set ylabel "Sinal"
unset grid

set linestyle 1 lt 2 lw 2 dashtype 3 lc rgb "black"
set linestyle 2 lt 3 lw 1 lc rgb "red"

# set multiplot layout 1,2 \


plot "output-signal-C.dat" w l ls 1 t "Sinal original",\
     "output-inv-dft-C.dat" w l ls 2 t "Transformada inversa"


reset
set terminal epslatex standalone size 10cm, 10cm
set output "inv-dft-D.tex"
set xlabel "Tempo (s)"
set ylabel "Sinal"
unset grid

set linestyle 1 lt 2 lw 2 dashtype 3 lc rgb "black"
set linestyle 2 lt 3 lw 1 lc rgb "red"

plot "output-signal-D.dat" w l ls 1 t "Sinal original",\
     "output-inv-dft-D.dat" w l ls 2 t "Transformada inversa"

reset
set terminal epslatex standalone size 10cm, 10cm
set output "inv-dft-E.tex"
set xlabel "Tempo (s)"
set ylabel "Sinal"
unset grid

set linestyle 1 lt 2 lw 2 dashtype 3 lc rgb "black"
set linestyle 2 lt 3 lw 1 lc rgb "red"

plot "output-signal-E.dat" w l ls 1 t "Sinal original",\
     "output-inv-dft-E.dat" w l ls 2 t "Transformada inversa"

reset
set terminal epslatex standalone size 10cm, 10cm
set output "inv-dft-F.tex"
set xlabel "Tempo (s)"
set ylabel "Sinal"
unset grid

set linestyle 1 lt 2 lw 2 dashtype 3 lc rgb "black"
set linestyle 2 lt 3 lw 1 lc rgb "red"

# set multiplot layout 1,2 \


plot "output-signal-F.dat" w l ls 1 t "Sinal original",\
     "output-inv-dft-F.dat" w l ls 2 t "Transformada inversa"