!     Efeito corona
!     código da tarefa-2 : dla_2d
!     com adaptação nas condições iniciais.
!     e mudança no random-walk
      implicit integer (x-x, y-y)
      parameter(N = 800)
      dimension lattice(-N:N, 0:4000)

      dimension x_step(0:3)
      dimension y_step(0:3)

      parameter(x_step=(/1, -1, 0, 0/))
      parameter(y_step=(/0, 0, 1, -1/))

      logical touched 

!      read(*, *) Np, iseed
      Np = 50000
      iseed = 423 

      lattice = 0
      call srand(423)

      open(1, file="saida-dla.dat")
!     semente inicial
      do i = -N, N
         lattice(i, 0) = 1
         write(1, *) i, 0
      end do
      R_in = 5
      R_f = 1.5 * R_in
!     sum = 0

      do i = 1, Np
         touched = .true.
!         touched = 1
!         print *, "Particle #", i
!     Gera uma particula em um ponto aleatorio.
         x = (2 * N * rand()) - N
         y = R_in
         do while(touched .eqv. .true.) 
!     random steps
            ia = 4 * rand()
            x = x + x_step(ia)
            y = y + y_step(ia)
!     Captura celula ao redor da posição atual se houver
            do j = -1, 1
               do k = 0, 1
                  sum=sum+lattice(x+j,y-k)
               end do
            end do
!            print *, "SUM = ", sum
            if(x >= N .or. x < -N .or. y > R_max) then
!               touched = 0
               touched = .false.
            else if (sum > 0) then
               lattice(x, y) = 1
               write(1, *) x, y
!               touched = 0
               touched = .false.
               sum = 0
               if(y == R_in) then
                  R_in = R_in + 5  
                  R_f =  R_in * 1.5
               end if 
            end if
         end do
      end do
      close(1)
      end
