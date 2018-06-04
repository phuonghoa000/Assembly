	.data
arr:	.word 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
str1:	.asciiz "Nhap ngay (DAY): "
str2: 	.asciiz "Nhap thang (MONTH): "
str3:	.asciiz "Nhap nam (YEAR >= 1900): "
str4:	.asciiz "Khong hop le, moi ban nhap lai!\n"
str5:	.asciiz "--------------- Ban hay chon 1 trong cac thao tac duoi day ----------------\n     1. Xuat chuoi TIME theo dinh dang DD/MM/YYYY\n"
str6:	.asciiz "     2. Chuyen doi chuoi TIME thanh mot trong cac dinh dang sau va xuat ra:\n          A. MM/DD/YYYY\n          B. Month DD, YYYY\n          C. DD Month, YYYY\n"
str7:	.asciiz "     3. Cho biet ngay vua nhap la ngay thu may trong tuan\n     4. Kiem tra nam trong chuoi TIME co phai la nam nhuan khong\n"
str8:	.asciiz "     5. Cho biet khoang thoi gian giua chuoi TIME_1 va chuoi TIME_2\n     6. Cho biet hai nam nhuan gan nhat voi nam trong chuoi TIME\n     7. Thoat\n"
str9:	.asciiz "---------------------------------------------------------------------------\n"
str10:	.asciiz "Khong co thao tac nay, moi ban nhap lai!\n"
str11:	.asciiz "Chon dinh dang (A, B hoac C): "
str12:	.asciiz "Khong co dinh dang nay, moi ban nhap lai!\n"
str13:	.asciiz " ngay.\n"
strT1:	.asciiz "Nhap chuoi TIME_1 (DD/MM/YYYY)(YEAR >= 1900): "
strT2:	.asciiz "Nhap chuoi TIME_2 (DD/MM/YYYY)(YEAR >= 1900): "
strLY:	.asciiz "Nam trong chuoi TIME la nam nhuan.\n"
strNLY:	.asciiz "Nam trong chuoi TIME khong phai la nam nhuan.\n"
str2LY:	.asciiz "Hai nam nhuan lien ke la "
strVa:	.asciiz " va "
strCh:	.asciiz "Lua chon: "
strRe:	.asciiz "Ket qua: "
strM1:	.asciiz "January"
strM2:	.asciiz "February"
strM3:	.asciiz "March"
strM4:	.asciiz "April"
strM5:	.asciiz "May"
strM6:	.asciiz "June"
strM7:	.asciiz "July"
strM8:	.asciiz "August"
strM9:	.asciiz "September"
strM10:	.asciiz "October"
strM11:	.asciiz "November"
strM12:	.asciiz "December"
strD1:	.asciiz "Sunday\n"
strD2:	.asciiz "Monday\n"
strD3:	.asciiz "Tuesday\n"
strD4:	.asciiz "Wednesday\n"
strD5:	.asciiz "Thursday\n"
strD6:	.asciiz "Friday\n"
strD7:	.asciiz "Saturday\n"
char:	.space 4
time:	.space 14
time_1:	.space 14
time_2:	.space 14
	.text
	.globl main
main:

# Nhap ngay thang nam
loop_input:
	jal input		# Goi ham input de nhap cac gia tri ngay, thang, nam
	add $a0, $s2, $zero	# $a0: gia tri nam nhap tu ban phim
	jal checkYear		# Kiem tra tinh hop le cua nam nhap vao
	beq $v0, $zero, next_input   # Neu nam khong hop le, nhay toi nhan next_input
	add $a0, $s1, $zero	# $a0: gia tri thang nhap tu ban phim
	jal checkMonth		# Neu nam hop le, kiem tra tinh hop le cua thang nhap vao
	beq $v0, $zero, next_input   # Neu thang khong hop le, nhay toi nhan next_input
	add $a0, $s0, $zero	# $a0: ngay
	add $a1, $s1, $zero	# $a1: thang
	add $a2, $s2, $zero	# $a2: nam
	jal checkDay		# Neu thang hop le, kiem tra tinh hop le cua ngay nhap vao
	beq $v0, $zero, next_input   # Neu ngay khong hop le, nhay toi nhan next_input
	j end_input		# Neu du lieu da hop le, nhay toi nhan end_input de thuc hien thao tac tiep theo

next_input:
	# Xuat thong bao du lieu nhap khong hop le
	la $a0, str4
	addi $v0, $zero, 4
	syscall
	# Quay lai thao tac nhap va kiem tra tinh hop le cua ngay, thang, nam
	j loop_input

end_input:
	# Luu y: $s0: ngay, $s1: thang, $s2: nam
	la $s3, time	# $s3: dia chi chuoi time

	# Xuat menu chuong trình
	la $a0, str5
	addi $v0, $zero, 4
	syscall

	la $a0, str6
	addi $v0, $zero, 4
	syscall

	la $a0, str7
	addi $v0, $zero, 4
	syscall

	la $a0, str8
	addi $v0, $zero, 4
	syscall
	
	la $a0, str9
	addi $v0, $zero, 4
	syscall

choice:
	# Cho nguoi dung chon lua thao tac
	la $a0, strCh
	addi $v0, $zero, 4
	syscall

	# Nhap thao tac (1->7)
	addi $v0, $zero, 5
	syscall
	add $s4, $v0, $zero

	# Lenh switch...case... kiem tra thao tac can thuc hien
	addi $t0, $zero, 1
	sub $s4 $s4, $t0
	bne $s4, $zero, next_label_2 # Neu khong phai thao tac 1, nhay toi thao tac 2
	# Neu thao tac la 1, truyen du lieu vao cac doi so dau vao ($a0, $a1, $a2, $a3)
	add $a0, $s0, $zero
	add $a1, $s1, $zero
	add $a2, $s2, $zero
	add $a3, $s3, $zero
	j label_1 # Nhay toi label_1 de thuc hien thao tac 1

next_label_2:
	sub $s4, $s4, $t0
	bne $s4, $zero, next_label_3 # Neu khong phai thao tac 2, nhay toi thao tac 3
	# Neu thao tac la 2, goi ham date de tao chuoi time
	add $a0, $s0, $zero
	add $a1, $s1, $zero
	add $a2, $s2, $zero
	add $a3, $s3, $zero
	jal date
	# Truyen du lieu vao doi so dau vao ($a0: dia chi chuoi time)
	add $a0, $v0, $zero
	j label_2 # Nhay toi label_2 de thuc hien thao tac 2

next_label_3:
	sub $s4, $s4, $t0
	bne $s4, $zero, next_label_4 # Neu khong phai thao tac 3, nhay toi thao tac 4
	# Neu thao tac la 3, goi ham date de tao chuoi time
	add $a0, $s0, $zero
	add $a1, $s1, $zero
	add $a2, $s2, $zero
	add $a3, $s3, $zero
	jal date
	# Truyen du lieu vao doi so dau vao ($a0: dia chi chuoi time)
	add $a0, $v0, $zero
	j label_3 # Nhay toi label_3 de thuc hien thao tac 3

next_label_4:
	sub $s4, $s4, $t0
	bne $s4, $zero, next_label_5 # Neu khong phai thao tac 4, nhay toi thao tac 5
	# Neu thao tac la 4, goi ham date de tao chuoi time
	add $a0, $s0, $zero
	add $a1, $s1, $zero
	add $a2, $s2, $zero
	add $a3, $s3, $zero
	jal date
	# Truyen du lieu vao doi so dau vao ($a0: dia chi chuoi time)
	add $a0, $v0, $zero
	j label_4 # Nhay toi label_4 de thuc hien thao tac 4

next_label_5:
	sub $s4, $s4, $t0
	bne $s4, $zero, next_label_6 # Neu khong phai thao tac 5, nhay toi thao tac 6
	# Neu thao tac la 5, truyen du lieu vao cac doi so dau vao
	la $a0, time_1 # $a0: dia chi chuoi time_1
	la $a1, time_2 # $a1: dia chi chuoi time_2
	j label_5 # Nhay toi label_5 de thuc hien thao tac 5

next_label_6:
	sub $s4, $s4, $t0
	bne $s4, $zero, next_label_7 # Neu khong phai thao tac 6, nhay toi thao tac 7
	# Neu thao tac la 6, goi ham date de tao chuoi time
	add $a0, $s0, $zero
	add $a1, $s1, $zero
	add $a2, $s2, $zero
	add $a3, $s3, $zero
	jal date
	# Truyen du lieu vao doi so dau vao ($a0: dia chi chuoi time)
	add $a0, $v0, $zero
	j label_6 # Nhay toi label_6 de thuc hien thao tac 6

next_label_7:
	sub $s4, $s4, $t0
	bne $s4, $zero, next # Neu khong phai thao tac 7, nhay toi nhan next
	# Neu thao tac la 7, nhay toi nhan exit, ket thuc chuong trinh
	j exit

next:
	# Neu thao tac ngoai (1->7), thong bao cho nguoi dung nhap lai
	la $a0, str10
	addi $v0, $zero, 4
	syscall
	# Nhay toi nhan choice de nguoi dung nhap lai thao tac
	j choice

#---------------------------------------------------------------------------------------
#----------Ham thuc hien thao tac 1: Xuat chuoi TIME theo dinh dang DD/MM/YYYY----------
# void label_1(int day, int month, int year, char* time)
# $a0: day, $a1: month, $a2: year, $a3: dia chi chuoi time
label_1:
	jal date   # Goi ham date, tao chuoi time theo dinh dang DD/MM/YYYY
	add $t0, $v0, $zero # Luu dia chi chuoi time vao bien tam $t0

	# Xuat chuoi "Ket qua: " ra man hinh
	la $a0, strRe
	addi $v0, $zero, 4
	syscall
	
	# Xuat chuoi time ra man hinh
	add $a0, $t0, $zero
	addi $v0, $zero, 4
	syscall

	# In ky tu xuong dong (endline)
	la $a0, 10
	addi $v0, $zero, 11
	syscall

	# Nhay toi nhan choice de nguoi dung chon thao tac tiep theo
	j choice

#-------------------------------------------------------------------------------------------------
#----------Ham thuc hien thao tac 2: Chuyen doi dinh dang chuoi TIME va xuat ra man hinh----------
# void label_2(char* time)
# $a0: dia chi chuoi time
label_2:
	addi $sp, $sp, 8 # Xin 8 bytes tu stack
	sw $s0, 0($sp)   # L?u du lieu hien tai cua $s0 vao stack
			 # $s0 sau do duoc dung nhu bien cuc bo cua ham  
	sw $a0, 4($sp)	 # Luu dia chi chuoi time vao stack

# Cho nguoi dung lua chon dinh dang can chuyen doi
choice_2:
	# Xuat chuoi thong bao cho nguoi dung lua chon dinh dang
	la $a0, str11
	addi $v0, $zero, 4
	syscall

	# Nguoi dung nhap lua chon dinh dang
	la $a0, char
	addi $a1, $zero, 4
	addi $v0, $zero, 8
	syscall

	# Kiem tra tinh hop le cua dinh dang vua nhap
	la $a0, char
	jal strlen
	addi $s0, $zero, 1 
	beq $v0, $s0, jump_choice # Neu nguoi dung nhap vao chi 1 ky tu
				  # Nhay toi nhan jump_choice de kiem tra ky tu do
	j call_back  # Neu nguoi dung nhap nhieu hon 1 ky tu (khong tinh ky tu endline)
		     # thi du lieu nhap khong hop le, nhay toi nhan call_back
	
# Kiem tra ky tu nhap vao de lua chon dinh dang
jump_choice:
	la $a0, char
	lb $a1, 0($a0)
	# Neu ky tu nhap vao la 'a', 'A', 'b', 'B', 'c', 'C' thi nhay toi nhan next_2 de thuc hien thao tac 2
	# Neu la cac ky tu khac, du lieu nhap khong hop le
	beq $a1, 'a', next_2
	beq $a1, 'A', next_2
	beq $a1, 'b', next_2
	beq $a1, 'B', next_2
	beq $a1, 'c', next_2
	beq $a1, 'C', next_2

# Truong hop du lieu nhap khong hop le
call_back:
	# Xuat thong bao du lieu nhap khong hop le cho nguoi dung biet
	la $a0, str12
	addi $v0, $zero, 4
	syscall
	
	# Nhay toi nhan choice_2 de nguoi dung nhap lai lua chon dinh dang cho thao tac 2
	j choice_2

# Truong hop du lieu nhap hop le
next_2:
	# Goi ham convert de chuyen doi dinh dang chuoi time
	lw $a0, 4($sp)
	jal convert
	add $t0, $v0, $zero # Luu dia chi chuoi time vao bien tam $t0

	# Xuat chuoi "Ket qua: " ra man hinh
	la $a0, strRe
	addi $v0, $zero, 4
	syscall

	# Xuat chuoi time ra man hinh
	add $a0, $t0, $zero
	addi $v0, $zero, 4
	syscall

	# In ky tu xuong dong (endline)
	la $a0, 10
	addi $v0, $zero, 11
	syscall

	lw $s0, 0($sp) # Tra lai gia tri ban dau cua $s0 truoc khi goi ham
	addi $sp, $sp, 8 # Tra lai 8 bytes da muon tu stack

	# Nhay toi nhan choice de nguoi dung chon thao tac tiep theo
	j choice
	
