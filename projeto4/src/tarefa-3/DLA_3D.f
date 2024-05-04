!     Dinâmica DLA em 2D
!     Para cada partícula:
!     - Gera posicao inicial aleatoria.
!     - Aplica dinâmica de random walk.
!     - Ao agregar novas celulas armazena a posição e raio atual à um
!     arquivo de dados.
!     Parâmetros:
!     Np -> numero de particulas
      subroutine DLA_3D(Np, iseed)
      implicit integer (x-x, y-y, z-z)
      parameter(N = 500)
      dimension lattice(-N:N, -N:N, -N:N)

!     semente inicial
      lattice(0, 0, 0) = 1
     
      rnd = rand(iseed)
      
      R_in = 5.0
      R_f = 1.5 * R_in


      open(1, file="saida-dla.dat")
      open(2, file="saida-contagem.dat")

      nparts = 0
      do i = 1, Np

         x = 0
         y = 0
         z = 0

         print *, "Particle #", i

         call generate_random_particle(R_in, x, y, z) 

!        print *, "r = ", R_in
         s = 0
         touched = 0

         do while(touched == 0) 

            call random_step(x, y, z) 

            d = sqrt(real(x**2+y**2+z**2))
!     Captura celula ao redor da posição atual se houver
            do k = -1, 1
               do j = -1, 1
                  do l = -1, 1
!     Checagem de borda
                     if(abs(x) < N .and. abs(y) < N)then
                        s = s + lattice(x+k, y+j, z+l)
                     end if
                  end do
               end do
            end do
!     Adiciona nova celula, atualiza raio
            if (d >= R_f) then
               touched = 1
            else if(s >= 1) then
               touched = 1
               lattice(x, y, z) = 1

               nparts = nparts + 1
!     Salva o cluster, particulas e raio
               write(1, *) x, y, z, R_in
               write(2, *) R_in, nparts
               if(d > R_in) then
                  R_in = d + 5
                  R_f = 1.5 * R_in
               end if
            end if
         end do
      end do
      close(1)
      close(2)
      end subroutine DLA_3D
!     Gera uma partícula em uma posicao aleatoria
!     dado um raio inicial R_in
      subroutine generate_random_particle(R_in, x, y, z) 
      implicit integer (x-x, y-y, z-z)
      parameter(pi = acos(-1e0))

      rnd_val1 = rand()
      rnd_val2 = rand()

      theta = 2 * pi * rnd_val1
      phi = 2 * pi * rnd_val2

      x = int(R_in * cos(theta)*cos(phi))
      y = int(R_in * sin(theta)*sin(phi))
      z = int(R_in * sin(theta))

      end subroutine generate_random_particle

!     Dinâmica das particulas.
!     Executa random-walk até que: atinge uma celula ocupada
!     Parametros:
!     posicao x, y
      subroutine random_step(x, y, z)
      implicit integer(x-x,y-y,z-z)

      x = x + floor(rand()*3) - 1
      y = y + floor(rand()*3) - 1
      z = z + floor(rand()*3) - 1

      end subroutine random_step
