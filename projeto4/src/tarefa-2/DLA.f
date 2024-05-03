!     Dinâmica DLA em 2D
!     Para cada partícula:
!     - Gera posicao inicial aleatoria.
!     - Aplica dinâmica de random walk.
!     - Ao agregar novas celulas armazena a posição e raio atual à um
!     arquivo de dados.
!     Parâmetros:
!     Np -> numero de particulas
      subroutine DLA_2D(Np)
      implicit integer (x-x, y-y)
      parameter(N = 500)
      dimension lattice(-N:N, -N:N)

!     semente inicial
      lattice(0, 0) = 1
     
      rnd = rand(iseed)
      
      R_in = 5.0
      R_f = 1.5 * R_in

      open(2, file="particle_positions.dat")

      do i = 1, Np

         x = 0
         y = 0

         print *, "Particle #", i

         call generate_random_particle(R_in, x, y) 

         print *, "r = ", R_in
         s = 0
         touched = 0

         print *, "x = ", x
         print *, "y = ", y

         do while(touched == 0) 

            call random_step(x, y) 

            d = sqrt(real(x**2 + y ** 2))
            
!     Captura celula ao redor da posição atual se houver
            do k = -1, 1
               do j = -1, 1
!                Checagem de borda
                  if(abs(x) < N .and. abs(y) < N)then
                     s = s + lattice(x+k, y+j)
                  end if
               end do
            end do
!     Adiciona nova celula, atualiza raio
            if (d >= R_f) then
               touched = 1
            else if(s >= 1) then
               touched = 1
               lattice(x, y) = 1

               write(2, *) x, y, R_in

               if(d > R_in) then
                  R_in = d + 5
                  R_f = 1.5 * R_in
               end if
            end if
         end do
      end do
      close(2)
      end subroutine DLA_2D

!     Gera uma partícula em uma posicao aleatoria
!     dado um raio inicial R_in
      subroutine generate_random_particle(R_in, x, y) !cell)
      implicit integer (c-c, x-x, y-y)
      parameter(pi = acos(-1e0))
      dimension cell(2)

      rnd_val = rand()

      theta = 2 * pi * rnd_val

      x = int(R_in * cos(theta))
      y = int(R_in * sin(theta))

!      cell(1) = x
!      cell(2) = y
      end subroutine generate_random_particle

!     Dinâmica das particulas.
!     Executa random-walk até que: atinge uma celula ocupada
!     Parametros:
!     posicao x, y
      subroutine random_step(x,y)!cell)
      implicit integer(x-x,y-y,c-c)
      dimension cell(2)

!      cell(1) = cell(1) + floor(rand()*3) -1
!      cell(2) = cell(2) + floor(rand()*3) -1

      x = x + floor(rand()*3) - 1
      y = y + floor(rand()*3) - 1

      end subroutine random_step