#----------------------------------------------------------------------------------
#----------Ham thuc hien thao tac 3: Tim thu cua ngay va xuat ra man hinh----------
# void label_3(char* time)
# $a0: dia chi chuoi time
label_3:
	# Goi ham weekday de tim thu cua ngay trong chuoi time
	jal weekday
	add $t0, $v0, $zero

	# Xuat chuoi "Ket qua: " ra man hinh
	la $a0, strRe
	addi $v0, $zero, 4
	syscall

	# Xuat chuoi thu can tim ra man hinh
	add $a0, $t0, $zero
	addi $v0, $zero, 4
	syscall

	# Nhay toi nhan choice de nguoi dung chon thao tac tiep theo
	j choice

#----------------------------------------------------------------------------------------------------------------------------------
#----------Ham thuc hien thao tac 4: Cho biet nam trong chuoi TIME co phai la nam nhuan khong va xuat ket qua ra man hinh----------
# void label_4(char* time)
# $a0: dia chi chuoi time
label_4:
	# Goi ham kiem tra nam trong chuoi time co nhuan khong
	jal leapYear

	beq $v0, $zero, not_LY 	# Neu nam khong nhuan, nhay toi nhan not_LY
	la $t0, strLY # Neu nam nhuan, tai dia chi chuoi thong bao nam nhuan vao $t0
	j next_4 

not_LY:
	la $t0, strNLY # Neu nam khong nhuan, tai dia chi chuoi thong bao nam khong nhuan vao $t0

next_4:
	# Xuat chuoi "Ket qua: " ra man hinh
	la $a0, strRe
	addi $v0, $zero, 4
	syscall
	
	# Xuat thong bao nam nhuan (hoac khong nhuan) ra man hinh
	add $a0, $t0, $zero
	addi $v0, $zero, 4
	syscall	

	# Nhay toi nhan choice de nguoi dung chon thao tac tiep theo
	j choice

#-------------------------------------------------------------------------------------------------------------------------
#----------Ham thuc hien thao tac 5: Tim khoang cach giua hai chuoi TIME_1 va TIME_2 va xuat ket qua ra man hinh----------
# (khoang cach giua hai chuoi tinh bang don vi ngay)
# VD: TIME_1: 01/01/2000, TIME_2: 01/01/2001 --> ket qua: 366 ngay.
# void label_5(char* time_1, char* time_2)
# $a0: dia chi chuoi time_1, $a1: dia chi chuoi time_2
label_5:
	addi $sp, $sp, -8 # Muon 8 bytes tu stack
	sw $a0, 0($sp)	  # Luu dia chi chuoi time_1 vao stack
	sw $a1, 4($sp)	  # Luu dia chi chuoi time_2 vao stack

input_time_1:
	# Xuat thong bao nhap chuoi time_1
	la $a0, strT1
	addi $v0, $zero, 4
	syscall

	# Nhap chuoi time_1
	lw $a0, 0($sp)
	addi $v0, $zero, 8
	addi $a1, $zero, 14
	syscall
	
	# Kiem tra tinh hop le cua chuoi time_1
	lw $a0, 0($sp)
	jal checkTime
	bne $v0, $zero, input_time_2 # Neu chuoi time_1 hop le, nhay den nhan input_time_2 de nhap chuoi time_2
	
	# Neu chuoi time_1 khong hop le, xuat thong bao khong hop le
	la $a0, str4
	addi $v0, $zero, 4
	syscall
	j input_time_1 # Nhay toi nhan input_time_1 de nhap lai chuoi time_1

input_time_2:
	# Xuat thong bao nhap chuoi time_2
	la $a0, strT2
	addi $v0, $zero, 4
	syscall

	# Nhap chuoi time_2
	lw $a0, 4($sp)
	addi $v0, $zero, 8
	addi $a1, $zero, 14
	syscall

	# Kiem tra tinh hop le cua chuoi time_2
	lw $a0, 4($sp)
	jal checkTime
	bne $v0, $zero, next_findDay # Neu chuoi time_2 hop le, nhay toi nhan next_findDay
	
	# Neu chuoi time_2 khong hop le, xuat thong bao khong hop le
	la $a0, str4
	addi $v0, $zero, 4
	syscall
	j input_time_2 # Nhay toi nhan input_time_2 de nhap lai chuoi time_2

next_findDay:
	# Goi ham findDay de tim khoang cach giua hai chuoi time_1 va time_2
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	jal findDay
	add $t0, $v0, $zero
	
	# Xuat chuoi "Ket qua: " ra man hinh
	la $a0, strRe
	addi $v0, $zero, 4
	syscall	

	# Xuat ket qua tim duoc ra man hinh
	add $a0, $t0, $zero
	addi $v0, $zero, 1
	syscall

	la $a0, str13
	addi $v0, $zero, 4
	syscall

	addi $sp, $sp, 8 # Tra lai 8 bytes da muon tu stack

	# Nhay toi nhan choice de nguoi dung chon thao tac tiep theo
	j choice

#-----------------------------------------------------------------------------------------------------------------------------
#----------Ham thuc hien thao tac 6: Tim hai nam nhuan gan nhat voi nam trong chuoi TIME va xuat ket qua ra man hinh----------
# void label_6(char* time)
# $a0: dia chi chuoi time
label_6:
	addi $sp, $sp, -16 # Muon 16 bytes tu stack
	# Luu $s0, $s1, $s2, $a0 vao stack
	# $s0, $s1, $s2: duoc dung nhu bien cuc bo trong ham
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $a0, 12($sp)

	# Lay nam tu chuoi time
	jal year
	# Chia nam cho 4 lay du
	addi $s0, $zero, 4
	div $v0, $s0
	mfhi $t0
	# Tim nam dung sau gan voi nam trong chuoi time nhat va chia het cho 4
	sub $s1, $v0, $t0
	addi $s1, $s1, 4
	# Goi ham date de tao chuoi 10/10/YYYY (voi Y la gia tri nam luu trong $s1)
	addi $a0, $zero, 10
	addi $a1, $zero, 10
	add $a2, $s1, $zero
	lw $a3, 12($sp)
	jal date
	# Kiem tra nam trong chuoi time (tuc gia tri $s1) co phai la nam nhuan khong
	add $a0, $v0, $zero
	jal leapYear
	# Neu nam nhuan, nhay toi nhan next_6
	bne $v0, $zero, next_6
	addi $s1, $s1, 4 # Neu nam khong nhuan, tang $s1 them 4 don vi (gia tri trong $s1 luc nay chinh la nam nhuan)

next_6:
	# Gan $s2 la 4 nam sau nam trong $s1
	addi $s2, $s1, 4
	# Goi ham date tao chuoi 10/10/YYYY (Y la gia tri nam luu trong $s2)
	addi $a0, $zero, 10
	addi $a1, $zero, 10
	add $a2, $s2, $zero
	lw $a3, 12($sp)
	jal date
	# Kiem tra nam trong chuoi time (tuc gia tri $s2) co phai la nam nhuan khong
	add $a0, $v0, $zero
	jal leapYear
	# Neu nam nhuan, nhay toi nhan out_6 de xuat ket qua tim duoc ra man hinh
	bne $v0, $zero, out_6
	addi $s2, $s2, 4 # Neu nam khong nhuan, tang $s2 them 4 don vi (gia tri trong $s2 luc nay chinh la nam nhuan)
	
out_6:
	# Xuat ket qua tim duoc ra man hinh
	la $a0, strRe
	addi $v0, $zero, 4
	syscall

	la $a0, str2LY
	addi $v0, $zero, 4
	syscall

	add $a0, $s1, $zero
	addi $v0, $zero, 1
	syscall

	la $a0, strVa
	addi $v0, $zero, 4
	syscall

	add $a0, $s2, $zero
	addi $v0, $zero, 1
	syscall

	addi $a0, $zero, '.'
	addi $v0, $zero, 11
	syscall

	# In ky tu xuong dong (endline)
	addi $a0, $zero, 10
	addi $v0, $zero, 11
	syscall

	# Tra lai gia tri ban dau cua $s0, $s1, $s2 truoc khi goi ham
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addi $sp, $sp, 16 # Tra lai 16 bytes da muon tu stack

	# Nhay toi nhan choice de nguoi dung chon thao tac tiep theo
	j choice

#---------------------------------------------------------
#----------Ham nhap cac gia tri ngay, thang, nam----------
# void input(int &day, int &month, int &year)
# $s0: day, $s1: month, $s2: year
input:
	# Nhap ngay
	la $a0, str1
	addi $v0, $zero, 4
	syscall

	addi $v0, $zero, 5
	syscall
	add $s0, $v0, $zero

	# Nhap thang
	la $a0, str2
	addi $v0, $zero, 4
	syscall
	
	addi $v0, $zero, 5
	syscall
	add $s1, $v0, $zero

	# Nhap nam
	la $a0, str3
	addi $v0, $zero, 4
	syscall

	addi $v0, $zero, 5
	syscall
	add $s2, $v0, $zero
	
	jr $ra   # Nhay den doan lenh ngay sau khi goi ham input

#-------------------------------------------------------------
#----------Ham kiem tra tinh hop le cua du lieu ngay----------
# bool checkDay(int day, int month, int year)
# $a0: day, $a1: month, $a2: year, $v0: 1 (neu ngay (day) hop le), 0 (neu ngay (day) khong hop le)
checkDay:
	addi $sp, $sp, -12 # Muon 12 bytes tu stack
	sw $s0, 0($sp) 	   # Luu $s0 vao stack, $s0 trong ham duoc su dung nhu 1 bien cuc bo
	sw $a0, 4($sp) 	   # Luu gia tri ngay
	sw $ra, 8($sp)	   # Luu dia tri tra ve cua ham vao stack

	add $v0, $zero, $zero # Khoi tao gia tri tra ve cua ham la 0 (false)
	addi $s0, $zero, 1    
	blt $a0, $s0, end_checkDay  # So sanh, neu ngay nho hon 1 thi nhay toi nhan end_checkDay
	# Tai gia tri 28 vao phan tu thu 2 cua mang arr
	addi $t0, $zero, 28
	la $t1, arr
	sw $t0, 4($t1)
	# Kiem tra nam co nhuan khong
	add $a0, $a2, $zero
	jal leapYear_2
	beq $v0, $zero, next_checkDay # Neu nam khong nhuan, nhay toi nhan next_checkDay
	# Neu nam nhuan, tai gia tri 29 vao phan tu thu 2 cua mang arr
	addi $t0, $zero, 29
	la $t1, arr
	sw $t0, 4($t1)

next_checkDay:
	# Goi ham dayOfMonth lay so ngay cua thang
	# VD: thang 1: so ngay la 31
	#     thang 4: so ngay la 30
	add $a0, $a1, $zero
	jal dayOfMonth
	add $s0, $v0, $zero   # Luu so ngay cua thang vao $s0
	add $v0, $zero, $zero # Khoi tao lai gia tri zero cho $v0 (gia tri tra ve)
	# So sanh, neu ngay lon hon ngay cao nhat cua thang thi nhay toi nhan end_checkDay
	lw $a0, 4($sp)
	bgt $a0, $s0, end_checkDay
	addi $v0, $zero, 1    # Neu ngay hop le, gan gia tri tra ve ($v0) cho 1 (true)

end_checkDay:
	lw $s0, 0($sp) # Tra lai gia tri truoc khi goi ham cho $s0
	lw $ra, 8($sp) # Lay dia tri tra ve da luu trong stack
	addi $sp, $sp, 12     # Tra lai 12 bytes da muon tu stack
	jr $ra	       # Nhay den doan lenh ngay sau khi goi ham checkDay

#--------------------------------------------------------------
#----------Ham kiem tra tinh hop le cua du lieu thang----------
# bool checkMonth(int month)
# $a0: month, $v0: 1 (neu thang hop le), 0 (neu thang khong hop le)
checkMonth:
	addi $sp, $sp, -4 # Muon 4 bytes tu stack
	sw $s0, 0($sp)	  # Luu gia tri $s0 hien tai vao stack
			  # $s0 luc nay duoc su dung nhu bien cuc bo trong ham

	add $v0, $zero, $zero  # Khoi gan gia tri tra ve ($v0) bang 0 (false)
	addi $s0, $zero, 1
	blt $a0, $s0, end_checkMonth # Neu thang nho hon 1, nhay toi nhan end_checkMonth
	addi $s0, $zero, 12
	bgt $a0, $s0, end_checkMonth # Neu thang lon hon 12, nhay toi nhan end_checkMonth
	addi $v0, $v0, 1  # Neu thang hop le, gan gia tri tra ve ($v0) cho 1 (true)

end_checkMonth:
	lw $s0, 0($sp)    # Tra lai gia tri ban dau (truoc khi goi ham) cho $s0
	addi $sp, $sp, 4  # Tra lai 4 bytes da muon tu stack
	jr $ra		  # Nhay den doan lenh ngay sau khi goi ham checkMonth

