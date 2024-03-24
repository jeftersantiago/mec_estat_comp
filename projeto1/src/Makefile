runall:
	gfortran tarefa-2/tarefa2.f -o tarefa-2/tarefa2.exe
	./tarefa-2/tarefa2.exe
	mv *dat tarefa-2/
	gfortran dft.f -o dft.exe
	./dft.exe

compile:

	gnuplot *.gp
	for i in *.tex; do\
		pdflatex $$i ;\
	done

	@rm  *.log *.aux *.tex *.aux *-inc*eps*

plot-%:
	gnuplot *.gp
	pdflatex *.tex
	evince ./$*.pdf & 
	@rm *-inc*eps* *.log *.tex *.aux

clean:
	@cd graficos;
	@rm *-inc*eps* *.log *.tex *.aux *eps
