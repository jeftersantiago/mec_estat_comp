!     Calcula a inversa da transformada de Fourier
!     a partir de um arquivo "data.out"
      implicit real*8(a-h, o-y)
      implicit complex*16(z-z)
      parameter(N = 200)
      parameter(pi = acos(-1.0e0))
      dimension signal(N)
      dimension zYn(N)
      zi = (0.0, 1.0)

      open(10, file="../tarefa-1/data.out")
      open(11, file="data.out")

      comp_real = 0.0d0
      comp_imag = 0.0d0

      t = 0.0e0
      do i = 1, N
         read(10, *) t, comp_real, comp_imag
         zYn(i) = cmplx(comp_real, comp_imag)
      end do
      dt = t / N

      zeta = exp(-2*pi*zi/N)
      ! Calcula a transformada inversa
      do m = 1, N
         zYm = zYn(1)/N
         do l = 1, N
            zYm = zYm+zYn(l)*zeta**(m*l)
         end do
         zYm = zYm/N
!     Escreve a transformada inversa no arquivo "data.out"
         write(11, *) m * dt, real(zYm)
      end do
      close(10)
      close(11)
      end
