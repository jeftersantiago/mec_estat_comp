        implicit integer(f-f)
        implicit real(m-m)
        parameter(L = 100)

        dimension exps(-4:4)
        byte lattice(1:L, 1:L)
        ! periodic boundary conditions
        dimension ipbc(0:L+1)
        ! this or using mod
        open(unit=1, file="saidas/tarefa-4/saida-tarefa-D.dat")
        beta = 0.5
        call define_exponentials(exps, beta)
        
        do L_real = 4, 10
            print *, "L = ", L_real 
            
            call srand(3519) ! /L_real+1)
            
            N = L_real * L_real
            ! setting ipbc
            do i = 1, L_real
                ipbc(i) = i
            end do  
            ipbc(0) = L_real
            ipbc(L_real+1) = 1
            
            mag = 0.0e0
            call initialize_random_lattice(lattice, L_real, L_real)
            call total_magnetization(lattice, mag, L_real)

            n_inversions = 1000
            n_curr = 0
            n_time = 0
            do while(n_curr < n_inversions) 
                
                mag_prev = mag
                do i = 1, N
                    call flip_spin(lattice, ipbc, exps, E, mag, L_real)
                end do
                n_time = n_time + 1
                ! Fazer o gráfico da magnetização aqui.
                if(mag_prev * mag < 0) then 
                    t_mean = t_mean + n_time
                    n_time = 0
                    n_curr = n_curr + 1
                end if
            end do
            t_mean = t_mean / n_inversions
            write(1, *) L_real, t_mean
        end do
        close(1)
        end