      subroutine dft(Y, N, dt)
      implicit real*8 (a-h,o-y)
      implicit complex*8(z-z)

      parameter(pi = acos(-1.0e0))
      dimension Y(4000)

      zi = (0.0, 1.0)
      open(unit = 2, file = "saidas/dft-item-c.dat")
      zeta = exp(2.d0*pi*zi/N)

      do k = 0, N/2 - 1
         zY = 0
         do m = 2, N 
            zY = zY + Y(m)*zeta**(k*m)
         end do

         res =  real(zY)**2 + aimag(zY)**2
!         res = res / (N/2)
         freq = k/(N*dt) 
         print *, freq, res
         write(2, '(3000F20.8)') freq, res
      end do
      close(2)
      end subroutine dft
