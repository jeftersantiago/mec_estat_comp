!     Gera estado inicial da cadeia.
!     Se config = 0 => C_0¹ = {0, ..., 0} 
!     Se config = 1 => C_0² = {1, ..., 1}
!     Se config qualquer outro valor => C_0³ = {b_1,..., b_L}
!     com b_i aleatorio.
      subroutine set_initial_state(C, config, L)
      implicit integer (c-c)
      dimension C(500)

      if(config == 0) then
         C(:) = 0
      else if (config == 1) then
         C(:) = 1
      else
         p = rand(iseed)
         do i = 1, L
            p = rand() * 2
!           k in [0, 1]
            k = int((p+1) / 2)
!            print *, k
            C(i) = k
         end do
      end if
      end subroutine

!     Popula o vetor rules de 8 posições
!     com valores 0 ou 1
!     a partir de um número inteiro
!     entre 0, 255
      subroutine rule_set(rules, N)
      implicit integer(r-r)
      dimension rules(8)
      M = N
!      print *, "N = ", N
!      print *, "M = ", M
      do i = 1, 8
         x = real(M)
         rules(i) = mod(M, 2)
         M = int(x/2.0)
      end do

!      do i = 1, 8
!         print *, rules(i)
!      end do

      end subroutine


      subroutine propagate(C, rules, L)
      implicit integer(c-c, r-r)
      dimension rules(8)
      ! C_{t}
      dimension C(500)
      ! C_{t+1}
      dimension C_tmp(500)

      do i = 2, L-1
         C_tmp(i) = rules(4*C(i-1)+2*C(i)+C(i+1)+1)
      end do

      C_tmp(1) = rules(4*C(L)+2*C(1)+C(2)+1)
      C_tmp(L) = rules(4*C(L-1)+2*C(L)+C(1)+1)

      C = C_tmp

      end subroutine

      
      ! Max size of chain; L = 500
      subroutine DCA(rule_number, N_iter, L, init_state, f_name)
      implicit integer(f-f, c-c, r-r)
      dimension rules(8)
      dimension C(500)

!      print *, "rule_number = ", rule_number
      call set_initial_state(C, init_state, L)

      write(f_name, *) (C(j), j = 1, L)

      call rule_set(rules, rule_number)

      do i = 1, N_iter
         write(f_name, *) (C(j), j = 1, L)
         call propagate(C, rules, L)
      end do
      end subroutine DCA

      ! Max size of chain; L = 500
      subroutine DCA_position(rule_number, N_iter, L, pos, f_name)
      implicit integer(f-f, c-c, r-r, p-p)
      dimension rules(8)
      dimension C(500)

!      print *, "rule_number = ", rule_number
      call set_initial_state(C, 0, L)
      C(pos) = 1

      write(f_name, *) (C(j), j = 1, L)

      call rule_set(rules, rule_number)

      do i = 1, N_iter
         write(f_name, *) (C(j), j = 1, L)
         call propagate(C, rules, L)
      end do
      end subroutine DCA_position
