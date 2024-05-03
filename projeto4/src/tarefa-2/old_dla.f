!     Rotinas para simulação de DLA (2D)

      subroutine dla(r, b)
      implicit integer(u-u, p-p, w-w)
!     # particles
      parameter(p = 100)
      parameter(N = 100)
      dimension lattice(-N:N, -N:N)
      dimension walk(2)
      lattice = 0

      ! Semente inicial
      lattice(0, 0) = 1

      rnd = rand(iseed)
      do i = 1, p

         ud = int((2*rand() + 1/2)) - 1
         lr = int((2*rand() - 1/2)) - 1

         ud =  (5+r) + ud + (-1)**ud
         lr =  (5+r) + lr + (-1)**lr

         print *, "UD+R=", ud, "LR+R=", lr
!         call motion(lattice, walk, r, b, N)
      end do

      
      

      end subroutine dla

!     Lattice -> grid
!     lattice = 1 reticulado com particula
!     lattice = 0 reticulado sem particula
!     r -> raio para inicializar partículas
!     b -> fator que indica raio máximo r_max = b * r
!     subroutine motion(lattice, r, b, N)
!     implicit integer(u-u, w-w)
!     current pos
!     1 -> x ;   2 -> y
!     dimension pos(2)
!     dimension r(2)

!     r_curr = r
!     rnd = rand(iseed)
!     Random walk 2D
!     do while(r_curr <= b * r)
!        ud = int((rand()*2 + 1)/ 2) + 1
!        lr = int((rand()*2 + 1)/ 2) + 1

!     ud e lr -> cada uma captura uma das direções andadas.
!     atualizamos a posição do andarilho com (-1) sendo um sentido ou
!     outro.
!        pos(ud) = pos(ud) + (-1)**lr
!        r_curr = sqrt(pos(1)**2+pos(2)**2)
!        
!     
!        hit_cell = check_borders(pos, lattice, N)
!        
!     end do
!     end subroutine motion





      
