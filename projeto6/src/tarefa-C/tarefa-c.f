      ! MODULO DE TESTES.
      implicit real*8(a-h, o-y)
      parameter (pi = acos(-1.e0))
      dimension r_prev(20, 2)
      dimension r_curr(20, 2)
      dimension r_next(20, 2)
      dimension v(20, 2)
      dimension acc(2)
      
      L = 10
      rL = 10d0
      N = 20
      
      open(unit = 5, file="saidas/tarefa-C/velocidades.dat")
      open(unit = 6, file="saidas/tarefa-C/posicoes.dat")
      
      !print *, "L = ", L
      !print *, "L_real = ", 1d0 * L
      dt = 0.02
      v0 = 1.0
      write(99, *) N, L, v0, dt
      
      call initialize_particles(N, L, r_curr,r_prev, v, v0)
      
      v = 0 
      do i = 1, N/2
            v(i, 1) = v0
            v(i+N/2, 2) = v0
      end do
      ! Dynamics 
      do k = 1, 5000
      
        t = k * dt 
        acc(1) = 0d0 
        acc(2) = 0d0
      
        do i = 1, N 
            acc(1) = 0d0 
            acc(2) = 0d0
            do j = 1, N 
                  if(i /= j) then
                       call compute_acc(N,i,j,L,r_curr,acc,E_pot)
                  end if
            end do 
            ! UPDATE POSITIONS
            r_next(i,1) = 2*r_curr(i,1)-r_prev(i,1)+acc(1)*(dt**2)
            r_next(i,2) = 2*r_curr(i,2)-r_prev(i,2)+acc(2)*(dt**2)      
            r_next(i,1) = mod(r_next(i,1)+rL, rL)
            r_next(i,2) = mod(r_next(i,2)+rL, rL)
            ! UPDATES VELOCITIES 
            delta_r_x = delta_pbc(r_next(i,1),r_prev(i,1),L)
            delta_r_y = delta_pbc(r_next(i,2),r_prev(i,2),L)
            ! UPDATE VELOCITIES using adjusted displacements
            v(i, 1) = delta_r_x / (2 * dt)
            v(i, 2) = delta_r_y / (2 * dt)
        end do
      
        ! SWAP VECTOR POSITIONS.
        do i = 1, N 
              r_prev(i, 1) = r_curr(i, 1)
              r_prev(i, 2) = r_curr(i, 2)          
              r_curr(i, 1) = r_next(i, 1) 
              r_curr(i, 2) = r_next(i, 2)
        end do
      
        if(mod(k, 20) == 0) then
              do i = 1, N
                    v_mag = sqrt(v(i,1)**2+v(i,2)**2)
                    write(5,*) k,  v_mag, v(i,1), v(i,2), t
              end do
        end if
      end do
      end