!       Tarefa B - Recozimento e quenching
        implicit real(j-j, m-m)
        parameter(L = 100)
        dimension exps(-4:4)
        byte lattice(1:L, 1:L)

        ! periodic boundary conditions
        dimension ipbc(0:L+1)
    
        L_real = 90

        do i = 1, L_real
            ipbc(i) = i
        end do  
        ipbc(0) = L_real
        ipbc(L_real+1) = 1

        N = L_real * L_real

        mag = 0.0d0
        
        call srand(351324)
        
        call initialize_random_lattice(lattice,  L_real)
        
        open(1, file="saida-configuracao-inicial-b1.dat")
        call write_lattice(lattice, L_real, 1) 

        call total_magnetization(lattice, mag, L_real)
         
        ! initial energy
        E = H_0(lattice, ipbc, L_real)

        open(3, file="saida-magnetizacao-energia-b1.dat")

        dbeta = 0.001
        ! monte carlo dynamics
        do i = 1, 3000
            beta = i * dbeta
            call define_exponentials(exps, beta)
            do k = 1 , N
                  call flip_spin(lattice,ipbc,exps,E,mag,L_real)
            end do   
            write(3, *) i, mag, E/N
        end do

        open(2, file="saida-configuracao-final-b1.dat")
        call write_lattice(lattice, L_real, 2) 

        close(1)
        close(2)
        close(3)
        end