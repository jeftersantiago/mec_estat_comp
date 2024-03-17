generate_signal = tarefa1
dft = tarefa23
idft = tarefa4
bench = tarefa5


runall:
	gfortran tarefa1.f -o tarefa1.exe
	gfortran dft.f -o dft.exe
	./tarefa1.exe
	./dft.exe
#	cp *.pdf ../relatorio/graficos/

signal:
	gfortran $(generate_signal).f -o $(generate_signal).exe
run-signal:
	./$(generate_signal).exe

dft:
	gfortran $(dft).f -o $(dft).exe
run-dft:
	./$(dft).exe

idft:
	gfortran $(idft).f -o $(idft).exe
run-idft:
	./$(idft).exe

bench:
	gfortran $(bench).f -o $(bench).exe
run-bench:
	./$(bench).exe

# compile-%: 
# 	gfortran $*.f -o ./$*.exe

compile:
	gnuplot ./*.gp
	pdflatex ./*.tex

	for i in *.tex; do\
		pdflatex $$i ;\
	done
	@rm *-inc*eps* *.log *.tex *.aux

plot-%:
	gnuplot ./*.gp
	pdflatex ./*.tex
	evince ./$*.pdf & 
	@rm *-inc*eps* *.log *.tex *.aux

clean:
	@rm *.exe *.dat
	@rm *-inc*eps* *.log *.tex *.aux *eps
