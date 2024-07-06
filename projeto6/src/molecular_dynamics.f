      ! Submodules for molecular dynamic simulations

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