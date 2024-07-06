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

      open(unit = 99, file="saidas/tarefa-A/parametros.dat")
      open(unit = 1, file="saidas/tarefa-A/posicoes-iniciais.dat")
      !open(unit = 2, file="saidas/tarefa-A/velocidades.dat")
      open(unit = 3, file="saidas/tarefa-A/evolucao-posicoes.dat")
      !open(unit = 4, file="saidas/tarefa-A/evolucao-energia.dat")
      open(unit = 5, file="saidas/tarefa-B/velocidades.dat")
      open(unit = 6, file="saidas/tarefa-B/posicoes.dat")

      !print *, "L = ", L
      !print *, "L_real = ", 1d0 * L

      dt = 0.02
      v0 = 1.0
      
      write(99, *) N, L, v0, dt

      debug = 0d0
      if(debug == 1d0) then
      call initialize_particles(N, L, r_curr,r_prev, v, v0)
      
      do i = 1, N
            write(3, *) 0d0, r_curr(i,1), r_curr(i, 2)
      end do 
      
      ! Dynamics 
      do k = 1, 5000

            t = k * dt 
            acc(1) = 0d0 
            acc(2) = 0d0

            E_pot = 0d0 
            E_k = 0d0

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
                  !print *, "x_next", r_next(i, 1)
                  !print *, "y_next", r_next(i, 2)

                  !print *, "x_mod = ", mod(r_next(i,1)+rL, rL)
                  !print *, "y_mod = ", mod(r_next(i,2)+rL, rL)
                  !print *, "------------------"

                  r_next(i,1) = mod(r_next(i,1)+rL, rL)
                  r_next(i,2) = mod(r_next(i,2)+rL, rL)

                  ! UPDATES VELOCITIES 
                  !v(i, 1) = (r_next(i,1)-r_prev(i,1))/(2*dt)
                  !v(i, 2) = (r_next(i,2)-r_prev(i,2))/(2*dt)

                  ! PBC for velocity...
                  !delta_r_x = r_next(i, 1) - r_prev(i, 1)
                  !if (delta_r_x > L/2) then
                  !      delta_r_x = delta_r_x - L
                  !else if (delta_r_x < -L/2) then
                  !      delta_r_x = delta_r_x + L
                  !end if
                  !delta_r_y = r_next(i, 2) - r_prev(i, 2)
                  !if (delta_r_y > L/2) then
                  !      delta_r_y = delta_r_y - L
                  !else if (delta_r_y < -L/2) then
                  !      delta_r_y = delta_r_y + L
                  !end if

                  delta_r_x = delta_pbc(r_next(i,1),r_prev(i,1),L)
                  delta_r_y = delta_pbc(r_next(i,2),r_prev(i,2),L)

                  ! UPDATE VELOCITIES using adjusted displacements
                  v(i, 1) = delta_r_x / (2 * dt)
                  v(i, 2) = delta_r_y / (2 * dt)

                  if(v(i, 1) < -100 .or. v(i, 2) > 100) then 
                        print *, "r_prev(i, 1) = ", r_prev(i, 1)
                        print *, "r_next(i, 1) = ", r_next(i, 1)
                        print *, "delta_r_x = ", delta_r_x
                        print *, "delta_r_y = ", delta_r_y
                  end if
            end do

            ! SWAP VECTOR POSITIONS.
            do i = 1, N 
                  r_prev(i, 1) = r_curr(i, 1)
                  r_prev(i, 2) = r_curr(i, 2)          
                  
                  r_curr(i, 1) = r_next(i, 1) 
                  r_curr(i, 2) = r_next(i, 2)
            end do

            ! TAREFA A 
            if(mod(k, 3) == 0 .and. k < 1000) then
                  do i = 1, N 
                        write(3,*)t,r_curr(i,1),r_curr(i, 2)
                  end do
            end if

            v_quad = (v(i,1)**2+v(i,2)**2)
            E_k = E_k + 0.5*v_quad
            
            !if(k > 1000) then 
                  if(mod(k, 20) == 0) then
                        do i = 1, N
                              v_mag = sqrt(v(i,1)**2+v(i,2)**2)
                              write(5,*) k,  v_mag, v(i,1), v(i,2), t
                              write(6,*) k, r_curr(i,1), r_prev(i,1)
                        end do
                  end if
            !end if
      end do
      end if
      !debug = 0d0
      !if(debug == 1d0) then
      ! TAREFA C
      ! Reinitialize 
      open(unit = 7, file="saidas/tarefa-C/velocidades.dat")
      open(unit = 8, file="saidas/tarefa-C/testes.dat")

      r_prev = 0 
      r_curr = 0 
      r_next = 0
      acc = 0 
      call initialize_particles(N, L, r_curr,r_prev, v, v0)

      ! setting velocities 
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
                        write(7,*) k,  v_mag, v(i,1), v(i,2), t
                  end do
            end if
      end do
      !end if
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
            do i = 1, N
                  write(1, *) r_curr(i, 1), r_curr(i, 2) 
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

