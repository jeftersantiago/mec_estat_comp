!       Tarefa B - Recozimento
        implicit real(j-j, m-m)
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

        m = 0.0d0
        
        call srand(iseed)

        call initialize_random_lattice(lattice,  L_real)

        call total_magnetization(lattice, m, L_real)

        print *, "<m> = ", m/N     
    !    call initialize_lattice(lattice, m, L_real)
    !    print *, "<m> = ", m
         
        ! initial energy
        E = H_0(lattice, ipbc, L_real)

        open(1, file="saida-configuracao.dat")
        open(2, file="saida-magnetizacao.dat")
        open(3, file="saida-energia.dat")

        print *, "E/N = ", E/N

        beta = 0
        dbeta = 0.001
        
        write(2, *) 0, m/N
        write(3, *) 0, E/N

        beta = 3.0d0
        call define_exponentials(exps, beta)

        ! monte carlo dynamics
        do i = 1, 3000

        !    prev_m = m/N
            do k = 1 , N
                  call flip_spin(lattice,ipbc,exps,E,m,L_real)
            end do   

 !           print *, "<m> = ", (1.0d0 * m)/N
            write(2, *) i, m/N
            write(3, *) i, E/N

            ! reached equilibrium
        !    if(abs(m/N - prev_m) == 0) then 
        !        exit
        !    end if

        end do
        call write_lattice(lattice, L_real, 1) 
        close(1)
        close(2)
        close(3)
        end