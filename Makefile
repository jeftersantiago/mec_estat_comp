# SRCS
file1 = tarefaX-etc

gera-file1:
	gfortran $(file1).f -o $(file1).exe
run-file1:
	./$(file1).exe


plot-%:
	gnuplot ./$*.gp
	pdflatex ./$*.tex
	evince ./$*.pdf & 
	@rm *-inc*eps* *.log *.tex *.aux

show-%:
	evince ./$*.pdf & 

clean:
	@rm *.exe *.dat 