#------------------------------------------------------------
#----------Ham kiem tra tinh hop le cua du lieu nam----------
# bool checkYear(int year)
# $a0: year, $v0: 1 (neu nam hop le), 0 (neu nam khong hop le (nho hon 1900))
checkYear:
	addi $sp, $sp, -4 # Muon 4 bytes tu stack
	sw $s0, 0($sp)	  # Luu gia tri $s0 hien tai vao stack
			  # $s0 luc nay duoc su dung nhu bien cuc bo trong ham

	add $v0, $zero, $zero	# Khoi gan gia tri tra ve ($v0) bang 0 (false)
	addi $s0, $zero, 1900
	blt $a0, $s0, end_checkYear # Neu thang nho hon 1900, nhay toi nhan end_checkMonth
	addi $v0, $v0, 1  # Neu nam hop le, gan gia tri tra ve ($v0) cho 1 (true)

end_checkYear:
	lw $s0, 0($sp)	  # Tra lai gia tri ban dau (truoc khi goi ham) cho $s0
	addi $sp, $sp, 4  # Tra lai 4 bytes da muon tu stack
	jr $ra		  # Nhay den doan lenh ngay sau khi goi ham checkMonth
	
#-------------------------------------------------------------------------------
#----------Ham dinh dang chuoi TIME theo dinh dang mac dinh DD/MM/YYYY----------
# char* date(int day, int month, int year, char* time)
# $a0: day, $a1: month, $a2: year, $a3: dia chi chuoi time, $v0: dia chi chuoi time
date:
	addi $sp, $sp, -16 # Muon 16 bytes tu stack
	sw $a0, 0($sp)	   # Luu ngay
	sw $a1, 4($sp)	   # Luu thang
	sw $a2, 8($sp)	   # Luu nam
	sw $ra, 12($sp)	   # Luu dia chi tra ve cua ham

	# Chuyen ngay sang kieu chuoi vao luu vao chuoi time
	add $a0, $a3, $zero
	lw $a1, 0($sp)
	jal convertIntToStr

	# Neu ngay lon hon 9 thi nhay toi nhan next_convertMonth
	# Neu khong, goi ham strInsert de chen ky tu '0' vao dau chuoi time
	addi $t0, $zero, 9
	lw $t1, 0($sp)
	bgt $t1, $t0, next_convertMonth
	add $a0, $a3, $zero
	add $a1, $zero, $zero
	addi $a2, $zero, '0'
	jal strInsert

next_convertMonth:
	# Chen ky tu '/' vao cuoi chuoi time hien tai
	addi $t0, $zero, '/'
	sb $t0, 2($a3)
	# Chuyen thang sang kieu chuoi va them vao cuoi chuoi time hien tai
	addi $a0, $a3, 3
	lw $a1, 4($sp)
	jal convertIntToStr

	# Neu thang lon hon 9 thi nhay toi nhan next_convertYear
	# Neu khong, goi ham strInsert de chen ky tu '0' vao truoc ky tu so chi thang trong chuoi time
	addi $t0, $zero, 9
	lw $t1, 4($sp)
	bgt $t1, $t0, next_convertYear
	add $a0, $a3, $zero
	addi $a1, $zero, 3
	addi $a2, $zero, '0'
	jal strInsert

next_convertYear:
	# Them ky tu '/' vao cuoi chuoi time (hien tai)
	addi $t0, $zero, '/'
	sb $t0, 5($a3)
	# Chuyen nam sang kieu chuoi va them vao cuoi chuoi time hien tai
	addi $a0, $a3, 6
	lw $a1, 8($sp)
	jal convertIntToStr

	lw $ra, 12($sp)	   # Lay dia chi tra ve cua ham tu stack
	addi $sp, $sp, 16  # Tra lai 16 bytes da muon tu stack
	add $v0, $a3, $zero  # $v0: dia chi chuoi time
	jr $ra		   # Nhay den doan lenh ngay sau khi goi ham date

#----------------------------------------------------------------
#----------Ham chuyen doi kieu dinh dang cua chuoi TIME----------
# char* convert(char* time, char type)
# $a0: dia chi chuoi time, $a1: type, $v0: dia chi chuoi tra ve
convert:
	addi $sp, $sp, -20  # Muon 20 bytes tu stack
	sw $s0, 0($sp)	    # Luu gia tri hien tai cua $s0 vao stack
	sw $s1, 4($sp)	    # Luu gia tri hien tai cua $s1 vao stack
	sw $s2, 8($sp)	    # Luu gia tri hien tai cua $s2 vao stack
	sw $a0, 12($sp)	    # Luu dia chi chuoi time vao stack
	sw $ra, 16($sp)	    # Luu dia chi tra ve cua ham convert vao stack
	
	# Sau day, $s0, $s1, $s2 se duoc dung nhu bien cuc bo cua ham convert	
	# Lay ngay tu chuoi time, luu vao $s0
	jal day
	add $s0, $v0, $zero	
	# Lay thang tu chuoi time, luu vao $s1
	lw $a0, 12($sp)
	jal month
	add $s1, $v0, $zero
	# Lay nam tu chuoi time, luu vao $s2
	lw $a0, 12($sp)
	jal year
	add $s2, $v0, $zero
	# Lenh if... kiem tra lua chon de chuyen doi dinh dang thich hop cho chuoi time
	beq $a1, 'b', convert_B
	beq $a1, 'B', convert_B
	beq $a1, 'c', convert_C
	beq $a1, 'C', convert_C

# Chuyen chuoi TIME thanh dinh dang MM/DD/YYYY
convert_A:
	# Chuyen gia tri thang ($s1) sang dang chuoi va luu vao chuoi time
	lw $a0, 12($sp)
	add $a1, $s1, $zero
	jal convertIntToStr
	
	# Neu thang lon hon 9, nhay toi nhan next_convertDay_A
	# Nguoc lai, chen ky tu '0' vao dau chuoi time
	addi $t0, $zero, 9
	add $t1, $s1, $zero
	bgt $t1, $t0, next_convertDay_A
	lw $a0, 12($sp)
	add $a1, $zero, $zero
	addi $a2, $zero, '0'
	jal strInsert

next_convertDay_A:
	# Chen ky tu '/' vao cuoi chuoi time hien tai
	addi $t0, $zero, '/'
	lw $t1, 12($sp)
	sb $t0, 2($t1)
	# Chuyen gia tri ngay ($s0) sang dang chuoi và them vao cuoi chuoi time
	lw $a0, 12($sp)
	addi $a0, $a0, 3
	add $a1, $s0, $zero
	jal convertIntToStr
	# Neu ngay lon hon 9, nhay toi nhan next_convertYear_A
	# Nguoc lai, chen ky tu '0' vao truoc ky tu chi ngay trong chuoi time
	addi $t0, $zero, 9
	add $t1, $s0, $zero
	bgt $t1, $t0, next_convertYear_A
	lw $a0, 12($sp)
	addi $a1, $zero, 3
	addi $a2, $zero, '0'
	jal strInsert

next_convertYear_A:
	# Chen ky tu '/' vao cuoi chuoi time
	addi $t0, $zero, '/'
	lw $t1, 12($sp)
	sb $t0, 5($t1)
	# Chuyen gia tri nam ($t2) sang dang chuoi va them vao cuoi chuoi time
	lw $a0, 12($sp)
	addi $a0, $a0, 6
	add $a1, $s2, $zero
	jal convertIntToStr
	# Nhay toi nhan end_convert sau khi chuyen doi dinh dang chuoi time hoan thanh
	j end_convert

# Chuyen chuoi TIME thanh dinh dang Month DD, YYYY
convert_B:
	# Goi ham choiceMonth de lay dia chi chuoi thang tuong ung voi gia tri thang ($s1)
	add $a0, $s1, $zero
	jal choiceMonth
	# Goi ham strcpy de copy chuoi thang vao chuoi time
	add $a1, $v0, $zero
	lw $a0, 12($sp)
	jal strcpy
	# Them ky tu khoang trang ' ' vao cuoi chuoi time hien tai
	add $a0, $v0, $zero
	jal strlen
	lw $a0, 12($sp)
	add $a0, $a0, $v0
	addi $t0, $zero, ' '
	sb $t0, 0($a0)
	# Neu ngay lon hon 9 thi nhay toi nhan next_convertDay_B
	# Nguoc lai, them ky tu '0' vao cuoi chuoi time hien tai
	addi $a0, $a0, 1
	addi $t0, $zero, 9
	bgt $s0, $t0, next_convertDay_B
	addi $t0, $zero, '0'
	sb $t0, 0($a0)
	addi $a0, $a0, 1

next_convertDay_B:
	# Chuyen gia tri ngay ($s0) sang dang chuoi va them vao cuoi chuoi time hien tai
	add $a1, $s0, $zero
	jal convertIntToStr
	# Them lan luot ky tu ',' va ky tu khoang trang ' ' vao cuoi chuoi time hien tai
	lw $a0, 12($sp)
	jal strlen
	lw $a0, 12($sp)
	add $a0, $a0, $v0
	addi $t0, $zero, ','
	sb $t0, 0($a0)
	addi $t0, $zero, ' '
	sb $t0, 1($a0)
	# Chuyen gia tri nam ($s2) sang dang chuoi va them vao cuoi chuoi time hien tai
	addi $a0, $a0, 2
	add $a1, $s2, $zero
	jal convertIntToStr
	# Nhay toi nhan end_convert sau khi chuyen doi dinh dang chuoi time hoan thanh
	j end_convert

# Chuyen chuoi TIME thanh dinh dang DD Month, YYYY
convert_C:
	# Chuyen gia tri ngay ($s0) sang dang chuoi va luu vao chuoi time
	lw $a0, 12($sp)
	add $a1, $s0, $zero
	jal convertIntToStr
	# Neu ngay lon hon 9 thi nhay toi nhan next_convertMonth_C
	# Nguoc lai, chen ky '0' vao dau chuoi time
	addi $t0, $zero, 9
	add $t1, $s0, $zero
	bgt $t1, $t0, next_convertMonth_C
	lw $a0, 12($sp)
	add $a1, $zero, $zero
	addi $a2, $zero, '0'
	jal strInsert

next_convertMonth_C:
	# Them ky tu khoang trang ' ' vao cuoi chuoi time hien tai
	lw $t0, 12($sp)
	addi $t0, $t0, 2
	addi $t1, $zero, ' '
	sb $t1, 0($t0)
	sb $zero, 1($t0)
	# Goi ham choiceMonth de lay dia chi chuoi thang tuong ung voi gia tri thang ($s1)
	add $a0, $s1, $zero
	jal choiceMonth
	# Cong chuoi thang vao cuoi chuoi time hien tai
	lw $a0, 12($sp)
	add $a1, $v0, $zero
	jal strAdd
	# Them lan luot ky tu ',' va ky tu khoang trang ' ' vao cuoi chuoi time hien tai
	lw $a0, 12($sp)
	jal strlen
	lw $a0, 12($sp)
	add $a0, $a0, $v0
	addi $t0, $zero, ','
	sb $t0, 0($a0)
	addi $t0, $zero, ' '
	sb $t0, 1($a0)
	# Chuyen gia tri nam ($s2) sang dang chuoi va them vao cuoi chuoi time hien tai
	addi $a0, $a0, 2
	add $a1, $s2, $zero
	jal convertIntToStr

end_convert:
	lw $s0, 0($sp)	   # Tra lai gia tri truoc khi goi ham cho $s0
	lw $s1, 4($sp)     # Tra lai gia tri truoc khi goi ham cho $s1
	lw $s2, 8($sp)     # Tra lai gia tri truoc khi goi ham cho $s2
	lw $v0, 12($sp)	   # Gan dia chi chuoi time cho gia tri tra ve $v0
	lw $ra, 16($sp)    # Lay dia chi tra ve cua ham convert tu stack
	addi $sp, $sp, 20  # Tra lai 20 bytes da muon tu stack
	jr $ra	# Nhay den doan lenh ngay sau khi goi ham convert

