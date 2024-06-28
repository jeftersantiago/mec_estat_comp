!      Submodules for molecular dynamic simulations

      ! Updates acceleration a = ax, ay 
      ! between particle i and all others
      subroutine compute_acc(N, i, j, L, r_curr,acc, U)
            implicit real*8(a-h, o-y)
            dimension r_curr(20, 2)
            dimension acc(2)

            dx = r_curr(i, 1) - r_curr(j, 1)
            dy = r_curr(i, 2) - r_curr(j, 2)

            dx = dx - floor(dx/L + 0.5) * L 
            dy = dy - floor(dy/L + 0.5) * L

            dist = sqrt(dx**2 + dy**2)  

            if(dist < 3.0) then 
                  F = 24.0 * (2.0/dist**13-1.0/dist**7)
                  acc(1) = acc(1) + F * dx / dist 
                  acc(2) = acc(2) + F * dy / dist
            end if
            
            U = U + 4 * (1.0/dist**(-12) - 1.0/dist**(-6))
      end subroutine compute_acc

      subroutine set_initial_positions(N_particles,r_prev,r_curr,L,v,v0)
            implicit real*8(a-h, o-y)
            parameter (pi = acos(-1.e0))
            dimension r_prev(20, 2)
            dimension r_curr(20, 2)
            dimension v(20, 2)

            call srand(1949412)
      
            isq = sqrt(1.0*N_particles)
            spacing = L / isq            
            
            ! Set initial position
            do i = 1, N_particles
                  x = (mod(i, isq) + 1)*spacing 
                  y = ceiling(1.0*i/isq)*spacing

                  x = x + (0.25*spacing) * (1.0 - 0.5*rand())
                  y = y + (0.25*spacing) * (1.0 - 0.5*rand())

                  theta = 2*pi*rand()

                  v(i, 1) = v0*cos(theta)
                  v(i, 2) = v0*sin(theta)

                  r_curr(i, 1)  = x
                  r_curr(i, 2)  = y

                  r_prev(i, 1) = r_curr(i, 1) + v(i, 1) * dt 
                  r_prev(i, 2) = r_curr(i, 2) + v(i, 2) * dt 
            end do

      end subroutine set_initial_positions


