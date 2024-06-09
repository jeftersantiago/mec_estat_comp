        open(1, file="saidas/tarefa-3/saida-tarefa-C1-L60-DB1.dat")
        open(2, file="saidas/tarefa-3/saida-tarefa-C1-L60-DB2.dat")

        open(3, file="saidas/tarefa-3/saida-tarefa-C1-L80-DB1.dat")
        open(4, file="saidas/tarefa-3/saida-tarefa-C1-L80-DB2.dat")
        
        open(5, file="saidas/tarefa-3/saida-tarefa-C1-L100-DB1.dat")
        open(6, file="saidas/tarefa-3/saida-tarefa-C1-L100-DB2.dat")
        

        call tarefaC1(60, 0.001, 1)
        call tarefaC1(60, 0.0001,  2)

        call tarefaC1(80, 0.001, 3)
        call tarefaC1(80, 0.0001, 4)

        call tarefaC1(100,0.001, 5)
        call tarefaC1(100,0.0001, 6)
        
        do i = 1, 6
            close(i)
        end do
        end

        subroutine tarefaC1(L_real, dbeta, f_name)
            implicit integer(f-f)
!           Tarefa B - Recozimento e quenching
            implicit real(j-j, m-m)
            parameter(L = 100)
            dimension exps(-4:4)
            byte lattice(1:L, 1:L)

            ! periodic boundary conditions
            dimension ipbc(0:L+1)
            
            do i = 1, L_real
                ipbc(i) = i
            end do  

            ipbc(0) = L_real
            ipbc(L_real+1) = 1

            N = L_real * L_real

            mag = 0.0d0

            call srand(96312)
            ! b = 0
            call initialize_random_lattice(lattice,  L_real, L_real)

            call total_magnetization(lattice, mag, L_real)

            ! initial energy
            E = H_0(lattice, ipbc, L_real)

            beta = 0.0

            write(f_name, *) 0, beta,  mag, E/N

            imax = int(1.75 / dbeta) + 1 

            do i = 1, imax

                call define_exponentials(exps, beta)

                if(i < imax/ 2) then 
                    beta = beta + dbeta 
                else
                    beta = beta - dbeta 
                end if  

                do k = 1 , N
                    call flip_spin(lattice,ipbc,exps,E,mag,L_real)
                end do   

                write(f_name, *) i, beta, mag, E/N
            
            end do
        end subroutine tarefaC1