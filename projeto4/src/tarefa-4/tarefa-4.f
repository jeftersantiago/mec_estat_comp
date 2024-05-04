!     Efeito corona
!     código da tarefa-2 : dla_2d
!     com adaptação nas condições iniciais e tamanho
!     do grid em Y.
      implicit integer (x-x, y-y)
      parameter(N = 800)
      dimension grid(-N:N, 0:5000)
      Np = 80000
      read(*, *) iseed
      call srand(iseed)
      grid = 0
      open(1, file="saida-dla.dat")
!     semente inicial
      do i = -N, N
         grid(i, 0) = 1
         write(1, *) i, 0
      end do
      Y_in = 5
      Y_f = 1.5 * Y_in
      do i = 1, Np
         touched = 1
         print *, "Particle #", i
!     Gera uma particula em um ponto aleatorio.
         x = (2 * N * rand()) - N
         y = R_in
         do while(touched == 1) 
!      Passo aleatorio
            x = x + floor(rand()*3) - 1
            y = y + floor(rand()*3) - 1
            call random_step(x, y)
!     Conta numero de vizinhos proximos
            do j = -1, 1
               do k = 0, 1
                  sum = sum + grid(x + j, y - k)
               end do
            end do
            if(x >= N .or. x < -N .or. y > R_f) then
               touched = 0
            else if (sum > 0) then
               grid(x, y) = 1
               write(1, *) x, y
               touched = 0
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
