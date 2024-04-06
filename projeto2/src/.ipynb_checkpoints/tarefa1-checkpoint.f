!     Simulação para ondas ideias
      implicit real*16(a-h, o-y)

      external write_to_file
      external drive_pulse

!     Grid de estados da computacao:
!     y_prev, y_current, y_next
!     Grid -> [100 linhas, 3 colunas]
!     Coluna 1 -> Anterior
!     Coluna 2 -> Atual
!     Coluna 3 -> Proximo
      dimension grid(300, 3)

      ! L 
      s = 1.d0
      c = 300.0d0
      r = 1.d0

      nt = 300
      nx = 300

      dx = s / (nx*1.d0)

!     print *, "dx = ", dx

      open(unit = 1, file = "saida-tarefa1.dat")

!     aplica as condicoes iniciais ao grid
      do i = 1, nx
         grid(i, 2) = Y0(i*dx, s) 
      end do

      grid(:,1) = grid(:, 2)
      grid(:, 3) = 0.e0

      call write_to_file(grid, nx)

!     t = 1
      grid(:, 2) = grid(:, 1)
!     simulação
      do n = 2, nt
         call drive_pulse(grid, nx, r)
         call write_to_file(grid, nx)
      end do
      close(1)

      end

      subroutine write_to_file(grid, nx)
      implicit real*16(a-h, o-y)
      dimension grid(300, 3)
      write(1, '(3000F16.8)') (grid(i, 2), i=1, nx)
      end subroutine write_to_file

      subroutine drive_pulse(grid, nx, r)
      implicit real*16(a-h, o-y)
      dimension grid(300, 3)

!     y_next = 2(1-r^2)y_curr + r^2[y(t+1,n)+y(t-1,n)] - y_prev

      grid(1, 3) = grid(1, 2)
      grid(nx,3) = grid(nx, 2)

      y = 2.e0*(1.e0-r*r)

      do i = 2, nx-1
         grid(i,3)=y*grid(i,2)+r*r*(grid(i+1,2)+grid(i-1,2))-grid(i,1)
      end do

      grid(:, 1) = grid(:, 2)
      grid(:, 2) = grid(:, 3)

      end subroutine drive_pulse

      function Y0(x, s)
!     Y0 =  exp[−(x − x0)^2 /σ^2 ]
      implicit real*16(a-h, o-y)
!     condicoes iniciais
      Y0 = exp(-((x-s/3)**2)/(s/30)**2)
!      print *, "Y0 = ", yo
      end
