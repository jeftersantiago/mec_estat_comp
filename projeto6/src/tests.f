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

      ! Tarefa A 
      open(unit = 99, file="saidas/tarefa-A/parametros.dat")
      open(unit = 1,  file="saidas/tarefa-A/posicoes-iniciais.dat")
      open(unit = 3,  file="saidas/tarefa-A/evolucao-posicoes.dat")

      ! Tarefa B 
      open(unit = 5,  file="saidas/tarefa-B/velocidades.dat")
      open(unit = 6,  file="saidas/tarefa-B/evolucao-posicoes.dat")

      ! Tarefa D
      open(unit = 9,  file="saidas/tarefa-D/temperatura-b.dat")

      dt = 0.02
      v0 = 1.0
      
      write(99, *) N, L, v0, dt
      close(99)

      call initialize_particles(N, L, r_curr,r_prev, v, v0)
      
      do i = 1, N
            write(1, *) r_curr(i, 1), r_curr(i, 2) 
            write(3, *) 0d0, r_curr(i,1), r_curr(i, 2)
      end do
      close(1)

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

                  ! APPLY PBC
                  r_next(i,1) = mod(r_next(i,1)+rL, rL)
                  r_next(i,2) = mod(r_next(i,2)+rL, rL)

                  delta_r_x = delta_pbc(r_next(i,1),r_prev(i,1),L)
                  delta_r_y = delta_pbc(r_next(i,2),r_prev(i,2),L)

                  ! UPDATE VELOCITIES using adjusted displacements
                  v(i, 1) = delta_r_x / (2 * dt)
                  v(i, 2) = delta_r_y / (2 * dt)

            end do
            r_prev(:, 1) = r_curr(:, 1)
            r_prev(:, 2) = r_curr(:, 2)
            
            r_curr(:, 1) = r_next(:, 1)
            r_curr(:, 2) = r_next(:, 2)

            ! TAREFA A 
            if(mod(k, 3) == 0 .and. k < 400) then
                  do i = 1, N 
                        write(3,*)t,r_curr(i,1),r_curr(i, 2)
                  end do
            end if
            
            ! Tarefa B & D 
            if(mod(k, 20) == 0) then
                  do i = 1, N
                        v_mag = sqrt(v(i,1)**2+v(i,2)**2)
                        write(5,*) k, v_mag, v(i,1), v(i,2)
                        write(9,*) .5d0 * v_mag**2
                        write(6,*) k, r_curr(i,1),r_curr(i, 2)
                  end do
            end if
      end do
      close(3)
      close(5)
      close(6)
      close(9)

      ! Tarefa C
      open(unit = 7,  file="saidas/tarefa-C/velocidades.dat")
      open(unit = 4,  file="saidas/tarefa-C/evolucao-posicoes.dat")
      open(unit = 66, file="saidas/tarefa-C/velocidades-iniciais.dat")

      ! Tarefa D 
      open(unit = 8,  file="saidas/tarefa-D/temperatura-c.dat")
      ! Modificacoes para tarefa C 

      r_prev = 0 
      r_curr = 0 
      r_next = 0
      acc = 0 

      ! setting velocities 
      v = 0 
      do i = 1, N/2
            v(i, 1) = v0
            v(i+N/2, 2) = v0
      end do

      ! Initialize particles 


      ! Defining # rows/columns 
      n_cols = ceiling(sqrt(N*1d0))
      n_rows = ceiling((N*1d0)/(n_cols*1d0)) 
      
      ! Spacing 1/4 
      x_spacing = L/(1d0*n_cols)
      y_spacing = L/(1d0*n_rows)

      spacing = min(x_spacing, y_spacing)/4.0 

      ! Centering in the grid
      x_offset = x_spacing / 2.0 
      y_offset = y_spacing / 2.0

      call srand(124689)

      k = 1 
      do j = 1, n_rows 
            do i = 1, n_cols 
                  r_curr(k, 1) = (i-1)*x_spacing+x_offset
                  r_curr(k, 2) = (j-1)*y_spacing+y_offset
                  
                  r_curr(k, 1) = r_curr(k,1)+(rand())*spacing
                  r_curr(k, 2) = r_curr(k,2)+(rand())*spacing
                  
                  r_prev(k, 1) = r_curr(k, 1) - v(k, 1) * dt 
                  r_prev(k, 2) = r_curr(k, 2) - v(k, 2) * dt 
                  k=k+1
            end do 
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

                  delta_r_x = delta_pbc(r_next(i,1),r_prev(i,1),L)
                  delta_r_y = delta_pbc(r_next(i,2),r_prev(i,2),L)

                  ! UPDATE VELOCITIES using adjusted displacements
                  v(i, 1) = delta_r_x / (2 * dt)
                  v(i, 2) = delta_r_y / (2 * dt)
            end do

            ! SWAP VECTOR POSITIONS.
            r_prev(:, 1) = r_curr(:, 1)
            r_prev(:, 2) = r_curr(:, 2)
            
            r_curr(:, 1) = r_next(:, 1)
            r_curr(:, 2) = r_next(:, 2)
            
            if(mod(k, 20) == 0) then
                  do i = 1, N
                        v_mag = sqrt(v(i,1)**2+v(i,2)**2)
                        write(7,*) k,  v_mag, v(i,1), v(i,2)
                        write(8,*) .5d0 * v_mag**2
                        write(4,*) k, r_curr(i,1),r_curr(i, 2)
                  end do
            end if
      end do
      close(4)
      close(8)

      ! TAREFA E 
      open(unit=75, file="saidas/tarefa-E/parametros.dat")
      open(unit=76, file="saidas/tarefa-E/posicoes-iniciais.dat")
      open(unit=77, file="saidas/tarefa-E/evolucao-posicoes-1.dat")
      open(unit=78, file="saidas/tarefa-E/evolucao-posicoes-2.dat")
      open(unit=79, file="saidas/tarefa-E/evolucao-posicoes-3.dat")

      ! Reset variables: 
      r_prev = 0
      r_curr = 0
      r_next = 0
      v = 0

      L = 4
      rL = 4d0
      N = 16

      dt = 5e-3
      v0 = 0.2

      write(75, *) N, L, v0, dt 
      close(75)

      ! Initialize particles 

      n_cols = ceiling(sqrt(N*1d0))
      n_rows = ceiling((N*1d0)/(n_cols*1d0)) 
      
      ! Spacing 1/4 
      x_spacing = L/(1d0*n_cols)
      y_spacing = L/(1d0*n_rows)
      spacing = min(x_spacing, y_spacing)/4.0 
      
      ! Centering in the grid
      x_offset = x_spacing / 2.0 
      y_offset = y_spacing / 2.0
      
      call srand(3512341)

      k = 1 
      do j = 1, n_rows 
            do i = 1, n_cols 
                  r_curr(k, 1) = (i-1)*x_spacing+x_offset
                  r_curr(k, 2) = (j-1)*y_spacing+y_offset
                  
                  r_curr(k, 1) = r_curr(k,1)+(rand())*spacing
                  r_curr(k, 2) = r_curr(k,2)+(rand())*spacing
                  
                  theta = 2*pi*rand()
                  
                  v(k, 1) = v0*cos(theta)
                  v(k, 2) = v0*sin(theta)
                  
                  r_prev(k, 1) = r_curr(k, 1) - v(k, 1) * dt 
                  r_prev(k, 2) = r_curr(k, 2) - v(k, 2) * dt 
                  k=k+1
            end do 
      end do

      do i = 1, N 
            write(76, *) r_curr(i, 1), r_curr(i, 2)
      end do 
      close(76)

      ! Dynamics 
      do k = 1, 3200 
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

                  ! APPLY PBC
                  r_next(i,1) = mod(r_next(i,1)+rL, rL)
                  r_next(i,2) = mod(r_next(i,2)+rL, rL)

                  delta_r_x = delta_pbc(r_next(i,1),r_prev(i,1),L)
                  delta_r_y = delta_pbc(r_next(i,2),r_prev(i,2),L)

                  ! UPDATE VELOCITIES using adjusted displacements
                  v(i, 1) = delta_r_x / (2 * dt)
                  v(i, 2) = delta_r_y / (2 * dt)
            end do
            r_prev(:, 1) = r_curr(:, 1)
            r_prev(:, 2) = r_curr(:, 2)
            
            r_curr(:, 1) = r_next(:, 1)
            r_curr(:, 2) = r_next(:, 2)

            if(k < 21) then 
                  do i = 1, N 
                        write(77,*) k, r_curr(i,1),r_curr(i,2)
                  end do
            else if (k > 40 .and. k < 81 .and. mod(k,3)==0) then 
                  do i = 1, N 
                        write(78,*) k, r_curr(i,1),r_curr(i,2)
                  end do
            else if (k > 2600 .and. k < 3200 .and. mod(k,10)==0) then 
                  do i = 1, N 
                        write(79,*) k, r_curr(i,1),r_curr(i,2)
                  end do
            end if 
      end do 
      close(77)
      close(78)
      close(79)
      end


      ! Submodules for molecular dynamic simulations
      ! Velocity delta 
      function delta_pbc(r_next, r_prev,L)
            implicit real*8(a-h, o-y)
            delta_pbc = r_next - r_prev
            if (delta_pbc > L/2) then
                  delta_pbc = delta_pbc - L
            else if (delta_pbc < -L/2) then
                  delta_pbc = delta_pbc + L
            end if
      end function delta_pbc

      subroutine initialize_particles(N, L, r_curr,r_prev, v, v0)
            implicit real*8(a-h, o-y)
            dimension r_prev(20, 2)
            dimension r_curr(20, 2)
            dimension v(20, 2)

            ! Defining # rows/columns 
            n_cols = ceiling(sqrt(N*1d0))
            n_rows = ceiling((N*1d0)/(n_cols*1d0)) 

            ! Spacing 1/4 
            x_spacing = L/(1d0*n_cols)
            y_spacing = L/(1d0*n_rows)
            spacing = min(x_spacing, y_spacing)/4.0 

            ! Centering in the grid
            x_offset = x_spacing / 2.0 
            y_offset = y_spacing / 2.0

            call srand(912472)

            k = 1 
            do j = 1, n_rows 
                  do i = 1, n_cols 

                        r_curr(k, 1) = (i-1)*x_spacing+x_offset
                        r_curr(k, 2) = (j-1)*y_spacing+y_offset
                        
                        r_curr(k, 1) = r_curr(k,1)+(rand())*spacing
                        r_curr(k, 2) = r_curr(k,2)+(rand())*spacing

                        theta = 2*pi*rand()
                        v(k, 1) = v0*cos(theta)
                        v(k, 2) = v0*sin(theta)

                        r_prev(k, 1) = r_curr(k, 1) - v(k, 1) * dt 
                        r_prev(k, 2) = r_curr(k, 2) - v(k, 2) * dt 

                        k=k+1
                  end do 
            end do
      end subroutine initialize_particles

      ! Updates acceleration a = ax, ay 
      ! between particle i and all others
      subroutine compute_acc(N, i, j, L, r_curr,acc, E_pot)
            implicit real*8(a-h, o-y)
            dimension r_curr(20, 2)
            dimension acc(2)

            epsilon = 1e-3
            
            !print *, "---------------------"
            !print *, "L = ", L
            !print *, "x_i, x_j = ", r_curr(i,1), r_curr(j,1)
            !print *, "y_i, y_j = ", r_curr(i,2), r_curr(j,2)
            
            dx = r_curr(i, 1) - r_curr(j, 1)
            dy = r_curr(i, 2) - r_curr(j, 2)

            !print *, "dy (before) = ", dy
            !print *, "dx (before) = ", dx

            dx = dx - floor(dx/L + .5) * L 
            dy = dy - floor(dy/L + .5) * L
            
            !print *, "dy (after) = ", dy
            !print *, "dx (after) = ", dx

            dist = sqrt(dx**2 + dy**2)  
            !print *, "dist = ", dist
            
            if(dist <= 3d0) then 
                  F = 24.0 * (2d0/dist**13 - 1d0/dist**7)
                  acc(1) = acc(1) + F * dx / dist 
                  acc(2) = acc(2) + F * dy / dist
            end if
            !print *, "ax, ay = ", acc(1), acc(2)
            !print *, "---------------------"

            if(dist > epsilon) then 
                  E_pot = E_pot + 4 * (dist**(-12)-dist**(-6))
            endif

      end subroutine compute_acc