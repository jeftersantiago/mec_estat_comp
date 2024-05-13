tarefa1:
	gfortran tarefa-1/tarefa-1.f ising_modules.f -o tarefa-1/tarefa-1.exe
run-tarefa1:
	./tarefa-1/tarefa-1.exe

tarefa2:
	gfortran tarefa-2/tarefa-2.f ising_modules.f -o tarefa-2/tarefa-2.exe
run-tarefa2:
	./tarefa-2/tarefa-2.exe

compile:
	gnuplot *.gp
	for i in *.tex; do\
		pdflatex $$i ;\
	done
	@rm  *.log *.aux *.tex *.aux *-inc*eps*
clean:
	@rm *-inc*eps* *.log *.tex *.aux *eps
	@rm *dat
