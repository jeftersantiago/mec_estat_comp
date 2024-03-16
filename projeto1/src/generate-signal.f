!     Gera series y_i = a1*cos(w1*t_i) + a2*sin(w2*t_i)
!     t_i = i * dt, i = 1,..., N
!     Usadadas para todas tarefas seguintes.
      parameter(N = 400)
      parameter(pi = acos(-1e0))
      dimension Ns(1:4)
      parameter(Ns = (/50, 100, 200, 400/))

      open(10, file="output-signal1.dat")
      open(20, file="output-signal2.dat")
      open(30, file="output-signal3.dat")
      open(40, file="output-signal4.dat")
      open(50, file="output-signal5.dat")
      open(60, file="output-signal6.dat")
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
         write(10, *)  ti1, a11*cos(w1*ti1) + a21*sin(w21*ti1) 
         write(20, *)  ti1, a12*cos(w1*ti1) + a22*sin(w21*ti1) 
         write(30, *)  ti2, a11*cos(w1*ti2) + a21*sin(w22*ti2) 
         write(40, *)  ti2, a12*cos(w1*ti2) + a22*sin(w22*ti2) 
         write(50, *)  ti1, a11*cos(w1*ti1) + a21*sin(1.4e0*pi*ti1) 
         write(60, *)  ti1, a11*cos(4.2*pi*ti1) + a21*sin(1.4e0*pi*ti1) 
      end do
      close(10)
      close(20)
      close(30)
      close(40)
      close(50)
      close(60)

      ! Gera os sinais para avaliação do tempo de execução da transformada de Fourier
      ! gera sinal para Ns = 50, ...
      open(1, file="output-signal-n50.dat")
      open(2, file="output-signal-n100.dat")
      open(3, file="output-signal-n200.dat")
      open(4, file="output-signal-n400.dat")
      do k = 1, 4
         do i = 1, Ns(k)
            ti1 = i * dt1
            write(k, *)  ti1, a11*cos(w1*ti1) + a21*sin(w21*ti1) 
         end do
         close(k)
      end do
      end








