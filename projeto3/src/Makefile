sim = simulation
sim:
	gfortran simulation.f wave.f dft.f -o simulation.exe
run:
	./$(sim).exe


compile:
	gnuplot *.gp
	for i in *.tex; do\
		pdflatex $$i ;\
	done
	@rm  *.log *.aux *.tex *.aux *-inc*eps*
clean:
	@rm *-inc*eps* *.log *.tex *.aux *eps
	@rm *dat
