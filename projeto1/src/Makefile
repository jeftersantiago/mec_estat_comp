generate_signal = generate-signal
dft = dft
bench = benchmarking

signal:
	gfortran $(generate_signal).f -o $(generate_signal).exe
run-signal:
	./$(generate_signal).exe

dft:
	gfortran $(dft).f -o $(dft).exe
run-dft:
	./$(dft).exe

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
	@rm *.exe *.dat  *.fort
	@rm *-inc*eps* *.log *.tex *.aux *eps
