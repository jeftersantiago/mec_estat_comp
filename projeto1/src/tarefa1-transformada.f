!     Calcula transformada discreta do sinal de entrada
!     Y_n = sum_{m=0}^{N-1} y_m e^{2\pi i m n/N}
      implicit real*8(a-h, o-y)
      implicit complex*16(z-z)
      parameter(N = 200)
      parameter(pi = acos(-1e0))
      dimension ztransform(200)
      dimension ztransform_inv(200)
      dimension signal(200)
      zi = (0.0, 1.0)

!      open(10, file="saida-tarefa1-amplitudes.dat")
      open(10, file="tarefa1-sinal1.dat")
      read(10, *) signal
      close(10)

      dt = 0.04
      open(11, file="saida-transformada.dat")
      open(12, file="saida-inverso-transformada.dat")
!     k ≡ n
      do k = 1, N
         zres = signal(1)

         do m = 1, N
            theta = 2*pi*m*k/ N
            zres = zres + signal(m) * exp(zi * theta)
         end do
         ztransform(k) = zres
         write(11, *) k/(dt * N * 2 * pi), real(zres), aimag(zres)
      end do
      close(11)
      close(12)


      end
