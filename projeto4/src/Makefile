tarefa1:
	gfortran tarefa-1/tarefa-1.f tarefa-1/cellular-automaton.f -o tarefa-1/tarefa-1.exe
run-tarefa1:
	./tarefa-1/tarefa-1.exe
all-rules:
	gfortran tarefa-1/all-rules.f tarefa-1/cellular-automaton.f -o tarefa-1/all-rules.exe
run-all-rules:
	./tarefa-1/all-rules.exe

tarefa2:
	gfortran tarefa-2/tarefa-2.f tarefa-2/DLA_2D.f -o tarefa-2/tarefa-2.exe
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
