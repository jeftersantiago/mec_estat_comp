      implicit real*8(a-h, o-y)
      implicit complex*16(z-z)
      parameter(N = 200)
      parameter(pi = acos(-1.0e0))
      dimension signal(N)
      dimension zYn(N)
      zi = (0.0, 1.0)

      open(1, file="tarefa-2/output-signal-A.dat")
      open(2, file="tarefa-2/output-signal-B.dat")
      open(3, file="tarefa-2/output-signal-C.dat")
      open(4, file="tarefa-2/output-signal-D.dat")
      open(5, file="tarefa-2/output-signal-E.dat")
      open(6, file="tarefa-2/output-signal-F.dat")

      open(7, file="tarefa-1/output-dft-A.dat")
      open(8, file="tarefa-1/output-dft-B.dat")
      open(9, file="tarefa-1/output-dft-C.dat")
      open(10, file="tarefa-1/output-dft-D.dat")
      open(11, file="tarefa-1/output-dft-E.dat")
      open(12, file="tarefa-1/output-dft-F.dat")

      open(13, file="tarefa-4/output-inv-dft-A.dat")
      open(14, file="tarefa-4/output-inv-dft-B.dat")
      open(15, file="tarefa-4/output-inv-dft-C.dat")
      open(16, file="tarefa-4/output-inv-dft-D.dat")
      open(17, file="tarefa-4/output-inv-dft-E.dat")
      open(18, file="tarefa-4/output-inv-dft-F.dat")

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
            zYl = zYl
            write(k+6, *) l/(N*dt),real(zYl),aimag(zYl)
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
