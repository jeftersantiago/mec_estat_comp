        implicit integer (p-p)
        parameter(L = 60)
        dimension exps(-4:4)

    !   PRESTAR ATENÇÃO A ISSO AQUI - PODE TA TUDO ERRADO
        byte lattice(1:L, 1:L)

        ! periodic boundary conditions
        dimension pbc(0:L+1)
        ! this or using mod
        do i = 1, N
            pbc(i) = i
        end do  
        pbc(0) = L
        pbc(L+1) = 1

        beta = 3

        call define_exponentials(exps, beta)
        L_real = L
        ! computes total energy and magnetization
        m = 0
        E = total_hamiltonian(lattice, pbc, m, L_real)

        call initialize_lattice(lattice, 1, L_real)

        open(unit = 1, file="magnetizacao-temperatura.dat")
        open(unit = 2, file=".dat")

        ! monte carlo dynamics
        do N = 1, 1000

            


        end do  
        end

        subroutine write_lattice(lattice, L_real)
            implicit integer (f-f)
            parameter(L = 100)
            byte lattice(1:L, 1:L)
            character *1 symb(-1:1)
            symb(1) = '+'
            symb(-1) = '-'
        
            do i = 1, L_real
                write(f_name, '(100A2)') (symb(lattice(i,j)), j = 1, L_real)
                
            end do  

        end subroutine write_lattice
        











