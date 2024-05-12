        implicit real(j-j)
        parameter(L = 100)
        dimension exps(-4:4)
        byte lattice(1:L, 1:L)

        ! periodic boundary conditions
        dimension ipbc(0:L+1)
        ! this or using mod
      
        L_real = 100
        
        do i = 1, L_real
            ipbc(i) = i
        end do  
        ipbc(0) = L_real
        ipbc(L_real+1) = 1

        beta = 3

        call define_exponentials(exps, beta)

        m = 0
        call initialize_lattice(lattice, m, L_real)
        
        call write_lattice(lattice, L_real, 1)

         ! initial energy
        E_0 = H_0(lattice, ipbc, m, L_real)

        open(1, file="saida-configuracao.dat")
        rnd = rand(iseed)
         ! intialize monte carlo dynamics
        do MC_step = 1, 1000
            write(2, *) m, E
            ! sweeps all configurations
            ! randomly flips spins
            do i = 1 , L_real * L_real
               call flip_spin(lattice,ipbc,exps,E,m,L_real)
            end do   
        end do  
        call write_lattice(lattice, L_real, 1) 
        close(1)
        end