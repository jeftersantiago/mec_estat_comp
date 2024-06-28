      !     Testes e etc
      implicit real*8(a-h, o-y)
      parameter (pi = acos(-1.e0))
      dimension r_prev(20, 2)
      dimension r_curr(20, 2)
      dimension r_next(20, 2)
      dimension v(20, 2)
      dimension acc(2)
      L = 10
      N = 20

      open(unit = 1, file="posicoes_iniciais.dat")
      open(unit = 3, file="system_velocity.dat")
      open(unit = 4, file="system_state.dat")

      call srand(1949412)

      isq = sqrt(1.0*N)
      spacing = L / isq

      dt = 0.02
      v0 = 1.0

      ! initial positions
      do i = 1, N
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

            write(1, *) r_curr(i,1),r_curr(i, 2)
      end do

      do i = 1, N 
            write(3, *) v(i, 1), v(i, 2)
            write(4, *) r_curr(i,1),r_curr(i, 2)
      end do
      
      ! Dynamics 
      do k = 1, 200

            t = k * dt 
            ! calculates acceleration at time t
            acc(1) = 0.0
            acc(2) = 0.0

            do i = 1, N 
                  
                  acc(1) = 0.0
                  acc(2) = 0.0
                  
                  do j = 1, N
                        if(j /= i) then 
                              call compute_acc(N,i,j,L,r_curr,acc)
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

            if(mod(k, 3) == 0) then 
                  do i = 1, N 
                        write(3, *) v(i, 1), v(i, 2)
                        write(4, *) r_curr(i,1),r_curr(i, 2)
                  end do
            end if
      end do
      end

      ! Updates acceleration a = ax, ay 
      ! between particle i and all others
      subroutine compute_acc(N, i, j, L, r_curr,acc)
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
      end subroutine compute_acc