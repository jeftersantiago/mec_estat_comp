!       Tarefa B - Recozimento
        implicit real(j-j)
        parameter(L = 100)
        dimension exps(-4:4)
        byte lattice(1:L, 1:L)

        ! periodic boundary conditions
        dimension ipbc(0:L+1)
        ! this or using mod
      
        L_real = 60
        
        do i = 1, L_real
            ipbc(i) = i
        end do  
        ipbc(0) = L_real
        ipbc(L_real+1) = 1


        N = L_real * L_real

        m = 0
        
        call srand(iseed)
        call initialize_random_lattice(lattice, m, L_real)
         
        ! initial energy
        E_0 = H_0(lattice, ipbc, m, L_real)

        open(1, file="saida-configuracao.dat")
        open(2, file="saida-magnetizacao-energia.dat")

        beta = 0
        dbeta = 1.0e-3
        
        ! monte carlo dynamics
        do i = 1, 3000
            call define_exponentials(exps, beta)
            do k = 1 , N
                  call flip_spin(lattice,ipbc,exps,E,m,L_real)
            end do   
            beta = beta + dbeta
            write(2, *) i, beta, m/N, E/N
        end do
        call write_lattice(lattice, L_real, 1) 
        close(1)
        close(2)
        end