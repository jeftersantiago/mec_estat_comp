        subroutine define_exponentials(exps, beta)
            dimension exps(-4:4)
            do i = -4,4
                exps(i) = exp(-beta*i * 1.0)! /(exp(-beta*i)+exp(-beta*i)) 
            end do  

        end subroutine define_exponentials

        subroutine flip_spin(lattice, ipbc, exps, E,  m, L_real)
            implicit integer(p-p, s-s, d-d)
            ! implicit real(J-J)
            parameter(L = 100)
            parameter(J = 1.0)
            dimension exps(-4:4)
            byte lattice(1:L, 1:L)
            dimension ipbc(0:L+1)

            ! choose a random site
            i = floor(rand()* L_real) + 1
            k = floor(rand()* L_real) + 1

            ! ∆M̃ = J[s(i − 1, j + s(i + 1, j) + s(i, j − 1) + s(i, j + 1)].
            dM = lattice(ipbc(i-1), k) + lattice(ipbc(i+1), k)
            dM = dM + lattice(i, ipbc(k-1)) + lattice(i,ipbc(k+1))
            dM = J * dM

            ! spin(i, j) and dM are positions of the lattice, so
            s = lattice(i, k)
            e_flip = exps(s*dM)/(exps(-s*dM)+exps(s*dM))

            if(rand() < e_flip) then 
                lattice(i, k) = -lattice(i, k)
                ! Magnetization
                m = m - 2 * s
                ! Change in the energy
                E = E - 2*s*dM
            end if  
         end subroutine flip_spin

        function H_0(lattice, ipbc, m, L_real)
            parameter(L = 100)
            byte lattice(1:L, 1:L)
            dimension ipbc(0:L+1)
            print *, "Computing total hamiltonian"
            print *, "L_real = ", L_real
            E_0 = 0
            do i = 1, L_real
               do k = 1, L_real
                   adj = lattice(ipbc(i-1),k)+lattice(ipbc(i+1),k)
                   adj = adj+lattice(i,ipbc(k-1))+lattice(i,ipbc(k+1))
                   E_0 = E_0 + adj * lattice(i, k)
                   m = m + adj
               end do
            end do
!           E = (-J/2) * (s(i, j)[s(i − 1, j) + s(i + 1, j) + s(i, j − 1) + s(i, j + 1))
            H_0 = - 0.5 * E_0
        end function H_0

        subroutine update_hamiltonian(lattice, pbc, i, k, E, J)
            implicit integer(p-p, a-a)
            implicit real(J-J)
            parameter(L = 100)
            byte lattice(1:L, 1:L)
            dimension pbc(0:L+1)

            adj = lattice(pbc(i-1),k) + lattice(pbc(i+1),k)
            adj = adj + lattice(i, pbc(k-1)) + lattice(i, pbc(k+1))

            E = E - 2 * J * adj           
        end subroutine update_hamiltonian


        subroutine initialize_lattice(lattice, m, L_real)
            parameter(L = 100)
            byte lattice(1:L, 1:L)
            ! initializing lattice
            m = 0
            do i = 1, L_real
               do k = 1, L_real
                  lattice(i, k) = 1
                  m = m + 1
               end do
            end do
        end subroutine initialize_lattice
    
        subroutine write_lattice(lattice, L_real, f_name)
            implicit integer (f-f)
            parameter(L = 100)
            byte lattice(1:L, 1:L)
            character *1 symb(-1:1)
            symb(1) = '1'
            symb(-1) = '0'
        
            do i = 1, L_real
               write(f_name,'(100A2)') (symb(lattice(i,j)),j = 1,L_real)

            end do  

        end subroutine write_lattice
