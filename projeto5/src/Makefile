tarefa1:
	gfortran tarefa-1/tarefa-1.f ising_modules.f -o tarefa-1/tarefa-1.exe
run-tarefa1:
	./tarefa-1/tarefa-1.exe

tarefa2:
	gfortran tarefa-2/tarefa-2-b1.f ising_modules.f -o tarefa-2/tarefa-2-b1.exe
	gfortran tarefa-2/tarefa-2-b2.f ising_modules.f -o tarefa-2/tarefa-2-b2.exe

run-t2b1:
	./tarefa-2/tarefa-2-b1.exe
run-t2b2:
	./tarefa-2/tarefa-2-b2.exe

tarefa3:
	gfortran tarefa-3/tarefa-3-c1.f ising_modules.f -o tarefa-3/tarefa-3-c1.exe

run-t3c1:
	./tarefa-3/tarefa-3-c1.exe

compile:
	gnuplot *.gp
	for i in *.tex; do\
		pdflatex $$i ;\
	done
	@rm  *.log *.aux *.tex *.aux *-inc*eps*
clean:
	@rm *-inc*eps* *.log *.tex *.aux *eps
	@rm *dat
