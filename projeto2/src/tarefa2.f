!     Simulação para ondas ideias
      implicit real*8(a-h, o-y)
      dimension grid(1000, 3)
      ! L 
      s = 1.0d0
      c = 300.0d0
      r = 1.0d0
      nx = 1000
      dx = s / (nx*1.d0)
      dt = r * dx / c
      t = 0.01
      nt = floor(t/dt)
      open(unit = 1, file = "saida-tarefa2-c2.dat")
      grid(:, 3) = 0.e0

!     aplica as condicoes iniciais ao grid
!     t = 0
      do i = 1, nx
         grid(i, 2) = Y0_pinca(i*dx, s)
      end do
!     
      grid(:,1) = grid(:, 2)
      call write_to_file(grid, nx)
!     t = 1
      grid(:, 2) = grid(:, 1)
!     simulação
      do n = 3, nt
         call drive_pulse(grid, nx, r)
         call write_to_file(grid, nx)
      end do
      close(1)
      end

      subroutine write_to_file(grid, nx)
      implicit real*8(a-h, o-y)
      dimension grid(1000, 3)
      write(1, '(3000F16.8)') (grid(i, 2), i=1, nx)
      end subroutine write_to_file

      subroutine drive_pulse(grid, nx, r)
      implicit real*8(a-h, o-y)
      dimension grid(1000, 3)
!     y_next = 2(1-r^2)y_curr + r^2[y(t+1,n)+y(t-1,n)] - y_prev
      grid(1, 3) = grid(1, 2)
      grid(nx,3) = grid(nx, 2)

      y = 2.e0*(1.e0-r*r)

      do i = 2, nx-1
         grid(i,3)=y*grid(i,2)+r*r*(grid(i+1,2)+grid(i-1,2))-grid(i,1)
      end do
!     swap
      grid(:, 1) = grid(:, 2)
      grid(:, 2) = grid(:, 3)
      end subroutine drive_pulse

      function Y0_pinca(x, s)
      implicit real*8(a-h, o-y)
      if(x .le. s/4) then
         Y0_pinca = x
      else
         Y0_pinca = (1.0e0/3.0e0)*(s - x)
      end if
      end






