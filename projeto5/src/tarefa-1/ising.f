        subroutine define_exponentials(exps, beta)
            dimension exps(-4:4)
            do i = -4,4
                exps(i) = exp(-beta*i)/(exp(-beta*i)+exp(-beta*i)) 
            end do  

        end subroutine define_exponentials

        subroutine flip_spin(lattice, pbc, exps, H,  H_m)
            implicit integer(p-p, s-s)
            implicit real(J-J)
            parameter(L = 100)
            parameter(J = 1.0)
            dimension exps(-4:4)
            dimension lattice(1:L, 1:L)
            dimension pbc(0:L+1)

            ! choose a random site
            i = floor(rand()* L) + 1
            k = floor(rand()* L) + 1

            ! ∆M̃ = J[s(i − 1, j + s(i + 1, j) + s(i, j − 1) + s(i, j + 1)].
            dM = lattice(pbc(i-1), k) + lattice(pbc(i+1), k)
            dM = dM + lattice(i, pbc(k-1)) + lattice(i,pbc(k+1))

            dM = J * dM

            ! spin(i, j) and dM are positions of the lattice, so
            s = lattice(i, k)
            e_flip = exps(floor(s*dM))/(exps(floor(-s*dM))+exps(floor(s*dM)))

            if(rand() < res) then 
                lattice(i, k) = -s
                ! Magnetization
                H_m = H_m - 2 * s
                ! Change in the energy
                H = H - 2*s*dM
            end if  
        end subroutine flip_spin

        function total_hamiltonian(lattice, pbc, m, L_real)
            implicit integer(p-p)
            implicit real(m-m)
            parameter(L = 100)
            dimension lattice(1:L, 1:L)
            dimension pbc(0:L+1)
            total_hamiltonian = 0
            m = 0
            do i = 1, L_real
                do j = 1, L_real
                    !   x axis
                    adj = (lattice(pbc(i-1),j)+lattice(pbc(i+1), j))
                    !   y axis
                    adj = adj + (lattice(i, pbc(j-1)) + lattice(i, pbc(j+1)))
                    total_hamiltonian = total_hamiltonian + lattice(i, j)*adj

                    m = m + adj
                end do  
            end do  
            total_hamiltonian = -(J / 2) * total_hamiltonian
        end function total_hamiltonian

        subroutine update_hamiltonian(lattice, pbc, i, k, H, J)
            implicit integer(p-p)
            implicit real(J-J)
            parameter(L = 100)
            dimension lattice(1:L, 1:L)
            dimension pbc(0:L+1)

            adj = lattice(pbc(i-1),k) + lattice(pbc(i+1),k)
            adj = adj + lattice(i, pbc(k-1)) + lattice(i, pbc(k+1))

            H = H - 2 * J * adj           
        end subroutine update_hamiltonian

        !  conf = 0 -> ordered 
        !  conf = 1 -> random
        subroutine initialize_lattice(lattice, conf, L_real)
            implicit integer (c-c)
            parameter(L = 100)
            dimension lattice(1:L, 1:L)

            if (conf == 0) then 
                do i = 1, L_real
                    do j = 1, L_real
                        lattice(i, j) = conf 
                    end do  
                end do  
            else 
                do i = 1, L_real
                    do j = 1, L_real
                        lattice(i, j) = rand() *  
                    end do
                end do
            end if
        end subroutine initialize_lattice