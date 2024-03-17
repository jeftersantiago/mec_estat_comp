      implicit real*8(a-h, o-y)
      implicit complex*16(z-z)
      parameter(N = 200)
      parameter(pi = acos(-1.0e0))
      dimension signal(N)
      dimension zYn(N)
      zi = (0.0, 1.0)

      open(1, file="output-signal-A.dat")
      open(2, file="output-signal-B.dat")
      open(3, file="output-signal-C.dat")
      open(4, file="output-signal-D.dat")
      open(5, file="output-signal-E.dat")
      open(6, file="output-signal-F.dat")

      open(7, file="output-dft-A.dat")
      open(8, file="output-dft-B.dat")
      open(9, file="output-dft-C.dat")
      open(10, file="output-dft-D.dat")
      open(11, file="output-dft-E.dat")
      open(12, file="output-dft-F.dat")

      open(13, file="output-inv-dft-A.dat")
      open(14, file="output-inv-dft-B.dat")
      open(15, file="output-inv-dft-C.dat")
      open(16, file="output-inv-dft-D.dat")
      open(17, file="output-inv-dft-E.dat")
      open(18, file="output-inv-dft-F.dat")

      do k = 1, 6
         t = 0.0e0
         do i = 1, N
            read(k, *) t, signal(i)
         end do

         dt = t / N

         zeta = exp(2*pi*zi/N)
         do l = 1, N
            zYl = signal(1)
            do m = 1, N
               zYl = zYl+signal(m)*zeta**(m*l)
            end do
            zYn(l) = zYl
            write(k+6, *) l/(N*dt*2*pi),real(zYl),aimag(zYl)
         end do
         close(k+6)
         
         zeta = exp(-2*pi*zi/N)
         do m = 1, N
            zYm = zYn(1)/N
            do l = 1, N
               zYm = zYm+zYn(l)*zeta**(m*l)
            end do
            zYm = zYm/N
            write(k+12, *) m * dt, real(zYm)
         end do
         close(k+12)
      end do
      end