#-----------------------------------------------------------------
#----------Ham cho biet ngay trong chuoi TIME la thu may----------
# char* weekday(char* time)
# $a0: dia chia chuoi time, $v0: dia chi chuoi thu
weekday:
	addi $sp, $sp, -28 # Muon 28 bytes tu stack
	sw $s0, 0($sp)	   # Luu gia tri hien tai cua $s0 vao stack
	sw $s1, 4($sp)	   # Luu gia tri hien tai cua $s1 vao stack
	sw $s2, 8($sp)	   # Luu gia tri hien tai cua $s2 vao stack
	sw $s3, 12($sp)	   # Luu gia tri hien tai cua $s3 vao stack
	sw $s4, 16($sp)	   # Luu gia tri hien tai cua $s4 vao stack
	sw $a0, 20($sp)	   # Luu dia chi chuoi time vao stack
	sw $ra, 24($sp)	   # Luu dia chi tra ve cua ham weekday

	# Cac bien cuc bo cua ham
	# $s0: ngay, $s1: thang, $s2: nam
	# $s3: d + m + y + [y/4] + c
	# d = $s0, m = gia tri tra ve tu ham findValue
	# y = hai so cuoi cua nam, [y/4] = phan nguyen cua y/4
	# c = gia tri tra ve cua ham findValue_2 (lay hai so dau cua nam chia 4 lay du)
	# $s4: luu cac hang so can dung trong ham

	# Lay ngay tu chuoi time, luu vao $s0
	jal day
	add $s0, $v0, $zero
	add $s3, $s0, $zero # Gan $s3 = $s0 (tuc $s3 = d)
	# Lay thang tu chuoi time, luu vao $s1
	lw $a0, 20($sp)
	jal month
	add $s1, $v0, $zero
	# Lay nam tu chuoi time, luu vao $s2
	lw $a0, 20($sp)
	jal year
	add $s2, $v0, $zero
	# Kiem tra nam trong chuoi time co phai la nam nhuan hay khong
	lw $a0, 20($sp)
	jal leapYear
	# G?i ham findValue de lay so tuong ung voi thang va nam trong chuoi time
	add $a0, $s1, $zero # Tai gia tri thang ($s1) vao $a0
	add $a1, $v0, $zero # Tai gia tri 1 (nam nhuan) hoac 0 (nam khong nhuan) vao $a1
	jal findValue
	add $s3, $s3, $v0   # tuong ung $s3 = d + m
	
	addi $s4, $zero, 100
	div $s2, $s4	    # Chi nam cho 100
	mfhi $t0   # Lay du
	add $s3, $s3, $t0   # Tuong ung $s3 = d + m + y
	mflo $t1   # Lay thuong
	addi $s4, $zero, 4
	div $t0, $s4	    # Tuong ung y/4
	mflo $t0	    # Lay phan nguyen cua y/4
	add $s3, $s3, $t0   # Tuong ung $s3 = d + m + y + [y/4]
	# Goi ham findValue_2 de tim c
	div $t1, $s4
	mflo $a0
	jal findValue_2
	add $s3, $s3, $v0   # Tuong ung $s3 = d + m + y + [y]4] + c
	# Chia $s3 cho 7 lay du roi goi ham choiceDay de tim thu tuong ung voi ngay trong chuoi time
	addi $s4, $zero, 7
	div $s3, $s4
	mfhi $a0
	jal choiceDay
	
	lw $s0, 0($sp)	  # Tra lai gia tri truoc khi goi ham cho $s0
	lw $s1, 4($sp)	  # Tra lai gia tri truoc khi goi ham cho $s1
	lw $s2, 8($sp)	  # Tra lai gia tri truoc khi goi ham cho $s2
	lw $s3, 12($sp)	  # Tra lai gia tri truoc khi goi ham cho $s3
	lw $s4, 16($sp)	  # Tra lai gia tri truoc khi goi ham cho $s4
	lw $ra, 24($sp)	  # Lay dia chi tra ve cua ham weekday tu stack
	addi $sp, $sp, 28 # Tra lai 28 bytes da muon tu stack
	jr $ra	# Nhay den doan lenh ngay sau khi goi ham weekday

#-------------------------------------------------------------------
#---------Ham kiem tra nam trong chuoi time co nhuan khong----------
# bool leapYear(char* time)
# $a0: dia chi chuoi time, $v0: 1 (neu nam nhuan), 0 (neu nam khong nhuan)
leapYear:
	addi $sp, $sp, -20  # Muon 20 bytes tu stack
	sw $s0, 0($sp)	    # Luu gia tri hien tai cua $s0 vao stack
	sw $s1, 4($sp)	    # Luu gia tri hien tai cua $s1 vao stack
	sw $s2, 8($sp)	    # Luu gia tri hien tai cua $s2 vao stack
	sw $s3, 12($sp)	    # Luu gia tri hien tai cua $s3 vao stack
	sw $ra, 16($sp)	    # Luu dia chi tra ve cua ham leapYear

	# Cac bien cuc bo cua ham
	# $s0: nam, $s1: 400, $s2: 4, $s3: 100

	# Lay gia tri nam tu chuoi time
	jal year
	add $s0, $v0, $zero
	# Gan gia tri cho cac bien cuc bo trong ham
	addi $s1, $zero, 400
	addi $s2, $zero, 4
	addi $s3, $zero, 100
	# Khoi gan $v0 = 0, tuc nam khong nhuan
	add $v0, $zero, $zero

	# Chia nam cho 400
	div $s0, $s1
	mfhi $t0 # Lay du
	beq $t0, $zero, yes # Neu du bang khong, thi nam nhuan, nhay toi nhan yes
	# Neu du khac khong, chia nam cho 4
	div $s0, $s2
	mfhi $t0 # Lay du
	bne $t0, $zero, end_leapYear # Neu du khac khong, nam khong nhuan, nhay toi nhan end_leapYear
	# Neu du bang khong (nam chia het cho 4), chia nam cho 100
	div $s0, $s3
	mfhi $t0 # Lay du
	beq $t0, $zero, end_leapYear # Neu du bang khong, nam khong nhuan, nhay toi nhan end_leapYear

# Nam nhuan, gan $v0 bang 1
yes:
	addi $v0, $zero, 1
	
end_leapYear:
	lw $s0, 0($sp)      # Tra lai gia tri truoc khi goi ham cho $s0
	lw $s1, 4($sp)	    # Tra lai gia tri truoc khi goi ham cho $s1
	lw $s2, 8($sp)	    # Tra lai gia tri truoc khi goi ham cho $s2
	lw $s3, 12($sp)	    # Tra lai gia tri truoc khi goi ham cho $s3
	lw $ra, 16($sp)	    # Lay dia tri tra ve cua ham leapYear tu stack
	addi $sp, $sp, 20   # Tra lai 20 bytes da muon tu stack
	jr $ra	# Nhay den doan lenh ngay sau khi goi ham leapYear

#----------------------------------------------------------------------------------------------------
#----------Ham tim khoang cach giua hai ngay (don vi: ngay) trong hai chuoi TIME_1 va TIME_2---------
# int findDay(char* time_1, char* time_2)
# $a0: dia chi chuoi time_1, $a1: dia chi chuoi time_2, $v0: so ngay
findDay:
	addi $sp, $sp, -44 # Muon 44 bytes tu stack
	sw $a0, 0($sp)	   # Luu dia chi chuoi time_1 vao stack
	sw $a1, 4($sp)	   # Luu dia chi chuoi time_2 vao stack
	sw $s0, 8($sp)	   # Luu gia tri hien tai cua $s0 vao stack
	sw $s1, 12($sp)	   # Luu gia tri hien tai cua $s1 vao stack
	sw $s2, 16($sp)    # Luu gia tri hien tai cua $s2 vao stack
	sw $s3, 20($sp)    # Luu gia tri hien tai cua $s3 vao stack
	sw $s4, 24($sp)    # Luu gia tri hien tai cua $s4 vao stack
	sw $s5, 28($sp)    # Luu gia tri hien tai cua $s5 vao stack
	sw $s6, 32($sp)    # Luu gia tri hien tai cua $s6 vao stack
	sw $s7, 36($sp)    # Luu gia tri hien tai cua $s7 vao stack
	sw $ra, 40($sp)	   # Luu dia chi tra ve cua ham findDay vao stack

	# Cac bien cuc bo cua ham
	# $s0: ngay, $s1: thang, $s2: nam (trong chuoi co thoi gian nho hon)
	# $s3: ngay, $s4: thang, $s5: nam (trong chuoi co thoi gian lon hon)
	# $s6: khoang cach giua hai chuoi (don vi: ngay)
	# $s7: gan bang 12

	# Goi ham so sanh hai ngay trong hai chuoi time_1 va time_2
	jal compareDate
	beq $v0, $zero, calcu_2 # Neu ngay trong chuoi time_1 lon hon ngay trong chuoi time_2, nhay toi nhan calcu_2
	addi $t0, $zero, 1
	beq $v0, $t0, calcu_1   # Neu ngay trong chuoi time_1 nho hon ngay trong chuoi time_2, nhay toi nhan calcu_1
	add $s6, $zero, $zero	# Khoi gan $s6 = 0
	j end_findDay	# Neu hai ngay trong hai chuoi bang nhau, nhay toi nhan end_findDay

# Truong hop ngay trong chuoi time_1 nho hon ngay trong chuoi time_2
calcu_1:
	# Lay ngay, thang, nam tu chuoi time_1 luu lan luot vao cac thanh ghi $s0, $s1, $s2
	lw $a0, 0($sp)
	jal day
	add $s0, $v0, $zero
	lw $a0, 0($sp)
	jal month
	add $s1, $v0, $zero
	lw $a0, 0($sp)
	jal year
	add $s2, $v0, $zero

	# Lay ngay, thang, nam tu chuoi time_2 luu lan luot vao cac thanh ghi $s3, $s4, $s5
	lw $a0, 4($sp)
	jal day
	add $s3, $v0, $zero
	lw $a0, 4($sp)
	jal month
	add $s4, $v0, $zero
	lw $a0, 4($sp)
	jal year
	add $s5, $v0, $zero	
	j calculate

# Truong hop ngay trong chuoi time_1 lon hon ngay trong chuoi time_2
calcu_2:
	# Lay ngay, thang, nam tu chuoi time_2 luu lan luot vao cac thanh ghi $s0, $s1, $s2
	lw $a0, 4($sp)
	jal day
	add $s0, $v0, $zero
	lw $a0, 4($sp)
	jal month
	add $s1, $v0, $zero
	lw $a0, 4($sp)
	jal year
	add $s2, $v0, $zero

	# Lay ngay, thang, nam tu chuoi time_1 luu lan luot vao cac thanh ghi $s3, $s4, $s5
	lw $a0, 0($sp)
	jal day
	add $s3, $v0, $zero
	lw $a0, 0($sp)
	jal month
	add $s4, $v0, $zero
	lw $a0, 0($sp)
	jal year
	add $s5, $v0, $zero	

# Tinh khoang cach giua hai chuoi time_1 va time_2
# Coi d1, m1, y1 la thoi gian nho hon
# Coi d2, m2, y2 la thoi gian lon hon
calculate:
	# Dat gia tri 28 vao phan tu thu 2 cua mang arr
	addi $t0, $zero, 28
	la $t1, arr
	sw $t0, 4($t1)
	# Tim hieu hai nam cua hai chuoi
	sub $t0, $s5, $s2
	bne $t0, $zero, dif_year # Neu hieu khac 0, tuc hai nam khac nhau, nhay toi nhan dif_year
	# Neu hieu bang 0, hai chuoi cung nam
	# Kiem tra nam trong hai chuoi co nhuan khong
	add $a0, $s2, $zero
	jal leapYear_2
	beq $v0, $zero, next_calcu_1 # Neu khong nhuan, nhay toi nhan next_calcu_1
	# Neu nam nhuan, dat gia tri 29 vao phan tu thu 2 cua mang arr
	addi $t0, $zero, 29
	la $t1, arr
	sw $t0, 4($t1)

next_calcu_1:
	sub $s6, $s3, $s0 # Tuong ung $s6 = d2 - d1
	subi $s4, $s4, 1  # $s4: thang lien truoc thang m2

# Tinh tong ngay tu 1/m1/y1 -> end/m2 - 1/y2 (o day: y1 = y2)
# end: la ngay cuoi cung cua thang lien truoc thang m2
# $s6 = $s6 + tong ngay tim duoc
loop_findSumOfDay_1:
	bgt $s1, $s4, end_findDay # Sau khi tim duoc tong so ngay, nhay toi nhan end_findDay
	add $a0, $s1, $zero
	jal dayOfMonth
	add $s6, $s6, $v0
	addi $s1, $s1, 1
	j loop_findSumOfDay_1

# Truong hop nam trong hai chuoi khac nhau
dif_year:
	# Kiem tra y1 co phai la nam nhuan
	add $a0, $s2, $zero
	jal leapYear_2
	beq $v0, $zero, next_calcu_2 # Neu y1 khong nhuan, nhay toi nhan next_calcu_2
	# Neu y1 nhuan, dat gia tri 29 vao mang arr
	addi $t0, $zero, 29
	la $t1, arr
	sw $t0, 4($t1)

# Tinh tong ngay tu d1 + 1/m1/y1 -> 31/12/y1
# tuc la bang tong ngay tu 1/m1/y1 -> 31/12/y1 tru di d1
next_calcu_2:
	sub $s6, $zero, $s0 # Gan $s6 = -d1
	addi $s7, $zero, 12 # Gan $s7 = 12

# Tinh tong ngay tu 1/m1/y1 -> 31/12/y1
# Gan $s6 = $s6 + tong ngay tim duoc
loop_findSumOfDay_2:
	bgt $s1, $s7, next_findSumOfDay_2 # Sau khi tim duoc tong so ngay can tim, nhay toi nhan next_findSumOfDay_2
	add $a0, $s1, $zero
	jal dayOfMonth
	add $s6, $s6, $v0
	addi $s1, $s1, 1
	j loop_findSumOfDay_2


next_findSumOfDay_2:
	# Dat gia tri 28 vao phan tu thu 2 cua mang arr
	addi $t0, $zero, 28
	la $t1, arr
	sw $t0, 4($t1)
	# Kiem tra nam y2 co nhuan khong
	add $a0, $s5, $zero
	jal leapYear_2
	beq $v0, $zero, next_calcu_3 # Neu y2 khong nhuan, nhay toi nhan next_label_3
	# Neu y2 nhuan, dat gia tri 29 vao phan tu thu 2 cua mang arr
	addi $t0, $zero, 29
	la $t1, arr
	sw $t0, 4($t1)

# Tim tong ngay tu 1/1/y2 -> d2/m2/y2
# tuc la tim tong cua d2 voi tong ngay tu 1/1/y2 toi end/m2 - 1/y2
# end: ngay cuoi cung cua thang lien truoc thang m2
# Gan $s6 = $s6 + tong ngay tim duoc
next_calcu_3:
	add $s6, $s6, $s3 # $s6 = $s6 + d2
	subi $s4, $s4, 1  # Gan $s4 cho thang lien truoc thang m2

