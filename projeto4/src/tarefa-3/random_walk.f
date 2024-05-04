!     Utiliza rotina random_step
!     para gerar um random walk em 3D
!     Programa utilizado para gerar figura pro relatorio.
      implicit integer (x-x,y-y,z-z)
      x = 0
      y = 0
      z = 0
      open(1, file="random_walk.dat")
      do i = 1, 5000
         call random_step(x, y, z)
         write(1, *) x, y, z
      end do
      close(1)
 
