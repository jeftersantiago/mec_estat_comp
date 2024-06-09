anim:
	gfortran animate/beta_evolution.f ising_modules.f -o animate/beta_evolution.exe
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
	gfortran tarefa-3/tarefa-3-c2.f ising_modules.f -o tarefa-3/tarefa-3-c2.exe
	gfortran tarefa-3/tarefa-3-c2-extra.f ising_modules.f -o tarefa-3/tarefa-3-c2-extra.exe
run-t3c1:
	./tarefa-3/tarefa-3-c1.exe
run-t3c2:
	./tarefa-3/tarefa-3-c2.exe
run-t3c2ext:
	./tarefa-3/tarefa-3-c2-extra.exe

tarefa4:
	gfortran tarefa-4/tarefa-4.f ising_modules.f -o tarefa-4/tarefa-4.exe
run-tarefa4:
	./tarefa-4/tarefa-4.exe
	

t4ext:
	gfortran tarefa-4/tarefa-4-extra.f ising_modules.f -o tarefa-4/tarefa-4-extra.exe
run-t4ext:
	./tarefa-4/tarefa-4-extra.exe

GREEN=\033[0;32m
RED=\033[0;31m
BLUE=\033[0;34m
END=\033[0m

make pj5:
	@echo -e  "${GREEN}Projeto 5 - Simulacoes de Monte Carlo ${END}"
	gfortran tarefa-1/tarefa-1.f ising_modules.f -o tarefa-1/tarefa-1.exe
	gfortran tarefa-2/tarefa-2-b1.f ising_modules.f -o tarefa-2/tarefa-2-b1.exe
	gfortran tarefa-2/tarefa-2-b2.f ising_modules.f -o tarefa-2/tarefa-2-b2.exe
	gfortran tarefa-3/tarefa-3-c1.f ising_modules.f -o tarefa-3/tarefa-3-c1.exe
	gfortran tarefa-3/tarefa-3-c2.f ising_modules.f -o tarefa-3/tarefa-3-c2.exe
	gfortran tarefa-4/tarefa-4.f ising_modules.f -o tarefa-4/tarefa-4.exe
	gfortran tarefa-4/tarefa-4-extra.f ising_modules.f -o tarefa-4/tarefa-4-extra.exe


runall:
	@echo -e "${GREEN} Executando tarefa A ${END}"
	./tarefa-1/tarefa-1.exe
	@echo -e "${GREEN} Executando tarefa B ${END}"
	./tarefa-2/tarefa-2-b1.exe
	./tarefa-2/tarefa-2-b2.exe
	@echo -e "${GREEN} Executando tarefa C ${END}"
	./tarefa-3/tarefa-3-c1.exe
	./tarefa-3/tarefa-3-c2.exe
	@echo -e "${GREEN} Executando tarefa D ${END}"
	./tarefa-4/tarefa-4.exe
	@echo -e "${GREEN} Executando tarefa D - Extra ${END}"
	./tarefa-4/tarefa-4-extra.exe

clean:
	@rm *-inc*eps* *.log *.tex *.aux *eps
	@rm *dat