# Tim tong ngay tu 1/1/y2 -> end/m2 - 1/y2
loop_findSumOfDay_3:
	beq $s4, $zero, next_calcu_4 # Sau khi tim duoc tong ngay va them vao $s6, nhay toi nhan next_calcu_4
	add $a0, $s4, $zero
	jal dayOfMonth
	add $s6, $s6, $v0
	subi $s4, $s4, 1
	j loop_findSumOfDay_3

next_calcu_4:
	addi $s2, $s2, 1 # Gan $s2 bang nam lien sau nam y1
	subi $s5, $s5, 1 # Gan $s5 bang nam lien truoc nam y2

# Tim tong ngay tu 1/1/y1 + 1 -> 31/12/y2 - 1	
loop_findSumOfDay_4:
	bgt $s2, $s5, end_findDay # Sau khi tinh xong tong ngay, nhay toi nhan end_findDay
	addi $s6, $s6, 365
	# Kiem tra nam dang tinh ngay co nhuan khong
	add $a0, $s2, $zero
	jal leapYear_2
	addi $s2, $s2, 1
	beq $v0, $zero, loop_findSumOfDay_4
	# Neu co, them vao $s6 them 1 ngay
	addi $s6, $s6, 1
	j loop_findSumOfDay_4

end_findDay:
	add $v0, $s6, $zero # Gan gia tri tra ve vao $v0 (tong so ngay tim duoc)
	lw $s0, 8($sp)	    # Tra lai gia tri truoc khi goi ham cho $s0
	lw $s1, 12($sp)	    # Tra lai gia tri truoc khi goi ham cho $s1
	lw $s2, 16($sp)	    # Tra lai gia tri truoc khi goi ham cho $s2
	lw $s3, 20($sp)	    # Tra lai gia tri truoc khi goi ham cho $s3
	lw $s4, 24($sp)	    # Tra lai gia tri truoc khi goi ham cho $s4
	lw $s5, 28($sp)	    # Tra lai gia tri truoc khi goi ham cho $s5
	lw $s6, 32($sp)     # Tra lai gia tri truoc khi goi ham cho $s6
	lw $s7, 36($sp)     # Tra lai gia tri truoc khi goi ham cho $s7
	lw $ra, 40($sp)     # Lay dia chi tra ve cua ham findDay tu stack
	addi $sp, $sp, 44   # Tra lai 44 bytes da muon tu stack
	jr $ra	# Nhay den doan lenh ngay sau khi goi ham leapYear

#-------------------------------------------------------
#----------Ham dem so chu so cua mot so nguyen----------
# int countDigit(int num)
# $a0: num, $v0: so chu so cua num (gia tri tra ve)
countDigit:
	add $v0, $zero, $zero  # Khoi gan so chu so la 0
	bne $a0, $zero, next_ctdigit # Neu num khac 0, nhay toi nhan next_ctdigit
	# Neu num  bang 0, gan $v0 = 1, nhay toi nhan end_ctdigit
	addi $v0, $v0, 1
	j end_ctdigit

next_ctdigit:
	addi $sp, $sp, -4 # Muon 4 bytes tu stack
	sw $s0, 0($sp)    # Luu gia tri hien tai cua $s0 vao stack 
	addi $s0, $zero, 10  # Gan $s0 = 10

# Dem so chu so cua num
loop_ctdigit:
	# Chia num lien tiep cho 10 cho den khi num = 0 thi dung lai
	# O moi lan chia (moi vong lap), them vao bien dem so chu so $v0 1 don vi
	beq $a0, $zero, end_loop_ctdigit
	div $a0, $s0
	mflo $a0
	addi $v0, $v0, 1
	j loop_ctdigit

end_loop_ctdigit:
	lw $s0, 0($sp)    # Tra lai gia tri truoc khi goi ham cho $s0
	addi $sp, $sp, 4  # Tra lai 4 bytes da muon tu stack

end_ctdigit:
	jr $ra  # Nhay den doan lenh ngay sau khi goi ham countDigit

#---------------------------------------------------------
#----------Ham chuyen so nguyen sang dang chuoi-----------
# char* convertIntToStr(char* str, int num)
# $a0: dia chi chuoi so nguyen num, $a1: num, $v0: dia chi chuoi tra ve
convertIntToStr:
	bne $a1, $zero, next_convert_itos # Neu num khac 0 thi nhay toi nhan next_convert_itos
	# Truong hop num = 0, thi them ky tu '0' vao dau chuoi str
	# gan ky tu '\0' vao vi tri lien sau ky tu '0' de ket thuc chuoi
	addi $t0, $zero, '0'
	sb $t0, 0($a0)
	sb $zero, 1($a0)
	add $v0, $a0, $zero
	jr $ra  # Nhay den doan lenh ngay sau khi goi ham convertIntToStr

next_convert_itos:
	addi $sp, $sp, -16 # Muon 16 bytes tu stack
	sw $a0, 0($sp)	   # Luu dia chi chuoi str vao stack
	sw $ra, 12($sp)    # Luu dia chi tra ve cua ham convertIntToStr vao stack
	# Dem so chu so cua num 
	add $a0, $a1, $zero
	jal countDigit

	lw $a0, 0($sp)     # Lay lai dia chi chuoi str tu stack, bo vao $a0
	sw $s0, 0($sp)	   # Luu gia tri hien tai cua $s0
	sw $s1, 4($sp)	   # Luu gia tri hien tai cua $s1
	sw $s2, 8($sp)	   # Luu gia tri hien tai cua $s2

	# $s0, $s1, $s2 luc nay duoc su dung nhu bien cuc bo cua ham
	add $s0, $v0, $zero  # $s0: so chu so cua num
	addi $s1, $zero, 10  # $s1: gan bang 10
	addi $s2, $zero, 1   # $s2: gan bang 1
	add $v0, $a0, $zero  # $v0: nhan gia tri tra ve la dia chi chuoi str

# Tim 10 ^ $s0, luu ket qua tim duoc vao $s2
loop_exp10:
	beq $s0, $zero, next_itos
	mult $s2, $s1
	mflo $s2
	subi $s0, $s0, 1
	j loop_exp10

# Chia $s2 cho 10, $s2 luc nay co gia tri nhu sau:
# VD: num = 11 -> $s2 = 10
#     num = 207 -> $s2 = 100
next_itos:
	div $s2, $s1
	mflo $s2

# Lay tung chu so cua num (tu trai sang), chuyen sang dang ky tu roi them vao chuoi str
loop_itos:
	beq $s2, $zero, end_itos
	div $a1, $s2
	mflo $t0     # Lay chu so trai nhat cua num hien tai
	mfhi $a1     # Gan num bang thuong cua phep chia num cho $s2
	div $s2, $s1 # Chia $s2 cho 10 
	mflo $s2     # Gan $s2 bang thuong nham giam $s2 di 10 lan
	addi $t0, $t0, '0'   # Chuyen chu so trai nhat cua num vua lay o tren sang dang ky tu
	sb $t0, 0($a0)       # Them vao cuoi chuoi str hien tai
	addi $a0, $a0, 1     # Load $a0 tro toi dia chi cua ky tu lien sau ky tu vua them vao chuoi str
	j loop_itos	     # Thuc hien lai vong lap

end_itos:
	sb $zero, 0($a0)     # Them ky tu ket thuc chuoi vao cuoi chuoi str
	lw $s0, 0($sp)	     # Tra lai gia tri truoc khi goi ham cho $s0
	lw $s1, 4($sp)	     # Tra lai gia tri truoc khi goi ham cho $s0
	lw $s2, 8($sp)	     # Tra lai gia tri truoc khi goi ham cho $s0 
	lw $ra, 12($sp)	     # Lay dia chi tra ve cua ham convertIntToStr tu stack
	addi $sp, $sp, 16    # Tra lai 16 bytes da muon tu stack
	jr $ra  # Nhay den doan lenh ngay sau khi goi ham countDigit

#-------------------------------------------------
#----------Ham strlen (tim do dai chuoi)----------
# int strlen(char* str)
# $a0: dia chi chuoi str, $v0: do dai chuoi (gia tri tra ve)
strlen:
	addi $sp, $sp, -4      # Muon 4 bytes tu stack
	sw $s0, 0($sp)	       # Luu gia tri hien tai cua $s0 vao stack
	addi $s0, $zero, 10    # $s0: ky tu xuong dong endline
	add $v0, $zero, $zero  # $v0: do dai chuoi (khoi gan bang 0)
	
loop_strlen:
	# Load tung ky tu cua chuoi, neu gap ky tu '\0' hoac endline thi ket thuc vong lap
	# O moi vong lap, them vao bien dem chieu dai chuoi 1 don vi
	lb $t0, ($a0)
	beq $t0, $zero, end_strlen
	beq $t0, $s0, end_strlen
	addi $a0, $a0, 1
	addi $v0, $v0, 1
	j loop_strlen

end_strlen:
	lw $s0, 0($sp)	       # Tra lai gia tri truoc khi goi ham cua $s0 
	addi $sp, $sp, 4       # Tra lai 4 bytes da muon tu stack
	jr $ra	# Nhay den doan lenh ngay sau khi goi ham strlen

#------------------------------------------------------------------------
#----------Ham chen mot ky tu vao mot vi tri xac dinh cua chuoi----------
# char* strInsert(char* str, int pos, char c)
# $a0: dia chi chuoi str, $a1: vi tri chen, $a2: ky tu c, $v0: dia chi chuoi str
strInsert:
	addi $sp, $sp, -8 # Khai bao kich thuoc stack can dung (8 bytes)
	sw $ra, 4($sp)	  # Cat dia chi quay ve cua ham strInsert vao stack
	sw $a0, 0($sp)	  # Cat dia chi chuoi str vao stack
	jal strlen	  # Nhay den ham strlen
	lw $a0, 0($sp)	  # Khoi phuc tham so thu nhat ($a0: dia chi chuoi str)
	lw $ra, 4($sp)	  # Khoi phuc dia chi quay ve cua thu tuc strInsert
	
	sw $s0, 4($sp)	  # Cat gia tri tai $s0 vao stack de dung $s0 lam bien cuc bo trong ham
	add $s0, $v0, $zero   # Luu gia tri tra ve tu ham strlen vao $s0
	add $v0, $a0, $zero   # $v0 nhan gia tri tra ve la dia chi chuoi str
	add $a0, $a0, $s0     # $a0: Dia chi cua ky tu ket thuc chuoi hoac ky tu endline

	addi $a0, $a0, 1  # $a0: Dia chi cua ky tu lien sau ky tu '\0' (hoac ky tu endline)
	sb $zero, ($a0)	  # Dat ky tu ket thuc chuoi '\0' tai vung nho ma $a0 dang giu dia chi

loop_insert:
	beq $s0, $a1, end_insert   # Kiem tra da toi vi tri can chen hay chua
	subi $a0, $a0, 1  # $a0: Dia chi cua ky tu lien truoc ky tu ma $a0 vua giu dia chi
	lb $t0, -1($a0)	  # $t0: Ky tu lien truoc ky tu ma $a0 dang giu dia chi
	sb $t0, ($a0)	  # Dat ky tu vua lay ($t0) tai vung nho ma $a0 dang giu dia chi
	subi $s0, $s0, 1
	j loop_insert

end_insert:
	subi $a0, $a0, 1  # $a0: Dia chi cua ky tu tai vi tri can chen
	sb $a2, ($a0)	  # Dat ky tu can chen ($a2) tai vung nho ma $a0 dang giu dia chi
	lw $s0, 4($sp)    # Khoi phuc gia tri ban dau cua $s0 (gia tri truoc khi goi ham)
	addi $sp, $sp, 8  # Khoi phuc 8 bytes gia tri $sp ban dau da muon, ket thuc stack
	jr $ra		  # Nhay den doan lenh ngay sau khi goi ham strInsert
	
#----------------------------------------------------------
#----------Ham cong mot chuoi vao cuoi chuoi khac----------
# char* strAdd(char* dest, char* source)
# $a0: dia chi chuoi dest, $a1: dia chi chuoi source, $v0: dia chi chuoi dest
strAdd:
	addi $sp, $sp, -12  # Muon 12 bytes tu stack
	sw $ra, 0($sp)	    # Luu dia chi tra ve cua ham strAdd vao stack 
	sw $s0, 4($sp)	    # Luu gia tri hien tai cua $s0 vao stack, $s0 sau do se duoc dung nhu bien cuc bo cua ham
	sw $a0, 8($sp)	    # Luu dia chi chuoi dest vao stack
	addi $s0, $zero, 10 # Khoi gan $s0 = 10 (o day la ky tu xuong dong (endline) )

# Vong lap dua $a0 tro toi dia chi cua ky tu ket thuc chuoi (hoac ky tu endline) cua chuoi dest hien tai
loop_strAdd:
	lb $t0, ($a0)  # Load tung ky tu cua chuoi dest (tu trai sang)
	beq $t0, $zero, end_strAdd # Kiem tra ky tu do co phai ky tu ket thuc chuoi
	beq $t0, $s0, end_strAdd   # hay ky tu xuong dong (endline) khong
				   # Neu phai, nhay toi nhan end_strAdd de ket thuc vong lap
	addi $a0, $a0, 1   # Tang $a0 them 1 don vi de $a0 tro toi dia chi cua ky tu tiep theo can kiem tra
	j loop_strAdd

