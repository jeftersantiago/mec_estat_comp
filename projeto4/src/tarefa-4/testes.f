      parameter(L = 800)
      parameter(N = 50000)
      dimension grade(-L:L,0:4000)
      dimension px(0:3)
      dimension py(0:3)
      parameter(px = (/1,-1,0,0/))
      parameter(py =(/0,0,1,-1/))

      logical condition
      grade = 0
      call srand(423)

      open(1, file='data.out')

      do i = -L, L
         grade(i,0) = 1
         write(1,*) i, 0
      end do

      Y_inic = 5
      Y_max = 1.5 * Y_inic
      do i = 1, N
         condition = .true.
         
         ix = (- L) + (2 * L * rand())
         iy = Y_inic
         
         do while (condition .eqv. .true.)
            
            ia = 4 * rand()
            ix = ix + px(ia)
            iy = iy + py(ia)
            
            do j = -1, 1
               do k = 0, 1
                  soma = soma + grade(ix + j, iy - k)
               end do
            end do
            
            if (ix >= L .or. ix < -L .or. iy > Y_max) then
               condition = .false.
            else if (soma > 0) then
               grade(ix, iy) = 1
               write(1,*) ix, iy
               condition = .false.
               soma = 0
               if (iy == Y_inic) then
                  Y_inic = Y_inic + 5
                  Y_max = Y_inic * 1.5d0
               end if
            end if
        end do
      end do
      end
