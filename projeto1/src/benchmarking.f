!     Testes de tempo para algoritmo da transformada de Fourier.
      implicit real*8(a-h, o-y)
      implicit complex*16(z-z)
      dimension N(1:4)
      parameter(N = (/50, 100, 200, 400/))
      parameter(pi = acos(-1.0e0))
      dimension signal(400)
      zi = (0.0, 1.0)

      start_time = 0.0e0
      end_time = 0.0e0

      open(5, file="output-benchmarking.dat")

      open(1, file="output-signal-n50.dat")
      open(2, file="output-signal-n100.dat")
      open(3, file="output-signal-n200.dat")
      open(4, file="output-signal-n400.dat")

      dt = 0.04e0
      t = 0.00e0

      do k = 1, 4
!     N atual
         Nc = N(k)
         do i = 1, Nc 
            read(k, *) t, signal(i)
         end do
         close(i)

         call cpu_time(start_time)

!     Calcula transformada
         zeta = exp(2*pi*zi/Nc)
         do l = 1, Nc
            zYl = signal(1)
            do m = 1, Nc
               zYl = zYl+signal(m)*zeta**(m*l)
            end do
         end do
!     Tempo passado
         call cpu_time(end_time)
         write(5, *) N(k), end_time-start_time
      end do
      close(5)
      end
