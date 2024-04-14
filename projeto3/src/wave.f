      subroutine drive_wave_fixed(grid, nx, r)
      implicit real*8(a-h, o-y)
      dimension grid(1000, 3)
!     y_next = 2(1-r^2)y_curr + r^2[y(t+1,n)+y(t-1,n)] - y_prev
      grid(1, 3) = grid(1, 2)
      grid(nx,3) = grid(nx, 2)
      y = 2.e0*(1.e0-r*r)
      do i = 2, nx-1
         grid(i,3)=y*grid(i,2)+r*r*(grid(i+1,2)+grid(i-1,2))-grid(i,1)
      end do
      grid(:, 1) = grid(:, 2)
      grid(:, 2) = grid(:, 3)
      end subroutine drive_wave_fixed

      subroutine drive_wave_free(grid, nx, r)
      implicit real*8(a-h, o-y)
      dimension grid(2000, 3)
!     y_next = 2(1-r^2)y_curr + r^2[y(t+1,n)+y(t-1,n)] - y_prev
      grid(1, 3) = grid(1, 2)
      y = 2.e0*(1.e0-r*r)
      do i = 2, nx-1
         grid(i,3)=y*grid(i,2)+r*r*(grid(i+1,2)+grid(i-1,2))-grid(i,1)
      end do

      grid(nx, 3) = grid(nx-1, 3)
      grid(:, 1) = grid(:, 2)
      grid(:, 2) = grid(:, 3)

      end subroutine drive_wave_free
      
      function gaussian(x, x0, sigma)
      implicit real*8(a-h, o-y)
      gaussian = exp(-((x-x0)**2)/(sigma)**2)
      end function gaussian


