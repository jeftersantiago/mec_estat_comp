      implicit integer (x-x, y-y)
      parameter(N = 1000)

      dimension lattice_static(-N:N, -N:N)
      dimension lattice_dynamic(-N:N, -N:N)
      dimension lattice_aux(-N:N, -N:N)

      dimension ipx(0:3)
      dimension ipy(0:3)
      parameter(ipx=(/1,-1,0,0/), ipy = (/0,0,1,-1/))

!      read(*, *) p
      p = 0.1

      open(1, file="output-dynamics.dat")
      open(2, file="output-static.dat")
      open(3, file="output-fractal.dat")

      lattice_static(0, 0) = 0
      lattice_dynamic(0, 0) = 1
!      l = 0
      do i = -N, N
         do j = -N, N
            if (rand() <= p) then
               lattice_static(i,j) = 1
!               l = l + 1
            end if
         end do
      end do
!      print *, "#Static=", l

!     Dinamica
!     · Agragado pode aglutinar particulas por ate M passos
!     · Definimos um raio para o agregado pode buscar particulas adjacentes
!     · Para cada passo olhamos em volta do agragado, aglutinamos
!     · particulas, atualizamos raio e contamos # particulas no dado raio.
      k_radious = 5
      x = 0
      y = 0
      n_parts = 0
      ! passos 
      do m = 1, 6000
         print *, "STEP #", m
!     · Percorre raio em torno das coordenadas (x,y) do aglomerado.
         do i = -k_radious, k_radious
            do j = -k_radious, k_radious
               if(lattice_dynamic(x+i, y+j) == 1) then
!     · Percorre coordenadas adjacentes ao aglomerado.
                  do k = -1, 1
                     do l = -1, 1
!     · Aglomerado chocou com uma particula.
                        if(lattice_static(i+k,j+l)==1) then
                           lattice_static(i+k,j+l) = 0
                           lattice_dynamic(i+k,j+l) = 1
!     · Verifica se o raio ultrapassou do raio inicial k_radious:
                           dist = sqrt(real(((i+k)-x)**2+((j+l)-y)**2))
                           if(dist >= k_radious) then
                              k_radious = k_radious + 5
                           end if 
                           n_parts = n_parts + 1
!     · Escreve raio atual e numero de particulas 
                           write(3, *) n_parts, dist
                        end if
                     end do
                  end do
               end if
            end do
         end do
         ! Movimenta o aglomerado:
         x_step = 0
         y_step = 0
         ia = 4 * rand()
!     · Todas particulas do aglomerado estao dentro do raio k_radious
         do i = x-k_radious, x+k_radious
            do j = y-k_radious, y+k_radious
!               print *, "(x, y) = (", i, ",",j,")"
               if(lattice_dynamic(i, j) == 1) then
!                  x_step = i + floor(rand()*3) - 1
!                  y_step = j + floor(rand()*3) - 1
                  lattice_aux(i+ipx(ia),j+ipy(ia))=lattice_dynamic(i,j)
!                  lattice_dynamic(i+x_step, j+y_step) = 1
!                  lattice_dynamic(i, j) = 0
!                  lattice_aux(i+x_step,j+y_step)=lattice_dynamic(i, j)
              end if
            end do
         end do
         x = ipx(ia)
         y = ipy(ia)
!         x = x_sjep
!         y = y_step
         lattice_dynamic = lattice_aux
         lattice_aux = 0
      end do

      do i = -(x + k_radious), (x + id)
         do j = -(y + k_radious), (y + id)
            if (lattice_dynamic(i,j) == 1) then
               write(1, *) i, j
            end if
            if (lattice_static(i,j) == 1) then
               write(2,*) i, j
            end if
         end do
      end do
      end
