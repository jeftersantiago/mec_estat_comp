!     Gera series y_i = a1*cos(w1*t_i) + a2*sin(w2*t_i)
!     t_i = i * dt, i = 1,..., N
      parameter(N = 200)
      parameter(pi = acos(-1e0))
      open(1, file="output-signal1.dat")
      open(2, file="output-signal2.dat")
      open(3, file="output-signal3.dat")
      open(4, file="output-signal4.dat")
      open(5, file="output-signal5.dat")
      open(6, file="output-signal6.dat")
      dt1 = 0.04
      dt2 = 0.4
      a11 = 2.0e0
      a12 = 3.0e0
      a21 = 4.0e0
      a22 = 2.0e0
      w1 = 4.0e0 * pi
      w21 = 2.5e0 * pi
      w22 = 0.2e0 * pi
      do i = 1, N
         ti1 = i * dt1
         ti2 = i * dt2
         write(1, *)  ti1, a11*cos(w1*ti1) + a21*sin(w21*ti1) 
         write(2, *)  ti1, a12*cos(w1*ti1) + a22*sin(w21*ti1) 
         write(3, *)  ti2, a11*cos(w1*ti2) + a21*sin(w22*ti2) 
         write(4, *)  ti2, a12*cos(w1*ti2) + a22*sin(w22*ti2) 
         write(5, *)  ti1, a11*cos(w1*ti1) + a21*sin(1.4e0*pi*ti1) 
         write(6, *)  ti1, a11*cos(4.2*pi*ti1) + a21*sin(1.4e0*pi*ti1) 
      end do
      close(1)
      close(2)
      close(3)
      close(4)
      end