end_strAdd:
	# $a0 luc nay tro toi vi tri bat dau them chuoi source vao chuoi dest
	# Goi ham strcpy de them chuoi source vao chuoi dest
	jal strcpy
	lw $ra, 0($sp)	   # Lay dia chi tra ve cua ham strAdd tu stack
	lw $s0, 4($sp)	   # Tra lai gia tri truoc khi goi ham cua $s0
	lw $v0, 8($sp)	   # Gan $v0 cho dia chi cua chuoi dest (gia tri can tra ve)
	addi $sp, $sp, 12  # Tra lai 12 bytes da muon tu stack
	jr $ra		   # Nhay den doan lenh ngay sau khi goi ham strAdd

#-------------------------------------------------------
#----------Ham copy chuoi nguon vao chuoi dich----------
# char* strcpy(char* dest, char* source)
# $a0: dia chia chuoi dest, $a1: dia chi chuoi source, $v0: dia chi chuoi dest
strcpy:
	addi $sp, $sp, -4	# Muon 4 bytes tu stack
	sw $s0, 0($sp)		# Luu gia tri hien tai cua $s0 vao stack
	addi $s0, $zero, 10	# Gan $s0 = 10 (tuong ung voi ky tu endline)
	add $v0, $a0, $zero	# Gan $v0 bang dia chi cua chuoi dest (gia tri can tra ve)

loop_strcpy:	
	lb $t0, ($a1) # Load tung ky tu cua chuoi dest
	beq $t0, $zero, end_strcpy # Neu gap ky tu ket thuc chuoi
	beq $t0, $s0, end_strcpy   # hoac ky tu endline thi nhay toi nhan end_strcpy
	sb $t0, ($a0) # Dat ky tu vua lay tu chuoi source vao vi tri dang tro toi cua chuoi dest
	addi $a0, $a0, 1  # Dua $a0 tro toi ky tu ke tiep trong chuoi dest
	addi $a1, $a1, 1  # Dua $a1 tro toi ky tu ke tiep trong chuoi source
	j loop_strcpy	  # Thuc hien vong lap tiep theo

end_strcpy:
	sb $zero, ($a0)	  # Dat ky tu ket thuc chuoi vao cuoi chuoi dest
	lw $s0, 0($sp)	  # Tra lai gia tri truoc khi goi ham cua $s0
	addi $sp, $sp, 4  # Tra lai 4 bytes da muon tu stack
	jr $ra		  # Nhay den doan lenh ngay sau khi goi ham strcpy

#-------------------------------------------------------------
#----------Ham atoi (chuyen chuoi so sang so nguyen)----------
# int atoi(char* str)
# $a0: dia chi chuoi str, $v0: so nguyen tuong ung voi chuoi so
# Luu y: ham chi chuyen doi duoc doi voi so nguyen khong am
atoi:
	addi $sp, $sp, -12	# Muon 12 bytes tu stack
	sw $s0, 0($sp)		# Luu gia tri hien tai cua $s0 vao stack
	sw $s1, 4($sp)		# Luu gia tri hien tai cua $s1 vao stack
	sw $s2, 8($sp)		# Luu gia tri hien tai cua $s2 vao stack
	addi $s0, $zero, '0'	# Khoi gan $s0 bang ky tu '0'
	addi $s1, $zero, '9'	# Khoi gan $s1 bang ky tu '9'
	addi $s2, $zero, 10	# Khoi gan $s2 bang ky tu endline
	add $v0, $zero, $zero	# Khoi gan $v0 bang gia tri 0

loop_atoi:
	lb $t0, ($a0) # Load tung ky tu cua chuoi str
	blt $t0, $s0, end_atoi  # Neu gap ky tu nam ngoai khoang ky tu so
	bgt $t0, $s1, end_atoi  # tuc la $t0 < '0' || $t0 > '9', thi nhay toi nhan end_atoi
	mult $v0, $s2		# Nhan $v0 cho 10
	mflo $v0
	subi $t0, $t0, '0'  	# Chuyen ky tu sang dang so
	add $v0, $v0, $t0 	# Them so vua chuyen vao $v0, luc nay so do nam o hang don vi cua $v0
	addi $a0, $a0, 1 	# Dua $a0 tro toi dia chi cua ky tu tiep theo trong chuoi str
	j loop_atoi		# Thuc hien vong lap tiep theo

end_atoi:
	lw $s0, 0($sp)		# Tra lai gia tri truoc khi goi ham cho $s0
	lw $s1, 4($sp)		# Tra lai gia tri truoc khi goi ham cho $s1
	lw $s2, 8($sp)		# Tra lai gia tri truoc khi goi ham cho $s2
	addi $sp, $sp, 12	# Tra lai 12 bytes da muon tu stack
	jr $ra			# Nhay den doan lenh ngay sau khi goi ham atoi

#------------------------------------------------------------
#----------Ham lay gia tri ngay (DAY) tu chuoi TIME----------	
# int day(char* time)
# $a0: dia chi chuoi time, $v0: gia tri ngay
day:
	addi $sp, $sp, -4 # Muon 4 bytes tu stack
	sw $ra, 0($sp)	  # Luu dia chi tra ve cua ham day vao stack
	jal atoi	  # Goi ham atoi lay gia tri ngay
	lw $ra, 0($sp)	  # Lay dia tri tra ve cua ham day tu stack 
	addi $sp, $sp, 4  # Tra lai 4 bytes da muon tu stack
	jr $ra		  # Nhay den doan lenh ngay sau khi goi ham day

#---------------------------------------------------------------
#----------Ham lay gia tri thang (MONTH) tu chuoi TIME----------
# int month(char* time)
# $a0: dia chi chuoi time, $v0: gia tri thang
month:
	addi $sp, $sp, -8	# Muon 8 bytes tu stack
	sw $ra, 0($sp)		# Luu dia chi tra ve cua ham month vao stack
	sw $s0, 4($sp)		# Luu gia tri hien tai cua $s0 vao stack
	addi $s0, $zero, '/'	# Gan $s0 bang ky tu '/'

# Vong lap dau $a0 tro toi ky tu '/' dau tien cua chuoi time
loop_month:
	lb $t0, 0($a0)
	beq $t0, $s0, end_month
	addi $a0, $a0, 1
	j loop_month

end_month:
	addi $a0, $a0, 1 # Dua $a0 tro toi ky tu lien sau ky tu '/' dau tien cua chuoi time
	jal atoi	 # Goi ham atoi lay gia tri thang tu chuoi time
	lw $ra, 0($sp)	 # Lay dia chi tra ve cua ham month tu stack
	lw $s0, 4($sp)	 # Tra lai gia tri truoc khi goi ham cho $s0
	addi $sp, $sp, 8 # Tra lai 8 bytes da muon tu stack
	jr $ra		 # Nhay den doan lenh ngay sau khi goi ham month

#------------------------------------------------------------
#----------Ham lay gia tri nam (YEAR) tu chuoi TIME----------
# int year(char* time)
# $a0: dia chi chuoi time, $v0: gia tri nam
year:
	addi $sp, $sp, -12	# Muon 12 bytes tu stack
	sw $ra, 0($sp)		# Luu dia chi tra ve cua ham year vao stack
	sw $s0, 4($sp)		# Luu gia tri hien tai cua $s0 vao stack
	sw $s1, 8($sp)		# Luu gia tri hien tai cua $s1 vao stack
	addi $s0, $zero, '/'	# Gan $s0 bang ky tu '/'
	addi $s1, $zero, 2	# Gan $s1 bang gia tri 2

# Vong lap dua $a0 tro toi ky tu '/' thu hai trong chuoi time
loop_year:
	beq $s1, $zero, end_year
	loop:
		lb $t0, 0($a0)
		beq $t0, $s0, end # Neu gap ky tu '/', nhay toi nhan end
		addi $a0, $a0, 1
		j loop
	end:
		addi $a0, $a0, 1  # Dua $a0 tro toi ky tu lien sau ky tu '/'
		subi $s1, $s1, 1  # Giam bien dem ky tu '/' di 1 don vi
		j loop_year	  # Thuc hien tiep vong lap lon

end_year:
	jal atoi		# Goi ham atoi lay gia tri nam tu chuoi time
	lw $ra, 0($sp)		# Lay dia chi tra ve cua ham year tu stack
	lw $s0, 4($sp)		# Tra lai gia tri truoc khi goi ham cua $s0
	lw $s1, 8($sp)		# Tra lai gia tri truoc khi goi ham cua $s1
	addi $sp, $sp, 12	# Tra lai 12 bytes da muon tu stack
	jr $ra			# Nhay den doan lenh ngay sau khi goi ham year

#--------------------------------------------------------------------
#----------Ham chon chuoi thang tuong ung voi gia tri thang----------
# char* choiceMonth(int month)
# $a0: month, $v0: dia chi chuoi thang tuong ung
choiceMonth:
	addi $t0, $zero, 1	# Khoi gan bien tam $t0 = 1

	# Lenh switch...case tim chuoi thang tuong ung voi month
	# Kiem tra month co phai thang 1 khong
	sub $a0, $a0, $t0	
	bne $a0, $zero, feb	# Neu $a0 khac 0, tuc khong phai thang 1, nhay toi nhan feb
	la $v0, strM1		# Nguoc lai, neu $a0 = 0, tai dia chi chuoi strM1 vao $v0
	j end_choiceMonth	# Nhay toi nhan end_choiceMonth

feb:
	# Kiem tra month co phai thang 2 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, mar	# Neu $a0 khong phai thang 2, nhay toi nhan mar
	la $v0, strM2		# Nguoc lai, tai dia chi chuoi strM2 vao $v0
	j end_choiceMonth	# Nhay toi nhan end_choiceMonth

mar:
	# Kiem tra month co phai thang 3 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, apr	# Neu $a0 khong phai thang 3, nhay toi nhan mar
	la $v0, strM3		# Nguoc lai, tai dia chi chuoi strM3 vao $v0
	j end_choiceMonth	# Nhay toi nhan end_choiceMonth

apr:
	# Kiem tra month co phai thang 4 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, may	# Neu $a0 khong phai thang 4, nhay toi nhan mar
	la $v0, strM4		# Nguoc lai, tai dia chi chuoi strM4 vao $v0
	j end_choiceMonth	# Nhay toi nhan end_choiceMonth

may:
	# Kiem tra month co phai thang 5 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, jun	# Neu $a0 khong phai thang 5, nhay toi nhan mar
	la $v0, strM5		# Nguoc lai, tai dia chi chuoi strM5 vao $v0
	j end_choiceMonth	# Nhay toi nhan end_choiceMonth

jun:
	# Kiem tra month co phai thang 6 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, jul	# Neu $a0 khong phai thang 6, nhay toi nhan mar
	la $v0, strM6		# Nguoc lai, tai dia chi chuoi strM6 vao $v0
	j end_choiceMonth	# Nhay toi nhan end_choiceMonth

jul:
	# Kiem tra month co phai thang 7 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, aug	# Neu $a0 khong phai thang 7, nhay toi nhan mar
	la $v0, strM7		# Nguoc lai, tai dia chi chuoi strM7 vao $v0
	j end_choiceMonth	# Nhay toi nhan end_choiceMonth

aug:
	# Kiem tra month co phai thang 8 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, sep	# Neu $a0 khong phai thang 8, nhay toi nhan mar
	la $v0, strM8		# Nguoc lai, tai dia chi chuoi strM8 vao $v0
	j end_choiceMonth	# Nhay toi nhan end_choiceMonth

sep:
	# Kiem tra month co phai thang 9 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, oct	# Neu $a0 khong phai thang 9, nhay toi nhan mar
	la $v0, strM9		# Nguoc lai, tai dia chi chuoi strM9 vao $v0
	j end_choiceMonth	# Nhay toi nhan end_choiceMonth

oct:
	# Kiem tra month co phai thang 10 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, nov	# Neu $a0 khong phai thang 10, nhay toi nhan mar
	la $v0, strM10		# Nguoc lai, tai dia chi chuoi strM10 vao $v0
	j end_choiceMonth	# Nhay toi nhan end_choiceMonth

nov:
	# Kiem tra month co phai thang 11 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, dec	# Neu $a0 khong phai thang 11, nhay toi nhan mar
	la $v0, strM11		# Nguoc lai, tai dia chi chuoi strM11 vao $v0
	j end_choiceMonth	# Nhay toi nhan end_choiceMonth

dec:
	# Con lai, month la thang 12
	la $v0, strM12		# Tai dia chi chuoi strM12 vao $v0

end_choiceMonth:
	jr $ra		# Nhay den doan lenh ngay sau khi goi ham choiceMonth

#--------------------------------------------------------------------------
#----------Ham tra ve dia chi chuoi thu tuong ung voi so nhap vao----------
# char* choiceDay(int num)
# $a0: num, $v0: dia chi chuoi thu tuong ung voi ngay
choiceDay:
	addi $t0, $zero, 1	# Khoi gan bien tam $t0 = 1

	# Lenh switch...case... tim chuoi thu tuong ung voi num
	# Kiem tra num co bang 1 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, mon 	# Neu num khac 1, nhay toi nhan mon
	la $v0, strD1		# Neu num bang 1, tai dia chi chuoi strD1 vao $v0 (SunDay)
	j end_choiceDay		# Nhay toi nhan end_choiceDay

