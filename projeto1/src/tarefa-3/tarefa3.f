!     Calcula a DFT para as séries (a), (b), (c), (d)
!     (e) e (f)

      implicit real*8(a-h, o-y)
      implicit complex*16(z-z)
      parameter(N = 200)
      parameter(pi = acos(-1.0e0))
      dimension signal(N)
      dimension zYn(N)
      zi = (0.0, 1.0)

      open(10, file="../tarefa-2/output-signal-D.dat")

      t = 0.0e0
      do i = 1, N
         read(10, *) t, signal(i)
      end do
      dt = t / N

      open(11, file="output-dft.dat")
      zeta = exp(2*pi*zi/N)
      do l = 1, N
         zYl = signal(1)
         do m = 1, N
            zYl = zYl+signal(m)*zeta**(m*l)
         end do
         zYn(l) = zYl
         write(11, *) l/(N*dt*2*pi),real(zYl),aimag(zYl)
      end do
      close(10)

      open(12, file="output-inv-dft.dat")
      zeta = exp(-2*pi*zi/N)
      do m = 1, N
         zYm = zYn(1)/N
         do l = 1, N
            zYm = zYm+zYn(l)*zeta**(m*l)
         end do
         zYm = zYm/N
         write(12, *) m * dt, real(zYm)
      end do
      close(12)
      end
