      implicit real*8(a-h,o-y)
      implicit real*8(l-l)
      implicit complex*8(z-z)

      external gaussian

      dimension grid(2000, 3)
      dimension Y(8000)

      nx = 1000
      nt = 4000
      r = 1.0d0
      L = 1.0d0
      c = 300.0d0
      dx = L / (nx*1.d0)
      dt = r * dx / c

      print *, "Paramêtros:"
      print *, "----------------------"
      print *, "r = ", r
      print *, " nx = ", nx
      print *, " nt = ", nt
      print *, " L = ", L
      print *, " t = ", nt * dt
      print *, " dx = ", dx
      print *, " dt = ", dt
      print *, "----------------------"

!     aplica as condicoes iniciais ao grid
!     t = 0
      print *, "x0 = ", L/2.0d0
      print *, "σ = ", L/30.0d0

      open(unit = 1, file = "saidas/evolucao-item-c.dat")

      do i = 1, nx 
         grid(i, 2) = gaussian(i*dx, L/3.0d0, L/30.d0)
      end do

      grid(:, 1) = grid(:, 2)
      grid(:, 3) = 0.d0
      call save_wave_state(grid, nx)

!     posicao x = L/4 no vetor das ondas.
      ni = nx / 4 
      print *, "Posicao L/4 = ", ni
      
      Y(1) = grid(ni, 2)

      do i = 3, nt
!         call drive_wave_fixed(grid, nx, r)
         call drive_wave_free(grid, nx, r)
         call save_wave_state(grid, nx)
         Y(i) = grid(ni,2)
      end do
      close(1)

      call dft(Y, nt, dt)
      end


      subroutine save_wave_state(grid, nx)
      implicit real*8(a-h, o-y)
      dimension grid(2000, 3)
      write(1, '(3000F16.8)') (grid(i, 2), i=1, nx)
      end subroutine save_wave_state
