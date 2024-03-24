reset
set terminal epslatex standalone size 10cm, 10cm
set output "signal-A.tex"

set xlabel "Tempo (s)"
set ylabel "Amplitude"

set linestyle 1 lt 3 lw 3 lc rgb "#b5b823"
plot "tarefa-2/output-signal-A.dat" w lines ls 1 pt 7 notitle # "$a_1 = 2, a_2 = 4\\ \\omega_1 = 4\\pi(Hz), \\omega_2=2.5\\pi(Hz)$"

reset
set terminal epslatex standalone size 10cm, 10cm
set output "signal-B.tex"

set xlabel "Tempo (s)"
set ylabel "Amplitude"

set linestyle 1 lt 3 lw 3 lc rgb "#b5b823"

plot "tarefa-2/output-signal-B.dat" w lines ls 1 pt 7 notitle # "$a_1 = 3, a_2 = 2, \\omega_1 = 4\\pi(Hz), \\omega_2 = 2.5\\pi (Hz)$"


reset
set terminal epslatex standalone size 10cm, 10cm
set output "signal-C.tex"

set title ""
set xlabel "Tempo (s)"
set ylabel "Amplitude"


set linestyle 1 lt 3 lw 3 lc rgb "#3ab541"

plot "tarefa-2/output-signal-C.dat" w lines ls 1 pt 7 notitle #  "$a_1 = 2, a_2 = 4, \omega_1 = 4\pi(Hz), \omega_2 = 0.2\pi (Hz)$"
reset
set terminal epslatex standalone size 10cm, 10cm
set output "signal-D.tex"

set title ""
set xlabel "Tempo (s)"
set ylabel "Amplitude"


set linestyle 1 lt 3 lw 3 lc rgb "#3ab541"
plot "tarefa-2/output-signal-D.dat" w lines ls 1 pt 7  notitle #  "$a_1 = 3, a_2 = 2, \omega_1 = 4\pi(Hz), \omega_2 = 0.2\pi (Hz)$"

reset
set terminal epslatex standalone size 10cm, 10cm
set output "signal-E.tex"
set xlabel "Tempo (s)"
set ylabel "Amplitude"

set linestyle 1 lt 3 lw 3 lc rgb "#3171c4"
plot "tarefa-2/output-signal-E.dat" w lines ls 1  pt 7 notitle # "$a_1 = 2, a_2 = 4, \\omega_1 = 4\\pi(Hz), \\omega_2 = 1.4\\pi (Hz)$"

reset
set terminal epslatex standalone size 10cm, 10cm
set output "signal-F.tex"
set xlabel "Tempo (s)"
set ylabel "Amplitude"

set linestyle 1 lt 3 lw 3 lc rgb "#3171c4"
plot "tarefa-2/output-signal-F.dat" w lines ls 1  pt 7 notitle # t "$a_1 = 2, a_2 = 4, \\omega_1 = 4.2\\pi(Hz), \\omega_2 = 1;4\\pi (Hz)$"