mon:
	# Kiem tra num co bang 2 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, tue	# Neu num khac 2, nhay toi nhan mon
	la $v0, strD2		# Neu num bang 2, tai dia chi chuoi strD2 vao $v0 (Monday)
	j end_choiceDay		# Nhay toi nhan end_choiceDay

tue:
	# Kiem tra num co bang 3 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, wed	# Neu num khac 3, nhay toi nhan mon
	la $v0, strD3		# Neu num bang 3, tai dia chi chuoi strD3 vao $v0 (Tuesday)
	j end_choiceDay		# Nhay toi nhan end_choiceDay

wed:
	# Kiem tra num co bang 4 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, thu	# Neu num khac 4, nhay toi nhan mon
	la $v0, strD4		# Neu num bang 4, tai dia chi chuoi strD4 vao $v0 (Wednesday)
	j end_choiceDay		# Nhay toi nhan end_choiceDay

thu:
	# Kiem tra num co bang 5 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, fri	# Neu num khac 5, nhay toi nhan mon
	la $v0, strD5		# Neu num bang 5, tai dia chi chuoi strD5 vao $v0 (Thursday)
	j end_choiceDay		# Nhay toi nhan end_choiceDay

fri:
	# Kiem tra num co bang 6 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, sat	# Neu num khac 6, nhay toi nhan mon
	la $v0, strD6		# Neu num bang 6, tai dia chi chuoi strD6 vao $v0 (Friday)
	j end_choiceDay		# Nhay toi nhan end_choiceDay

sat:
	# Truong hop con lai, num = 0
	la $v0, strD7		# Tai dia chi chuoi strD7 vao $v0 (Saturday)

end_choiceDay:
	jr $ra		# Nhay den doan lenh ngay sau khi goi ham choiceMonth

#------------------------------------------------------------------
#----------Ham tra ve so tuong ung voi thang va nam nhuan----------
# int findValue(int month, int leapYear)
# $a0: month, $a1: leapYear (co gia tri 1 hoac 0), $v0: so can tim
findValue:
	addi $t0, $zero, 1	# Khoi gan bien tam $t0 = 1

	# Lenh switch...case... tim gia tri tuong ung voi thang va nam nhuan
	# Neu month la thang 1
	sub $a0, $a0, $t0
	bne $a0, $zero, feb_2	# Neu month khong la thang 1, nhay toi nhan feb_2
	bne $a1, $t0, next_jan	# Neu month la thang 1, nam khong nhuan, nhay toi nhan next_jan
	addi $v0, $zero, 6	# Neu month la thang 1, nam nhuan, gan $v0 = 6
	j end_findValue		# Nhay toi nhan end_findValue

next_jan:
	# Truong hop thang 1, nam khong nhuan
	add $v0, $zero, $zero	# Gan $v0 = 0
	j end_findValue		# Nhay toi nhan end_findValue

feb_2:
	# Neu month la thang 2
	sub $a0, $a0, $t0
	bne $a0, $zero, mar_2	# Neu month khong la thang 2, nhay toi nhan mar_2
	bne $a1, $t0, next_feb	# Neu month la thang 2, nam khong nhuan, nhay toi nhan next_feb
	addi $v0, $zero, 2	# Neu month la thang 2, nam nhuan, gan $v0 = 2
	j end_findValue		# Nhay toi nhan end_findValue

next_feb:
	# Truong hop thang 2, nam khong nhuan
	addi $v0, $zero, 3	# Gan $v0 = 3
	j end_findValue		# Nhay toi nhan end_findValue

mar_2:
	# Neu month la thang 3
	sub $a0, $a0, $t0
	bne $a0, $zero, apr_2	# Neu month khong la thang 3, nhay toi nhan apr_2
	addi $v0, $zero, 3	# Neu month la thang 3, gan $v0 = 3
	j end_findValue		# Nhay toi nhan end_findValue

apr_2:
	# Neu month la thang 4
	sub $a0, $a0, $t0
	bne $a0, $zero, may_2	# Neu month khong la thang 4, nhay toi nhan may_2
	addi $v0, $zero, 6	# Neu month la thang 4, gan $v0 = 6
	j end_findValue		# Nhay toi nhan end_findValue

may_2:
	# Neu month la thang 5
	sub $a0, $a0, $t0
	bne $a0, $zero, jun_2	# Neu month khong la thang 5, nhay toi nhan jun_2
	addi $v0, $zero, 1	# Neu month la thang 5, gan $v0 = 1
	j end_findValue		# Nhay toi nhan end_findValue

jun_2:
	# Neu month la thang 6
	sub $a0, $a0, $t0
	bne $a0, $zero, jul_2	# Neu month khong la thang 6, nhay toi nhan jul_2
	addi $v0, $zero, 4	# Neu month la thang 6, gan $v0 = 4
	j end_findValue		# Nhay toi nhan end_findValue

jul_2:
	# Neu month la thang 7
	sub $a0, $a0, $t0
	bne $a0, $zero, aug_2	# Neu month khong la thang 7, nhay toi nhan aug_2
	addi $v0, $zero, 6	# Neu month la thang 7, gan $v0 = 6
	j end_findValue		# Nhay toi nhan end_findValue

aug_2:
	# Neu month la thang 8
	sub $a0, $a0, $t0
	bne $a0, $zero, sep_2	# Neu month khong la thang 8, nhay toi nhan sep_2
	addi $v0, $zero, 2	# Neu month la thang 8, gan $v0 = 2
	j end_findValue		# Nhay toi nhan end_findValue

sep_2:
	# Neu month la thang 9
	sub $a0, $a0, $t0
	bne $a0, $zero, oct_2	# Neu month khong la thang 9, nhay toi nhan oct_2
	addi $v0, $zero, 5	# Neu month la thang 9, gan $v0 = 5
	j end_findValue		# Nhay toi nhan end_findValue

oct_2:
	# Neu month la thang 10
	sub $a0, $a0, $t0
	bne $a0, $zero, nov_2	# Neu month khong la thang 10, nhay toi nhan nov_2
	addi $v0, $zero, 0	# Neu month la thang 10, gan $v0 = 0
	j end_findValue		# Nhay toi nhan end_findValue

nov_2:
	# Neu month la thang 11
	sub $a0, $a0, $t0
	bne $a0, $zero, dec_2	# Neu month khong la thang 11, nhay toi nhan dec_2
	addi $v0, $zero, 3	# Neu month la thang 11, gan $v0 = 3
	j end_findValue		# Nhay toi nhan end_findValue

dec_2:
	# Truong hop con lai, month la thang 12
	addi $v0, $zero, 5	# Gan $v0 = 5
	
end_findValue:
	jr $ra			# Nhay den doan lenh ngay sau khi goi ham findValue

#-----------------------------------------------------------------------------
#----------Ham tra ve so tuong ung voi so du cua phep chia nam cho 4----------
# Ham phuc vu cho viec tim thu cua ngay trong chuoi time
# int findValue_2(int mod)
# $a0: mod, $v0: so can tim
findValue_2:
	addi $t0, $zero, 1	# Khoi gan $t0 = 1

	# Lenh switch...case... tim so tuong ung voi so du cua phep chia nam cho 4
	# Kiem tra mod co bang 1 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, mod_2	# Neu mod khac 1, nhay den nhan mod_2
	addi $v0, $zero, 5	# Neu mod bang 1, gan $v0 = 5
	j end_findValue_2	# Nhay den nhan end_findValue_2

mod_2:
	# Kiem tra mod co bang 2 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, mod_3	# Neu mod khac 2, nhay den nhan mod_3
	addi $v0, $zero, 3	# Neu mod bang 2, gan $v0 = 3
	j end_findValue_2	# Nhay den nhan end_findValue_2

mod_3:
	# Kiem tra mod co bang 3 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, mod_0	# Neu mod khac 3, nhay den nhan mod_0
	addi $v0, $zero, 1	# Neu mod bang 3, gan $v0 = 1
	j end_findValue_2	# Nhay den nhan end_findValue_2

mod_0:
	# Truong hop con lai, mod bang 0
	add $v0, $zero, $zero	# Gan $v0 = 0

end_findValue_2:
	jr $ra			# Nhay den doan lenh ngay sau khi goi ham findValue_2

#---------------------------------------------------------
#----------Ham dem so ky tu '/' trong chuoi TIME----------
# int countSlash(char* time)
# $a0: dia chi chuoi time, $v0: so ky tu '/' trong chuoi time
countSlash:
	addi $sp, $sp, -8	# Muon 8 bytes tu stack
	sw $s0, 0($sp)		# Luu gia tri hien tai cua $s0 vao stack
	sw $s1, 4($sp)		# Luu gia tri hien tai cua $s1 vao stack

	addi $s0, $zero, '/'	# Gan $s0 bang ky tu '/'
	addi $s1, $zero, 10	# Gan $s1 bang ky tu endline
	add $v0, $zero, $zero	# Khoi gan $v0 bang 0

loop_ctSl:
	lb $t0, 0($a0)		# Load tung ky tu cua chuoi time
	beq $t0, $zero, end_ctSl  # Neu gap ky tu ket thuc chuoi
	beq $t0, $s1, end_ctSl	  # hoac ky tu xuong dong thi nhay toi nhan end_ctSl
	addi $a0, $a0, 1	# Dua $a0 tro toi ky tu tiep theo trong chuoi time
	bne $t0, $s0, loop_ctSl # Neu ky tu tai $t0 khac ky tu '/' thi nhay toi nhan loop_ctSl
	addi $v0, $v0, 1	# Neu ky tu tai $t0 la ky tu '/', tang bien dem $v0 them 1 don vi
	j loop_ctSl		# Thuc hien vong lap tiep theo
	
end_ctSl:
	lw $s0, 0($sp)		# Tra lai gia tri truoc khi goi ham countSlash cho $s0
	lw $s1, 4($sp)		# Tra lai gia tri truoc khi goi ham countSlash cho $s1
	addi $sp, $sp, 8	# Tra lai 8 bytes da muon tu stack
	jr $ra			# Nhay den doan lenh ngay sau khi goi ham countSlash

#----------------------------------------------------------------------------------------------
#----------Ham kiem tra chuoi TIME co chua ky tu khac ky tu so va ky tu '/' hay khong----------
# bool checkCharInTime(char* time)
# $a0: dia chi chuoi time, $v0: 1 (neu co), 0 (neu khong)
checkCharInTime:
	addi $sp, $sp, -16	# Muon 16 bytes tu stack
	sw $s0, 0($sp)		# Luu gia tri hien tai cua $s0 vao stack
	sw $s1, 4($sp)		# Luu gia tri hien tai cua $s1 vao stack
	sw $s2, 8($sp)		# Luu gia tri hien tai cua $s2 vao stack
	sw $s3, 12($sp)		# Luu gia tri hien tai cua $s3 vao stack

	addi $s0, $zero, '/'	# Gan $s0 bang ky tu '/'
	addi $s1, $zero, '0'	# Gan $s1 bang ky tu '0'
	addi $s2, $zero, '9'	# Gan $s2 bang ky tu '9'
	addi $s3, $zero, 10	# Gan $s3 bang ky tu endline
	addi $v0, $zero, 1	# Khoi gan bien tra ve $v0 = 1 (true)

loop_checkChar:
	lb $t0, 0($a0)		# Load tung ky tu tu chuoi time
	addi $a0, $a0, 1	# Dua $a0 tro toi ky tu tiep theo trong chuoi time
	beq $t0, $zero, next_checkChar	# Neu gap ky tu ket thuc chuoi
	beq $t0, $s3, next_checkChar	# hoac ky tu xuong dong thi nhay toi nhan next_checkChar
	beq $t0, $s0, loop_checkChar	# Neu gap ky tu '/' thi nhay toi nhan loop_checkChar de thuc hien vong lap tiep theo
	blt $t0, $s1, end_checkChar	# Neu ky tu nam ngoai khoang ky tu so
	bgt $t0, $s2, end_checkChar	# tuc $t0 < '0' || $t0 > '9' thi nhay toi nhan end_checkChar
	j loop_checkChar		# Thuc hien vong lap tiep theo

next_checkChar:
	add $v0, $zero, $zero	# Neu khong ton tai ky tu khac ky tu so va ky tu '/' trong chuoi
				# tru ky tu endline va ky tu ket thuc chuoi thi gia tri tra ve $v0 = 0
end_checkChar:
	lw $s0, 0($sp)		# Tra lai gia tri truoc khi goi ham cho $s0
	lw $s1, 4($sp)		# Tra lai gia tri truoc khi goi ham cho $s1
	lw $s2, 8($sp)		# Tra lai gia tri truoc khi goi ham cho $s2
	lw $s3, 12($sp)		# Tra lai gia tri truoc khi goi ham cho $s3
	addi $sp, $sp, 16	# Lay dia chi tra ve cua ham checkChar tu stack
	jr $ra			# Nhay den doan lenh ngay sau khi goi ham checkCharInTime

