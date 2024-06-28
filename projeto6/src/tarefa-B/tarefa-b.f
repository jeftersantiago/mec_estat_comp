      !     Tarefa 
      implicit real*8(a-h, o-y)
      parameter (pi = acos(-1.e0))
      dimension r_prev(20, 2)
      dimension r_curr(20, 2)
      dimension r_next(20, 2)
      dimension v(20, 2)
      dimension acc(2)

      L = 10
      N = 20
      
      open(unit = 1, file="saidas/tarefa-B/evolucao-posicoes.dat")
      open(unit = 2, file="saidas/tarefa-B/velocidades.dat")

      call srand(1949412)

      isq = sqrt(1.0*N)
      spacing = L / isq

      dt = 0.02
      v0 = 1.0

      ! initial positions
      call set_initial_positions(N, r_prev, r_curr, L, v, v0)

      do i = 1, N
            write(1, *) r_curr(i,1),r_curr(i, 2)
            write(2, *) v0, v(i, 1), v(i, 2)
      end do

      U = 0d0

      ! Dynamics 
      do k = 1, 1000
            t = k * dt 
            ! calculates acceleration at time t
            acc(1) = 0.0
            acc(2) = 0.0

            do i = 1, N 
            
                  acc(1) = 0.0
                  acc(2) = 0.0

                  do j = 1, N
                        if(j /= i) then 
                              call compute_acc(N,i,j,L,r_curr,acc, U)
                        end if
                  end do

                  r_next(i,1) = 2*r_curr(i,1)-r_prev(i,1)+acc(1)*dt**2
                  r_next(i,2) = 2*r_curr(i,2)-r_prev(i,2)+acc(2)*dt**2

                  r_next(i, 1) = mod(r_next(i, 1) + 1.0 * L, 1.0*L) 
                  r_next(i, 2) = mod(r_next(i, 2) + 1.0 * L, 1.0*L)

                  ! Updates velocities 
                  v(i, 1) = (r_next(i, 1)- r_prev(i,1))/(2*dt)
                  v(i, 2) = (r_next(i, 2)- r_prev(i,2))/(2*dt)
            end do

            do i = 1, N 
                  ! Updates positions. 
                  r_prev(i, 1) = r_curr(i, 1)
                  r_prev(i, 2) = r_curr(i, 2)

                  r_curr(i, 1) = r_next(i, 1) 
                  r_curr(i, 2) = r_next(i, 2)
            end do
            
            if(mod(k, 20) == 0) then 
                  do i = 1, N 
                        v_quad = sqrt(v(i,1)**2+v(i,2)**2)
                        write(1, *) r_curr(i,1),r_curr(i, 2)
                        write(2, *) v_quad, v(i, 1),v(i, 2)
                  end do
            end if

      end do
      end