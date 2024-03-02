      implicit complex * 16(z-z)
      dimension ym(200)
      dimension transform(200)
      
      parameter(pi = acos(-1e0))


      read(*, *) N, dt, a2, a1, w1, w2

      open(unit=11,file='saida-tarefa.dat')

      open(unit=12, file='resultado-transformada.dat')

      do i = 1, N
         ti = i * dt
         ym(i) = a1 * cos(w1*ti*pi) + a2 * sin(w2*ti*pi) 
         write(11, *) ti , ym(i)
      end do
      close(11)
      ! print *, ym

      do k = 1, N
         ti = i * dt
         zexp = 1
         do i = 1, N
            zexp = zexp + exp(2*pi*j/N)
            zexp = ym(j) * zexp
         end do
          transform(k) = exp_res
         write(12, *) ti, transform(k)
      end do

      close(12)
      end