#------------------------------------------------------------------------------
#----------Ham kiem tra tinh hop le cua chuoi TIME (nhap tu ban phim)----------
# bool checkTime(char* time)
# $a0: dia chi chuoi time, $v0: 1 (neu chuoi time hop le), 0 (neu chuoi time khong hop le)
checkTime:
	addi $sp, $sp, -16	# Muon 16 bytes tu stack
	sw $s0, 0($sp)		# Luu gia tri hien tai cua $s0 vao stack
	sw $s1, 4($sp)		# Luu gia tri hien tai cua $s1 vao stack
	sw $a0, 8($sp)		# Luu dia chi chuoi time vao stack
	sw $ra, 12($sp)		# Luu dia chi tra ve cua ham checkTime vao stack
	
	# Kiem tra chuoi time co chua ky tu khac ky tu so hay ky tu '/' khong
	jal checkCharInTime
	bne $v0, $zero, false_time # Neu co, nhay den nhan false_time
	# Neu chuoi time khong chua ky tu khac ky tu '/' va ky tu so
	# Goi ham countSlash dem so ky tu '/' cua chuoi
	lw $a0, 8($sp)
	jal countSlash
	subi $v0, $v0, 2
	bne $v0, $zero, false_time # Neu so ky tu '/' cua chuoi khac 2, nhay den nhan false_time
	# Neu chuoi co du 2 ky tu '/'
	# Goi ham year lay gia tri nam tu chuoi
	lw $a0, 8($sp)
	jal year
	add $s1, $v0, $zero # Luu gia tri nam vao $s1
	# Goi ham checkYear de kiem tra gia tri nam trong chuoi time co hop le khong
	add $a0, $v0, $zero
	jal checkYear
	beq $v0, $zero, false_time # Neu nam khong hop le, nhay toi nhan false_time
	# Neu nam hop le, goi ham month lay gia tri thang tu chuoi time
	lw $a0, 8($sp)
	jal month
	add $s0, $v0, $zero # Luu gia tri thang vao $s0
	# Goi ham checkMonth de kiem tra gia tri thang trong chuoi time co hop le khong
	add $a0, $v0, $zero
	jal checkMonth
	beq $v0, $zero, false_time # Neu thang khong hop le, nhay toi nhan false_time
	# Neu thang hop le, goi ham day lay gia tri ngay tu chuoi time
	lw $a0, 8($sp)
	jal day
	# Goi ham checkDay de kiem tra gia tri ngay trong chuoi time co hop le khong
	add $a0, $v0, $zero
	add $a1, $s0, $zero
	add $a2, $s1, $zero
	jal checkDay
	beq $v0, $zero, false_time # Neu ngay khong hop le, nhay toi nhan false_time
	j end_checkTime	# Neu ngay, thang, nam trong chuoi time da hop le, nhay toi nhan end_checkTime

false_time:
	add $v0, $zero, $zero # Truong hop chuoi time khong hop le, gan gia tri tra ve $v0 = 0

end_checkTime:
	lw $s0, 0($sp)		# Tra lai gia tri truoc khi goi ham cho $s0
	lw $s1, 4($sp)		# Tra lai gia tri truoc khi goi ham cho $s1
	lw $ra, 12($sp)		# Lay dia chi tra ve cua ham checkTime tu stack
	addi $sp, $sp, 16	# Tra lai 16 bytes da muon tu stack
	jr $ra			# Nhay den doan lenh ngay sau khi goi ham checkTime

#---------------------------------------------------
#----------Ham kiem tra nam nhuan (kieu 2)----------
# bool leapYear_2(int year)
# $a0: year, $v0: 1 (neu year la nam nhuan), 0 (neu year khong phai la nam nhuan)
leapYear_2:
	addi $sp, $sp, -12	# Muon 16 bytes tu stack
	sw $s0, 0($sp)		# Luu gia tri hien tai cua $s0 vao stack
	sw $s1, 4($sp)		# Luu gia tri hien tai cua $s1 vao stack
	sw $s2, 8($sp)		# Luu gia tri hien tai cua $s2 vao stac

	# $s0, $s1, $s2 la cac bien cuc bo
	addi $s0, $zero, 400
	addi $s1, $zero, 4
	addi $s2, $zero, 100
	add $v0, $zero, $zero	# Khoi gan $v0 = 0 (false)
	# Chia year cho 400
	div $a0, $s0
	mfhi $t0 # Lay du
	beq $t0, $zero, yes_2	# Neu du bang 0, tuc nam nhuan, nhay toi nhan yes_2
	# Chia year cho 4
	div $a0, $s1
	mfhi $t0 # Lay du
	bne $t0, $zero, end_leapYear_2	# Neu du khac 0, tuc nam khong nhuan, nhay toi nhan end_leapYear_2
	# Chia year cho 100
	div $a0, $s2
	mfhi $t0 # Lay du
	beq $t0, $zero, end_leapYear_2  # Neu du bang 0, tuc nham khong nhuan, nhay toi nhan end_leapYear_2

yes_2:
	addi $v0, $zero, 1 # Truong hop nam nhuan, gan gia tri tra ve $v0 = 1 (true)
	
end_leapYear_2:
	lw $s0, 0($sp)		# Tra lai gia tri truoc khi goi ham cho $s0
	lw $s1, 4($sp)		# Tra lai gia tri truoc khi goi ham cho $s1
	lw $s2, 8($sp)		# Tra lai gia tri truoc khi goi ham cho $s2
	addi $sp, $sp, 12	# Tra lai 12 bytes da muon tu stack
	jr $ra			# Nhay den doan lenh ngay sau khi goi ham leapYear_2

#-------------------------------------------------------------------------
#----------Ham so sanh hai ngay trong hai chuoi TIME_1 va TIME_2----------
# int compareDate(char* time_1, char* time_2)
# $a0: dia chia chuoi time_1, $a1: dia chi chuoi time_2
# $v0: 0 (time_1 > time_2), 1 (time_1 < time_2), 2 (time_1 = time_2)
compareDate:
	addi $sp, $sp, -20	# Muon 20 bytes tu stack
	sw $s0, 0($sp)		# Luu gia tri hien tai cua $s0 vao stack
	sw $s1, 4($sp)		# Luu gia tri hien tai cua $s1 vao stack
	sw $a0, 8($sp)		# Luu dia chi chuoi time_1 vao stack
	sw $a1, 12($sp)		# Luu dia chi chuoi time_2 vao stack
	sw $ra, 16($sp)		# Luu dia chi tra ve cua ham compareDate vao stack
	
	# Coi d1, m1, y1 la ngay, thang, nam cua chuoi time_1
	# Coi d2, m2, y2 la ngay, thang, nam cua chuoi time_2
	
	# Lay y1 tu chuoi time_1
	jal year
	add $s0, $v0, $zero
	# Lay y2 tu chuoi time_2
	lw $a0, 12($sp)
	jal year
	add $s1, $v0, $zero	
	blt $s0, $s1, one	# Neu y1 < y2, nhay toi nhan one
	bgt $s0, $s1, zero	# Neu y1 > y2, nhay toi nhan zero
	# Neu y1 == y2, so sanh thang
	# Lay m1 tu chuoi time_1
	lw $a0, 8($sp)
	jal month
	add $s0, $v0, $zero
	# Lay m2 tu chuoi time_2
	lw $a0, 12($sp)
	jal month
	add $s1, $v0, $zero
	blt $s0, $s1, one	# Neu m1 < m2, nhay toi nhan one
	bgt $s0, $s1, zero	# Neu m1 > m2, nhay toi nhan zero
	# Neu m1 == m2, so sanh ngay
	# Lay d1 tu chuoi time_1
	lw $a0, 8($sp)
	jal day
	add $s0, $v0, $zero
	# Lay d2 tu chuoi time_2
	lw $a0, 12($sp)
	jal day
	add $s1, $v0, $zero
	blt $s0, $s1, one	# Neu d1 < d2, nhay toi nhan one
	bgt $s0, $s1, zero	# Neu d1 > d2, nhay toi nhan zero
	# Neu d1 == d2, tuc hai chuoi time_1 va time_2 bang nhau
	addi $v0, $zero, 2 	# Gan $v0 = 2
	j end_compareDate	# Nhay toi nhan end_compareDate

one:
	# Neu time_1 < time_2 (o day hieu la thoi gian trong chuoi time_1 nho h?n thoi gian trong chuoi time_2)
	addi $v0, $zero, 1	# Gan $v0 = 1
	j end_compareDate	# Nhay toi nhan end_copareDate

zero:
	# Neu time1 > time_2 (o day hieu la thoi gian trong chuoi time_1 lon h?n thoi gian trong chuoi time_2)
	add $v0, $zero, $zero	# Gan $v0 = 0

end_compareDate:
	lw $s0, 0($sp)		# Tra lai gia tri truoc khi goi ham cho $s0
	lw $s1, 4($sp)		# Tra lai gia tri truoc khi goi ham cho $s1
	lw $ra, 16($sp)		# Lay dia chi tra ve cua ham compareDate tu stack
	addi $sp, $sp, 20	# Tra lai 20 bytes da muon tu stack
	jr $ra			# Nhay den doan lenh ngay sau khi goi ham compareDate

#---------------------------------------------
#----------Ham tim so ngay cua thang----------
# int dayOfMonth(int month)
# $a0: month, $v0: so ngay cua thang month
dayOfMonth:
	addi $t0, $zero, 1	# Khoi gan $g0 = 1
	la $t1, arr		# Load dia chi mang arr vao $t1

	# Lenh switch...case tim so ngay cua thang
	# Kiem tra month co la thang 1 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, feb_3	# Neu month khong phai thang 1, nhay toi nhan feb_3
	lw $v0, 0($t1)		# Load phan tu thu nhat cua mang arr vao $v0
	j end_dayOfMonth	# Nhay den nhan end_dayOfMonth

feb_3:
	# Kiem tra month co la thang 2 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, mar_3	# Neu month khong phai thang 2, nhay toi nhan mar_3
	lw $v0, 4($t1)		# Load phan tu thu hai cua mang arr vao $v0
	j end_dayOfMonth	# Nhay den nhan end_dayOfMonth

mar_3:
	# Kiem tra month co la thang 3 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, apr_3	# Neu month khong phai thang 3, nhay toi nhan apr_3
	lw $v0, 8($t1)		# Load phan tu thu ba cua mang arr vao $v0
	j end_dayOfMonth	# Nhay den nhan end_dayOfMonth

apr_3:
	# Kiem tra month co la thang 4 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, may_3	# Neu month khong phai thang 4, nhay toi nhan may_3
	lw $v0, 12($t1)		# Load phan tu thu tu cua mang arr vao $v0
	j end_dayOfMonth	# Nhay den nhan end_dayOfMonth

may_3:
	# Kiem tra month co la thang 5 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, jun_3	# Neu month khong phai thang 5, nhay toi nhan jun_3
	lw $v0, 16($t1)		# Load phan tu thu nam cua mang arr vao $v0
	j end_dayOfMonth	# Nhay den nhan end_dayOfMonth

jun_3:
	# Kiem tra month co la thang 6 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, jul_3	# Neu month khong phai thang 6, nhay toi nhan jul_3
	lw $v0, 20($t1)		# Load phan tu thu sau cua mang arr vao $v0
	j end_dayOfMonth	# Nhay den nhan end_dayOfMonth

jul_3:
	# Kiem tra month co la thang 7 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, aug_3	# Neu month khong phai thang 7, nhay toi nhan aug_3
	lw $v0, 24($t1)		# Load phan tu thu bay cua mang arr vao $v0
	j end_dayOfMonth	# Nhay den nhan end_dayOfMonth

aug_3:
	# Kiem tra month co la thang 8 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, sep_3	# Neu month khong phai thang 8, nhay toi nhan sep_3
	lw $v0, 28($t1)		# Load phan tu thu tam cua mang arr vao $v0
	j end_dayOfMonth	# Nhay den nhan end_dayOfMonth

sep_3:
	# Kiem tra month co la thang 9 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, oct_3	# Neu month khong phai thang 9, nhay toi nhan oct_3
	lw $v0, 32($t1)		# Load phan tu thu chin cua mang arr vao $v0
	j end_dayOfMonth	# Nhay den nhan end_dayOfMonth

oct_3:
	# Kiem tra month co la thang 10 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, nov_3	# Neu month khong phai thang 10, nhay toi nhan nov_3
	lw $v0, 36($t1)		# Load phan tu thu muoi cua mang arr vao $v0
	j end_dayOfMonth	# Nhay den nhan end_dayOfMonth

nov_3:
	# Kiem tra month co la thang 11 khong
	sub $a0, $a0, $t0
	bne $a0, $zero, dec_3	# Neu month khong phai thang 11, nhay toi nhan dec_3
	lw $v0, 40($t1)		# Load phan tu thu muoi mot cua mang arr vao $v0
	j end_dayOfMonth	# Nhay den nhan end_dayOfMonth

dec_3:
	# Truong hop con lai, month la thang 12
	lw $v0, 44($t1)		# Load phan tu thu muoi hai cua mang arr vao $v0

end_dayOfMonth:
	jr $ra	# Nhay den doan lenh ngay sau khi goi ham dayOfMonth

#------------------------------------------
#------------------------------------------
exit:
	addi $v0, $zero, 10
	syscall
