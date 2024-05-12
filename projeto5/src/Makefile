tarefa1:
	gfortran tarefa-1/tarefa-1.f tarefa-1/ising.f -o tarefa-1/tarefa-1.exe
run-tarefa1:
	./tarefa-1/tarefa-1.exe

compile:
	gnuplot *.gp
	for i in *.tex; do\
		pdflatex $$i ;\
	done
	@rm  *.log *.aux *.tex *.aux *-inc*eps*
clean:
	@rm *-inc*eps* *.log *.tex *.aux *eps
	@rm *dat
