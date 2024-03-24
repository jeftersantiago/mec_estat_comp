!     Calcula a DFT lendo dados de um arquivo "data.in" e escreve ela em
!     um arquivo "data.out"
      implicit real*8(a-h, o-y)
      implicit complex*16(z-z)
      parameter(N = 200)
      parameter(pi = acos(-1.0e0))
      dimension signal(N)
      dimension zYn(N)
      zi = (0.0, 1.0)

      open(unit=1, file="data.in")
      open(unit=2, file="data.out")

      do i = 1, N
         read(1, *) t, signal(i)
      end do
      dt = t / N

      zeta = exp(2*pi*zi/N)
      do l = 1, N
         zYl = signal(1)
         do m = 1, N
            zYl = zYl+signal(m)*zeta**(m*l)
         end do
         zYn(l) = zYl
         write(2, *) l/(N*dt*2*pi),real(zYl),aimag(zYl)
      end do

      close(1)
      close(2)
      end
      
